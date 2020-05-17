Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCDDC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 16:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12CB207D4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 16:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KOFm0Jp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgEQQCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 12:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgEQQCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 12:02:48 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169CBC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E9G0K1xzYmVUjRPXAZZB5OxYfrHyxpKU/RdYiB/52Ug=; b=KOFm0Jp32Y0Oe1wtaukenFyRr
        8d18iO22LgaBq+Z18aOew3tkghELlKKJhz1ZWvhcmxgrZFHhyT5yAWQV0UWCoUZLUGmgNYfvYjriP
        auzEDF8wBhKu54qfoF8SvhpjKDBSl2NedyViOcjdtZdV41iCDNgmihaQXnPdTKrzVl7vlz8OMkP7F
        /RylV8Aif2uC3YUVP7Ui/eJZTJldYMsD5KbMwGXQnWUVzposGv2mxf/7SAXEtWVIO/2HHtspPo1j9
        9jKd3HFspWywYMbZ50T8JQIKEHJ2WknacGWPjxnKuvi+ev/ysfDOEnRGZlcx5IKyob5BPtFz47ach
        +VBphNApw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:59208)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jaLkE-0005iI-86; Sun, 17 May 2020 17:02:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jaLkB-0003oG-6i; Sun, 17 May 2020 17:02:27 +0100
Date:   Sun, 17 May 2020 17:02:27 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mhiramat@kernel.org, labbott@redhat.com,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: kprobes: Avoid fortify_panic() when copying
 optprobe template
Message-ID: <20200517160227.GU1551@shell.armlinux.org.uk>
References: <20200517153959.293224-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517153959.293224-1-andrew@aj.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 01:09:59AM +0930, Andrew Jeffery wrote:
> Setting both CONFIG_KPROBES=y and CONFIG_FORTIFY_SOURCE=y on ARM leads
> to a panic in memcpy() when injecting a kprobe despite the fixes found
> in commit e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with
> FORTIFY_SOURCE") and commit 0ac569bf6a79 ("ARM: 8834/1: Fix: kprobes:
> optimized kprobes illegal instruction").
> 
> arch/arm/include/asm/kprobes.h effectively declares
> the target type of the optprobe_template_entry assembly label as a u32,
> which leads memcpy()'s __builtin_object_size() call to determine that
> the pointed-to object is of size four. In practical terms the symbol is
> used as a handle for the optimised probe assembly template that is at
> least 96 bytes in size. The symbol's use despite its type blows up the
> memcpy() in ARM's arch_prepare_optimized_kprobe() with a false-positive
> fortify_panic() when it should instead copy the optimised probe template
> into place.
> 
> As mentioned, a couple of attempts have been made to address the issue
> by casting a pointer to optprobe_template_entry before providing it to
> memcpy(), however gccs such as Ubuntu 20.04's arm-linux-gnueabi-gcc
> 9.3.0 (Ubuntu 9.3.0-10ubuntu1) see through these efforts.
> 
> Squash the false-positive by aliasing the template assembly with a new
> symbol 'arm_optprobe_template'; declare it as a function object and
> pass the function object as the argument to memcpy() such that
> __builtin_object_size() cannot immediately determine the object size.
> 
> Fixes: e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE")
> Fixes: 0ac569bf6a79 ("ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction")
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  arch/arm/include/asm/kprobes.h    | 7 +++++++
>  arch/arm/probes/kprobes/opt-arm.c | 4 +++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
> index 213607a1f45c..94db8bf25f9c 100644
> --- a/arch/arm/include/asm/kprobes.h
> +++ b/arch/arm/include/asm/kprobes.h
> @@ -43,6 +43,13 @@ int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
>  int kprobe_exceptions_notify(struct notifier_block *self,
>  			     unsigned long val, void *data);
>  
> +/*
> + * The optprobe template buffer is not anything that should be called directly,
> + * however describe it as a function to give ourselves a handle to it that
> + * bypasses CONFIG_FORTIFY_SOURCE=y sanity checks in memcpy().
> + */
> +extern __visible void arm_optprobe_template(void);

Does this really need to be globally visible to anything that happens
to include this header?

While we may abhor "extern" declarations and prototypes in .c files, it
seems to me to be entirely reasonable for this to live in opt-arm.c and
remove the .global for this symbol, thereby making this symbol local to
opt-arm.c

> +
>  /* optinsn template addresses */
>  extern __visible kprobe_opcode_t optprobe_template_entry;
>  extern __visible kprobe_opcode_t optprobe_template_val;
> diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
> index 7a449df0b359..59133d59616a 100644
> --- a/arch/arm/probes/kprobes/opt-arm.c
> +++ b/arch/arm/probes/kprobes/opt-arm.c
> @@ -31,6 +31,8 @@
>   * to the stack cost of the instruction.
>   */
>  asm (
> +			".global arm_optprobe_template\n"
> +			"arm_optprobe_template:\n"
>  			".global optprobe_template_entry\n"
>  			"optprobe_template_entry:\n"
>  			".global optprobe_template_sub_sp\n"
> @@ -234,7 +236,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
>  	}
>  
>  	/* Copy arch-dep-instance from template. */
> -	memcpy(code, (unsigned long *)&optprobe_template_entry,
> +	memcpy(code, arm_optprobe_template,
>  			TMPL_END_IDX * sizeof(kprobe_opcode_t));
>  
>  	/* Adjust buffer according to instruction. */
> -- 
> 2.25.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
