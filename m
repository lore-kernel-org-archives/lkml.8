Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631C2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC8E21532
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K/EwsJHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404920AbgE1QOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404861AbgE1QOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:14:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC95C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=34M3bU0/0QB8LQP8GZrCo5U3TUnUpPnt7qaBIw2Vc+U=; b=K/EwsJHMR7zcvmSnJisDj2ik7b
        rfd8mjkBI7FtHlsfl9MHuzDEvnur5rjVB+Vt2wHR8x25PHMW9yi196plPq47Aq/avd5Ys+Mbygyip
        V1AGvEQTjf2yXqPXQNeJukYyZt+Sd2q3dGt0jiqa1ebjh0tMrmM7Fmvg70B6wXDUtpt/ayQGm4+Jn
        QnE98kaRPEQ4e0OF7o+O955atZf1rlBBUSwC3Cq7MptiRdw3naGg7AtzNV9HMCJMIkpFqscr14NAg
        vGt3E5OlXa/IONnRUXwrimhu9ZfGf1o2/En9LnY7/cbE2oq9pb4o7BOl4eKkUESQi26ih4orSe370
        s4IXOBHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeLB4-0004rd-Vu; Thu, 28 May 2020 16:14:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10CE09836F8; Thu, 28 May 2020 18:14:41 +0200 (CEST)
Date:   Thu, 28 May 2020 18:14:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [patch 2/5] x86/idt: Add comments about early #PF handling
Message-ID: <20200528161440.GJ2483@worktop.programming.kicks-ass.net>
References: <20200528145315.727724091@linutronix.de>
 <20200528145522.807135882@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528145522.807135882@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:53:17PM +0200, Thomas Gleixner wrote:
> The difference between 32 and 64 bit vs. early #PF handling is not
> documented. Replace the FIXME at idt_setup_early_pf() with proper comments.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/idt.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -61,7 +61,11 @@ static bool idt_setup_done __initdata;
>  static const __initconst struct idt_data early_idts[] = {
>  	INTG(X86_TRAP_DB,		asm_exc_debug),
>  	SYSG(X86_TRAP_BP,		asm_exc_int3),
> +
>  #ifdef CONFIG_X86_32
> +	/*
> +	 * Not possible on 64-bit. See idt_setup_early_pf() for details.
> +	 */
>  	INTG(X86_TRAP_PF,		asm_exc_page_fault),
>  #endif
>  };
> @@ -276,8 +280,10 @@ void __init idt_setup_traps(void)
>   * cpu_init() is invoked and sets up TSS. The IST variant is installed
>   * after that.
>   *
> - * FIXME: Why is 32bit and 64bit installing the PF handler at different
> - * places in the early setup code?
> + * Note, that X86_64 cannot install the real #PF handler in
> + * idt_setup_early_traps() because the memory intialization needs the #PF
> + * handler from the early_idt_handler_array to initialize the early page
> + * tables.

+ "See early_make_pgtables()" ?

I had to frob around in head_64.S to find wth that early handler
actually did.

>   */
>  void __init idt_setup_early_pf(void)
>  {
> 
