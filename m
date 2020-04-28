Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55822C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B74206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CW1WJz+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgD1KhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726328AbgD1KhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:37:19 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB84C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:37:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j1so24052956wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7MejAFBM22X91TMwqTDKSAeWhAdaxEoe9krCl6slZcg=;
        b=CW1WJz+v+l5HJMoPdvjvjK/VgsrHkwFr4WsjHdgLJGBXnep8kEZ68Z+I1d60yQVsg5
         8ycIUR4EOnZSldddQ+VA7nG8H5wj91eIDi7sDP6g+dV+NEku+iLIaTzcJz7qCDOqdhPu
         oHa6deCp/HBKhISiwFkT5Eb0yXwnC26RyKbmpEq4iz7DNDud5v2lSggY0aJpoE1x1Lue
         jJoI2KGhD2+wXreNYy2XH1+RgVAiHfgVlfkWtkNuGzIgyq2g02Sw3UbOA6i2Et+ltdha
         tWuZmqrrgavp+4B2q+n3dCe2wDA4gSfV7+Mo+rABKEyziPx26InaOZOfzgeIzu/98O+w
         MWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7MejAFBM22X91TMwqTDKSAeWhAdaxEoe9krCl6slZcg=;
        b=PXNcEZWreYmBwhj3gzxr8TX1s1mn/DdYOtJ3lRpsspoELkViqt39Jr/MCoq9aMNK71
         mM3Fq9j69z/2kwY7EcY2nRn4vMjiEJiswy8Xe+ynlgVPvD19ztjswrx2pw1D5pPT8HwK
         fCXd78gWGaldTcsxPa9Bz/SbTMvmEQb8W2KWBe6j6t+ARi3VNlB9EicaMjTJa6bbTs0N
         nekgR1wVBDyYGwnq6aiGRP5erzniVOmhSdJLZL5sGQrDsH1klS0FexMvwGgB45tBCm+h
         fjyTjX/qH4tg9l6m4RuyiEFphzvXye1fkuMtjfYxvfQeHPrzeGgcc+ZMXf+RH0kS43/p
         MqsA==
X-Gm-Message-State: AGi0PubIwdtUoWS2PmuBnvWNSA6CfUktcoxgl9h9fT04m96NECri5T2b
        lcvd4QtCwitTDioAcL/R88c4Fw==
X-Google-Smtp-Source: APiQypKdoep9dH64db2eqNaZcKDzXAa4SCLSqqV2lBPjzT69msPFvROIeGblV3W9BBHviXISbLazmA==
X-Received: by 2002:a05:6000:f:: with SMTP id h15mr31915700wrx.408.1588070238317;
        Tue, 28 Apr 2020 03:37:18 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id h188sm2986813wme.8.2020.04.28.03.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:37:17 -0700 (PDT)
Date:   Tue, 28 Apr 2020 11:37:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/4] mfd: wm8994: Fix unbalanced calls to
 regulator_bulk_disable()
Message-ID: <20200428103716.GR3559@dell>
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
 <CGME20200427074842eucas1p2a37c7f854188cccf3b103b221a84e9f2@eucas1p2.samsung.com>
 <20200427074832.22134-3-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427074832.22134-3-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020, Marek Szyprowski wrote:

> When runtime PM is enabled, regulators are being controlled by the
> driver's suspend and resume callbacks. They are also unconditionally
> enabled at driver's probe(), and disabled in remove() functions. Add
> more calls to runtime PM framework to ensure that the device's runtime
> PM state matches the regulators state:
> 1. at the end of probe() function: set runtime PM state to active, so
> there will be no spurious call to resume();
> 2. in remove(), ensure that resume() is called before disabling runtime PM
> management and unconditionally disabling the regulators.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/wm8994-core.c | 3 +++
>  1 file changed, 3 insertions(+)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
