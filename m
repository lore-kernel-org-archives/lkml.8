Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFA3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3556D20656
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGnqNsFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgG3T4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgG3T4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:56:41 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA98C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:56:41 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w17so15132174ply.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KzXD0MRi65oSTXHgCyzde0q1srH0GAtc+ha28tXiTLc=;
        b=NGnqNsFTZlKNXRaJQvbsmWULw8+/G5xUXncje3YJWBb3mLbdKb/zIY43ER/dfAFZEs
         0o944uAgnE2HOKxBDwTdhW2CH3OQN+i7KUGd+WKYpBWqpCAQV3vgYlo3cLJ1kBrXF8UK
         CxodWOaVKLsCsbyZN1Vztyei1X75TBj2TOykBFAatZPzqbWukqayWMH8KDmTNPzMPCyj
         cYBjonm/+EWJeXx8zW0eBqsq0Z4WxMTxVbzkNpjV7YI8F8kdD0R+0xLkTeLgtHXV1lw/
         Ug6vPGFpIF2bstOJ2fpbi03P7d4pS0GXW+0ZW88kEdlu6xi9hykUmHvg3S9Xx588a+7C
         ZVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KzXD0MRi65oSTXHgCyzde0q1srH0GAtc+ha28tXiTLc=;
        b=Bx18g6wswOpYYxjIxAbQyovfDVbM9mGRR6BW1x0ztYJZJsrnOh64fDyQqpe8IGKcSQ
         SODs+y5ruzBq0I5R75+EgPJzW2z+Fcb7i/a8i3IzjC5Skf7ehb7qbywNbM/WzSs3HDmv
         QYXc5Tw67luaG0BG/eR7+IFNggZGXkEVhEBS4o8jRQrHT+3gLzoYVCMAtyfpFA1vJ7cH
         XIUS/SEYrNwWYNxwlg3kOATOknumNFsPVxbQJp7ipAccwkqlXH+8p+IUNB2Ms5CIDnAR
         wNkvxKJA/NLGffdPnRvygMc8PWCMxjPZHQ5WJf2rErNFqKxKPO/UK7exFtS3FC0e9RrH
         qWZQ==
X-Gm-Message-State: AOAM530SMLFy1joQQSXi0YgrrrENQJ0j9t5CuuOVriUgN7pWf2U/nqnm
        gIakqPERdS1cWJacYDvaIUrs3A==
X-Google-Smtp-Source: ABdhPJwl6R8PoPsL0ppPlmpcjuFT65L9AryjbOfKLLj/4Glx60PaO1QR2ebP1qlrkD2f3Z0AJgbAXQ==
X-Received: by 2002:a17:90a:89:: with SMTP id a9mr714997pja.171.1596139001101;
        Thu, 30 Jul 2020 12:56:41 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g6sm7295794pfr.129.2020.07.30.12.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 12:56:40 -0700 (PDT)
Date:   Thu, 30 Jul 2020 13:56:38 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
Subject: Re: [RFC PATCH 07/14] coresight: etm4x: Always read the registers on
 the host CPU
Message-ID: <20200730195638.GD3155687@xps15>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-8-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722172040.1299289-8-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 06:20:33PM +0100, Suzuki K Poulose wrote:
> As we are about to add support for sysreg access to ETM4.4+ components,
> make sure that we read the registers only on the host CPU.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  .../coresight/coresight-etm4x-sysfs.c         | 23 ++++++++-----------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index b673e738bc9a..90c75ba31a0c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -2341,23 +2341,20 @@ static u32 etmv4_cross_read(const struct device *dev, u32 offset)
>  	return reg.data;
>  }
>  
> -#define coresight_etm4x_reg(name, offset)			\
> -	coresight_simple_reg32(struct etmv4_drvdata, name, offset)
> -
>  #define coresight_etm4x_cross_read(name, offset)			\
>  	coresight_simple_func(struct etmv4_drvdata, etmv4_cross_read,	\
>  			      name, offset)
>  
> -coresight_etm4x_reg(trcpdcr, TRCPDCR);
> -coresight_etm4x_reg(trcpdsr, TRCPDSR);
> -coresight_etm4x_reg(trclsr, TRCLSR);
> -coresight_etm4x_reg(trcauthstatus, TRCAUTHSTATUS);
> -coresight_etm4x_reg(trcdevid, TRCDEVID);
> -coresight_etm4x_reg(trcdevtype, TRCDEVTYPE);
> -coresight_etm4x_reg(trcpidr0, TRCPIDR0);
> -coresight_etm4x_reg(trcpidr1, TRCPIDR1);
> -coresight_etm4x_reg(trcpidr2, TRCPIDR2);
> -coresight_etm4x_reg(trcpidr3, TRCPIDR3);
> +coresight_etm4x_cross_read(trcpdcr, TRCPDCR);
> +coresight_etm4x_cross_read(trcpdsr, TRCPDSR);
> +coresight_etm4x_cross_read(trclsr, TRCLSR);
> +coresight_etm4x_cross_read(trcauthstatus, TRCAUTHSTATUS);
> +coresight_etm4x_cross_read(trcdevid, TRCDEVID);
> +coresight_etm4x_cross_read(trcdevtype, TRCDEVTYPE);
> +coresight_etm4x_cross_read(trcpidr0, TRCPIDR0);
> +coresight_etm4x_cross_read(trcpidr1, TRCPIDR1);
> +coresight_etm4x_cross_read(trcpidr2, TRCPIDR2);
> +coresight_etm4x_cross_read(trcpidr3, TRCPIDR3);
>  coresight_etm4x_cross_read(trcoslsr, TRCOSLSR);
>  coresight_etm4x_cross_read(trcconfig, TRCCONFIGR);
>  coresight_etm4x_cross_read(trctraceid, TRCTRACEIDR);
> -- 
> 2.24.1
> 
