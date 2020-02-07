Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AE4C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 00:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D24214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 00:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BBGuoH4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgBGAzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:55:42 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39983 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgBGAzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 19:55:42 -0500
Received: by mail-qk1-f194.google.com with SMTP id b7so610190qkl.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 16:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=p/R0f3V2QFDfmc86YhIhDY9+JDhyDpcA5H1ziRMRmpw=;
        b=BBGuoH4ljNf/nsbHXmKFXmeibCtToF0UNbAw3aMRh+69fImEKVZ7WDHIxU2vwAK/rM
         qRtIQA2bAYT6FF8ZqdcCwDjiUKoQNSw1CAD4bOxrp9icysMpkOzz8lKO56W4yNo6OriH
         Jt9VtlgGaId+xsdyXSF2zzVf3CAOxStkjWu4y4GBU5bhqH8SZdjgcr6d15n44iGoU0/r
         yt6Khu+Jf6Ng5yanUKjysg4Etfyzk3QlHJLsgsaD50bX2dQki4v8udeniiVNW21JKm7O
         W9A8kGUkdbL2L2rlz5GocvQiIiBqRij4BY4mKcl2tKcX5s/h6ZuXnsjQg/8uVzjd38AJ
         Qr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=p/R0f3V2QFDfmc86YhIhDY9+JDhyDpcA5H1ziRMRmpw=;
        b=WdlFItif/296z6bys4EahxduogiZz1Td8WhY1LYz/EnKYTAoQXSiln2tRFTNIYAd2q
         S0RBhckdb0pWfHsxyqc7ZyMF0liHv4fgZjbSenWwIvV9wEeRSCroxdqZdUBzy6BegTaz
         ITkWsfmTmYPic0MH6Ef8SYghMiZ7/QnRhMeXYAgVfWd4tmnMpWSkOiMDKKC7cnJjRkkf
         tjNQj/yutBlyrd14y0npAOkmnJEVYm6ruxQ74xehpMDuk39fNylSoUI3Qyc6niqGh2cu
         mvdFUH/swHt/JX3sa1v6RHjeUxpjhq7xVratb8IoNLTGv/4QNtMfvPcTNhgz2KzoIFMN
         Ea2Q==
X-Gm-Message-State: APjAAAV9UNsNVk73y+F9sZx0TtbSCwFYZNThFshGF6hqg/TgqKKGSCn4
        RAZxUdi+34z2vWWCsFDICz6SQQ==
X-Google-Smtp-Source: APXvYqylHGR1vme3BY/+qExRUkU3mklEmQvEqAdTdVc9OyvDOG07clXlLFLYLXGmQj8HjiH/lyLAdw==
X-Received: by 2002:ae9:f709:: with SMTP id s9mr5073023qkg.463.1581036940798;
        Thu, 06 Feb 2020 16:55:40 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f32sm540876qtk.89.2020.02.06.16.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 16:55:40 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] mm: fix a data race in put_page()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <90ab0b09-0f70-fe6d-259e-f529f4ef9174@nvidia.com>
Date:   Thu, 6 Feb 2020 19:55:38 -0500
Cc:     Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, ira.weiny@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Marco Elver <elver@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1CFC5A47-3334-4696-89FE-CDF01026B12B@lca.pw>
References: <20200206145501.GD26114@quack2.suse.cz>
 <D022CBB0-C8EC-4F5A-A0B0-893AA7A014AA@lca.pw>
 <079c4429-8a11-154d-cf5c-473d2698d18d@nvidia.com>
 <235ACF21-35BE-4EDA-BA64-9553DA53BF12@lca.pw>
 <90ab0b09-0f70-fe6d-259e-f529f4ef9174@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 6, 2020, at 7:27 PM, John Hubbard <jhubbard@nvidia.com> wrote:
>=20
> On 2/6/20 4:18 PM, Qian Cai wrote:
>>> On Feb 6, 2020, at 6:34 PM, John Hubbard <jhubbard@nvidia.com> =
wrote:
>>> On 2/6/20 7:23 AM, Qian Cai wrote:
>>>>> On Feb 6, 2020, at 9:55 AM, Jan Kara <jack@suse.cz> wrote:
>>>>> I don't think the problem is real. The question is how to make =
KCSAN happy
>>>>> in a way that doesn't silence other possibly useful things it can =
find and
>>>>> also which makes it most obvious to the reader what's going on... =
IMHO
>>>>> using READ_ONCE() fulfills these targets nicely - it is free
>>>>> performance-wise in this case, it silences the checker without =
impacting
>>>>> other races on page->flags, its kind of obvious we don't want the =
load torn
>>>>> in this case so it makes sense to the reader (although a comment =
may be
>>>>> nice).
>>>>=20
>>>> Actually, use the data_race() macro there fulfilling the same =
purpose too, i.e, silence the splat here but still keep searching for =
other races.
>>>>=20
>>>=20
>>> Yes, but both READ_ONCE() and data_race() would be saying untrue =
things about this code,
>>> and that somewhat offends my sense of perfection... :)
>>>=20
>>> * READ_ONCE(): this field need not be restricted to being read only =
once, so the
>>> name is immediately wrong. We're using side effects of READ_ONCE().
>>>=20
>>> * data_race(): there is no race on the N bits worth of page zone =
number data. There
>>> is only a perceived race, due to tools that look at word-level =
granularity.
>>>=20
>>> I'd propose one or both of the following:
>>>=20
>>> a) Hope that Marco (I've fixed the typo in his name. --jh) has an =
idea to enhance KCSAN so as to support this model of
>>>  access, and/or
>>=20
>> A similar thing was brought up before, i.e., anything compared to =
zero is immune to load-tearing
>> issues, but it is rather difficult to implement it in the compiler, =
so it was settled to use data_race(),
>>=20
>> =
https://lore.kernel.org/lkml/CANpmjNN8J1oWtLPHTgCwbbtTuU_Js-8HD=3DcozW5cYk=
m8h-GTBg@mail.gmail.com/#r
>>=20
>=20
>=20
> Thanks for that link to the previous discussion, good context.
>=20
>=20
>>>=20
>>> b) Add a new, better-named macro to indicate what's going on. =
Initial bikeshed-able
>>>  candidates:
>>>=20
>>> 	READ_RO_BITS()
>>> 	READ_IMMUTABLE_BITS()
>>> 	...etc...
>>>=20
>>=20
>> Actually, Linus might hate those kinds of complication rather than a =
simple data_race() macro,
>>=20
>> =
https://lore.kernel.org/linux-fsdevel/CAHk-=3Dwg5CkOEF8DTez1Qu0XTEFw_oHhxN=
98bDnFqbY7HL5AB2g@mail.gmail.com/
>>=20
>=20
> Another good link. However, my macros above haven't been proposed yet, =
and I'm perfectly=20
> comfortable proposing something that Linus *might* (or might not!) =
hate. No point in=20
> guessing about it, IMHO.
>=20
> If you want, I'll be happy to put on my flame suit and post a patchset =
proposing=20
> READ_IMMUTABLE_BITS() (or a better-named thing, if someone has another =
name idea).  :)
>=20

BTW, the current comment said (note, it is called =E2=80=9Caccess=E2=80=9D=
 which in this case it does read the whole word
rather than those 3 bits, even though it is only those bits are of =
interested for us),

/*
 * data_race(): macro to document that accesses in an expression may =
conflict with
 * other concurrent accesses resulting in data races, but the resulting
 * behaviour is deemed safe regardless.
 *
 * This macro *does not* affect normal code generation, but is a hint to =
tooling
 * that data races here should be ignored.
 */

Macro might have more to say.=
