Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA626C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE0224687
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgB0EKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:10:38 -0500
Received: from kernel.crashing.org ([76.164.61.194]:36582 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbgB0EKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 23:10:37 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 01R49rsH022471
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Feb 2020 22:09:56 -0600
Message-ID: <2f424decb5fc2e4bc945682e0839aa2f2d2e14ee.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 3/7] usb: gadget: aspeed: add ast2600 vhub support
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     rentao.bupt@gmail.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Date:   Thu, 27 Feb 2020 15:09:52 +1100
In-Reply-To: <20200226230346.672-4-rentao.bupt@gmail.com>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
         <20200226230346.672-4-rentao.bupt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-26 at 15:03 -0800, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Add AST2600 support in aspeed-vhub driver. There are 3 major
> differences
> between AST2500 and AST2600 vhub:
>   - AST2600 supports 7 downstream ports while AST2500 supports 5.
>   - AST2600 supports 21 generic endpoints while AST2500 supports 15.
>   - EP0 data buffer's 8-byte DMA alignment restriction is removed
> from
>     AST2600.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  No Change in v3/v4.
>  Changes in v2:
>    - removed "ast_vhub_config" related logic.
> 
>  drivers/usb/gadget/udc/aspeed-vhub/Kconfig | 4 ++--
>  drivers/usb/gadget/udc/aspeed-vhub/core.c  | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> b/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> index 83ba8a2eb6af..605500b19cf3 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> @@ -4,5 +4,5 @@ config USB_ASPEED_VHUB
>  	depends on ARCH_ASPEED || COMPILE_TEST
>  	depends on USB_LIBCOMPOSITE
>  	help
> -	  USB peripheral controller for the Aspeed AST2500 family
> -	  SoCs supporting the "vHub" functionality and USB2.0
> +	  USB peripheral controller for the Aspeed AST2400, AST2500 and
> +	  AST2600 family SoCs supporting the "vHub" functionality and
> USB2.0
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> index f8ab8e012f34..f8d35dd60c34 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> @@ -423,6 +423,9 @@ static const struct of_device_id
> ast_vhub_dt_ids[] = {
>  	{
>  		.compatible = "aspeed,ast2500-usb-vhub",
>  	},
> +	{
> +		.compatible = "aspeed,ast2600-usb-vhub",
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ast_vhub_dt_ids);

