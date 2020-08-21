Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E532C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B8720702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ogxHaAki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHUABQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgHUABP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 20:01:15 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6005AC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 17:01:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x6so123801pgx.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 17:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8gPBGC3S/z9HS8aDBgc5rqdRFeyO0//Bt9ssEZ7I3dw=;
        b=ogxHaAkiJ7Tyxqn8fhJ5nqSlNNoVbt0qVqudnNK0eOYtu/m2jGmES5ZZDlli37zho+
         5Z57S10gcgjQTurZgkmFSuoMU9y2hm23Njnr4rXqRpgDlsCVOpnNUkSbdenNm6yagSoX
         YRABQXoDHQi0W2N8ETIBZUILheszgnbDeJSx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8gPBGC3S/z9HS8aDBgc5rqdRFeyO0//Bt9ssEZ7I3dw=;
        b=tb/b3P0gapN4uW/y6z+AvvqZP2kQkXWHGIRHxgYF0LAKhn16UzrWpRMv9POlFYblEP
         SUlxmwoz8eT2rSUlW335W3beYaPfO/RDjYsu3cW4S6h1MdQ9pKPwp4kgwAoBSKpR8RE8
         B7lE9PnEOlLm3eB1q4Zmz0BQNY8Dlpa6UAhTpixT1v851hb8bifRM9jhKBjuFBOOd56f
         4FDiPJXAbhbtwN+xJnHPgxQkCx3tWrmC6iF+NTWgI0BI6p+XzOUq62o93ykNI5buYs8a
         pbCo4Ri49ILpDQSHbqDxPV8uhLPJ/U7VjW2P53A1MwltDUdcLsTLDqKsXzvl4WmBMIOA
         MG7g==
X-Gm-Message-State: AOAM531vcbVVK+BwDuXd/EUXDNFtScYrnF6dkmH9NAXHYBqzZjHN32Ct
        3Cdk8WKbp23VlqPg6VPW34hNjQ==
X-Google-Smtp-Source: ABdhPJx6EARyoRGAF/PaIYwlSnt7WsE8X6M14izy3iDlxUUs1qFrGIBjQd2/aaehKhny7nRda/GPUg==
X-Received: by 2002:a62:8cd3:: with SMTP id m202mr268324pfd.184.1597968074768;
        Thu, 20 Aug 2020 17:01:14 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id l78sm209018pfd.130.2020.08.20.17.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 17:01:14 -0700 (PDT)
Date:   Thu, 20 Aug 2020 17:01:13 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Azhar Shaikh <azhar.shaikh@intel.com>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, heikki.krogerus@linux.intel.com,
        linux-kernel@vger.kernel.org, rajmohan.mani@intel.com,
        utkarsh.h.patel@intel.com, casey.g.bowman@intel.com
Subject: Re: [PATCH v4 3/3] platform/chrome: cros_ec_typec: Re-order
 connector configuration steps
Message-ID: <20200821000113.GA2553024@google.com>
References: <20200820233833.4551-1-azhar.shaikh@intel.com>
 <20200820233833.4551-4-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820233833.4551-4-azhar.shaikh@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 04:38:32PM -0700, Azhar Shaikh wrote:
> As per USB Type-C Spec R2.0 section 4.5.1.2 (Connecting Sources and Sinks)
> and section 4.5.2.2 (Connection State Machine Requirements), the typical
> flow for configuring a device connected to a typeC port is as below:
> 
> 1. Source/sink detection
> 2. Orientation
> 3. Data role
> 4. VCONN
> 5. VBUS (USB Type-C currents)
> 6. The connector is now configured. We can start the PD communication
>    that should lead into configuration of the mux if we enter a mode.
> 
> But in existing code data role was set after the connector and mux are
> already configured. So fix this by following the spec to set the data
> role before the connector and mux are configured.
> 
> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
To be clear, I still maintain that the quoted section pertains to
*detection* of those various properties (which is handled by the TCPM in
the Chrome OS EC), and not any ordering for setting switches etc.

That said, I'm not opposed to the re-ordering, so:
Reviewed-by: Prashant Malani <pmalani@chromium.org>
> ---
> Changes in v4:
>  - No change
> 
> Changes in v3:
>  - New patch added
> 
>  drivers/platform/chrome/cros_ec_typec.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 2b43e1176e73..9e4fad9ca59e 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -516,6 +516,12 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
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
> @@ -533,12 +539,7 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>  		ret = -ENOTSUPP;
>  	}
>  
> -	if (ret)
> -		return ret;
> -
> -	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
> -				       pd_ctrl->role & PD_CTRL_RESP_ROLE_DATA
> -				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
> +	return ret;
>  }
>  
>  static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
> -- 
> 2.17.1
> 
