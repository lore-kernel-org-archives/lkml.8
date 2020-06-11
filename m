Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81F6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B0B20792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AcM0ENgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgFKQuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgFKQuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:50:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB00FC08C5C3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 09:50:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j10so6884473wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6515e9EWm5jt/wBgz8o5nKQ9DvkrHHIupbzxxJRVBVw=;
        b=AcM0ENgyTIkG6prNtB2Wvpox2sVZ27dEKDUc422WU4R+XKKKmjv+AK8dJhbyjr5f0E
         Gqk2J2yjUjkwphycoKSuVZLv640rr5CniCwIDWJ9MBayJjfeZDpqDifwk7iSMLH0tjG3
         RT1Lg4t5OrAWguqWn/SzEdsA8mHG5KKaMJ2Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6515e9EWm5jt/wBgz8o5nKQ9DvkrHHIupbzxxJRVBVw=;
        b=jHR+hPHRt7rZE6zC7rdSTBZJzQL8yKORbAgsVnoXvlaFTYGshFz7c6VXNBcfPXgZ3I
         dRfzgYPo+yghgsObpx7dB6p6AQI27/29pkNszi9ok10EppzYKI4TARwxM6dk1PLrAbfd
         93hjvfkrfhmBrQiMk7sk1B5jzd+LtSiPImN3LPN5DNcQtdUQOOe56dVYf0rpHNCsEb+U
         gEUD3mutPkKdk60HDJj2sm3F7L3c8LM5wweX7oSvhTza/vZJt88jIEViB3l+uU0CT7Dz
         nBRZA9nrXxk/VBPnxPDC2xwzwUrUpwuAhPkZv1upqF1GwIod1flsoHi7abJNAmWn5NDT
         hz9A==
X-Gm-Message-State: AOAM531wFnV2xT6dJ2aZvkSxDkWjDN1BOdH/DLzsDSmX3AqNqO3U05Iy
        wX1igVhM38PZ9/7ExXf1OGyPlQ==
X-Google-Smtp-Source: ABdhPJwsVmMDI0pm3cj4yymPaJuKLgVFy93RQHQ3urhSAFwhD7NTFT5tUA1Bg2Gwg0wQixixd9PrjQ==
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr11124576wrx.66.1591894219582;
        Thu, 11 Jun 2020 09:50:19 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id d17sm6217221wrg.75.2020.06.11.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 09:50:19 -0700 (PDT)
Date:   Thu, 11 Jun 2020 16:50:17 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Xia Jiang <xia.jiang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        srv_heupstream@mediatek.com, senozhatsky@chromium.org,
        mojahsu@chromium.org, drinkcat@chromium.org,
        maoguang.meng@mediatek.com, sj.huang@mediatek.com
Subject: Re: [PATCH RESEND v9 13/18] media: platform: Delete redundant code
 and add annotation for an enum
Message-ID: <20200611165017.GB8694@chromium.org>
References: <20200604090553.10861-1-xia.jiang@mediatek.com>
 <20200604090553.10861-15-xia.jiang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604090553.10861-15-xia.jiang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xia,

On Thu, Jun 04, 2020 at 05:05:48PM +0800, Xia Jiang wrote:
> Delete unused member variables annotation.
> Delete unused variable definition.
> Delete redundant log print, because V4L2 debug logs already print it.
> Add annotation for enum mtk_jpeg_ctx_state.
> 
> Signed-off-by: Xia Jiang <xia.jiang@mediatek.com>
> ---
> v9: add annotation for enum mtk_jpeg_ctx_state
> ---
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 15 ++-------------
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h |  8 ++++++--
>  2 files changed, 8 insertions(+), 15 deletions(-)
> 

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
