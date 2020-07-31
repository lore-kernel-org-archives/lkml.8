Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FD5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82852208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgGaNgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:36:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:1326 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgGaNge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:36:34 -0400
IronPort-SDR: DrOC4b9mTkNdTGBpZdcFQGhQGu0O3nOd6EZ6xXWB9uRFHUSY9dR4uYqNpq2TnmoSLXsPWrACfl
 /5hMF3QoB2kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="151741994"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="151741994"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 06:36:34 -0700
IronPort-SDR: S62zBOUguJJ4GKCUVqdcSsTnw6NtzTSyiaqyJtukNHMOmxW+QgZuoaXu0zO69oVP7zOmwANK/g
 2h6Z98k56Y8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="395307344"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 31 Jul 2020 06:36:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 31 Jul 2020 16:36:30 +0300
Date:   Fri, 31 Jul 2020 16:36:30 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Azhar Shaikh <azhar.shaikh@intel.com>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, pmalani@chromium.org,
        linux-kernel@vger.kernel.org, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com, rajmohan.mani@intel.com
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Avoid setting usb role
 twice during disconnect
Message-ID: <20200731133630.GR883641@kuha.fi.intel.com>
References: <20200730225257.7208-1-azhar.shaikh@intel.com>
 <20200730225257.7208-3-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730225257.7208-3-azhar.shaikh@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I guess this is was supposed to be PATCH v2 2/2, right?

On Thu, Jul 30, 2020 at 03:52:57PM -0700, Azhar Shaikh wrote:
> On disconnect port partner is removed and usb role is set to NONE.
> But then in cros_typec_port_update() the role is set again.
> Avoid this by moving usb_role_switch_set_role() to
> cros_typec_configure_mux().
> 
> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
> Suggested-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index eb4713b7ae14..df97431b2275 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -515,6 +515,12 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>  	if (ret)
>  		return ret;
>  
> +	ret = usb_role_switch_set_role(typec->ports[port_num]->role_sw,
> +				       pd_ctrl->role & PD_CTRL_RESP_ROLE_DATA
> +				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
> +	if (ret)
> +		return ret;
> +
>  	if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
>  		ret = cros_typec_enable_tbt(typec, port_num, pd_ctrl);
>  	} else if (mux_flags & USB_PD_MUX_DP_ENABLED) {
> @@ -589,9 +595,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  	if (ret)
>  		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
>  
> -	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
> -				       resp.role & PD_CTRL_RESP_ROLE_DATA
> -				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
> +	return ret;
>  }
>  
>  static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
> -- 
> 2.17.1

thanks,

-- 
heikki
