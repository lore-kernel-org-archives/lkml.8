Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C4CC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF4720781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LKuthNgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHMPto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMPtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:49:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F07BC061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:49:42 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t11so2803663plr.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QisyeHY3ZHMM3TerX6llGGeWvEX6TJlY7NstZgbx+iA=;
        b=LKuthNgyTESR2Nb5oycvHkDmSlKMH02vcClqoGbLB+Q3J0FfgdtV/KW/wYLum4WUiZ
         OfVxpFSYY5d8YHZ3+iqoHu/a+DIQeHox5ug7EO6gbNtt/HujRCr9O0uZruzuirhrVqMC
         7tXN7EGsBqpcLjldCm3M1WB/akMnXU8vn394U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QisyeHY3ZHMM3TerX6llGGeWvEX6TJlY7NstZgbx+iA=;
        b=PazWt5gshbFHr7xuKWqX+G4g1lCIzgscDfl76rIBGdJueVb2N6OKGTKTsf7IKpoiR+
         VAnDU8Osl28TaqiENkynXoVjCfCmC2YPXfR0eG+96DQnFJzxdZQhm3fGW0DC/R1QCtvT
         DSH/PqhJ03byeOI3x96PCfyU0kQDYVj3QMrR70P8qYDK/+y8fWDfvtNWry7Nw3x05H8o
         NBgKypL+g5eroJBz3jM4oZjwGnmlNZT1IORrI0lwM9eA7bxBJUaATvoE/e4GL/rYGoVq
         7PLTcsUeu/AC9aFGY3Criv1d3Z8u9nby8fe4zcXSzEcIUSkUaPNcsb6/TXykEkst6lEu
         kLbQ==
X-Gm-Message-State: AOAM533SHp5lWwKrax6UajuP/nLeeHkiuP+O/DvjyJNPPsAkZ1EohgNi
        eHas9vjIG4R8Eu9A/fKVcJd1og==
X-Google-Smtp-Source: ABdhPJz1M1P1S51YzM2m55MEu1bwSyYnt8Ac/RYg3NEhBAQvrxXf7zaV/15+/gOI8U5pzir/Bpl51Q==
X-Received: by 2002:a17:90a:6d96:: with SMTP id a22mr5449139pjk.165.1597333782100;
        Thu, 13 Aug 2020 08:49:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id b185sm6329480pfg.71.2020.08.13.08.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 08:49:40 -0700 (PDT)
Date:   Thu, 13 Aug 2020 08:49:39 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v2 1/3] usb: dwc3: core: Host wake up support from system
 suspend
Message-ID: <20200813154939.GB2995789@google.com>
References: <1594235417-23066-1-git-send-email-sanm@codeaurora.org>
 <1594235417-23066-2-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1594235417-23066-2-git-send-email-sanm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 12:40:15AM +0530, Sandeep Maheswaram wrote:
> Avoiding phy powerdown in host mode so that it can be wake up by devices.
> Added need_phy_for_wakeup flag to distinugush resume path and hs_phy_flags
> to check connection status and set phy mode and  configure interrupts.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  drivers/usb/dwc3/core.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
>  drivers/usb/dwc3/core.h |  2 ++
>  2 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 25c686a7..eb7c225 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -31,12 +31,14 @@
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/of.h>
>  #include <linux/usb/otg.h>
> +#include <linux/usb/hcd.h>
>  
>  #include "core.h"
>  #include "gadget.h"
>  #include "io.h"
>  
>  #include "debug.h"
> +#include "../host/xhci.h"
>  
>  #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
>  
> @@ -1627,10 +1629,36 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
>  	return ret;
>  }
>  
> +static void dwc3_set_phy_speed_flags(struct dwc3 *dwc)
> +{
> +
> +	int i, num_ports;
> +	u32 reg;
> +	struct usb_hcd	*hcd = platform_get_drvdata(dwc->xhci);
> +	struct xhci_hcd	*xhci_hcd = hcd_to_xhci(hcd);
> +
> +	dwc->hs_phy_flags &= ~(PHY_MODE_USB_HOST_HS | PHY_MODE_USB_HOST_LS);
> +
> +	reg = readl(&xhci_hcd->cap_regs->hcs_params1);
> +
> +	num_ports = HCS_MAX_PORTS(reg);
> +	for (i = 0; i < num_ports; i++) {
> +		reg = readl(&xhci_hcd->op_regs->port_status_base + i * 0x04);
> +		if (reg & PORT_PE) {
> +			if (DEV_HIGHSPEED(reg) || DEV_FULLSPEED(reg))
> +				dwc->hs_phy_flags |= PHY_MODE_USB_HOST_HS;
> +			else if (DEV_LOWSPEED(reg))
> +				dwc->hs_phy_flags |= PHY_MODE_USB_HOST_LS;
> +		}
> +	}
> +	phy_set_mode(dwc->usb2_generic_phy, dwc->hs_phy_flags);
> +}
> +
>  static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  {
>  	unsigned long	flags;
>  	u32 reg;
> +	struct usb_hcd  *hcd = platform_get_drvdata(dwc->xhci);
>  
>  	switch (dwc->current_dr_role) {
>  	case DWC3_GCTL_PRTCAP_DEVICE:
> @@ -1643,9 +1671,12 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  		dwc3_core_exit(dwc);
>  		break;
>  	case DWC3_GCTL_PRTCAP_HOST:
> +		dwc3_set_phy_speed_flags(dwc);
>  		if (!PMSG_IS_AUTO(msg)) {
> -			dwc3_core_exit(dwc);
> -			break;
> +			if (usb_wakeup_enabled_descendants(hcd->self.root_hub))
> +				dwc->need_phy_for_wakeup = true;
> +			else
> +				dwc->need_phy_for_wakeup = false;
>  		}
>  
>  		/* Let controller to suspend HSPHY before PHY driver suspends */
> @@ -1705,11 +1736,13 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>  		break;
>  	case DWC3_GCTL_PRTCAP_HOST:
>  		if (!PMSG_IS_AUTO(msg)) {
> -			ret = dwc3_core_init_for_resume(dwc);
> -			if (ret)
> -				return ret;
> -			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
> -			break;
> +			if (!dwc->need_phy_for_wakeup) {
> +				ret = dwc3_core_init_for_resume(dwc);
> +				if (ret)
> +					return ret;
> +				dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
> +				break;
> +			}
>  		}
>  		/* Restore GUSB2PHYCFG bits that were modified in suspend */
>  		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 013f42a..5367d510e 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1094,6 +1094,8 @@ struct dwc3 {
>  	struct phy		*usb3_generic_phy;
>  
>  	bool			phys_ready;
> +	bool                    need_phy_for_wakeup;
> +	unsigned int            hs_phy_flags;
>  
>  	struct ulpi		*ulpi;
>  	bool			ulpi_ready;

Should this include a check for the 'wakeup-source' DT attribute as in
xhci-mtk.c, to make wakeup support optional?
