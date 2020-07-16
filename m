Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA43C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2DC207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+wyW/U9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgGPO5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPO5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:57:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C44FC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:57:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so7367930wrl.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Xpge14sV3XcdoTt3xDoqzbYEwttWmufNba1daoXoE1A=;
        b=J+wyW/U9gdDLdITg4YfzCmv7D73MaBHyreqDJE7qRFLz1XeyXs17BjDJvLVDc4j28j
         RW1kzm1wUOdyBKRyWaKa0q/qjRldIjM5O0JWLtW7eBP+Zw13Qzm6k1GtBZi90IQowXXe
         7sYE7i9oxUBGAAMrfi/01ydsNRVnXoTX+oDQo+IubxrBI29BhJ4hav14KoNcHqC9ONHB
         WHqskV9zMZ+XSPL3GFk2MPwm9g8ZoCQ7cOTmoqOizBMk+HYUDk70JJhBOdMGmP6Ft0XK
         EVhjUOUjpItl8y36iLmL6kMObW4d4nePZ5ABrI98/BkUWUmXqCUEcVcQTC32QKKdJwDk
         x3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Xpge14sV3XcdoTt3xDoqzbYEwttWmufNba1daoXoE1A=;
        b=ORuGTA7E/xHz9ATH4GOcBtff5PQ/uMHgP4ra0OajikQQNamRi5enGtolxTbGQAKKsA
         RnArEOAMUlAROkZOLfWh0+2joKF3FKw2ABe8Fz5Kq7Nobki8G1bG8ALpANWJ/kabKDsJ
         ppNad/7MYm+Snv0GZvpKuSwZ2vU1zcs9FRDnzr+ByxtA2vxqzsN4gpshRPbJH2Fh902u
         nNWzHht9EYtOxivmR7XXPw0hLpKRA868Km8xQSsU4adIxnoBHty4YnuYzmYDqOw/5V+R
         sJCq2f6sFKEO+PYfDnX4oCF7Ld0olFZ5Kx+paK/HinZilN7be2ZKadWhKV1lC9NGDJsO
         GKGg==
X-Gm-Message-State: AOAM531AJB4qytUE5MOQqZsieNcif/+yo/FAhsZKJdK4a35lpa9fLiH0
        jjukSN1ddKyTbcr/8GWMIBt4ea9hpvw=
X-Google-Smtp-Source: ABdhPJxOexkEuBxrIIT6NLtdXaI9fPey7YXsXj7BOki1czGm7Zg1I5iu5n15mJENb0upnshAAMWoHw==
X-Received: by 2002:a5d:5587:: with SMTP id i7mr5419335wrv.314.1594911424394;
        Thu, 16 Jul 2020 07:57:04 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id v6sm9212435wrr.85.2020.07.16.07.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:57:03 -0700 (PDT)
Date:   Thu, 16 Jul 2020 15:57:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] mfd: motorola-cpcap: Disable interrupt for suspend
Message-ID: <20200716145701.GU3165313@dell>
References: <20200706183934.26274-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200706183934.26274-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jul 2020, Tony Lindgren wrote:

> Otherwise we get spammed with errors on resume after rtcwake:
> 
> cpcap-core spi0.0: Failed to read IRQ status: -108
> 
> Note that rtcwake is still capable of waking up the system with
> this patch.
> 
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> This has always been broken so can be merged whenever.
> 
> ---
>  drivers/mfd/motorola-cpcap.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
