Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E36C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE502085B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgD2McI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:32:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:38142 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgD2McI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:32:08 -0400
IronPort-SDR: MY+iQx1UMuaEkzUiRJfhW0alux81eKnIzFT8Ej/cHiHkpj/4mhB/eb0Dxu6bbpbXl3mb5v8+d2
 k8Rqn7QOkJ/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 05:32:08 -0700
IronPort-SDR: uECXpProGKoGxHCxtdC7mRXgmn8QiFkNwiIVooF1jMmXrUo4sB3j5Gqj0oYP8ZbWiS7Csftvy+
 fvlpwCV0FABA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="367792649"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 29 Apr 2020 05:32:04 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 29 Apr 2020 15:32:03 +0300
Date:   Wed, 29 Apr 2020 15:32:03 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB TYPEC CLASS" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2] usb: typec: mux: intel: Handle alt mode HPD_HIGH
Message-ID: <20200429123203.GB2738754@kuha.fi.intel.com>
References: <20200429054432.134178-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200429054432.134178-1-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 10:44:28PM -0700, Prashant Malani wrote:
> According to the PMC Type C Subsystem (TCSS) Mux programming guide rev
> 0.6, when a device is transitioning to DP Alternate Mode state, if the
> HPD_STATE (bit 7) field in the status update command VDO is set to
> HPD_HIGH, the HPD_HIGH field in the Alternate Mode request “mode_data”
> field (bit 14) should also be set. Ensure the bit is correctly handled
> while issuing the Alternate Mode request.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Fixes: 6701adfa9693 ("usb: typec: driver for Intel PMC mux control")

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> - Clarified the commit message to mention the proper field names.
> 
>  drivers/usb/typec/mux/intel_pmc_mux.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index f5c5e0aef66f..c599112559e7 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -157,6 +157,10 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
>  	req.mode_data |= (state->mode - TYPEC_STATE_MODAL) <<
>  			 PMC_USB_ALTMODE_DP_MODE_SHIFT;
>  
> +	if (data->status & DP_STATUS_HPD_STATE)
> +		req.mode_data |= PMC_USB_DP_HPD_LVL <<
> +				 PMC_USB_ALTMODE_DP_MODE_SHIFT;
> +
>  	return pmc_usb_command(port, (void *)&req, sizeof(req));
>  }
>  
> -- 
> 2.26.2.303.gf8c07b1a785-goog

thanks,

-- 
heikki
