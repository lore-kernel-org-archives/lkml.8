Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6872C433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B75762075B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597701290;
	bh=Q151OcxfVK5+W50g+orX+Xdf9Ht0NdL90Vbo2D+cfFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VTbWV67Rmm78KVdqn7PWN8Q5+zbgUrWb0utb/qwcSXQKemPfaa4t375RIKxjcrczY
	 PJOJZRgnWIDxP2cXyF+UQUnjDTjFNNINy6QUiQaWyGnGtPvdEOwyLLtlK3LKc5qeAd
	 5S3h4h1Pcj3v1AhzAv6Zg0XdlTOuVR4hidDPDQRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgHQVys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:54:48 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34904 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbgHQVxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:53:54 -0400
Received: by mail-il1-f195.google.com with SMTP id q14so12432265ilm.2;
        Mon, 17 Aug 2020 14:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=irJy6S2QShWPaULF8WN8Xlc9QcpqNGnW+ZOqavaiAyM=;
        b=d8cM75gEHUaRRHCqQTxgy6t8O4641CoUmEi85l9mVCM++fJvJoBppibjxYGD6LGzR2
         Fm4RcV/+ArH/ke/aFw9iH6kIfvrtw35rKOZLOPIilHCzOFCxAlwccHfWT8ZjJy/LbH+d
         eic/9Q5CDgsKUkaMppZl99j0IDOOjIrR4FEJPPxmQ0UqvyrFX8SxRS7ESTUYMKfoUtPg
         d5A94l8ZalyJpCszH4hkRntGgu8SjBsTp0g3Yw37Hj7jOVfS1hzizhNIz51z5sl1Pw6N
         bXf8FIVrgp4xzJmgcGMnGM04P0dP0ItI4ANhVs+rPXB1k84pFYl4ECNmFuLdCqQBGx02
         OyXw==
X-Gm-Message-State: AOAM532yyzNkWew9sSGYW/aGXrt7yQzdu+Fv9szg6bFpsGNBOfqXU3ZR
        lL0DCTyYGin9elB3JMDwdg==
X-Google-Smtp-Source: ABdhPJzI1M0gVI1I3xczRo7fzd9EhOM5wg2+74nfZYkCDwTZcLbXmRjG9cYzZnFU3l78Z92I5uWOog==
X-Received: by 2002:a92:aa94:: with SMTP id p20mr15902826ill.266.1597701233225;
        Mon, 17 Aug 2020 14:53:53 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id n5sm742881ilj.43.2020.08.17.14.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:53:52 -0700 (PDT)
Received: (nullmailer pid 1638312 invoked by uid 1000);
        Mon, 17 Aug 2020 21:53:50 -0000
Date:   Mon, 17 Aug 2020 15:53:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: platform: Destroy child devices symmetrically
Message-ID: <20200817215350.GA1638282@bogus>
References: <20200806153650.3883530-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806153650.3883530-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Aug 2020 17:36:50 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Iterate over child devices in reverse when unpopulating a platform
> device to make this step symmetrical with the population step. This
> fixes an issue in the Tegra DRM driver where upon module unload the
> DPAUX controller tries to unregister an I2C controller but will end
> up waiting indefinitely because one of the SOR devices is keeping a
> reference to it. Since the SOR devices are instantiated after the
> DPAUX devices, they would only be removed (and hence release their
> reference to the I2C controller) after the DPAUX devices have been
> removed.
> 
> While destroying the child devices in reverse order helps in this
> situation, it isn't fully safe to do so either. An even better way
> would be for the child devices to be reordered to match the probe
> order, which would work irrespective of the instantiation order.
> 
> However, reordering by probe order would be fairly complicated and
> doesn't fix any known issues, so we'll go with the simpler fix for
> now.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/of/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
