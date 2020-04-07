Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A724FC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A1020730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="uc8JaIBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgDGTgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:36:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37717 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgDGTgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:36:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id t11so3326652lfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 12:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zYmwLnSJ94Ak1KFQ2Lt4K/NwHQ1452knMRyiQWVA3M8=;
        b=uc8JaIBoePdZQYUsZFc2nPs8Ko9Dz2onCuSwcbV59VPMJCmgoNdFMbJCpw0aiIknZt
         Re41I6UNrzUrpklpcSzYlGTYDGJDLwByQhN4wdNx3JIKj+eaYPFoinaVAd5q3BwMj0l3
         Cxrt5e82wl9kH6B/slgjYgtqU/4+3U1LHwux7GxgdffJljupkwvCWf6alBds2zJNKV9X
         uC4d22I+0NA3a4deAToJSJejnFINFAtT/I727lzfdG3l4CY76U/MQmYCnqfqs+KM9aEy
         qIM2Neory0Dgfp9vrzhpKMuO8L9v9ZOfdVCyw9Arsj0jBdP/QrB1Z6EhaBi1+Versc0Q
         JmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zYmwLnSJ94Ak1KFQ2Lt4K/NwHQ1452knMRyiQWVA3M8=;
        b=bPKzsEd3oSCeg4KqGn8yb9ZEfZgXD4MB4zNADRxSu51HDuwQVy3HkErlF2207U+K9c
         Hj/6hDwQJfoQs49J/UU3s4T6UOn0ToxwaIbCUyxSQPfS5F1EE2BuLWfp4VK3/QEhdKVK
         bld8xoOt38kT/oS5rpPq72bLMqrHS1tg4RvZWZNRt6iLz13rUQsJMnUYrHhZIWu+yVmg
         KT0kYnlCnd75AWpGKzd6fWV9WGEUQKWXUbjWWK+DZKzDcfpfKoqiw9iCtlrK1YYWI6Pg
         WMZKV6o1XugxUF8cv/4D7MQdmyKp6CINhhm+2rFGU+BSo6HvuyV3sttx+GnNVHSPwobG
         1Dqg==
X-Gm-Message-State: AGi0PubWQSiDzSOHyoBHDf0h1574AXIQ9A9MONSMOotK16622Jx9tgYM
        +C+5d4g8Rf730QBxV7KjIZxKeQ==
X-Google-Smtp-Source: APiQypLDRt4Lwe0RPpsuG1osUpGjx+Fpay7l4fosQ49a38aeoE/FR14zxknbcc1YZE8RZHUmwgI8NQ==
X-Received: by 2002:a19:3848:: with SMTP id d8mr2332310lfj.44.1586288176141;
        Tue, 07 Apr 2020 12:36:16 -0700 (PDT)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id n26sm12248798ljg.93.2020.04.07.12.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 12:36:15 -0700 (PDT)
Date:   Tue, 7 Apr 2020 21:36:15 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     linux-media@vger.kernel.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        hans.verkuil@cisco.com, skhan@linuxfoundation.org,
        mchehab@kernel.org
Subject: Re: [PATCH v2 0/3] media: add v4l2_pipeline_stream_{enable,disable}
 helpers
Message-ID: <20200407193615.GG1716317@oden.dyn.berto.se>
References: <20200403213312.1863876-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403213312.1863876-1-helen.koike@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helen,

On 2020-04-03 18:33:09 -0300, Helen Koike wrote:
> Hi,
> 
> Media drivers need to iterate through the pipeline and call .s_stream()
> callbacks in the subdevices.
> 
> Instead of repeating code, add helpers for this.
> 
> These helpers will go walk through the pipeline only visiting entities
> that participates in the stream, i.e. it follows links from sink to source
> (and not the opposite).
> 
> Which means that in a topology like this https://bit.ly/3b2MxjI
> calling v4l2_pipeline_stream_enable() from rkisp1_mainpath won't call
> .s_stream(true) for rkisp1_resizer_selfpath.
> 
> stream_count variable was added in v4l2_subdevice to handle nested calls
> to the helpers.
> This is useful when the driver allows streaming from more then one
> capture device sharing subdevices.
> 
> This patch came from the error I was facing when multistreaming from
> rkisp1 driver, where stoping one capture would call s_stream(false) in
> the pipeline, causing a stall in the second capture device.
> 
> Also, the vimc patch https://patchwork.kernel.org/patch/10948833/ won't
> be required with this patchset.
> 
> This patchset was tested on rkisp1 and vimc drivers.

I'm just curious, with this series applied can I stream simultaneously 
on multiple video devises using vimc?

> 
> Other cleanup might be possible (but I won't add in this patchset as I
> don't have the hw to test):
> 	https://git.linuxtv.org/media_tree.git/tree/drivers/media/platform/qcom/camss/camss-video.c#n430
> 	https://git.linuxtv.org/media_tree.git/tree/drivers/media/platform/omap3isp/isp.c#n697
> 	https://git.linuxtv.org/media_tree.git/tree/drivers/media/platform/stm32/stm32-dcmi.c#n680
> 	https://git.linuxtv.org/media_tree.git/tree/drivers/media/platform/xilinx/xilinx-dma.c#n97
> 
> Changes in V2:
> ====================
> The first version was calling the s_stream() callbacks from sensor to
> capture.
> 
> This was generating errors in the Scarlet Chromebook, when the sensor
> was being enabled before the ISP.
> 
> It make sense to enable subdevices from capture to sensor instead (which
> is what most drivers do already).
> 
> This v2 drops the changes from mc-entity.c, and re-implement helpers in
> v4l2-common.c
> 
> Overview of patches:
> ====================
> 
> Path 1/3 adds the helpers in v4l2-common.c, allowing nested calls by
> adding stream_count in the subdevice struct.
> 
> Patch 2/3 cleanup rkisp1 driver to use the helpers.
> 
> Patch 3/3 cleanup vimc driver to use the helpers.
> 
> Helen Koike (3):
>   media: v4l2-common: add helper functions to call s_stream() callbacks
>   media: staging: rkisp1: use v4l2_pipeline_stream_{enable,disable}
>     helpers
>   media: vimc: use v4l2_pipeline_stream_{enable,disable} helpers
> 
>  drivers/media/platform/vimc/vimc-capture.c    |  28 +++--
>  drivers/media/platform/vimc/vimc-streamer.c   |  49 +-------
>  drivers/media/v4l2-core/v4l2-common.c         | 117 ++++++++++++++++++
>  drivers/staging/media/rkisp1/rkisp1-capture.c |  76 +-----------
>  include/media/v4l2-common.h                   |  28 +++++
>  include/media/v4l2-subdev.h                   |   2 +
>  6 files changed, 173 insertions(+), 127 deletions(-)
> 
> -- 
> 2.26.0
> 

-- 
Regards,
Niklas Söderlund
