Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CBAC35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5712C24681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgA1JlT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:41:19 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41415 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgA1JlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:41:19 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iwN4U-00038f-Iu; Tue, 28 Jan 2020 10:22:10 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iwN4S-00034Z-Jb; Tue, 28 Jan 2020 10:22:08 +0100
Message-ID: <01d73961207b5110c2edc72d4964582b12bcc8f7.camel@pengutronix.de>
Subject: Re: [PATCH v1 2/5] reset: brcmstb-rescal: add unspecified HAS_IOMEM
 dependency
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, heidifahim@google.com
Date:   Tue, 28 Jan 2020 10:22:08 +0100
In-Reply-To: <20200127235356.122031-3-brendanhiggins@google.com>
References: <20200127235356.122031-1-brendanhiggins@google.com>
         <20200127235356.122031-3-brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-27 at 15:53 -0800, Brendan Higgins wrote:
> Currently CONFIG_RESET_BRCMSTB_RESCAL=y implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> the following build error:
> 
> /usr/bin/ld: drivers/reset/reset-brcmstb-rescal.o: in function `brcm_rescal_reset_probe':
> drivers/reset/reset-brcmstb-rescal.c:76: undefined reference to `devm_ioremap_resource'
> 
> Fix the build error by adding the unspecified dependency.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/reset/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 461b0e506a26f..a19bd303f31a9 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -51,6 +51,7 @@ config RESET_BRCMSTB
>  
>  config RESET_BRCMSTB_RESCAL
>  	bool "Broadcom STB RESCAL reset controller"
> +	depends on HAS_IOMEM
>  	default ARCH_BRCMSTB || COMPILE_TEST
>  	help
>  	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on

Thank you, I'll pick up the reset patches 2 and 3.

regards
Philipp
