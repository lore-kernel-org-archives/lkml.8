Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC315C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE16206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XvMkEJKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgBMQ42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:56:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47712 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgBMQ41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:56:27 -0500
Received: from zn.tnic (p200300EC2F07F6001C43AF432C3E1E0D.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:f600:1c43:af43:2c3e:1e0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4ED601EC0C81;
        Thu, 13 Feb 2020 17:56:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581612986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fkivMn8MGvRAC0Bvhdtut0KFBSz8+UtpKvhJLeurZK0=;
        b=XvMkEJKFKyKHfUuFDXuUrcKilPT/wg/bGv0LnT25RLfshivuyWLm91TWyGRjte+vvk/xyS
        4UF+2bVmIq1qIYkxJl9MWRzhBgmz/WcE7BLRJ2cFETM4yO50w3MxRePeFlxzLzBa3tRpI5
        2GRY0w3P029cSt1wx+SPOyLBSinakdc=
Date:   Thu, 13 Feb 2020 17:56:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] x86/mce: Add new "handled" field to "struct mce"
Message-ID: <20200213165617.GL31799@zn.tnic>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200212204652.1489-4-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200212204652.1489-4-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:46:50PM -0800, Tony Luck wrote:
> There can be many different subsystems register on the mce handler
> chain. Add a new bitmask field and define values so that handlers
> can indicate whether they took any action to log or otherwise
> handle an error.
> 
> The default handler at the end of the chain can use this information
> to decide whether to print to the console log.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/uapi/asm/mce.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
> index 955c2a2e1cf9..99ca07f7b078 100644
> --- a/arch/x86/include/uapi/asm/mce.h
> +++ b/arch/x86/include/uapi/asm/mce.h
> @@ -35,8 +35,17 @@ struct mce {
>  	__u64 ipid;		/* MCA_IPID MSR: only valid on SMCA systems */
>  	__u64 ppin;		/* Protected Processor Inventory Number */
>  	__u32 microcode;	/* Microcode revision */
> +	__u32 handled;		/* Bitmap of logging/handling actions */
>  };
>  
> +/* handled flag bits */
> +#define	MCE_HANDLED_CEC		BIT(0)
> +#define	MCE_HANDLED_UC		BIT(1)
> +#define	MCE_HANDLED_EXTLOG	BIT(2)
> +#define	MCE_HANDLED_NFIT	BIT(3)
> +#define	MCE_HANDLED_EDAC	BIT(4)
> +#define	MCE_HANDLED_MCELOG	BIT(5)
> +
>  #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
>  #define MCE_GET_LOG_LEN      _IOR('M', 2, int)
>  #define MCE_GETCLEAR_FLAGS   _IOR('M', 3, int)
> -- 

Not sure if this should be exposed to user. I don't think it has any
business poking its nose into how the MCE was handled. Or maybe it does
but I cannot think of a good example ATM.

If not, this could be

	...
	void *private;
};

which userspace can't make any assumptions about. And we can put
whatever we need in there...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
