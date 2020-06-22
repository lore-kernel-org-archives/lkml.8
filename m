Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171C9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06EC20675
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7/MYp6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgFVKQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgFVKQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:16:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551D5C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:16:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y11so18637213ljm.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R3B47LhSzlhf0CyG1tgvim2OLOrvyZ3razYI3nJme5U=;
        b=F7/MYp6K3ALqvV1Pk4dcuMsGKwszBlgZe6Wswk+bxqBKID6d74blxWVWa8ithjNlbB
         f+ZfUhB55CLLROLEhJ/H71hH4eGx/w74csavIqcgv2EUFST86ArC2UEIQN/srrf83gGj
         5UbUUqyvat9aUPnhxdtMeGggVsExXeL7vO3xXKMMMybrsHMSNMAr8IwdwtSbEZJM6JaM
         25hZeuIRs4MnuCB81nu7KQGTa+ZxC2MHgMzQOgAj/vZT5c+jKs39G2PVD6hKP6fNq31j
         981OSedENF5UJm6cPOHI+q/RjPTzDzvIvgFpySUuC1ijacExCY4BKFyAOTEpmQqF49Xb
         rP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3B47LhSzlhf0CyG1tgvim2OLOrvyZ3razYI3nJme5U=;
        b=Q2cZVZNzASN0rp0Ac0Uf1FWDo+jgTJB/r4rRJkQelc8GPsz/E9ChifnZdKKoFiciMV
         7rQp1JAG+wIFdEZfcmguYGw73KkfdR2dgwSSUL6mTD9YOjtX4w3JCdN55H1+I9lcYPIH
         /iEacDUanw/Zm1TXYogJSr+qBUVzvTs0AsjwK/hKpi53YHGQLtpgW/g08M+pbl4wr9VO
         nQasO1rkxj0MMT7wRSAM8BvrkIdSUtvK8OHzGOJfqtgN6BF43tbWScnkQr3Y1dUH21b+
         ZrjNbQdectUDLkfUblAR3AZ3hsEhrPCPLW74x1VYpMKFRzvHqMIvLgocx1NqGaSG8+SY
         qSjQ==
X-Gm-Message-State: AOAM533EiRQiFjwPy81DTuR0pE5CohkWpbbbk24ByK9WmdB2WX5RJ8Ty
        qMf8nbhfL3SLqEQy9UzWZUT2Sfjw3w4MfGMQ/JF8Hg==
X-Google-Smtp-Source: ABdhPJyKVFwQEbwtY+Abdz6wmfxYTSKmli499smwlc6siT5OYxo93F6Kbx9OmqeCMdTsTov+7kmIswdfNAfgYfOBi4o=
X-Received: by 2002:a2e:984b:: with SMTP id e11mr7726051ljj.358.1592821003711;
 Mon, 22 Jun 2020 03:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <87y2onbdtb.fsf@nanos.tec.linutronix.de> <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
 <20200616132705.GW2531@hirez.programming.kicks-ass.net> <20200617131742.GD8389@yuki.lan>
 <87r1ucb0rt.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87r1ucb0rt.fsf@nanos.tec.linutronix.de>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 22 Jun 2020 15:46:32 +0530
Message-ID: <CA+G9fYu18y4iWOkTCDWi9dUj+FosStVTH-6swN7wE4GePZa=Ng@mail.gmail.com>
Subject: Re: [LKP] Re: [LTP] [x86/entry] 2bbc68f837: ltp.ptrace08.fail
To:     Thomas Gleixner <tglx@linutronix.de>,
        Cyril Hrubis <chrubis@suse.cz>, LTP List <ltp@lists.linux.it>,
        lkft-triage@lists.linaro.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 at 01:32, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Cyril Hrubis <chrubis@suse.cz> writes:
> > What is does is to write:
> >
> >       (void*)1 to u_debugreg[0]
> >       (void*)1 to u_debugreg[7]
> >       do_debug addr to u_debugreg[0]
> >
> > Looking at the kernel code the write to register 7 enables the breakpoints and
> > what we attempt here is to change an invalid address to a valid one after we
> > enabled the breakpoint but that's as far I can go.
> >
> > So does anyone has an idea how to trigger the bug without the do_debug function
> > address? Would any valid kernel function address suffice?
>
> According to https://www.openwall.com/lists/oss-security/2018/05/01/3
> the trigger is to set the breakpoint to do_debug() and then execute
> INT1, aka. ICEBP which ends up in do_debug() ....
>
> In principle each kernel address is ok, but do_debug() is interesting
> due to the recursion issue because user space can reach it by executing
> INT1.
>
> So you might check for exc_debug() if do_debug() is not available and
> make the whole thing fail gracefully with a usefu error message.

My two cents,
LTP test case ptrace08 fails on x86_64 and i386.

ptrace08.c:62: BROK: Cannot find address of kernel symbol \"do_debug\"

This error is coming from test case setup
KERNEL_SYM = do_debug

if (strcmp(symname, KERNEL_SYM))
tst_brk(TBROK, "Cannot find address of kernel symbol \"%s\"",
KERNEL_SYM);

Test case got pass when DEBUG_INFO config enabled

CONFIG_DEBUG_INFO=y

ptrace08.c:68: INFO: Kernel symbol \"do_debug\" found at 0xd8898410

Full test log,
https://lkft.validation.linaro.org/scheduler/job/1483117#L1325

ref:
https://bugs.linaro.org/show_bug.cgi?id=5651#c1
