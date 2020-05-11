Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BBFC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339A12075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgEKKTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:19:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:60153 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgEKKTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:19:31 -0400
IronPort-SDR: CpfMjcxYewT0+DNQhP5qX4TutEN50ZfjfYiyVNrKIoOpsNmnTufXB8Ndjit7/49qLTGLsHzS5r
 2hgiFPQfvPIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 03:19:27 -0700
IronPort-SDR: pdhUQcMw0nd5lv8JNlKh867//xSKWOV//CePf+o0qYqs0xqnHP06Dej0E2N4BIb5VTp0Ka9nSh
 KfKUug0/vXOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,379,1583222400"; 
   d="scan'208";a="371179750"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 May 2020 03:19:25 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 11 May 2020 13:19:24 +0300
Date:   Mon, 11 May 2020 13:19:24 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB TYPEC CLASS" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v3] usb: typec: mux: intel: Fix DP_HPD_LVL bit field
Message-ID: <20200511101924.GC1295548@kuha.fi.intel.com>
References: <20200511091837.102508-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511091837.102508-1-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 02:18:34AM -0700, Prashant Malani wrote:
> According to the PMC Type C Subsystem (TCSS) Mux programming guide rev
> 0.6, the PMC HPD request LVL bit field is bit 4.
> Fix the definition here to match the programming guide.
> 
> Since this bit field is changing, explicitly define a field for the
> HPD_HIGH mode data bit.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Fixes: 6701adfa9693 ("usb: typec: driver for Intel PMC mux control")
> Reviewed-by: Benson Leung <bleung@chromium.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v3:
> - Fixed sorting of the bit field after modification.
> 
> Changes in v2:
> - Fixed bit error in commit message.
> 
>  drivers/usb/typec/mux/intel_pmc_mux.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 67c5139cfa0d..c22e5c4bbf1a 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -63,6 +63,7 @@ enum {
>  #define PMC_USB_ALTMODE_DP_MODE_SHIFT	8
>  
>  /* TBT specific Mode Data bits */
> +#define PMC_USB_ALTMODE_HPD_HIGH	BIT(14)
>  #define PMC_USB_ALTMODE_TBT_TYPE	BIT(17)
>  #define PMC_USB_ALTMODE_CABLE_TYPE	BIT(18)
>  #define PMC_USB_ALTMODE_ACTIVE_LINK	BIT(20)
> @@ -74,8 +75,8 @@ enum {
>  #define PMC_USB_ALTMODE_TBT_GEN(_g_)	(((_g_) & GENMASK(1, 0)) << 28)
>  
>  /* Display HPD Request bits */
> +#define PMC_USB_DP_HPD_LVL		BIT(4)
>  #define PMC_USB_DP_HPD_IRQ		BIT(5)
> -#define PMC_USB_DP_HPD_LVL		BIT(6)
>  
>  struct pmc_usb;
>  
> @@ -158,8 +159,7 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
>  			 PMC_USB_ALTMODE_DP_MODE_SHIFT;
>  
>  	if (data->status & DP_STATUS_HPD_STATE)
> -		req.mode_data |= PMC_USB_DP_HPD_LVL <<
> -				 PMC_USB_ALTMODE_DP_MODE_SHIFT;
> +		req.mode_data |= PMC_USB_ALTMODE_HPD_HIGH;
>  
>  	return pmc_usb_command(port, (void *)&req, sizeof(req));
>  }
> -- 
> 2.26.2.645.ge9eca65c58-goog

-- 
heikki
