Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8B6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47989206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="buvt6vge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgFVJwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgFVJwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:52:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6ACC061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:52:37 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x16so5094986wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=z9PYdNEx68fdBQ4HIC09rySNq4GQIIixBVz7VbNxwSM=;
        b=buvt6vgeNTt/iKd/o5dPmVQOcj041HOK0mEiS1raeq2f76wAMtyGd5yO8V5rsDbHRz
         WbKMN/6+4/njzXJp2iEj8U0GTR4E9V2rQ3vZEsrK7KUPh3V748fXHschIUqHedzkAQPa
         Ta2tCa3nQqqwZvHbIOPJbcv3uRW+8V51SLKFPa4d3uQlxnQaTLDny/XzTwmdWGIFqBwx
         PziozKa+D1YRjR2XDg1egygWFKief76yoO7oNcdRhltfsH5MWncFDPKsxLzn30e9v+BZ
         T+C3tY+GVM83PAw3wUkvDetkTlq9Ab8f3BJphWK6pYUUVO8MWF0Vfu/SFyfHeGYqw4UR
         YKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z9PYdNEx68fdBQ4HIC09rySNq4GQIIixBVz7VbNxwSM=;
        b=VlAFGKuOSKalL0EQWoP6iDgWgPIQtFSDLfmPvwKJ0KQOuUR4quf5sXJWBlK0DID00J
         IaG7kU1vOEwxfCeS0i1vsAHaZZmadiHe2dAo+EZCDhn1Y8DuMkXL3bmbv/OQApz+veKx
         K3ZlhaiWtdcfYAkcaq0Xj2ZkMTAlRTf8kL3vnKOuQmzcMU20S10vryO+jrKIVRj5Tmef
         ESG4UwAwz5E6qGYqVwNlpybqGshnvq9cbo6PtYocrvgUGTucOstL2L4qMrZMOhkQ+SNg
         LkaB675H/zT0D8TUXeFCHv7T5/qpZSQyQLF64P1fcQSuOtSgALeLrxiXiu4wTRgoFAzH
         K8PQ==
X-Gm-Message-State: AOAM5314YtZdJvykmJDAlpSrbIp3gCf6IZPiRKx/6+ByczevC/0H4ebT
        JsfLJuxSX9vTiKFJQWRrnubKgQ==
X-Google-Smtp-Source: ABdhPJy67Na5SSLqjDDRCQMG2Ypxj0FmvNWK+vh2n5U9GFODDnlovJgaDdVNh8P/IULQkezN4OggnA==
X-Received: by 2002:a7b:c345:: with SMTP id l5mr18487051wmj.31.1592819556511;
        Mon, 22 Jun 2020 02:52:36 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id z9sm15749716wmi.41.2020.06.22.02.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:52:35 -0700 (PDT)
Date:   Mon, 22 Jun 2020 10:52:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Xiaopeng Bai <xiaopeng.bai@unisoc.com>
Subject: Re: [PATCH v2] mfd: sprd: populate sub-devices defined in DT
Message-ID: <20200622095234.GQ954398@dell>
References: <20200619090914.23801-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200619090914.23801-1-zhang.lyra@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020, Chunyan Zhang wrote:

> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> SC27XX-SPI added subdevices according to a pre-defined mfd_cell array,
> no matter these devices were really included on board. In this patch,
> switch to use devm_of_platform_populate() for adding sub-devices which
> are defined in devicetree.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
> Changes since v1:
> * Address comments from Lee Jones:
> - Switch to use devm_of_platform_populate() to add sub-devices.
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 75 ++---------------------------------
>  1 file changed, 3 insertions(+), 72 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
