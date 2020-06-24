Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D722DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F2520738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZRRVGCU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405598AbgFXRmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404017AbgFXRmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:42:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A29C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:42:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so1725202pge.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JXr+4obL6y+4i4RBwA/iY67vvlxQ00x3l5smzh2eGTQ=;
        b=ZRRVGCU841hW9rRpB82+Xbh7lmRIZ84opZop/DioDsLCGra+0kOgb9uWZZnKgXoEFF
         cKicNFOz9UQNY17R6Wn6ztfL8uBRey1Zcs4F2Uu7lV+oxc5uNLQWE92qJD4bx6qg6vzo
         BA7x9dS9P4YdkdJ6Vng68neUk8FbCvzyfzgWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JXr+4obL6y+4i4RBwA/iY67vvlxQ00x3l5smzh2eGTQ=;
        b=AG7yujGHWAR/Fmv8hSs0gjVtqSevvdQma/iK/l5u6JxhMd4fwoI8+1AkTiEBNgTkV4
         d2wC7yzUb3um+17i4iX/AV1vaoyzSi0KogLd08VnBGYq+sjB164zow2/KKCq9fvIBsg7
         1ZIay82Hm7rqSFiyQu156iStGsG3Rq+KeLSiZoXuRJfagAs73FMvJwuuYYj5M+tOvrne
         vgvKQoF0APm2UWr/aBu2S78/rlEt4JxRr4WoK5mYn1yE4hRqtpn8IYQdRm2JbXJH+yOV
         usbLYlD7iVB7Cw/19vHd9uuxwiyrJziD8huYV5x7ZKF7rug+jFlvrfUMQ3kLSRdCKDW5
         Vjng==
X-Gm-Message-State: AOAM530WYx41zSZd9JtcaESWyAlHonk+31ofoZYlwuDde2yltUbGsqiU
        XBI36wsXLAP5v0v+T4U3QYljISKvUhg=
X-Google-Smtp-Source: ABdhPJyavFovjn6UaEvHwnVOz/g3p0xCaL0L5e6PX27geSJVDOcaKfI42x1ilysgD0JoHoDQrf9sfQ==
X-Received: by 2002:a63:9d45:: with SMTP id i66mr23278986pgd.25.1593020525758;
        Wed, 24 Jun 2020 10:42:05 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id y5sm17945322pgl.85.2020.06.24.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:42:05 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:42:04 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Casey Bowman <casey.g.bowman@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yicheng Li <yichengli@chromium.org>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Add TBT compat
 support
Message-ID: <20200624174204.GB151731@google.com>
References: <20200624080926.165107-1-pmalani@chromium.org>
 <20200624080926.165107-2-pmalani@chromium.org>
 <20200624091520.GA1487@kuha.fi.intel.com>
 <20200624092040.GB1487@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624092040.GB1487@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Wed, Jun 24, 2020 at 12:20:40PM +0300, Heikki Krogerus wrote:
> On Wed, Jun 24, 2020 at 12:15:20PM +0300, Heikki Krogerus wrote:
> > On Wed, Jun 24, 2020 at 01:09:24AM -0700, Prashant Malani wrote:
> > > Add mux control support for Thunderbolt compatibility mode.
> > > 
> > > Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Co-developed-by: Azhar Shaikh <azhar.shaikh@intel.com>
> > > Co-developed-by: Casey Bowman <casey.g.bowman@intel.com>
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > ---
> > >  drivers/platform/chrome/cros_ec_typec.c | 70 ++++++++++++++++++++++++-
> > >  1 file changed, 69 insertions(+), 1 deletion(-)
> > 
> > Cool! Can you guys test also USB4 with the attached patch (still work
> > in progress)? It should apply on top of these.
> > 
> > The mux driver is still missing USB4 support, but I'll send the
> > patches needed for that right now...
> 
> Actually, I'll just attach that one here as well. Let me know if you
> guys can test these.

Thanks for the patches. Will try them out today and compare the PMC IPC
buffers against what extcon is doing.

Best regards,

-Prashant
> 
> thanks,
> 
> -- 
> heikki

> From 396bd399ac815165ec4992739d45d52ecf234acc Mon Sep 17 00:00:00 2001
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Date: Wed, 3 Jun 2020 17:00:14 +0300
> Subject: [PATCH] usb: typec: intel_pmc_mux: Add support for USB4
> 
> The PMC mux-agent can be used also when Enter_USB is used in
> order to enter USB4 mode. The mux-agent does not have USB4
> specific message, but instead needs to be put into TBT
> alternate mode also with USB4. That is OK as the controller
> is in any case the same with TBT3 and USB4.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 65 +++++++++++++++++++++++----
>  1 file changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 70ddc9d6d49e4..6d223bd360b8e 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> +#include <linux/usb/pd.h>
>  #include <linux/usb/role.h>
>  #include <linux/usb/typec_mux.h>
>  #include <linux/usb/typec_dp.h>
> @@ -227,6 +228,41 @@ pmc_usb_mux_tbt(struct pmc_usb_port *port, struct typec_mux_state *state)
>  	return pmc_usb_command(port, (void *)&req, sizeof(req));
>  }
>  
> +static int
> +pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
> +{
> +	u32 eudo = *(u32 *)state->data;
> +	struct altmode_req req = { };
> +	u8 cable_speed;
> +
> +	req.usage = PMC_USB_ALT_MODE;
> +	req.usage |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
> +	req.mode_type = PMC_USB_MODE_TYPE_TBT << PMC_USB_MODE_TYPE_SHIFT;
> +
> +	/* USB4 Mode */
> +	req.mode_data = PMC_USB_ALTMODE_FORCE_LSR;
> +	req.mode_data |= PMC_USB_ALTMODE_ACTIVE_LINK;
> +
> +	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
> +	req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
> +
> +	switch ((eudo & EUDO_CABLE_TYPE_MASK) >> EUDO_CABLE_TYPE_SHIFT) {
> +	case EUDO_CABLE_TYPE_PASSIVE:
> +		break;
> +	case EUDO_CABLE_TYPE_OPTICAL:
> +		req.mode_data |= PMC_USB_ALTMODE_CABLE_TYPE;
> +		/* fall through */
> +	default:
> +		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
> +		break;
> +	}
> +
> +	cable_speed = (eudo & EUDO_CABLE_SPEED_MASK) >> EUDO_CABLE_SPEED_SHIFT;
> +	req.mode_data |= PMC_USB_ALTMODE_CABLE_SPD(cable_speed);
> +
> +	return pmc_usb_command(port, (void *)&req, sizeof(req));
> +}
> +
>  static int pmc_usb_mux_safe_state(struct pmc_usb_port *port)
>  {
>  	u8 msg;
> @@ -268,17 +304,28 @@ pmc_usb_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
>  {
>  	struct pmc_usb_port *port = typec_mux_get_drvdata(mux);
>  
> -	if (!state->alt)
> -		return 0;
> -
>  	if (state->mode == TYPEC_STATE_SAFE)
>  		return pmc_usb_mux_safe_state(port);
> -
> -	switch (state->alt->svid) {
> -	case USB_TYPEC_TBT_SID:
> -		return pmc_usb_mux_tbt(port, state);
> -	case USB_TYPEC_DP_SID:
> -		return pmc_usb_mux_dp(port, state);
> +	if (state->mode == TYPEC_STATE_USB)
> +		return pmc_usb_connect(port);
> +
> +	if (state->alt) {
> +		switch (state->alt->svid) {
> +		case USB_TYPEC_TBT_SID:
> +			return pmc_usb_mux_tbt(port, state);
> +		case USB_TYPEC_DP_SID:
> +			return pmc_usb_mux_dp(port, state);
> +		}
> +	} else {
> +		switch (state->mode) {
> +		case TYPEC_MODE_USB2:
> +			/* REVISIT: Try with usb3_port set to 0? */
> +			break;
> +		case TYPEC_MODE_USB3:
> +			return pmc_usb_connect(port);
> +		case TYPEC_MODE_USB4:
> +			return pmc_usb_mux_usb4(port, state);
> +		}
>  	}
>  
>  	return -EOPNOTSUPP;
> -- 
> 2.27.0
> 

