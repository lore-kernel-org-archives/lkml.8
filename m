Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF39C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 14:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A836F2469C
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 14:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="r/hOCw/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgB2Ogv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 09:36:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39600 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbgB2Ogv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 09:36:51 -0500
Received: from zn.tnic (p200300EC2F1D580074FEC020E389DD32.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:5800:74fe:c020:e389:dd32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 976921EC0C9D;
        Sat, 29 Feb 2020 15:36:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582987009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l/xIGwTtnSO9nmCEizm7Hm3VTAwFUx4IN8eQJwkGvM0=;
        b=r/hOCw/dys8HCW+V26Y7NtUc0mCpAWfj3q68cI0pJ0c8PUE90EIrI00PkoI5fbFCwjbHNJ
        C6lKMNY79y9IkvfHEPWFKHjOoMYL7TsCip2dQnG8bdQKq+dn7PhK4q9Sm08xWksQN/LUaf
        Zqt+UOjvK5JwuHnO2xw1fzSuaPj7Sa4=
Date:   Sat, 29 Feb 2020 15:36:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 8/8] x86/fpu/xstate: Restore supervisor xstates for
 __fpu__restore_sig()
Message-ID: <20200229143644.GA1129@zn.tnic>
References: <20200228121724.GA25261@zn.tnic>
 <89bcab262d6dad4c08c4a21e522796fea2320db3.camel@intel.com>
 <20200228162359.GC25261@zn.tnic>
 <6f91699c91f9ea0f527e80ed3ea2999444a8d2d1.camel@intel.com>
 <20200228172202.GD25261@zn.tnic>
 <9a283ad42da140d73de680b1975da142e62e016e.camel@intel.com>
 <20200228183131.GE25261@zn.tnic>
 <7c6560b067436e2ec52121bba6bff64833e28d8d.camel@intel.com>
 <20200228214742.GF25261@zn.tnic>
 <c8da950a64db495088f0abe3932a489a84e4da97.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8da950a64db495088f0abe3932a489a84e4da97.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:13:29PM -0800, Yu-cheng Yu wrote:
> If the XSAVES buffer already has current data (i.e. TIF_NEED_FPU_LOAD is
> set), then skip copy_xregs_to_kernel().  This happens when the task was
> context-switched out and has not returned to user-mode.

So I got tired of this peacemeal game back'n'forth and went and did your
work for ya.

First of all, on my fairly new KBL test box, the context size is almost
a kB:

[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.

Then, I added this ontop of your patchset:

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 0d3e06a772b0..2e57b8d79c0e 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -337,6 +337,8 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
         */
        fpregs_lock();
        if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
+               trace_printk("!NEED_FPU_LOAD, size: %d, supervisor: 0x%llx\n",
+                            size, xfeatures_mask_supervisor());
                if (xfeatures_mask_supervisor())
                        copy_xregs_to_kernel(&fpu->state.xsave);
                set_thread_flag(TIF_NEED_FPU_LOAD);

and traced a fairly boring kernel build workload where the kernel
.config is not even a distro one but a tailored for this machine.

Which means, it took 3m35.058s to build and the trace buffer had 53973
entries like this one:

bash-1211  [002] ...1   648.238585: __fpu__restore_sig: !NEED_FPU_LOAD, size: 1092, supervisor: 0x0

which means I have

53973 / (3*60 + 35) =~ 251 XSAVES invocations per second!

And this only during this single workload - I don't even wanna imagine
what that number would be if it were a huge, overloaded box with a
signal heavy workload.

And all this overhead to save 16 + 24 bytes supervisor states and throw
away the rest up to 960 bytes each time.

Err, I don't think so.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
