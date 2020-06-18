Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71696C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F43620890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgFRUCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730805AbgFRUCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:02:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D39C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:02:46 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jm0k2-0001uq-Jc; Thu, 18 Jun 2020 22:02:31 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 10965101482; Thu, 18 Jun 2020 22:02:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Cyril Hrubis <chrubis@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Andy Lutomirski <luto@kernel.org>, ltp@lists.linux.it
Subject: Re: [LTP] [x86/entry] 2bbc68f837: ltp.ptrace08.fail
In-Reply-To: <20200617131742.GD8389@yuki.lan>
References: <87y2onbdtb.fsf@nanos.tec.linutronix.de> <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net> <20200616132705.GW2531@hirez.programming.kicks-ass.net> <20200617131742.GD8389@yuki.lan>
Date:   Thu, 18 Jun 2020 22:02:30 +0200
Message-ID: <87r1ucb0rt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cyril Hrubis <chrubis@suse.cz> writes:
> What is does is to write:
>
> 	(void*)1 to u_debugreg[0]
> 	(void*)1 to u_debugreg[7]
> 	do_debug addr to u_debugreg[0]
>
> Looking at the kernel code the write to register 7 enables the breakpoints and
> what we attempt here is to change an invalid address to a valid one after we
> enabled the breakpoint but that's as far I can go.
>
> So does anyone has an idea how to trigger the bug without the do_debug function
> address? Would any valid kernel function address suffice?

According to https://www.openwall.com/lists/oss-security/2018/05/01/3
the trigger is to set the breakpoint to do_debug() and then execute
INT1, aka. ICEBP which ends up in do_debug() ....

In principle each kernel address is ok, but do_debug() is interesting
due to the recursion issue because user space can reach it by executing
INT1.

So you might check for exc_debug() if do_debug() is not available and
make the whole thing fail gracefully with a usefu error message.

Thanks,

        tglx
