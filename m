Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F685C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AE92158C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oQfpCz/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGBRPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgGBRPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:15:49 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6132C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 10:15:48 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so16700537lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5MMSu0IKj9agZGg9cxf0hzKiayIrDKbeVQZ3G6flH/I=;
        b=oQfpCz/dy0nMemAHyrv4rMS95h2aDl4GHkuT8qBY18btLj85NW9YlPOKrGKA9duufq
         MN3gP2GdE2sL81ExpJYM3YTD07rEOHG/Pd64sI13/Iz51FYHGRwGaIOiPYpJeVMezdw5
         zYWMoytINWNRDAh4jdUkVy67/llD3vZzEv4tkc35z4Qrp9em14RsK/EVjt8fAg9TvJ/k
         pIpzWM2YdDNsBwyOeMTK4f4CXT1UAagYeX+Bwzv9bvXaW+4pF8TQIVLt2GaEaF7LNCZe
         xdq8xwsgpaPtAuHTSihqtF+xC2AJCSB10WovcHxZV5/qW1g4GvGrWAFz8j0eRTabXNUJ
         XZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5MMSu0IKj9agZGg9cxf0hzKiayIrDKbeVQZ3G6flH/I=;
        b=Bg3IdzF3rpelvZqvxI/SmN9NaCuxOWpujguKFsRR9kYjoPNDFoo00Ri/e0pChJXirK
         CF5HJik4Uj/nvLGWNCIhNKRQKY1VwVbFyoowu7KRSB3F51wSFvIQXmJN3En/nLBfv2SB
         etyeKKi1V8Q1Y4irrpzmNe5fGa7GIPMUuBJC/iPkui6O/7WSdddhCX4Wkp3ehM6VMWL+
         7w2W0+MGHMn7utxDaghd3BgvbRW+M/KaBFg4f2u97j7Me6kao2ShrbalxisM6HKSDnW0
         cej7xv2sxVVVudoaKFK7XYo3ylPvllvnC0Y1ZxDwGYJnlVBnDqx/ltnQVedsSBHC8zlL
         cCpw==
X-Gm-Message-State: AOAM530PMpJnMn+JA3v6aBzrT8vWVjzqo4Ypca5mzSISGVPf0PLNeKX9
        tVRzHk0jojj21eVn2EyBbHNCcUZhua8606p6yRpRQw==
X-Google-Smtp-Source: ABdhPJyfVtddZ45VkLEG0xbzDemqeE1ll2R++itxclUYcRHamKIxvqHxvcWGowyOx8tthxIB/+RWZEX7pseZf1A0vr8=
X-Received: by 2002:a05:6512:74f:: with SMTP id c15mr8465079lfs.26.1593710147267;
 Thu, 02 Jul 2020 10:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <87imfwd5f6.fsf@nanos.tec.linutronix.de> <8DD3180E-0E69-4FD6-92C3-311AAB3F688F@amacapital.net>
 <87d064d13p.fsf@nanos.tec.linutronix.de> <CA+G9fYvVEMVaF=qzhCpJ8NMb1-VN4cEh6sw8P_eNFCLQYOjCzA@mail.gmail.com>
 <20200702150250.GS4800@hirez.programming.kicks-ass.net>
In-Reply-To: <20200702150250.GS4800@hirez.programming.kicks-ass.net>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Jul 2020 22:45:35 +0530
Message-ID: <CA+G9fYs2oBzFnDHOd8ZKw7EH0qzYkk4S15LzyP6s2=PJ_-xXXQ@mail.gmail.com>
Subject: Re: Perf: WARNING: arch/x86/entry/common.c:624 idtentry_exit_cond_rcu+0x92/0xc0
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, cj.chengjian@huawei.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        lkft-triage@lists.linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 at 20:33, Peter Zijlstra <peterz@infradead.org> wrote:

>
> How's this?
>
> DEFINE_IDTENTRY_DEBUG() is DEFINE_IDTENTRY_RAW on x86_64
>                            DEFINE_IDTENTRY on i386
>
> calling exc_debug_*() from DEFINE_IDTENTRY() does a double layer of
> idtentry_{enter,exit}*() functions.
>
> Also, handle_debug() is still a trainwreck, we should never get to
> cond_local_irq_enable() when !user.
>
> Completely untested...

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

The patch did not apply smooth.
I have manually edited the patch [1] and applied it on top of linus
master branch
and tested on x86_64 and i386 and test pass and the reported WARNING gone.

ref:
patch link
[1] https://pastebin.com/mBHkP1A6

Test jobs links,
https://lkft.validation.linaro.org/scheduler/job/1538367#L1218
https://lkft.validation.linaro.org/scheduler/job/1538368#L1271

- Naresh
