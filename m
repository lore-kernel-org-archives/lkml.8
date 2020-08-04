Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFE9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F5C2070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KkLn8YU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgHDGFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgHDGFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:05:09 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFD6C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 23:05:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ep8so1402737pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 23:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=29RX8bXAuW3G0jtpg7c07xftgd6wAAyG9UIW4GkKkEE=;
        b=KkLn8YU63zAqqKEqBxzj8VgPytKimcuOSG62fWGwsmSKCplvu+pSTTOhZlnhVMl0x2
         3FYwjL8gJehForcHWlq53ixj/peur2dmTjDXxvGpprq/z9uGcT9NW+RPBItW2ty2zn/K
         d1RmHMauflrekOsAZtkgMo1WTH+sipmLGpIRHev75H610NRRiIKqTSflqwJMNs5EdOEo
         yVNc7LotapWaHklZdxCIuObQmNZACw5oxP064/kWiY2fQ/4pM/Qg4J3MGQzUw5WmvXAY
         juJEJRrK2ZUtHjWDdwwzejVi9+HpL/jSNxmCxVrhrRlg/ok2iR167hKTGZZwo6ac/1HH
         JjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=29RX8bXAuW3G0jtpg7c07xftgd6wAAyG9UIW4GkKkEE=;
        b=a/0M0p18drUfnqPPcHLqUq+iuIOO0UzlIOETqs4B3KSte4h0sZAGBTmPRb6m9NZCpy
         TRQRsQqRwLW/CgNe1lwrc08LD9eaOUA0S3aJoIf8Vq/kanVlhPoCjvL39+h6jOn7EyL9
         l76B38M47kW+txupPNhlr+HPW+Z1hHbuNqztyfSNs3g02G+0eEUaLERW1p3COV0meFGf
         /wlyqhbt6JCh6VUM2wcsdW6HYmR2L9ZruG9kMhkZP8heMKj+e2QMrcAEY/6dnH7HZM7a
         J9UeJKX/tMerZ53vz27BUAs8eM/GSQbbmmWJbqd5Z7286wzV/yCyhH3foqzNWk35JhG5
         4G+w==
X-Gm-Message-State: AOAM5305lHq/CU0odP/z7sVdQ9eccMff4q/cw3PctuzIMRAuldHVOmJf
        hC4d7eyGLZDoZFmFQ7FGwDxovA==
X-Google-Smtp-Source: ABdhPJwLL5n6gEYWYzbVJtSX2UtSyopSxs/VQFcZUH1Ttai8mPQYDOSqhsn/4gxSrBnvlERUgZaFkw==
X-Received: by 2002:a17:902:221:: with SMTP id 30mr18452271plc.222.1596521108530;
        Mon, 03 Aug 2020 23:05:08 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n26sm16606191pgl.42.2020.08.03.23.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 23:05:07 -0700 (PDT)
Date:   Mon, 3 Aug 2020 23:05:05 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     agross@kernel.org, kishon@ti.com, vkoul@kernel.org,
        dovl@codeaurora.org, ygardi@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianjia.zhang@alibaba.com
Subject: Re: [PATCH] phy: qcom-ufs: Fix wrong return value in
 ufs_qcom_phy_calibrate()
Message-ID: <20200804060505.GJ61202@yoga>
References: <20200802111546.5611-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802111546.5611-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 02 Aug 04:15 PDT 2020, Tianjia Zhang wrote:

> On an error exit path, a negative error code should be returned
> instead of a positive return value.
> 
> Fixes: adaafaa393ef1 ("phy: qcom-ufs: add support for QUALCOMM Technologies UFS PHY drivers")
> Cc: Yaniv Gardi <ygardi@codeaurora.org>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Thanks for your patch Tianjia.

The support provided by this driver was added to phy-qcom-qmp.c a while
back and in what's will become 5.9 the phy-qcom-ufs.c driver is removed.
So your change is unfortunately no longer needed.

Regards,
Bjorn

> ---
>  drivers/phy/qualcomm/phy-qcom-ufs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-ufs.c b/drivers/phy/qualcomm/phy-qcom-ufs.c
> index 763c8d396af1..49d47dc5bfd4 100644
> --- a/drivers/phy/qualcomm/phy-qcom-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-ufs.c
> @@ -24,7 +24,7 @@ int ufs_qcom_phy_calibrate(struct ufs_qcom_phy *ufs_qcom_phy,
>  
>  	if (!tbl_A) {
>  		dev_err(ufs_qcom_phy->dev, "%s: tbl_A is NULL", __func__);
> -		ret = EINVAL;
> +		ret = -EINVAL;
>  		goto out;
>  	}
>  
> @@ -42,7 +42,7 @@ int ufs_qcom_phy_calibrate(struct ufs_qcom_phy *ufs_qcom_phy,
>  		if (!tbl_B) {
>  			dev_err(ufs_qcom_phy->dev, "%s: tbl_B is NULL",
>  				__func__);
> -			ret = EINVAL;
> +			ret = -EINVAL;
>  			goto out;
>  		}
>  
> -- 
> 2.26.2
> 
