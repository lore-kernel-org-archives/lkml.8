Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F19C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8274D206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="a38NKQ5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgGWH41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:56:27 -0400
Received: from smtp1.axis.com ([195.60.68.17]:10893 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgGWH40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2866; q=dns/txt; s=axis-central1;
  t=1595490985; x=1627026985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4tk5dl/I9CocNqe8nQ3SjDglchoPKe3JhKQ0S/Rdjqs=;
  b=a38NKQ5PfV8r6CEUY5bW7uU7YP9pxejKEBisRTgjkVK8FBnvABpWgDSi
   vaFtOdGJAIipAfY7MwuEL70iUm2bM4q4zPfg1VpikwPP6kR+LwRBBGRCc
   QTUIsyfdGMYRy9Loe2u0+qDhUzRxOm6tu0VESwQCqxSZ07KyjvmV9oybH
   v/Rp5xFJktqWDfLSl1/qZvc+1qPtdobQ+6TuXMhfLK8MpkkWjLJSBrpY8
   XPhRrenlpfLuBCl5T72ffh1aYqqf4yhDyxSUqpgxpBg+rvdMROUrXCsc/
   P0LGJ5zA5Y9IzW3grg2MCqiq8xeyoSFQj1Jfhw1AqWkv7kwJkkAST/ym+
   A==;
IronPort-SDR: 2m2vDWpuYU7qwfCeogPy2Z0U7Sbt1b5hJm2caHhvITOQMZpaOLhXPbHhryhXo4UdTQvxOlAaJz
 JD3Pn5LVzbEonH7fFQP1KEluCZ4AazJjuNL6bYPv0zTcwgnG6xusIHTxQMpjYrqSIlT6sXcaCl
 SwCw0o1eRZgPkR21XCskNcO/I2vZ5srna0AVkYjhwgzMtcwftDvY78bG/aOfepPsV6deEp7pbT
 AjbGq1qX8oEOAhxmte9bkIJacfX9LM2IlZcRLSJAkbkec7z8eHlMqES2H6wr2nUmPb2FoOLk0e
 Zrk=
X-IronPort-AV: E=Sophos;i="5.75,386,1589234400"; 
   d="scan'208";a="11135062"
Date:   Thu, 23 Jul 2020 09:56:14 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: Add support for VBUS power control
Message-ID: <20200723075612.tn5dbkhes2chohwh@axis.com>
References: <20200619142512.19824-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200619142512.19824-1-mike.looijmans@topic.nl>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 04:25:12PM +0200, Mike Looijmans wrote:
> +void dwc3_set_vbus(struct dwc3 *dwc, bool enable)
> +{
> +	int ret;
> +
> +	if (enable != dwc->vbus_reg_enabled) {
> +		if (enable)
> +			ret = regulator_enable(dwc->vbus_reg);
> +		else
> +			ret = regulator_disable(dwc->vbus_reg);

dwc->vbus_reg is set to NULL when the regulator is not present.  These
regulator_* functions expect a non-NULL pointer so a NULL check is
required before calling them.

> +		if (!ret)
> +			dwc->vbus_reg_enabled = enable;
> +	}
> +
> +	if (dwc->usb2_phy)
> +		otg_set_vbus(dwc->usb2_phy->otg, enable);
> +}
> +
>  static void __dwc3_set_mode(struct work_struct *work)
>  {
>  	struct dwc3 *dwc = work_to_dwc(work);
> @@ -164,8 +182,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>  		if (ret) {
>  			dev_err(dwc->dev, "failed to initialize host\n");
>  		} else {
> -			if (dwc->usb2_phy)
> -				otg_set_vbus(dwc->usb2_phy->otg, true);
> +			dwc3_set_vbus(dwc, true);
>  			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>  			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>  		}
> @@ -173,8 +190,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>  	case DWC3_GCTL_PRTCAP_DEVICE:
>  		dwc3_event_buffers_setup(dwc);
>  
> -		if (dwc->usb2_phy)
> -			otg_set_vbus(dwc->usb2_phy->otg, false);
> +		dwc3_set_vbus(dwc, false);
>  		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
>  		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
>  
> @@ -1183,8 +1199,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  	case USB_DR_MODE_PERIPHERAL:
>  		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>  
> -		if (dwc->usb2_phy)
> -			otg_set_vbus(dwc->usb2_phy->otg, false);
> +		dwc3_set_vbus(dwc, false);
>  		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
>  		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
>  
> @@ -1198,8 +1213,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  	case USB_DR_MODE_HOST:
>  		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
>  
> -		if (dwc->usb2_phy)
> -			otg_set_vbus(dwc->usb2_phy->otg, true);
> +		dwc3_set_vbus(dwc, true);
>  		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>  		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>  
> @@ -1470,6 +1484,14 @@ static int dwc3_probe(struct platform_device *pdev)
>  
>  	dwc3_get_properties(dwc);
>  
> +	dwc->vbus_reg = devm_regulator_get_optional(dev, "vbus");
> +	if (IS_ERR(dwc->vbus_reg)) {
> +		if (PTR_ERR(dwc->vbus_reg) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;

Some drivers seem to do it this way, but I think it would be more
correct to return all errors that aren't ENODEV, like
drivers/gpu/drm/exynos/exynos_hdmi.c does.  That way you would allow the
regulator to not be present, but you also wouldn't silently ignore other
errors such as ENOMEM.

> +
> +		dwc->vbus_reg = NULL;
> +	}
> +
