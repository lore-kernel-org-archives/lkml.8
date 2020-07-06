Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B30C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1755A20720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HTFpHQqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgGFWQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 18:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgGFWQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 18:16:34 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505D0C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 15:16:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ch3so2421026pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RPR+vbiGJLIO9U3ggOOx9uRw2O0XTPg2vmBQmkYy86g=;
        b=HTFpHQqZ/wf0W17lYB1l8+cXiy6bboMupZQGURtfipUtZDCLD4HRFc6VgluB9eUBxW
         UH4EyCHSRkQsZytUJLW3JqWZFO/GAStBg5T/tKHXVspo1yRrO2WciPNsfppSGMQitZic
         ag1nopHsJcr2X6sh8rdblUz5z/O7R4IxsGHzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RPR+vbiGJLIO9U3ggOOx9uRw2O0XTPg2vmBQmkYy86g=;
        b=mYm6QhUTaBbAKvI/4PEh1E5kjX7nNLYewoGTjyhNlzI7HNhqw8WQt3v12hRodg0DXP
         C1ZSLA4KSJmUZd98hs1hGz+ONuad2Iekq8O3gcgpFraRuW6zkpM9PctQgJMoVakoX6rk
         BCGlHHU/exstVQzsnkFmriZ8/wcwkraTYi9BpEw5ayfja4FbJ2jhpw7yKFRS3isuIXWG
         pB1nrI6SqJkSpHjJngVMVNW+CHeyI+WDneS9RZ906blK8f3T3cpaaojbd+Zn4HaR+2io
         HX/1v5ScM+al3NHgrv1npf4IBIFV4bmtSQepjGVBEfdUqDePwT4NnLPugkAOJEhbOlJg
         Kz7w==
X-Gm-Message-State: AOAM531GUYPsUZS0FtIKIlXhgXvfXFusL9vXE4XgKA1rJ5ByuE55Dawq
        LHP+MZnbSiOdCsH/7L4QH2KJexNZWss=
X-Google-Smtp-Source: ABdhPJzJdOg5Poh89QM4q2cedydRsgoop9P4NRMq8mhCo4oVj80nMEs00WTC598bb1tq2yqcg77F8Q==
X-Received: by 2002:a17:90a:ab96:: with SMTP id n22mr1243226pjq.52.1594073792814;
        Mon, 06 Jul 2020 15:16:32 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id d18sm417913pjz.11.2020.07.06.15.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 15:16:32 -0700 (PDT)
Date:   Mon, 6 Jul 2020 15:16:31 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: USB4 support
Message-ID: <20200706221631.GA68629@google.com>
References: <20200703081703.87720-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703081703.87720-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Fri, Jul 03, 2020 at 11:17:03AM +0300, Heikki Krogerus wrote:
> With USB4 mode the mux driver needs the Enter_USB Data
> Object (EUDO) that was used when the USB mode was entered.
> Though the object is not available in the driver, it is
> possible to construct it from the information we have.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Hi,
> 
> This patch depends on latest usb-next from Greg KH, this commit in
> particular:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=ad8db94d6813dc659bd4de0531a8a1150559eafb
> 
> Prashant, can you take over the development of this patch (in case it
> still needs work)? I will take a few weeks vacation starting from next
> week (July 6th).

Sure. Have a nice vacation! :)

> I was hoping to get this feature into v5.9 if that's
> possible. But if you guys think there is no hurry, let's forget about
> it. Then we can just wait for 5.9-rc1 and not worry about the
> dependency on Greg's usb-next.
> 
> thanks,
> 
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 42 ++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 0c041b79cbbac..c9713aab9b6b0 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_data/cros_usbpd_notify.h>
>  #include <linux/platform_device.h>
> +#include <linux/usb/pd.h>
>  #include <linux/usb/typec.h>
>  #include <linux/usb/typec_altmode.h>
>  #include <linux/usb/typec_dp.h>
> @@ -494,6 +495,43 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
>  	return typec_mux_set(port->mux, &port->state);
>  }
>  
> +static int cros_typec_enable_usb4(struct cros_typec_data *typec,
> +				  int port_num,
> +				  struct ec_response_usb_pd_control_v2 *pd_ctrl)
> +{
> +	struct cros_typec_port *port = typec->ports[port_num];
> +	struct enter_usb_data data;
> +
> +	data.eudo = EUDO_USB_MODE_USB4 << EUDO_USB_MODE_SHIFT;
> +
> +	/* Cable Speed */
> +	data.eudo |= pd_ctrl->cable_speed << EUDO_CABLE_SPEED_SHIFT;
> +
> +	/* Cable Type */
> +	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
> +		data.eudo |= EUDO_CABLE_TYPE_OPTICAL << EUDO_CABLE_TYPE_SHIFT;
> +	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> +		data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
> +
> +	/* REVISIT: Cable Current? */
> +
> +	/* REVISIT: Claiming unconditionally that all tunnels are supported. */
> +	data.eudo |= EUDO_PCIE_SUPPORT;
> +	data.eudo |= EUDO_DP_SUPPORT;
> +
> +	data.eudo |= EUDO_TBT_SUPPORT;
> +	data.eudo |= EUDO_HOST_PRESENT;
> +
> +	data.active_link_training = !!(pd_ctrl->control_flags &
> +				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
> +
> +	port->state.alt = NULL;
> +	port->state.data = &data;
> +	port->state.mode = TYPEC_MODE_USB4;
> +
> +	return typec_mux_set(port->mux, &port->state);
> +}
> +
>  static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>  				uint8_t mux_flags,
>  				struct ec_response_usb_pd_control_v2 *pd_ctrl)
> @@ -514,7 +552,9 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>  	if (ret)
>  		return ret;
>  
> -	if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
> +	if (mux_flags & USB_PD_MUX_USB4_ENABLED) {
> +		ret = cros_typec_enable_usb4(typec, port_num, pd_ctrl);
> +	} else if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
>  		ret = cros_typec_enable_tbt(typec, port_num, pd_ctrl);
>  	} else if (mux_flags & USB_PD_MUX_DP_ENABLED) {
>  		ret = cros_typec_enable_dp(typec, port_num, pd_ctrl);
> -- 
> 2.27.0
> 
