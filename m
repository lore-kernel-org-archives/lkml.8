Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE53BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE142072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IGMUFSuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgEUQCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgEUQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:02:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49315C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:02:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t8so2529126wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FFgD33+aNouNGQWGPAQ82q8pOVxArb54Ymtj9k6c/CI=;
        b=IGMUFSuZHglbq89dE4lbiHY6u0LsaqFDfzsLsjDKYGX4etHufoYeD8MS2j3VMbQ2PM
         QYQ2wFMBSsxWjwvI7O4lhXaSNIwjtur44RocetRNs9sxRMWwWs7HxhKmb6El1eqr43uc
         qj5WC8JdzADa1cvKlTb2t6+rKtlh1XdmkFwVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FFgD33+aNouNGQWGPAQ82q8pOVxArb54Ymtj9k6c/CI=;
        b=JfdqL7x7AjkIsHkOi/v0O8kTJK/Bk6RrkOw7ehN7hBApE/M4SPTdS303zAYgK77scS
         AKjOVuGof9hda+bIDCss9obPJVE9HBGlrmmNncS2lGOIOEXfOmv1R+qq9A36Gm3CGc/K
         NScOmSsIHcd81gS0Pfa9amNfgNbEFfZPSyrbYFLkLQs22RksHfmfaBrysOL80kSViYld
         +NV619nUAZgwSEDWX+OK9rrQ/1brZo1nUEhD1PBwrlvcfy3z0zrmBGLh+zl9663j7jqZ
         CeB9XyVd4rtw+xdJaZGa6Ia/iQxfQMSRF5a1DUtSzZfqlJrO51DIXJJeg49NJG6TMO7v
         fudQ==
X-Gm-Message-State: AOAM5305lT/kmsXNCk4xJ8QfXBhBdA2y3NjIUoDsaFnmWzHwsSbMphaa
        RqAlpfLfuAeCNth+f/K9JTMqpg==
X-Google-Smtp-Source: ABdhPJyvZZpk19V7dcx34aHKaL1bXMZY4n4ffWiVEXRuCg9hQzx9AwjLNVAy7P/eRQEZ4BCf3LkRUw==
X-Received: by 2002:a7b:c207:: with SMTP id x7mr9976002wmi.79.1590076948087;
        Thu, 21 May 2020 09:02:28 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id x10sm7147943wrn.54.2020.05.21.09.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 09:02:27 -0700 (PDT)
Date:   Thu, 21 May 2020 16:02:26 +0000
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
Subject: Re: [PATCH v8 13/14] media: platform: Rename jpeg dec file name
Message-ID: <20200521160226.GK209565@chromium.org>
References: <20200403094033.8288-1-xia.jiang@mediatek.com>
 <20200403094033.8288-14-xia.jiang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403094033.8288-14-xia.jiang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xia,

On Fri, Apr 03, 2020 at 05:40:32PM +0800, Xia Jiang wrote:
> Rename the files which are for decode feature. This is preparing
> path since the jpeg enc patch will be added later.
> 
> Signed-off-by: Xia Jiang <xia.jiang@mediatek.com>
> ---
> v8: no changes
> 
> v7: no changes
> 
> v6: no changes
> 
> v5: no changes
> 
> v4: no changes
> 
> v3: no changes
> 
> v2: no changes
> ---
>  drivers/media/platform/mtk-jpeg/Makefile                      | 2 +-
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c               | 4 ++--
>  .../platform/mtk-jpeg/{mtk_jpeg_hw.c => mtk_jpeg_dec_hw.c}    | 2 +-
>  .../platform/mtk-jpeg/{mtk_jpeg_hw.h => mtk_jpeg_dec_hw.h}    | 2 +-
>  .../mtk-jpeg/{mtk_jpeg_parse.c => mtk_jpeg_dec_parse.c}       | 2 +-
>  .../mtk-jpeg/{mtk_jpeg_parse.h => mtk_jpeg_dec_parse.h}       | 2 +-
>  .../platform/mtk-jpeg/{mtk_jpeg_reg.h => mtk_jpeg_dec_reg.h}  | 0
>  7 files changed, 7 insertions(+), 7 deletions(-)
>  rename drivers/media/platform/mtk-jpeg/{mtk_jpeg_hw.c => mtk_jpeg_dec_hw.c} (99%)
>  rename drivers/media/platform/mtk-jpeg/{mtk_jpeg_hw.h => mtk_jpeg_dec_hw.h} (98%)
>  rename drivers/media/platform/mtk-jpeg/{mtk_jpeg_parse.c => mtk_jpeg_dec_parse.c} (98%)
>  rename drivers/media/platform/mtk-jpeg/{mtk_jpeg_parse.h => mtk_jpeg_dec_parse.h} (92%)
>  rename drivers/media/platform/mtk-jpeg/{mtk_jpeg_reg.h => mtk_jpeg_dec_reg.h} (100%)
> 

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
