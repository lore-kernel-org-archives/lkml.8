Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF8DC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF3320828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OM1HSWa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgBXK13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:27:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39053 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbgBXK13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:27:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so909118wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 02:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/wPxcyrQruYDAUyh+jsOvRDd2ILov7dBYbjfQHdUR9k=;
        b=OM1HSWa05yHXwkkMJacChsT5B/1SWbWNLxCzkWbbOoDmENeKMuT66ieIDskm160KTb
         0sbwd12T2eCBlJlA4lggTfxd1OQ81GmrG6BbeKSBJHvS5vgX7HjTzsflOdqniSLoMJaU
         /k1WGJ2ew/1V7nH6CxDjxb4Q50En04RBWnNBMZJLRe1dKdOctHgl49WA/xeXUHE9eJmF
         tc+a96pghF5lTrYgXKzyWjtq25uFpjadgURs27R/4CTUnOBJsrRrc8oQstDpVJMYNBY4
         RF7AUNQGUS4O7xIQLzeDwb6ZsqWHa5hLvKiCjr4+h+oXcfMY95FXUvUMPuCQ32exkDx5
         XnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/wPxcyrQruYDAUyh+jsOvRDd2ILov7dBYbjfQHdUR9k=;
        b=NDA4POB/RokkcmTk2uDwx/PuFNn0o3uOfYG2imw4xxCotRn06kQTLAxJDGPSV0aDcr
         cmwVG6wr3eoJArGDVv8W92FCZqJUZxrodX1Hkjfqwzng+0B0WhTppQtrksk1W6fROzs5
         FppZmULbrELR2l1v75x1d5Fc0r8NunwBwppuFMiLlmfBTRRGYCCYMZM+amy8aTc2cgeS
         ACcYJRUFb7AWDeOtj8nVr1h4X1un5K2nviqa5WTEMeOv0BqAEBtfH3QYMjYr+fJl+yfu
         7GZw69g3l+eAWUCU1nt4WSSGkNq9xh0Jzrig2hmmaJXuoNG7pAfkWMChnnNscxV3zuh1
         ymkQ==
X-Gm-Message-State: APjAAAXB6GpvPxLQ/QVbg6lRyeyUD0Z+p0Pc+zVci2Bq6kKQNwUjLRY1
        vcGbR29wW5ahfGItmrwgdFL42g==
X-Google-Smtp-Source: APXvYqzt5+G2FRAHu4Ld1WC5LSxw0Vs4RC2Rs28c7+oDkTb503qdeuPcpgIfu31rO5pd3EWywZu3KQ==
X-Received: by 2002:a5d:4c41:: with SMTP id n1mr2207962wrt.183.1582540047270;
        Mon, 24 Feb 2020 02:27:27 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id d3sm6569072wrr.56.2020.02.24.02.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 02:27:26 -0800 (PST)
Date:   Mon, 24 Feb 2020 10:27:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 3/4] mfd: cros_ec: Check DT node for usbpd-notify add
Message-ID: <20200224102758.GN3494@dell>
References: <20200124231834.63628-1-pmalani@chromium.org>
 <20200124231834.63628-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200124231834.63628-3-pmalani@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020, Prashant Malani wrote:

> Add a check to ensure there is indeed an EC device tree entry before
> adding the cros-usbpd-notify device. This covers configs where both
> CONFIG_ACPI and CONFIG_OF are defined, but the EC device is defined
> using device tree and not in ACPI.

Don't this 'fix' a patch in *this* set?

If so, please squash and resend.

> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes in v8:
> - Patch first introduced in v8 of the series.
> 
>  drivers/mfd/cros_ec_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index d0c28a4c10ad0..411e80fc9a066 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -212,7 +212,7 @@ static int ec_device_probe(struct platform_device *pdev)
>  	 * explicitly added on platforms that don't have the PD notifier ACPI
>  	 * device entry defined.
>  	 */
> -	if (IS_ENABLED(CONFIG_OF)) {
> +	if (IS_ENABLED(CONFIG_OF) && ec->ec_dev->dev->of_node) {
>  		if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
>  			retval = mfd_add_hotplug_devices(ec->dev,
>  					cros_usbpd_notify_cells,

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
