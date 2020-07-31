Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3600FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B5AE20656
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbgGaNd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:33:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:55894 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbgGaNd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:33:29 -0400
IronPort-SDR: f5pd6pWLlTqyYFWvLZAgQ47jtIkQg9qKYrMRtJQdolJWD7MP/4gqtCE75z3qRytGqPpxxZKaYB
 BakdjDqAekRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="152982012"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="152982012"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 06:33:28 -0700
IronPort-SDR: 2nXL8SupauE/0M+unYjSdPQW9WQCxn0XFWcj1uHnd6RuRMuogD6ibB4ub91xYNeC7XYXe919Vu
 SAW1mmOuf2ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="395306863"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 31 Jul 2020 06:33:25 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 31 Jul 2020 16:33:25 +0300
Date:   Fri, 31 Jul 2020 16:33:24 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Azhar Shaikh <azhar.shaikh@intel.com>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, pmalani@chromium.org,
        linux-kernel@vger.kernel.org, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com, rajmohan.mani@intel.com
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Send enum values
 to usb_role_switch_set_role()
Message-ID: <20200731133324.GQ883641@kuha.fi.intel.com>
References: <20200730225257.7208-1-azhar.shaikh@intel.com>
 <20200730225257.7208-2-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200730225257.7208-2-azhar.shaikh@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 03:52:56PM -0700, Azhar Shaikh wrote:
> usb_role_switch_set_role() has the second argument as enum for usb_role.
> Currently depending upon the data role i.e. UFP(0) or DFP(1) is sent.
> This eventually translates to USB_ROLE_NONE in case of UFP and
> USB_ROLE_DEVICE in case of DFP. Correct this by sending correct enum
> values as USB_ROLE_DEVICE in case of UFP and USB_ROLE_HOST in case of
> DFP.
> 
> Fixes: 7e7def15fa4b ("platform/chrome: cros_ec_typec: Add USB mux control")
> 
> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
> Cc: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 3eae01f4c9f7..eb4713b7ae14 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -590,7 +590,8 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
>  
>  	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
> -					!!(resp.role & PD_CTRL_RESP_ROLE_DATA));
> +				       resp.role & PD_CTRL_RESP_ROLE_DATA
> +				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
>  }
>  
>  static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
> -- 
> 2.17.1

-- 
heikki
