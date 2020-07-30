Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA3BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5DF720829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O1X9eS8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgG3XCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgG3XCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:02:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7569BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:02:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k1so5531723pjt.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t9jU7MuX4adB1Ml6Zb+VWg0mbwqZhtdikGa8sw5Pn1I=;
        b=O1X9eS8BbahmnjH+4oO3ugldb0eDFwjbp6tvfyrhF3/SjXk+JjK23sNdg88AOCbpkW
         eCYCXTICIQrhLA+43RlNZuOPKSySOvU3qc9RG7Wt50J29NtGt3zBU0ni91qTjRN3YHB6
         DLhl/DGMV+dliUuvkObptZqIESVjkqBPbEWbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t9jU7MuX4adB1Ml6Zb+VWg0mbwqZhtdikGa8sw5Pn1I=;
        b=YfuX1saEhMCaxNEVJDPq//sSrDLVSppJ1Pu3/FV10MBoarpxESzXEpsRIYJWxZLfTu
         OTPGKv6Kyf5HgiwqjfhhtVpArfNT74QKNrLHn2+OjYCfomcPAeIxYXla97P7Dwi9IIEU
         y6lVBW4E3gHzM4V8feP9HGeuhSHLZxlSG+OWmIat940aoKZOd66sfS8hfpiGkR/wujuC
         vr5NdNDvAu7N/bg7o1Ydfn8/S9JQM7goqsIkR2cqFK9eaH7ObxkpSqTTYiqxXdPwyo9Q
         8eKGt8nSJb0s2FEToJUtVPNqJzRdMCcuCXguHdpunH4SAeJd77RsMDBCpx8YvMVqDsYd
         srwQ==
X-Gm-Message-State: AOAM530nbPfPd8tDMU3zi8bdrWy6WWKdXpww9HDjb9/4HJOPr7XkLKJ3
        Tr3anPJDaOe2JrTzT9siLHTNRQ==
X-Google-Smtp-Source: ABdhPJysynISxwBHGwE+taUYOzluALgdGlTi5dReU5a+mLMNu+iZ7y4ARsNxkHOpzCWplvNTQ07LIw==
X-Received: by 2002:a17:902:8206:: with SMTP id x6mr1331809pln.328.1596150159917;
        Thu, 30 Jul 2020 16:02:39 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id s23sm6948699pjs.47.2020.07.30.16.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 16:02:39 -0700 (PDT)
Date:   Thu, 30 Jul 2020 16:02:38 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Azhar Shaikh <azhar.shaikh@intel.com>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        heikki.krogerus@linux.intel.com, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com, rajmohan.mani@intel.com
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting usb
 role during disconnect
Message-ID: <20200730230238.GD3145664@google.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
 <20200730225609.7395-3-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730225609.7395-3-azhar.shaikh@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Azhar,

On Thu, Jul 30, 2020 at 03:56:09PM -0700, Azhar Shaikh wrote:
> On disconnect port partner is removed and usb role is set to NONE.
> But then in cros_typec_port_update() the role is set again.
> Avoid this by moving usb_role_switch_set_role() to
> cros_typec_configure_mux().
> 
> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
> Suggested-by: Prashant Malani <pmalani@chromium.org>
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

Since this was the last switch being configured, please maintain the
same order and add this at the end of the function, after the if-else if
block.

Best regards,

-Prashant
