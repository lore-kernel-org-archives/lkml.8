Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3010CC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B8AC206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXE7jWkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgD1KhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726328AbgD1KhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:37:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7906AC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:37:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so2270835wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=D8psmyYEtN8Z2pq4q8A6sTe4dHln0Jw+fnsaaC8uTYk=;
        b=FXE7jWkXt/8YDgD5af9Adko3ZoKRvikJM9bS23w8DI+jgkRjz18xtRrogbbmjbNYiG
         1KSB4F6mLsF4rybsW4R+Z/JUPtDyt8Gra9jHJiMp+376YAv/1QL36xbbzf8h5RwcQMEG
         nGqfgX7GbV1Sjn2StNzrUC1hi+2W6K+ka2/GxW6ZRuvcqcwYe/xZ0wFw65vC3dOC8FmK
         xha3sP6foA3+kbLp9cHY/2CTlwOgEFGYtPXCb8Gleiy3F/MeVwslCCkdzxOQr7HsL7iW
         eNQa3BRuh7u3Omz5BcX0JH92/Xq0kzh2GmsHa/zr/Met8ZlQHkqkrdGGsIPpMbH0CvXc
         8/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D8psmyYEtN8Z2pq4q8A6sTe4dHln0Jw+fnsaaC8uTYk=;
        b=hSd6Ol/cD1O3WpAn75TC0eu/aXosa1Y8l2sPjSayShHUqMwuiAFS0s+Db1+oQcW4eO
         AzUUfDegQ18kbDZXWMbUwOv/56ha4HMTcoEJ+9BgMUeU9+pyAORBhaJvDtrUa4zp9iGj
         C24UohK14BbUFY7L7W9USi4oB4za8gQ2ytobcw1GAt24c9uuCRCwbWcxHnMxfcPbYsT1
         3sWZgj97cTvTFl5MP1Gjc7hJOQycN2SxdvXDmczetZltUlae0d1ppP2jNHfn9Tgj9/Wg
         7N9fV2d3phh22kWOqQ57B2lXbDxxL/+iNrvXOJ1YWoRTTMmYkpBuRoDGCd1TFRHRxe4P
         4QQA==
X-Gm-Message-State: AGi0Puam9O+VjPEsyWH3OkzJaHWBI8MxuGspXrAon54pvtIjW3QtU+Qr
        kdACSNyh0ahnYZvGfQ7MbZrWyg==
X-Google-Smtp-Source: APiQypK8X1fXoKcP9x6DDd/rjoa5KhpafxYy9uVPe4QqZ8y7ujJuURQ6h3E5Fy/v6bbENVt1m3CqAA==
X-Received: by 2002:a1c:5683:: with SMTP id k125mr3743532wmb.17.1588070224229;
        Tue, 28 Apr 2020 03:37:04 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id h5sm25593874wrp.97.2020.04.28.03.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:37:03 -0700 (PDT)
Date:   Tue, 28 Apr 2020 11:37:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/4] mfd: wm8994: Fix driver operation if loaded as
 modules
Message-ID: <20200428103702.GQ3559@dell>
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
 <CGME20200427074842eucas1p1abfb9af74f0d898ba381700f37820318@eucas1p1.samsung.com>
 <20200427074832.22134-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427074832.22134-2-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020, Marek Szyprowski wrote:

> WM8994 chip has built-in regulators, which might be used for chip
> operation. They are controlled by a separate wm8994-regulator driver,
> which should be loaded before this driver calls regulator_get(), because
> that driver also provides consumer-supply mapping for the them. If that
> driver is not yet loaded, regulator core substitute them with dummy
> regulator, what breaks chip operation, because the built-in regulators are
> never enabled. Fix this by annotating this driver with MODULE_SOFTDEP()
> "pre" dependency to "wm8994_regulator" module.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/wm8994-core.c | 1 +
>  1 file changed, 1 insertion(+)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
