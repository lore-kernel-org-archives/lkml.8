Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E70C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FBBD207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GuF8N+/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgETIt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETIt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:49:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E63C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:49:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n18so2000923wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NWaEHiofUdf6wDwIAUa4y4wi7tw1BiA51/qEMLgs6AU=;
        b=GuF8N+/dbPRSqOaevF9sTk9YryCPv4r7ZqF95iG8M/GZV046sf+1OpVYRUmJ752O9n
         tLXAERYZqA7k029FQshrGhBiG7tb2rtPY4ogy4K9IyTelhqOq+SVqMCmU49UIRwHlDxZ
         XJbwXHFhkhNqLBWhbTi4FFgUgCKGRUClXdUGodLuhTUp2TyZe4KEMoou11NlGQUA/wCq
         6IL8M5cqfbhyfM7K3u2w/YSXQG7ruenssF6HkITumCnwrTls78z0FPxhBCagma1UNfBB
         DNC8eumC5kfd7gwArsj/TdT7Kd0tYyKMNN79bt9sHM1SUcbk+xmLbHj+qCq/ltslGHEq
         D8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NWaEHiofUdf6wDwIAUa4y4wi7tw1BiA51/qEMLgs6AU=;
        b=tuNuxLzmJQ4oG7oYDi9xq4iiMh56LABO6Nz7TuZacBJyz5++Dn5F5vnp5VXG8f/nId
         AgBbR1ME+zFzSSG61guk6cHlssLCQ0xP/jwv+U4JnTxsUTP9nR6lgMrdDFU59Or/q7/R
         C+JiyPFIYmOQK5MrUHT7MxOZhLsv6EjeOgRrCD2P7X8itS/d4FX8IdfsUl5ZsVlInluA
         A5M98MXid4+wudS5uN/dFS+00IHNoe/gxjRDT5PtPOOzux5Quq/SHASvHBo9YE90d9R+
         iXm9TIdC+etO/hH39LlBJSMbLnIaJaecDhd62h6FpymPJpZ1HBpySCSVkuwqaBSXmm2N
         Ayqw==
X-Gm-Message-State: AOAM532swYHHEkmNTbBVmofDdzfdGkeeC0JYUKZobC5We4/7I5CrNDYL
        xkUo72emSv2jeaiLC6wkttzw2Q==
X-Google-Smtp-Source: ABdhPJyep+rJQfzqk9gMxRBnRY9lMOYkgMnXKzNjAD/1SMDl4Fj2JnyisEDn3M3lozBwoT6aLNE+pg==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr3413772wmk.99.1589964595466;
        Wed, 20 May 2020 01:49:55 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id s8sm2168440wrg.34.2020.05.20.01.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 01:49:54 -0700 (PDT)
Date:   Wed, 20 May 2020 09:49:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, vkoul@kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: stm32-timers: Use dma_request_chan() instead
 dma_request_slave_channel()
Message-ID: <20200520084953.GC271301@dell>
References: <20200107105959.18920-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107105959.18920-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jan 2020, Peter Ujfalusi wrote:

> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> Changes since v1:
> - Fall back to PIO mode only in case of ENODEV and report all other errors
> 
> Regards,
> Peter
> 
>  drivers/mfd/stm32-timers.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
