Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43003C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D0B2073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgATLHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:07:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:48060 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgATLHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:07:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 03:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,341,1574150400"; 
   d="scan'208";a="274942210"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 20 Jan 2020 03:07:31 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 20 Jan 2020 13:07:30 +0200
Date:   Mon, 20 Jan 2020 13:07:30 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Thomas Hebb <tommyhebb@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fix "op-sink-microwatt" defaults that were
 in mW
Message-ID: <20200120110730.GB32175@kuha.fi.intel.com>
References: <bcd87046185bb7cea42873186d706aeb50e27a80.1579517594.git.tommyhebb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcd87046185bb7cea42873186d706aeb50e27a80.1579517594.git.tommyhebb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Jan 20, 2020 at 02:53:16AM -0800, Thomas Hebb wrote:
> commit 8f6244055bd3 ("usb: typec: fusb302: Always provide fwnode for the
> port") and commit 4c912bff46cc ("usb: typec: wcove: Provide fwnode for
> the port") converted a legacy TCPM platdata structure to a more generic
> format. However, one field, denoting required sink power, was specified
> in mW in the old format but uW in the new format. The migration failed
> to account for this, meaning that the values are now 1000x too small.
> 
> Correct the issue by converting the values to uW.
> 
> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>

Thanks for catching this.

You should split this in two, one patch for each driver, and those
should have proper "Fixes:" tags.

I think those should also go to the stable trees, so you'll also need
the stable tag (Cc: stable@vger.kernel.org).

> ---
> 
>  drivers/usb/typec/tcpm/fusb302.c | 2 +-
>  drivers/usb/typec/tcpm/wcove.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index ed8655c6af8c..b498960ff72b 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1666,7 +1666,7 @@ static const struct property_entry port_props[] = {
>  	PROPERTY_ENTRY_STRING("try-power-role", "sink"),
>  	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
>  	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
> -	PROPERTY_ENTRY_U32("op-sink-microwatt", 2500),
> +	PROPERTY_ENTRY_U32("op-sink-microwatt", 2500000),
>  	{ }
>  };
>  
> diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
> index edc271da14f4..9b745f432c91 100644
> --- a/drivers/usb/typec/tcpm/wcove.c
> +++ b/drivers/usb/typec/tcpm/wcove.c
> @@ -597,7 +597,7 @@ static const struct property_entry wcove_props[] = {
>  	PROPERTY_ENTRY_STRING("try-power-role", "sink"),
>  	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
>  	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
> -	PROPERTY_ENTRY_U32("op-sink-microwatt", 15000),
> +	PROPERTY_ENTRY_U32("op-sink-microwatt", 15000000),
>  	{ }
>  };
>  
> -- 
> 2.24.1

thanks,

-- 
heikki
