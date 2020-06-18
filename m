Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D73C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A799821BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJlDC6ys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgFRIRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgFRIRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:17:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E88FC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 01:17:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t194so4655387wmt.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 01:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NDyr9zstTs9Nq+zPZv6Gql9N0F6eSp5HHPdSh/JTGbE=;
        b=MJlDC6ysXgmjeUc1Qc+dVLIpYvX7pC1p6fQJsbFdp5S8FrVR+Kq+idOo26bUeeWIja
         e/8Q+asaRlszugusmnJN8yJgQQLlR0N3jkXAPXcKSiX5LcoWhWecTAy4yKpU9cUfvwPm
         AzA06IoaxMXGuBrRLZLe2U9QAwqfBV/Kepzl0t54uMKpjJ1cjHeMoOEOzzEahkiNF9BK
         lYqwuxk6HaVO0azDXianiiFMaUaCvl+I59c1x02uT08lTGCIzIEW3K4atLjn86ezIu2c
         +m5QC5+zWt75hYbirmBHH80hAJOrFmqPdezZgA/tVOCYl8+k6SfG736TlxaLhAGcOcKJ
         Z3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NDyr9zstTs9Nq+zPZv6Gql9N0F6eSp5HHPdSh/JTGbE=;
        b=nXdyGej364UdsaLL3+n1WdwiSNfmv64lJnN0JOXxXNLYTbUuNkkmU1LfB3iHsC7dkS
         fGVFHCB0xKCn5e5T873YhwmFKoKXWfLAb+8ES6KJVS5TjF6dgZ3qEjyecY2sxsMMOO+Q
         U/aRYWOlWFlSd0aEFzCfcHSw5OzyXDV7WW0y+VH1/352pwAUW8fyq4RGpeQsSBdijO/E
         P6eEk9ufCGybvxHGcKOtW5dYrFA0WCn1Yndbz/UYD/NIn8vbiAZVkwEv4qadKKjL/9x0
         ZN6PtZok85Tz4sQ1wtG7z9UBoMcTwN3lhQu192+6wQbjO2tOQNdtu5wGBW1N1R7mr9m8
         DbOg==
X-Gm-Message-State: AOAM5335d4W89Dqt8cenp2KOXfp2tgF5ELaX79nMMWSMVTPuWrDZhBev
        bC2MVK/+kUA6RNd5PsvUjzQ33Q==
X-Google-Smtp-Source: ABdhPJynqsLitcWa78812w1ql91heYr7oKRr0vEFQTLuGV6/e9w6jwU/14rOdWKeAcyy4QFw6t7aVw==
X-Received: by 2002:a1c:16:: with SMTP id 22mr2684181wma.42.1592468218943;
        Thu, 18 Jun 2020 01:16:58 -0700 (PDT)
Received: from dell ([95.149.164.118])
        by smtp.gmail.com with ESMTPSA id 4sm2525430wrf.74.2020.06.18.01.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:16:58 -0700 (PDT)
Date:   Thu, 18 Jun 2020 09:16:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: mfd: add Khadas Microcontroller
 bindings
Message-ID: <20200618081656.GB2608702@dell>
References: <20200608091739.2368-1-narmstrong@baylibre.com>
 <20200608091739.2368-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200608091739.2368-2-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jun 2020, Neil Armstrong wrote:

> This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
> boards.
> 
> It has multiple boot control features like password check, power-on
> options, power-off control and system FAN control on recent boards.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mfd/khadas,mcu.yaml   | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
