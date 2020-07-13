Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044ABC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B372067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="u4CmsHwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgGMSTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgGMSTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:19:05 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1665C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 11:19:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ls15so264432pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=DMv6KVcfwWuUfVxq/TG9jnHiUvzjJiD3obg8ZekXyMs=;
        b=u4CmsHwa7xaCe3zDb4jrOUPoyQAwVMb0GO0GgYreE3k9fxWU5POmlIk30LPDTgAQUj
         UXSamG1nn5bzlmnsItQRLjFVeTX9jNNZSWB3UwJkV82kO9sw8mlCK+8QA2A6XZi7xW2p
         cYw26U3rmfF6mijGvSDefylxiQCOhgYcxL7pxRoq9V/UTMxzAkw29s2tnGqbRpV7VXiB
         xUZoWpQGSZUmOzxEuR/l0sY53x7ZhIn9xs7ai2/qJ8GwCFJdnk5CAStVEdHSJJZOWF44
         QORefjrjcSrzgiOPOEdXNRfrCTZl39dyw6LhXayUWrSOVuTaE7f9koQ+xXXMyR2rQ5bk
         e1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=DMv6KVcfwWuUfVxq/TG9jnHiUvzjJiD3obg8ZekXyMs=;
        b=TBx/M07vuoyHW5ho37HFt/xf4xJbseN8hmsplBuV/LgNMOBcXdld71dpXYtqSzCTrp
         bY69ocYx3YUG+xbVQpsiCvMyvsNLet2R0N1aZiKMkNjfAPp+AN6nmutVAEFdJgIXDd08
         CQOHfWQ1Y7Lw6zRZuVCdlGVlghM7RaZ94g8XADZ1c/IUm8+4zNidlrVPxcu2BagCdTfw
         BOAoT2xoipPtE6wcpKeOgs3yX74TAHYzEeMoAPkAW4jIpJ0UiJU2wpKpUtpvhdmyG4bv
         HMGHWDx3G1+Mh9slgAI7gDyi6gAVr2MpkWDi6g26hq9dlFcHfY9RLlsng5guLTZUsJjj
         nE5g==
X-Gm-Message-State: AOAM5334u3WjudFUmU6BnUj2rOheC8Lm9znKQ7s2T0BelPhnBTJXwYe/
        1H3kbda3w1PC3PDz1HHG2msQ+w==
X-Google-Smtp-Source: ABdhPJxyhASCLIINvghsf6QoRE0SwaPQ4do1QD3z/4f/3BAYiXHFhS0sGlAWxIM465D2lRN3W0sD0g==
X-Received: by 2002:a17:90a:ba86:: with SMTP id t6mr719906pjr.10.1594664345260;
        Mon, 13 Jul 2020 11:19:05 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3071:afe7:f805:6350? ([2601:646:c200:1ef2:3071:afe7:f805:6350])
        by smtp.gmail.com with ESMTPSA id j5sm15051298pfa.5.2020.07.13.11.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 11:19:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 7/7] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
Date:   Mon, 13 Jul 2020 11:18:57 -0700
Message-Id: <010054C3-7FFF-4FB5-BDA8-D2B80F7B1A5D@amacapital.net>
References: <1594658283.qabzoxga67.astroid@bobo.none>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
In-Reply-To: <1594658283.qabzoxga67.astroid@bobo.none>
To:     Nicholas Piggin <npiggin@gmail.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 13, 2020, at 9:48 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
> =EF=BB=BFExcerpts from Andy Lutomirski's message of July 14, 2020 1:59 am:=

>>> On Thu, Jul 9, 2020 at 6:57 PM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>>=20
>>> On big systems, the mm refcount can become highly contented when doing
>>> a lot of context switching with threaded applications (particularly
>>> switching between the idle thread and an application thread).
>>>=20
>>> Abandoning lazy tlb slows switching down quite a bit in the important
>>> user->idle->user cases, so so instead implement a non-refcounted scheme
>>> that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
>>> any remaining lazy ones.
>>>=20
>>> On a 16-socket 192-core POWER8 system, a context switching benchmark
>>> with as many software threads as CPUs (so each switch will go in and
>>> out of idle), upstream can achieve a rate of about 1 million context
>>> switches per second. After this patch it goes up to 118 million.
>>>=20
>>=20
>> I read the patch a couple of times, and I have a suggestion that could
>> be nonsense.  You are, effectively, using mm_cpumask() as a sort of
>> refcount.  You're saying "hey, this mm has no more references, but it
>> still has nonempty mm_cpumask(), so let's send an IPI and shoot down
>> those references too."  I'm wondering whether you actually need the
>> IPI.  What if, instead, you actually treated mm_cpumask as a refcount
>> for real?  Roughly, in __mmdrop(), you would only free the page tables
>> if mm_cpumask() is empty.  And, in the code that removes a CPU from
>> mm_cpumask(), you would check if mm_users =3D=3D 0 and, if so, check if
>> you just removed the last bit from mm_cpumask and potentially free the
>> mm.
>>=20
>> Getting the locking right here could be a bit tricky -- you need to
>> avoid two CPUs simultaneously exiting lazy TLB and thinking they
>> should free the mm, and you also need to avoid an mm with mm_users
>> hitting zero concurrently with the last remote CPU using it lazily
>> exiting lazy TLB.  Perhaps this could be resolved by having mm_count
>> =3D=3D 1 mean "mm_cpumask() is might contain bits and, if so, it owns the=

>> mm" and mm_count =3D=3D 0 meaning "now it's dead" and using some careful
>> cmpxchg or dec_return to make sure that only one CPU frees it.
>>=20
>> Or maybe you'd need a lock or RCU for this, but the idea would be to
>> only ever take the lock after mm_users goes to zero.
>=20
> I don't think it's nonsense, it could be a good way to avoid IPIs.
>=20
> I haven't seen much problem here that made me too concerned about IPIs=20
> yet, so I think the simple patch may be good enough to start with
> for powerpc. I'm looking at avoiding/reducing the IPIs by combining the
> unlazying with the exit TLB flush without doing anything fancy with
> ref counting, but we'll see.

I would be cautious with benchmarking here. I would expect that the nasty ca=
ses may affect power consumption more than performance =E2=80=94 the specifi=
c issue is IPIs hitting idle cores, and the main effects are to slow down ex=
it() a bit but also to kick the idle core out of idle. Although, if the idle=
 core is in a deep sleep, that IPI could be *very* slow.

So I think it=E2=80=99s worth at least giving this a try.

>=20
> Thanks,
> Nick
