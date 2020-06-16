Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EFAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7EA206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKukRORk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgFPIBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgFPIBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:01:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA27C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:01:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q11so19723020wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HhjqqjzEYPgE2Ky9gjHhAXS7V3IrpqPk8DWTpyD0b64=;
        b=UKukRORkWtcUkfrCjZxk2foD26jM5/R7GXk20sgPvRxGP1ppPKOop+1XSK4OL2KXDd
         NFZ4c6diNE+fG/QUZN5SnFNviaa0hwYGmI29PO/CKAmaF0zHzDQbuH4p2Lit4hfdQwHQ
         zRqLVoed9MQw/WeuOkGOc7+nWq2qTp0crQRIREjsV/+iKHqPfkanpisdAno0dDp5DXYd
         mPbVBwn6VcAloEFMYKCV3wqtIcsdd7s36jfnLt9543myFph2FklVLxD1Dv4Wg++gEQ+Q
         ZGbNOwdceFxQem00+QPczd5NOM1I728byKYQTRYTxmWPmtpVrle2Wy6OSSXpb2zNwqtW
         K4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HhjqqjzEYPgE2Ky9gjHhAXS7V3IrpqPk8DWTpyD0b64=;
        b=W+JizyjSJgDOFzBDTAxVFO6dYiHF5l4CtYvvlMSDvMnYx1gbxwjuBZ5QdY0ezFt3ii
         kGjaQJmtbDWEqeTHybc/OHa5Kn7JHDbKCk4GQGd/xVr8Vdbqycfo4IhfIGxxrwRlKL19
         jNaqmPr6RhLyJoza1rnVGPff5iU/ODPkMN4Be/A3vlTNOXJoC53qPDpN8+HmiSvz0Mq0
         ODVhuyBrSxeQ8tg/QQkIghPW2PRlAzs8oz2i0eTapSs0RryRmAG+GmGv4zRli7Dwyyp7
         FUCaIRW/C+l0yVIDzsrcCH1cU5ugarz7r26x1zPY+yVweABOK22G+8plfOG3XHvm+jAA
         yoEQ==
X-Gm-Message-State: AOAM531ESrJdAhGnv1kLwKpdIOpsudIUv9ohA3j5OUZl7KtyuVgL1I3N
        sZtu1AOlulTVIVVbf4HPAej0aw==
X-Google-Smtp-Source: ABdhPJyNmNaCBChojScT8g2OU8BVtjkcsW4N3R9Vl/4+BodMV2HCHbW0ABKtK1sezjhYxzRX7Eb4dQ==
X-Received: by 2002:a5d:684a:: with SMTP id o10mr1607087wrw.4.1592294458894;
        Tue, 16 Jun 2020 01:00:58 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id o82sm2825871wmo.40.2020.06.16.01.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:00:58 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:00:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     s.nawrocki@samsung.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2 2/4] mfd: arizona: Ensure 32k clock is put on driver
 unbind and error
Message-ID: <20200616080056.GG2608702@dell>
References: <20200615135323.15215-1-ckeepax@opensource.cirrus.com>
 <20200615135323.15215-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615135323.15215-2-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020, Charles Keepax wrote:

> Whilst it doesn't matter if the internal 32k clock register settings
> are cleaned up on exit, as the part will be turned off losing any
> settings, hence the driver hasn't historially bothered. The external
> clock should however be cleaned up, as it could cause clocks to be
> left on, and will at best generate a warning on unbind.
> 
> Add clean up on both the probe error path and unbind for the 32k
> clock.
> 
> Fixes: cdd8da8cc66b ("mfd: arizona: Add gating of external MCLKn clocks")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No changes since v1.
> 
> Thanks,
> Charles
> 
>  drivers/mfd/arizona-core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
