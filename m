Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D75C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5322E208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="m1bbgEjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbgFPTaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:30:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56648 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730139AbgFPTaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:30:01 -0400
Received: from zn.tnic (p200300ec2f0f4c0065584234413100e1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4c00:6558:4234:4131:e1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 86AD71EC0289;
        Tue, 16 Jun 2020 21:30:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592335800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QeyWb9lUgDLyCat8HPesiOku9Uoen29AAGJ4eKLbXfY=;
        b=m1bbgEjl200cxLF5iGDsuTrNIi6AQZILJhmjutD8yNY4Z2507FeLL4M3xW+xUvoelpjO/E
        pws/ly5ux0vzJvD5UrbkW/wajkL7yVuIm8YD6v/uGH8U0ncVOj/FZvHP1b0DzbYUvsBZXz
        neCZlTQGqe0wj7sw4g+IkynPL8YWCuw=
Date:   Tue, 16 Jun 2020 21:29:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Add Skylake quirk for patrol scrub reported
 errors
Message-ID: <20200616192952.GO13515@zn.tnic>
References: <20200615184056.26531-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200615184056.26531-1-tony.luck@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:40:56AM -0700, Tony Luck wrote:
> From: Youquan Song <youquan.song@intel.com>
> 
> Skylake has a mode where the system administrator can use a BIOS setup
> option to request that the memory controller report uncorrected errors
> found by the patrol scrubber as corrected.  This results in them being
> signalled using CMCI, which is less disruptive than a machine check.
> 
> Add a quirk to detect that a "corrected" error is actually a downgraded
> uncorrected error with model specific checks for the "MSCOD" signature in
> MCi_STATUS and that the error was reported from a memory controller bank.
> 
> Adjust the severity to MCE_AO_SEVERITY so that Linux will try to take
> the affected page offline.
> 
> [Tony: Wordsmith commit comment]
> 
> Signed-off-by: Youquan Song <youquan.song@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index e9265e2f28c9..0dbd0a21a0bf 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -123,6 +123,8 @@ static struct irq_work mce_irq_work;
>  
>  static void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs *regs);
>  
> +static void no_adjust_mce_log(struct mce *m) {};
> +static void (*adjust_mce_log)(struct mce *m) = no_adjust_mce_log;
>  /*
>   * CPU/chipset specific EDAC code can register a notifier call here to print
>   * MCE errors in a human-readable form.
> @@ -772,6 +774,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>  		if (mca_cfg.dont_log_ce && !mce_usable_address(&m))
>  			goto clear_it;
>  
> +		adjust_mce_log(&m);
>  		mce_log(&m);

Two things: can that error type be detected when #MC gets raised, i.e., in
do_machine_check() as part of scanning all banks?

If so, then the adjusting needs to happen inside mce_log().

Also, that assignment to the function pointer doesn't make much sense to
me and I think you should do the vendor/family/model checking straight
in a function adjust_mce_log() which gets called by whoever...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
