Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1ADC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 08:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BED3206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 08:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/xaQv5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgEVIG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 04:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgEVIG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 04:06:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09C7C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 01:06:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so9207649wrx.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 01:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eYZ+JqAlYOgHXPOJCTtuz0GyTZH5GxzAjW2qDHscMoI=;
        b=s/xaQv5gx2QZodgkEgraSKx6LKxVuErDsWOmIGFJqCi7RbAlAAf2IRD7bLRK3BNX+U
         9AAqXmLYsIzY+eqSywvLWdQK4vlZKqCSGaKrMLaVFBGNjD3IlwYni4fvYJRki0WmP/G5
         JkGHMATLsjlN7UbGBmzQNme4Mr49vmnIaSJEmvwmqx2W7HEzHI2lppGMGoVBMO4CD8da
         4hDgiv4yYBICc0pCHlOTru+XXmnhmtSVD5jhDe9tBKx3SDQHgFnne0HvPfrtKtqkp+l8
         5xJWpLcyGHMHDPVpq02LQcPXuqteNUybnAKDX9jm7GsKtV1bbvNoYLq+keXP2TpqUy6H
         L9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eYZ+JqAlYOgHXPOJCTtuz0GyTZH5GxzAjW2qDHscMoI=;
        b=JEofbh+1X/pGVPgUwsQRAQEJTTZ2HlCJceB+AMc+WgjEOFcbQ7DxxBAt3nVMNGOmYN
         ho4uRmnBlFBJu/IMaOwD/fu5qrBZl1bEXV5hHOMno4c/Zzm3tSsW5MQWuBe+MDWQPim9
         3m/kbJjzDeGk7sZzTJqjAeOSaMPFC7/x9e1Tw4XojL3B+Sop+lYbHF0o/jPk/qXQoxUw
         GLPfY1jL4Y9vAKCOMox9Pw1dkIE7dX4kbrwHxjadUOtxDgNvxAAyjHWari1Y6EgauapS
         NJXhwciAme1rhR7Tj5pjKJNhGmmACiRURiwVRn+5egTl7SsRxx1z00Ph/6qeYP1TSRLO
         V/5Q==
X-Gm-Message-State: AOAM533S3crCm2HHxJm85GhMU8EMlruZEcwbLodiDjTh8xC5WIZ24vXq
        mkPDk4TlxTxYoli/AsUAcVrnsw==
X-Google-Smtp-Source: ABdhPJys1hWyXl3jHtzATMUKReeozUyk1CGPsBMj6QlrMYrp7cQPEUT5Drui5+A7TU3k3HbQDtX/pA==
X-Received: by 2002:a05:6000:1083:: with SMTP id y3mr2227792wrw.425.1590134814513;
        Fri, 22 May 2020 01:06:54 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id p1sm363971wrx.44.2020.05.22.01.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 01:06:53 -0700 (PDT)
Date:   Fri, 22 May 2020 09:06:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/4] mfd: wm8994: Fix driver operation if loaded as
 modules
Message-ID: <20200522080652.GR271301@dell>
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

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
