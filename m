Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E842CC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8902077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFNn2y6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgAPN2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:28:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39262 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAPN2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:28:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so19145771wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=egNm5hnStcEuGVyvsQ7QZ8Yg17G8I6nyWH7ckz/t1Rk=;
        b=EFNn2y6nU9mQc8EDxHTqfCAETdJttg+EGro1+6+YW/Fx+iKOW24CBqkjna6DZwx6Pn
         vOWfbc8QYhHnxGCxXRYTW4kXs5+C5pCkl4HmssJDK0nGvCnfnllndxMTgZb+saWysjrV
         TA99+RRlQ6W00cuCNaEUg8KYDHPvmQPZiq2EvmKSugBF3tc3EtnsEI5yVumK95dlojta
         zRgeQ0x4DCojeNbg5hXtP4WTX1VS3XZ5V05HPJbH99wU7/+QFB6l9OBAFWDhWRFt3Fgk
         BUUr2DOlftoQrN0Xm3rORMbmajk6yXWp388osUMms7hHBzUe+YYqH1afQ5H8J/v87b/O
         AfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=egNm5hnStcEuGVyvsQ7QZ8Yg17G8I6nyWH7ckz/t1Rk=;
        b=lW8TGs1I6/7Plf9ubn8Sjmpx67duOlZjB4CRIh6/UQzeBj1GyUghg4sTldiaMpClcg
         O5waxJcxdShqpLCOTmbs9dYmZAMN1L71ltLb6cjUT525NN4Kim1m1cX5CZmHw629dtFP
         2ZcoXIgwG18butaqKVPuNmBFzRkkf53pHQwI+2qhuzxIC/wFUBdXaBdkwVylg2S1DwRq
         xFA/rlQTw0+WNnu8mPQ2rUy8Y0kJ3THxC6XPGyUGWaI+OxTHp7mnZimUKZFOR6QhdAhn
         133HVJtTtDY72twRV6jTScnEds7vlID2nY8P3gqccN1xqVojMT3mqXGJu+sAmFly7LP+
         wyXQ==
X-Gm-Message-State: APjAAAVpeTcVaN6Yh4vqcd3JVWPOFOw7I1WYX5pu5eW7OpDGuYvpm8Dq
        BZZA6JpmZZPsEbf0vs8cjsLFdLhWpIE=
X-Google-Smtp-Source: APXvYqxdKSEagkiplHcxJxhokSNkM8KIwX2aZaSVa2IuPpU0i/S2qMSA6AjTrb5/Vr63bg0Wdh+1/w==
X-Received: by 2002:adf:e984:: with SMTP id h4mr3279869wrm.275.1579181310583;
        Thu, 16 Jan 2020 05:28:30 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id d10sm30112220wrw.64.2020.01.16.05.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:28:30 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:28:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] mfd: cros_ec: Add cros-usbpd-notify subdevice
Message-ID: <20200116132848.GM325@dell>
References: <20200114031056.44502-1-pmalani@chromium.org>
 <20200114031056.44502-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200114031056.44502-2-pmalani@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020, Prashant Malani wrote:

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
> Changes in v5:
> - Updated the IS_ENABLED() check to check for CONFIG_OF instead of
>   !CONFIG_ACPI according to upstream comments.
> 
> Changes in v4:
> - Removed #ifndef usage; instead, moved cros-usbpd-notify to a separate
>   mfd_cell and used an IS_ENABLED() check.
> - Changed commit title and description slightly to reflect change in
>   code.
> 
>  drivers/mfd/cros_ec_dev.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Looks okay to me, but I would like more Chromium reviews please.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
