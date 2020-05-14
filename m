Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A13C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417492065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fJqBY/5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgENQaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgENQaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:30:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FF5C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:30:50 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so12664879pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NZQc8uXoIuHdBfx3/ho5SqJ2T1qFdUpk12Ew1zdXSig=;
        b=fJqBY/5FYNxLDv9s+k1bD5kgHfZb4x4QdhSQDjvTPRce5F0WExj6Yk8EKnqN5ujCqJ
         tYDyne4MPTY5jWebIQOLSn4f3t+eJX2+MsRSvEAzyIPPIhVwKdUf51O+c0IKkjwj16EV
         CtEG6JwwC0NoImpoajwzZB99GDA5wBo3Sfvzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NZQc8uXoIuHdBfx3/ho5SqJ2T1qFdUpk12Ew1zdXSig=;
        b=PJum+tKrzXtH0s89AY1NJdRo7+QTVmNI0oYadP0Xvm8/cxJDzD4QFLHAIOtCyAYviS
         4MJ3fheFi0ConxCHzc0iChKz4gMnaDEdltoJH5b0EZUChDa6aOSD3AukZGQbiALXgVtG
         32tQlNWw0QQge/1DLpNXkOxbqIy3QeDo32YcTiN0g+mbVU35Ey3bbmwYGS77tjWBQ9OZ
         Lc6l9Xm1P2GvRRw/gp+x+kCaopxOa/w8/wLNz1Tksg/kRLg9dC8t2oUhNIzu3geinZyo
         6QaXS10KIsF+pBkTBKDDo/JUezPM/xmOWcW0vgIwSBxhDraYoe3ivdhNI0v0L/VNvm1k
         OVmQ==
X-Gm-Message-State: AOAM533ADuRrbPNrknj0Sd09pfBUMVNhlmDl+AQPwFbC6nbjXUm/nh2m
        z/wGlGFd2KJKcPJzOTBBSDZyKw==
X-Google-Smtp-Source: ABdhPJwO1LU11eYIyY6fK3UdsEdl9NAr0oC6KDbrIPekP8Jj3YE72XYnPb9U++gPLJcDiY+EjAWgtQ==
X-Received: by 2002:a17:902:7d85:: with SMTP id a5mr4964543plm.106.1589473850143;
        Thu, 14 May 2020 09:30:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id w11sm2634015pfq.100.2020.05.14.09.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 09:30:49 -0700 (PDT)
Date:   Thu, 14 May 2020 09:30:48 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org, bgodavar@codeaurora.org,
        alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_qca: Enable WBS support for wcn3991
Message-ID: <20200514163048.GO4525@google.com>
References: <20200513204111.1.I68404fc395a3dbc57c8a89ca02490013e8003a87@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200513204111.1.I68404fc395a3dbc57c8a89ca02490013e8003a87@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Wed, May 13, 2020 at 08:41:25PM -0700, Abhishek Pandit-Subedi wrote:
> WCN3991 supports transparent WBS (host encoded mSBC). Add a flag to the
> device match data to show WBS is supported.

In general this looks good to me, a few nits inside.

> This requires the matching firmware for WCN3991 in linux-firmware:
>         1a8b0dc00f77 (qca: Enable transparent WBS for WCN3991)
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
>  drivers/bluetooth/hci_qca.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index b3fd07a6f8127..305976c4dcf42 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -75,6 +75,9 @@ enum qca_flags {
>  	QCA_HW_ERROR_EVENT
>  };
>  
> +enum qca_driver_flags {
> +	QCA_DRV_WIDEBAND_SPEECH_SUPPORTED = 0x1,

s/0x1/BIT(0)/

> +};

The 'driver'/'DRV' midfix is a bit misleading. WBS support is a device
capability, it's not something the driver supports or doesn't. Maybe
name it 'qca_capabilities' or similar.

>  /* HCI_IBS transmit side sleep protocol states */
>  enum tx_ibs_states {
> @@ -187,10 +190,11 @@ struct qca_vreg {
>  	unsigned int load_uA;
>  };
>  
> -struct qca_vreg_data {
> +struct qca_device_data {
>  	enum qca_btsoc_type soc_type;
>  	struct qca_vreg *vregs;
>  	size_t num_vregs;
> +	uint32_t flags;

capabilities?
