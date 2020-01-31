Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F74C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7382067C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZAGlDzEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgAaCWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 21:22:08 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40008 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgAaCWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:22:08 -0500
Received: by mail-qk1-f194.google.com with SMTP id t204so5127013qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 18:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WL0FLgSacIAqtCGMkthh4uOIeyhw7X/ubIyKLP7UcMQ=;
        b=ZAGlDzEgoEB6R7NedCVOXEjZKZzovnmhhKhJX7mrctCT0WxPjz2pT7AYk70aYaUSXV
         YOLsGZRFqCjyLeHfBbb+3oTJ5bhG+C5v9YugT1VlbFlVKRIJizIsRgHHbVX8zl+Yo1nK
         TGkAjNH48Wtqm+0e4kmJN+vtnce23YuHP0G4rns0WRLERVJhRs6UOLYeeBrBzVv16ftN
         DP0JQkV0BkkFYMpHG9+WC11jTS7Aq+t7RJmkoMrrlVOQdREPeYQfbbk0L22wmclJIUrt
         1HnmuAsOqFI1dzq24676j4PRVcC/32mqTtjhlKJQgsWQd7VG4tsbDqzqPvFCYsQ0GsLQ
         U2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WL0FLgSacIAqtCGMkthh4uOIeyhw7X/ubIyKLP7UcMQ=;
        b=BUGAgSDWgiann1izzvK7fYrsFvE5K0Ls/9IMOVL3AIvSMPcn3RUTNKMZC7iePk0EGX
         tHLVvMNmlgmrL8MZzza8Qbp+7PW7yOUwyCtE6Ye0nyzdyG8bcghjiwt4Q5z9SnQehyFF
         xUx/necEOU+0OWVHbQYvn8XySXswCvTzVuS8oihq2Z7h0HbhJ9jwtZ7GHNghnLog+CUa
         XczHGoVTnEyRJ2+FqWLOQ2Ukmrm7ubGfncZ4OgJpaKz+bskuCqGulxbcD8i8L35nJ/SM
         Iua4EspBNU0pY8IF1e9WOh6dqF+pHy3oFCcK/enyIzYadw/6X275PIlWAg8ojJI9j2AN
         VJjw==
X-Gm-Message-State: APjAAAVHnOM9190oj9iPvag6Quwx+eOg7Og28IEYpvXswOIz6CYCMxJz
        fG+yB1OZOcQL9AdDJ4hExoD2BA==
X-Google-Smtp-Source: APXvYqx8JQk+90y2rl6YQE+bmI4aQ+EhMYsBcxfyUMLozcHF1DtPAe1VuWEJhRflwNMVLcMDnCXtYA==
X-Received: by 2002:a37:308:: with SMTP id 8mr8346060qkd.98.1580437326892;
        Thu, 30 Jan 2020 18:22:06 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x3sm3934273qts.35.2020.01.30.18.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 18:22:06 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] mm/util: fix a data race in __vm_enough_memory()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200130181834.633c201c7d0a2638aacbc7ba@linux-foundation.org>
Date:   Thu, 30 Jan 2020 21:22:05 -0500
Cc:     Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>, dennis@kernel.org,
        tj@kernel.org, Christoph Lameter <cl@linux.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B86F7FF-C892-4F58-A24E-E0728D2637BC@lca.pw>
References: <20200130042011.GI6615@bombadil.infradead.org>
 <1135BD67-4CCB-4700-8150-44E7E323D385@lca.pw>
 <CANpmjNNr_Kq6Do+UYrR-3aF0sO3++psUfN7Ppt8mmgcF5ynzrA@mail.gmail.com>
 <20200130181834.633c201c7d0a2638aacbc7ba@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 30, 2020, at 9:18 PM, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Thu, 30 Jan 2020 13:35:18 +0100 Marco Elver <elver@google.com> =
wrote:
>=20
>> On Thu, 30 Jan 2020 at 12:50, Qian Cai <cai@lca.pw> wrote:
>>>=20
>>>> On Jan 29, 2020, at 11:20 PM, Matthew Wilcox <willy@infradead.org> =
wrote:
>>>>=20
>>>> I'm really not a fan of exposing the internals of a percpu_counter =
outside
>>>> the percpu_counter.h file.  Why shouldn't this be fixed by putting =
the
>>>> READ_ONCE() inside percpu_counter_read()?
>>>=20
>>> It is because not all places suffer from a data race. For example, =
in __wb_update_bandwidth(), it was protected by a lock. I was a bit =
worry about blindly adding READ_ONCE() inside percpu_counter_read() =
might has unexpected side-effect. For example, it is unnecessary to have =
READ_ONCE() for a volatile variable. So, I thought just to keep the =
change minimal with a trade off by exposing a bit internal details as =
you mentioned.
>>>=20
>>> However, I had also copied the percpu maintainers to see if they =
have any preferences?
>>=20
>> I would not add READ_ONCE to percpu_counter_read(), given the writes
>> (increments) are not atomic either, so not much is gained.
>>=20
>> Notice that this is inside a WARN_ONCE, so you may argue that a data
>> race here doesn't matter to the correct behaviour of the system
>> (except if you have panic_on_warn on).
>>=20
>> For the warning to trigger, vm_committed_as must decrease. Assume =
that
>> a data race (assuming bad compiler optimizations) can somehow
>> accomplish this, then the load or write must cause a transient value
>> to somehow be less than a stable value. My hypothesis is this is very
>> unlikely.
>>=20
>> Given the fact this is a WARN_ONCE, and the fact that a transient
>> decrease in the value is unlikely, you may consider
>> 'VM_WARN_ONCE(data_race(percpu_counter_read(&vm_committed_as)) <
>> ...)'. That way you won't modify percpu_counter_read and still catch
>> unintended races elsewhere.
>>=20
>=20
> That, or add an alternative version of per_cpu_counter_read() to the
> percpu API.  A very carefully commented version!

 I send a patch to use data_race() which should be sufficient,

https://lore.kernel.org/linux-mm/20200130145649.1240-1-cai@lca.pw/=
