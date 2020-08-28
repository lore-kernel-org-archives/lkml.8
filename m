Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB87C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0B02078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUfsV9bX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgH1KKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgH1KKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:10:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C530C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:10:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so744274wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bSq5SvyGuEAR7HTW9EkWirck6/mt4ja6XuqM9i2UtcE=;
        b=uUfsV9bX2g2WLFAJal0RrTio5GD0tveUiqEms18A2TFDdY2TayD39/bho6lbBwpEO9
         7OhSIBrYLpMUP/NGPk9jIdS+L6KSJ+iO7HtzJ9m6eNnxrBLQEf//Rzlw5dwJKRBieFFY
         Ro8Niwh+WjPJdFnsWeMkvHdejo+IKspyDCvmNVSkXT93DDFOwncnTuHfl6F+JxvHBVhw
         Ky6wX3T9eIbgxGEdk/t1FPEWfknnZG20Tl/p4r2VeGauWC4IPUNHZDZZma8zwN2xpXLS
         ORhVOduYIDi4qSfzGTMLJw1f9KxEVYCds40B8cT6R+aIMu8jrMtkJp3BX1fz5LyGMUc/
         fiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bSq5SvyGuEAR7HTW9EkWirck6/mt4ja6XuqM9i2UtcE=;
        b=TGErEf1PoVycfEgFR4TCvkaiUxIOi/iEznbIwlPiI/9ZjuEOrLgH1cUyAe3vMZIopD
         2EUlsdYXs8Xq9MxVKpdd5/fsz19m9c5k60iCQJd+2e3NOcXCgcLNnzHrGq/lwAZkEWkD
         1/JYufxGYqXEsXeuKTcFp5qzEgU1yHMifTUjQ9hp5aL5UiwVC5mzpRSlUyEKgKBGAzSh
         JW7SzF8vsTFRqJatmsXFB75LfNw5syT3ZUE8uaWh313G8lEdE+MKCvhWi9RNXkzcRvyk
         vGRkffPuE+afrZwhYOHhxR4Zanv00/vkxgRtPo5Bf+qWgzY4SVDQlDocowTQDuP/QzNY
         qKYg==
X-Gm-Message-State: AOAM533kle2aUSMoHPmi8MTPqpjsj6Ot9qqoTrG4iZHUp5OdLl8GqRJn
        wUx2W32kB9tAb73/RXttDQLQEA==
X-Google-Smtp-Source: ABdhPJyHZPvqQFcx1P7uiUjZgyKst3EX44RhRKQqLGhsYGi70Dj6nTfb9BsJHrslejUACrbZt03uug==
X-Received: by 2002:a05:6000:1082:: with SMTP id y2mr821224wrw.222.1598609415296;
        Fri, 28 Aug 2020 03:10:15 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id i4sm1197625wrw.26.2020.08.28.03.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:10:14 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:10:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] mfd: stmfx: Simplify with dev_err_probe()
Message-ID: <20200828101013.GI1826686@dell>
References: <20200826144935.10067-1-krzk@kernel.org>
 <20200826144935.10067-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200826144935.10067-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020, Krzysztof Kozlowski wrote:

> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/stmfx.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
