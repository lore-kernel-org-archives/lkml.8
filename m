Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AE3C35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 00:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF7820838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 00:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="B12iZ8ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBGAST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:18:19 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42665 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBGASS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 19:18:18 -0500
Received: by mail-qk1-f193.google.com with SMTP id q15so528190qke.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 16:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m2dTuWO1ugKcCHTxp+o4yxt+su2yu8181wVA1BN+7GA=;
        b=B12iZ8ko/b6w6maPcjEcpsoonvUtE2A1DTzmX6pv+zpWPUgPquTz3qKUIBBmF2rkqI
         8NDyiIztfImGvwbT8GB5BTlo8SZ7WmZmQsRKt8u+lHdVOUCbs10h9UQFxdAYgbp13ldP
         oEjP5b3/4xj9FlITI0Cxgkmm0lL3fzIMjStd4PYwoOsoOSHMG8kVhccmLD66df7IhLEy
         7xRfb9t0lkch2Z+gjrtBUiaWPOI0EEdIlHVEGwXPawVv7/dVhrbznhwTfSjIKN36zcV2
         B1c6kxaOiJnqlsQotvevCyD3Si/WEui6mAu1KIAGuomlWA6UDh2UtKg3YX/LWcsmFNTH
         CThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m2dTuWO1ugKcCHTxp+o4yxt+su2yu8181wVA1BN+7GA=;
        b=jWCttexvRjP5gPL6FYNXjJa2Q+rK53z03v/hv2G7su8avKQMq2PxvLuMsxbmJoKxwZ
         /CVAiN0im7acZpHogA0zW9jGd037PseIyGTXCXbaHeNZS+Ahxt+ZounEMHeXVCmBujuv
         Zr/K4HMGbjdRAg7OTadbkJwDD+rEirbjhQtWlxUXmyLy5V7bmIK9RgzWUHm8m6WqxCDq
         pHwsOSOag0Vj4bApo6sG+YR0ABEi8TWcQbnyBg/dnjn7jKboJl1UFZDiLmMvb4kwX5yP
         iILRsIYys/ko5T6Ad+RpOEZNKKz1aPQgrEoqO5yqdx3u2CvZiVAXe6oI2W7pQ0I/8r29
         XLVA==
X-Gm-Message-State: APjAAAXffYN0yqCVJRfJwvtgO5o76P4S7MVkczbp3rIslJwQ4qE2Ob4p
        wxsOQwcQBOr7I1WXYSIjEhzY7A==
X-Google-Smtp-Source: APXvYqyW8vjg6mpDaL9RjukFihPCoLu22QT7ULPVH+6VRvaYDXqqwCCxKU52v5R+fKuyrqg+RArsBw==
X-Received: by 2002:a37:8e44:: with SMTP id q65mr5066875qkd.70.1581034697891;
        Thu, 06 Feb 2020 16:18:17 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y27sm539145qta.50.2020.02.06.16.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 16:18:17 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] mm: fix a data race in put_page()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <079c4429-8a11-154d-cf5c-473d2698d18d@nvidia.com>
Date:   Thu, 6 Feb 2020 19:18:16 -0500
Cc:     Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, ira.weiny@intel.com,
        dan.j.williams@intel.com, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <235ACF21-35BE-4EDA-BA64-9553DA53BF12@lca.pw>
References: <20200206145501.GD26114@quack2.suse.cz>
 <D022CBB0-C8EC-4F5A-A0B0-893AA7A014AA@lca.pw>
 <079c4429-8a11-154d-cf5c-473d2698d18d@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 6, 2020, at 6:34 PM, John Hubbard <jhubbard@nvidia.com> wrote:
>=20
> On 2/6/20 7:23 AM, Qian Cai wrote:
>>=20
>>=20
>>> On Feb 6, 2020, at 9:55 AM, Jan Kara <jack@suse.cz> wrote:
>>>=20
>>> I don't think the problem is real. The question is how to make KCSAN =
happy
>>> in a way that doesn't silence other possibly useful things it can =
find and
>>> also which makes it most obvious to the reader what's going on... =
IMHO
>>> using READ_ONCE() fulfills these targets nicely - it is free
>>> performance-wise in this case, it silences the checker without =
impacting
>>> other races on page->flags, its kind of obvious we don't want the =
load torn
>>> in this case so it makes sense to the reader (although a comment may =
be
>>> nice).
>>=20
>> Actually, use the data_race() macro there fulfilling the same purpose =
too, i.e, silence the splat here but still keep searching for other =
races.
>>=20
>=20
> Yes, but both READ_ONCE() and data_race() would be saying untrue =
things about this code,
> and that somewhat offends my sense of perfection... :)
>=20
> * READ_ONCE(): this field need not be restricted to being read only =
once, so the
>  name is immediately wrong. We're using side effects of READ_ONCE().
>=20
> * data_race(): there is no race on the N bits worth of page zone =
number data. There
>  is only a perceived race, due to tools that look at word-level =
granularity.
>=20
> I'd propose one or both of the following:
>=20
> a) Hope that Marcus has an idea to enhance KCSAN so as to support this =
model of
>   access, and/or

A similar thing was brought up before, i.e., anything compared to zero =
is immune to load-tearing
issues, but it is rather difficult to implement it in the compiler, so =
it was settled to use data_race(),

=
https://lore.kernel.org/lkml/CANpmjNN8J1oWtLPHTgCwbbtTuU_Js-8HD=3DcozW5cYk=
m8h-GTBg@mail.gmail.com/#r

>=20
> b) Add a new, better-named macro to indicate what's going on. Initial =
bikeshed-able
>   candidates:
>=20
> 	READ_RO_BITS()
> 	READ_IMMUTABLE_BITS()
> 	...etc...
>=20

Actually, Linus might hate those kinds of complication rather than a =
simple data_race() macro,

=
https://lore.kernel.org/linux-fsdevel/CAHk-=3Dwg5CkOEF8DTez1Qu0XTEFw_oHhxN=
98bDnFqbY7HL5AB2g@mail.gmail.com/

