Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F85C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512DE20801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgFLJBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgFLJBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:01:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C61C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 02:01:24 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jjfYc-0000VY-SN; Fri, 12 Jun 2020 11:01:02 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id DD984100F5A; Fri, 12 Jun 2020 11:01:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
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
Subject: Re: Perf: WARNING: arch/x86/entry/common.c:624 idtentry_exit_cond_rcu+0x92/0xc0
In-Reply-To: <CALCETrVQxFq2b5ydSk-w4W-7+6OMro0jyHQqtFoM2Tvn_=aLSQ@mail.gmail.com>
References: <CA+G9fYvF3cyrY+-iw_SZtpN-i2qA2BruHg4M=QYECU2-dNdsMw@mail.gmail.com> <CALCETrXqhwJzhsAoM72tskso5aDELgfGLnHdGYHiAFmgCPforQ@mail.gmail.com> <20200611192518.GA2483@worktop.programming.kicks-ass.net> <CALCETrXq2sVuT39+oB2CskQBP3nNk4ogx+cwv-Jc3vE-uZazYg@mail.gmail.com> <CALCETrVQxFq2b5ydSk-w4W-7+6OMro0jyHQqtFoM2Tvn_=aLSQ@mail.gmail.com>
Date:   Fri, 12 Jun 2020 11:01:01 +0200
Message-ID: <87imfwd5f6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> On Thu, Jun 11, 2020 at 4:22 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> Two bugs here.
>
> 1. We had an issue with WARN. Patch sent.

Grabbed it

> 2. idtentry.h has, for x86_32:
>
> # define DEFINE_IDTENTRY_IST  DEFINE_IDTENTRY
>
> This is nonsense.  It's getting late over here and I'd rather focus on
> the more interesting RCU issue, so that's all from me today.

Well, this might be nonsense, but it's exactly matching the current code
in mainline which, e.g. for #DB does:

SYM_CODE_START(debug)
	/*
	 * Entry from sysenter is now handled in common_exception
	 */
	ASM_CLAC
	pushl	$0
	pushl	$do_debug
	jmp	common_exception
SYM_CODE_END(debug)

There is no IST on 32bit, never was. We do software stack switching for
device interrupts, but that's a different story.

Thanks,

        tglx
