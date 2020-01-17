Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC8EC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227812073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wa4/IqEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgAQLdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:33:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43526 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgAQLdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:33:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so22373441wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 03:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HlGSqRPWCcpTVOvm2y/4qtBvBsg/45YDsT7XOrDxWQM=;
        b=wa4/IqEfc6rA+A/P5fHdkezc4l0JT2FKB0L8O2eIS8GE75THnOPZY1efa7QMDwReoT
         vQTSUimHGiira0WvCAsM9xAFumAjav8oSbE6ynre1ZUIhbMYZPjAKN73HxW9/V7ujGxj
         p09HveO7MV5D2braT3bzrQkaDFCxkYT9oHVm933uCoSdV3ogA9miGjx+geK/7hsroHUy
         ilTkQs1o36Mxs6PgZVX1sL0c6mQY8xf+kLlR3+kiomjPAFrl6eZ1GGl15YIXvkjLk2ck
         z2RRWzaFarWf6iWxahIrJ9ABra2dOuzC0cSG+y7BBpy4MjHw0ENqLaHTuBNWG4FVHUS8
         3Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HlGSqRPWCcpTVOvm2y/4qtBvBsg/45YDsT7XOrDxWQM=;
        b=iIUEsPdPGj3RSuBSsn8xsp0iA6+ofQgCJ0KGBz6J8kKbj7dn4Q+NMTZCri1rVqRqtI
         XWtGszP4l+ZZ3tP/vRv27u1owOxqpEVeFCbNv2DyGK22E8HXxpjxFjZDjj+vnA4oHsTx
         V880Jum66f5WSVBN3ZMBsgpqPdYmZyD5kbCUoC0wCSJsk4V/+RJ9MFKg1oTzj2MiOf0F
         i+92XWM9Yw3T5a1ZrT18MhiEXtWZRyjdNH8sEwFx6i9+nglOt2MgIikIvGi8rEPyC81+
         I48idVexIjwOPaYAcocbzTyLQK8de3psFxXr0nCFaJel6Wqomc2+eAlyKme2ajrfXSAV
         F5MQ==
X-Gm-Message-State: APjAAAWFdlsT8b/WgHXZIQGnG7MlSbE7mk+APCNMLCU9xXC7Ww+3g6fC
        arIa7ZOWAW+h8AHZffeCthItZg==
X-Google-Smtp-Source: APXvYqxWFzmFtAaZqwXcheoxbrUKo9fL18irV27YAg6aTrSXgtUWJp16xEvIUZeWzLPnBLgypfOWqQ==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr2544858wro.216.1579260830707;
        Fri, 17 Jan 2020 03:33:50 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id u14sm33018273wrm.51.2020.01.17.03.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:33:50 -0800 (PST)
Date:   Fri, 17 Jan 2020 11:34:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 2/3] mfd: cros_ec: Add cros-usbpd-notify subdevice
Message-ID: <20200117113404.GI15507@dell>
References: <20200114232219.93171-1-pmalani@chromium.org>
 <20200114232219.93171-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200114232219.93171-2-pmalani@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020, Prashant Malani wrote:

> Add the cros-usbpd-notify driver as a subdevice on platforms that
> support the EC_FEATURE_USB_PD EC feature flag and don't have the
> ACPI PD notification device defined.
> 
> This driver allows other cros-ec devices to receive PD event
> notifications from the Chrome OS Embedded Controller (EC) via a
> notification chain.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes in v6:
> - No changes.
> 
> Changes in v5:
> - Updated the IS_ENABLED() check to check for CONFIG_OF instead of
>   !CONFIG_ACPI according to upstream comments.
> 
> Changes in v4:
> - Removed #ifndef usage; instead, moved cros-usbpd-notify to a separate
>   mfd_cell and used an IS_ENABLED() check.
> - Changed commit title and description slightly to reflect change in
>   code.
>  drivers/mfd/cros_ec_dev.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
