Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E9BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8862063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ac55q3Zm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgGPPGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPPGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:06:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8C3C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:06:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so10613821wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HlvGKFaG5MmOytwqLGoLiKZ8wGbh30D2hsn+mi7pUuU=;
        b=Ac55q3ZmAh67qDQuBn4DTTOG8vcWoh7dxtGs/WOeLrGqlKo0uI+1fhS4pKjqn+0YHd
         T/YzD4qM732SL9QwSoZnWEn2cXyqy0HvjnfygIOhJcLkzwt86qEbrNh3KM8EV5GVwhpG
         w0BZNA+Jmv37bXLC81zeL/HjHwB/+gHHb14EkWSmqfnUTy4w0p8XPQmmF5X0hldTjecO
         MXKb6qq/02Y25bS4OQRMUMTUlaCZuXIfDdLJ6sJSR0qey9WaxMswCss7uE9SUS9p31tr
         BIs1tRbsgpWxIfuzShoLx307H66HN4glRDsYxDWqW2D4iJsU9ud8uOBQgCrmfHsfcRh3
         fxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HlvGKFaG5MmOytwqLGoLiKZ8wGbh30D2hsn+mi7pUuU=;
        b=Vey8oqhU+nzFyCpdZudsCrlmoCRw8J76EuGZq4XDaStb9Z+8dtLABha5gU5LCNv7p/
         wMLwg1oDsgRq8pn+OkVaTXXTncoltfosCkgS3tqOudAJqJBoc4h1hTLgt7su47IkQUIq
         kpFQvnX/QJyxhZ7LFLuZ2lC+itg8lsHr1dyhIbQlzyY64UKFGgmyHC1U2b/wAeO1zF2A
         jaMyORgWquqoaTH4kSuH0nbFZcGE3GAdLOu+Z+cb1pV4dAJutl8hHh+bkm6h2UJwPlzG
         EVywP9mMrKN1LXpqqB/1qlr99sOQhTBSGpoxoTCsyFvMpmRM7NhfKKymOG2yLSIebOIg
         Iiig==
X-Gm-Message-State: AOAM532XLN+/JyvP+oQOWDKWCENnIgR2l3X2dWL+ZvcSmzVGkLVw+dSA
        TQMxPyS6DThs1ZcBItAkBp1gTunY5Og=
X-Google-Smtp-Source: ABdhPJwe5waIrGsT7rvEsA2OlS5xHGXLFf1lFYnd1zBtOx1SbonyLFYC+sR0GdPMilGXS/FbHJhfhw==
X-Received: by 2002:a1c:2e57:: with SMTP id u84mr5064742wmu.52.1594911982685;
        Thu, 16 Jul 2020 08:06:22 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id j75sm10521336wrj.22.2020.07.16.08.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:06:22 -0700 (PDT)
Date:   Thu, 16 Jul 2020 16:06:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [RESEND PATCH v3 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Message-ID: <20200716150620.GW3165313@dell>
References: <cover.1594632559.git.Adam.Thomson.Opensource@diasemi.com>
 <565560ffd791f597826fe724843e69dd0a315c18.1594632559.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <565560ffd791f597826fe724843e69dd0a315c18.1594632559.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020, Adam Thomson wrote:

> The current implementation performs checking in the i2c_probe()
> function of the variant_code but does this immediately after the
> containing struct has been initialised as all zero. This means the
> check for variant code will always default to using the BB tables
> and will never select AD. The variant code is subsequently set
> by device_init() and later used by the RTC so really it's a little
> fortunate this mismatch works.
> 
> This update adds raw I2C read access functionality to read the chip
> and variant/revision information (common to all revisions) so that
> it can subsequently correctly choose the proper regmap tables for
> real initialisation.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
> 
> v3:
>  - Replaced magic numbers around I2C paged access code with enums and defines
>  - Small style tidy ups as requested by Lee Jones
> 
> v2:
>  - Use raw I2C read access instead of a temporary regmap to interrogate chip and
>    variant id registers
> 
>  drivers/mfd/da9063-core.c            |  31 ------
>  drivers/mfd/da9063-i2c.c             | 184 +++++++++++++++++++++++++++++++----
>  include/linux/mfd/da9063/registers.h |  15 ++-
>  3 files changed, 177 insertions(+), 53 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
