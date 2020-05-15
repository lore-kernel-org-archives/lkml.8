Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA57C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7EA2065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcDTPoeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgEOKh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEOKh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:37:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B97C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:37:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h17so2929834wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zEDoa0ErUN0eUS6B2B7vnP3z3yrneo9SzbNz15AHHe0=;
        b=HcDTPoeCeZeSpmHFbMii2sqY6AviN41u9cVuhqLZJLVoMoFkQjsTZ5sYC4+wtjF8xt
         m4N3SLRK9QRZGbU1yG3a5winKeta1hmFvxZYO9YJPGxHKN78wdARZX5a9q/PTWRyNa7a
         EMmSOF7D2MlyeT3PV2t0b21IZ+6LykoxRxrOTJh7xQz5/mgh+g020M2qwjxG41bzb01m
         j5VDRyWBPAExLdCHzdOXAqACJANoAkwVHInWUi0C4kYmR57vwMkSyvq03+Tzj1OqTAJy
         JtXTODmQqvKyP/dPEiAQ12TKpY4bEOH3ZGC1MSp3ROzpIQ21mtwhqaLDIUCWw860Jw5B
         zKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zEDoa0ErUN0eUS6B2B7vnP3z3yrneo9SzbNz15AHHe0=;
        b=DeYu425jKUWlKG59ZSuZBDMWDHTGszBQRPn6F+Yzmfffhbggms631S1dol19biXVeq
         u/cWPCU6OvS+5fU9VV5iHdZQ0gsX4Npdj4lnqTwAS5BII4Wem27VzJR/RW0PJJ/a9fvZ
         pR6WOTcMgx+hEHGPQFK7lUyiFGxk/50zwGGKZS8XhU5gS3fUlu1yzBFRb42JXUKkvIxj
         TH7b4w1RfSi/qPC1ehcMMThjoq3xT84x5FZTu13KG3Rc9AHqluWVwZyelTyAYc0swdUb
         6xZttdR8XdOocVUAvYKWuBBlpoHlmRef8qOGTCzdLJfTzcWr4wRXkvkHu5M15mlbdahA
         Kb5g==
X-Gm-Message-State: AOAM532z6Adsz8sb513wBaS/IdLVZWYt3jvWZeD/Z1gd/hJsYCRFBsRH
        vp0XKe2vJXDNQ11OTM362RQbNw==
X-Google-Smtp-Source: ABdhPJxabsjhlpvKL6bWFNg3Y2HG16tYqQaXbfKMvfkg/Bm//7xyFBik9FL5B39SmPkdQPNKkt8SmQ==
X-Received: by 2002:adf:decb:: with SMTP id i11mr3816868wrn.172.1589539075499;
        Fri, 15 May 2020 03:37:55 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id h137sm55242856wme.0.2020.05.15.03.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:37:54 -0700 (PDT)
Date:   Fri, 15 May 2020 11:37:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sprd: Remove unnecessary spi_bus_type setting
Message-ID: <20200515103753.GI271301@dell>
References: <88f48e38c4f3e2130de0f58564562453d7ee57f2.1588153213.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88f48e38c4f3e2130de0f58564562453d7ee57f2.1588153213.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020, Baolin Wang wrote:

> The spi_register_driver() will set the spi_bus_type for the spi_driver,
> thus remove the redundant setting in this driver.
> 
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
