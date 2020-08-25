Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72636C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4343520782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lpohMO4A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CFSF1lVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgHYHV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:21:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47524 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgHYHVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:21:55 -0400
Date:   Tue, 25 Aug 2020 09:21:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598340113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dMiNCEJ8BasINNDn7lM/cZvFiMvMZcNk+zxoVqGBx0c=;
        b=lpohMO4AuqciTq7XljGE/G6Tn+Q3G1RblpL1soN2WKA+jafIfUYM+lazj3F5s2Vnfx4D5s
        2VIGsTbgLnTPkSK6dqtp0j6oZHScwD4k8kvyjd4oAhLqaoTFi41AB35mLbEnqB1i+Fck+/
        e3RNHtBM4ewSNktev6GgoReG6rxHulCKkjcCeFHAlnQ4qpYSVUIHSBl5UggT/yJaD5Z9zL
        2gkqfxsKbQWqfhSe7bgmptTbQKTfyFhQytXSjvsuqyBvWC119GwzQ3ewVssLpK9acgqqEF
        WDIYNBFweYzw/6Mi6+fz2EhEqLNC30L8bBOUhklEEyaStbJjqnFlX1waKWwGzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598340113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dMiNCEJ8BasINNDn7lM/cZvFiMvMZcNk+zxoVqGBx0c=;
        b=CFSF1lVUmnhX4zs4jWvsEjHzIO4f477Y3lFEcnW9PCL0KkPZ3ufd/79F0cnlDvuO0f0Jr+
        hrR7F4GAPgW9XmDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        oferle@mellanox.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] irqchip/eznps: Fix build error for !ARC700 builds
Message-ID: <20200825072152.725jmtlcqah5oos4@linutronix.de>
References: <20200824230149.199656-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824230149.199656-1-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-24 16:01:49 [-0700], Vineet Gupta wrote:

A little of patch description wouldn't hurt. Especially since it is not
a simple move but IENABLE comes out of nowhere.

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: http://lists.infradead.org/pipermail/linux-snps-arc/2020-August/004032.html

That link gets lost if someone decides to recreate the pipermail archive
and you have no hint what it was. Using

  Link: https://lkml.kernel.org/r/20200824095831.5lpkmkafelnvlpi2@linutronix.de

instead will instead give you the message-id in case lore dies or the
lkml.kernel.org redirect service goes into retirement.

> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
>  arch/arc/plat-eznps/include/plat/ctop.h | 1 -
>  include/soc/nps/common.h                | 6 ++++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arc/plat-eznps/include/plat/ctop.h b/arch/arc/plat-eznps/include/plat/ctop.h
> index a4a61531c7fb..77712c5ffe84 100644
> --- a/arch/arc/plat-eznps/include/plat/ctop.h
> +++ b/arch/arc/plat-eznps/include/plat/ctop.h
> @@ -33,7 +33,6 @@
>  #define CTOP_AUX_DPC				(CTOP_AUX_BASE + 0x02C)
>  #define CTOP_AUX_LPC				(CTOP_AUX_BASE + 0x030)
>  #define CTOP_AUX_EFLAGS				(CTOP_AUX_BASE + 0x080)
> -#define CTOP_AUX_IACK				(CTOP_AUX_BASE + 0x088)
>  #define CTOP_AUX_GPA1				(CTOP_AUX_BASE + 0x08C)
>  #define CTOP_AUX_UDMC				(CTOP_AUX_BASE + 0x300)
>  
> diff --git a/include/soc/nps/common.h b/include/soc/nps/common.h
> index 9b1d43d671a3..8c18dc6d3fde 100644
> --- a/include/soc/nps/common.h
> +++ b/include/soc/nps/common.h
> @@ -45,6 +45,12 @@
>  #define CTOP_INST_MOV2B_FLIP_R3_B1_B2_INST	0x5B60
>  #define CTOP_INST_MOV2B_FLIP_R3_B1_B2_LIMM	0x00010422
>  
> +#ifndef AUX_IENABLE
> +#define AUX_IENABLE				0x40c
> +#endif
> +
> +#define CTOP_AUX_IACK				(0xFFFFF800 + 0x088)
> +
>  #ifndef __ASSEMBLY__
>  
>  /* In order to increase compilation test coverage */

Sebastian
