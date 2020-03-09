Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C637C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264C620578
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WvmVXXNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCIPjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:39:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57448 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgCIPjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:39:19 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 029FdEgD057358;
        Mon, 9 Mar 2020 10:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583768354;
        bh=5NMdHScQpOzmekHtb8MLspeqES1SnaeW3nR3WGI9oxk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=WvmVXXNMq+oeJY9LSUEt8Q+Hov1Mf1dNbjoyPKl+9fpve0/zEo+Zv3g+73KSbgdiG
         AsPRL7vRdPBRwjZ23BvcA1ubznfkJjfUF5+HriEagTz1zOK/BC7VhK+u+SLldIdNmy
         GjCQcm+WLtCqKO2yWaStw5O+spc8I72uNz+PWndo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 029FdEZC054556;
        Mon, 9 Mar 2020 10:39:14 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Mar
 2020 10:38:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Mar 2020 10:38:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 029FcD4i106953;
        Mon, 9 Mar 2020 10:38:13 -0500
Date:   Mon, 9 Mar 2020 10:44:01 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <od@zcrc.me>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] usb: musb: jz4740: Register USB role switch
Message-ID: <20200309154401.GB31115@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200224014008.27114-1-paul@crapouillou.net>
 <20200224014008.27114-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200224014008.27114-3-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 23, 2020 at 10:40:06PM -0300, Paul Cercueil wrote:
> Register a USB role switch, in order to get notified by the connector
> driver when the USB role changes. The notification is then transmitted
> to the PHY.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: No change
> 
>  drivers/usb/musb/Kconfig  |  1 +
>  drivers/usb/musb/jz4740.c | 46 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index c4b349e074c1..3268adb7d7cf 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -113,6 +113,7 @@ config USB_MUSB_JZ4740
>  	depends on MIPS || COMPILE_TEST
>  	depends on USB_MUSB_GADGET
>  	depends on USB=n || USB_OTG_BLACKLIST_HUB
> +	select USB_ROLE_SWITCH
>  
>  config USB_MUSB_MEDIATEK
>  	tristate "MediaTek platforms"
> diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
> index aa32b5af0c1f..bbfeb9881788 100644
> --- a/drivers/usb/musb/jz4740.c
> +++ b/drivers/usb/musb/jz4740.c
> @@ -12,13 +12,16 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/usb/role.h>
>  #include <linux/usb/usb_phy_generic.h>
>  
>  #include "musb_core.h"
>  
>  struct jz4740_glue {
>  	struct platform_device	*pdev;
> +	struct musb		*musb;
>  	struct clk		*clk;
> +	struct usb_role_switch	*role_sw;
>  };
>  
>  static irqreturn_t jz4740_musb_interrupt(int irq, void *__hci)
> @@ -72,11 +75,38 @@ static const struct musb_hdrc_config jz4740_musb_config = {
>  	.fifo_cfg_size	= ARRAY_SIZE(jz4740_musb_fifo_cfg),
>  };
>  
> +static int jz4740_musb_role_switch_set(struct device *dev, enum usb_role role)

The prototype has been changed by bce3052f0c16 ("usb: roles: Provide the
switch drivers handle to the switch in the API"). Please update.

Thanks,
-Bin.
