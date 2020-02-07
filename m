Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D169C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612DB20726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EcLtczvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBGL1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:27:42 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47660 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGL1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=x1VnWLZd/ipfmC11QBc/PnLMdism1SxK3sdpzs5jQ+A=; b=EcLtczvFv2RmHlp3a5ImArwhAD
        pN0JdKwHen2jMwv7Io6UFiAwwvjle6kowP+mCMj6Ppq4LzvkPtTcqkZdf96KfO/RraQ6b/pc0DK3S
        Gc3G1J267WTyqGoFifChMxPzLBvLpXXe5k6L3GsPQo+aFHtpHkE5MgoGBCmDiojLD59T93Ul8Jnp6
        3e7k/1Plax/0nzyQVvj0i4XFR2NGFNvLDePaPgvXiBHe+0I1VkZwmOKoO2FhH4FHfBTCEXGon3fIH
        R21IpYLYa8Rnk72iPQWv3FouYHP+D2jU/MO6Mxte9+qgK3eUCvOnizgisNOgjBAWAOV4t9v1R3Hd4
        NoTiJldQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j01n9-00073o-Dr; Fri, 07 Feb 2020 11:27:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8D543011E8;
        Fri,  7 Feb 2020 12:25:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3B422B836D8C; Fri,  7 Feb 2020 12:27:20 +0100 (CET)
Date:   Fri, 7 Feb 2020 12:27:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org, Will Deacon <will@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        ard.biesheuvel@linaro.org, james.morse@arm.com, rabin@rab.in,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [tip: core/kprobes] arm/ftrace: Use __patch_text()
Message-ID: <20200207112720.GF14914@hirez.programming.kicks-ass.net>
References: <20191113092636.GG4131@hirez.programming.kicks-ass.net>
 <157544841563.21853.2859696202562513480.tip-bot2@tip-bot2>
 <10cbfd9e-2f1f-0a0c-0160-afe6c2ccbebd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10cbfd9e-2f1f-0a0c-0160-afe6c2ccbebd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 12:26:46AM +0300, Dmitry Osipenko wrote:
> 04.12.2019 11:33, tip-bot2 for Peter Zijlstra пишет:
> > @@ -97,10 +94,7 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
> >  			return -EINVAL;
> >  	}
> >  
> > -	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
> > -		return -EPERM;
> > -
> > -	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
> > +	__patch_text((void *)pc, new);
> >  
> >  	return 0;
> >  }
> > 
> 
> Hello,
> 
> NVIDIA Tegra20/30 are not booting with CONFIG_FTRACE=y, but even with
> CONFIG_FTRACE=n things are not working well.

Ooh, I think I see. Can you try this:

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 2a5ff69c28e6..10499d44964a 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -78,13 +78,10 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
 {
 	unsigned long replaced;
 
-	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
 		old = __opcode_to_mem_thumb32(old);
-		new = __opcode_to_mem_thumb32(new);
-	} else {
+	else
 		old = __opcode_to_mem_arm(old);
-		new = __opcode_to_mem_arm(new);
-	}
 
 	if (validate) {
 		if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
