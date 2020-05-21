Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BC4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C5720721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z/tzAhAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgEUNqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgEUNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:46:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEE8C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:46:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so6683802wrx.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ioC6Q3HVvwh9td7JcekYBXwgG6Rm0JWudJ5rZTXChDU=;
        b=Z/tzAhAz8W/eG2mYxcKFp8KKWJhs36XabdHfyuvXnPY8DOreXETPs/WweazwIgydiJ
         jpbDx3OyuHOM1EtBdf1/4JLco99/fbJ06XTQ32t3r8hNyvFhLtEUM/0lGWROiBSNYLTc
         ExFC7STIDBPFVHvsLzXEMa9T35z6/KZzKV7Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ioC6Q3HVvwh9td7JcekYBXwgG6Rm0JWudJ5rZTXChDU=;
        b=CoAzIzVxdlno2O++sevD3L65CzzlxfqtsM8MgWNSrC/lNsC3gw2oJx/zuBHRh6i1Si
         FYrQka/xYaRwArfEXRmbeL1jcjHkHbT2Qozgkx3S6YhNfDJcE8JaTJEJUKAvD6JbAiY7
         OxTaCXLOuNIbO68dVvlSIjchzCo7nlCBvGHI2iazPpNfDh3x6uyh9ml/mfiqwcJh9MX3
         4M4TY/GCww7Ixz4x0CUHozXfwI7V12XskYpliyBdb03FiEQVumaTg2/podpW1o1LNVxA
         NIuylFakBsvCbX/gKc4XWuh8ZvCCTZYP7K+TymDeQOjDovRuYOgFLTtM7jTSBM1swu7M
         Dm9A==
X-Gm-Message-State: AOAM531U47XTZVEts8dFCppwlhbFNp/pX9h8qoZvNdlwMOcI3J8oqboV
        kCUggBf99StSkGZHL8GI6+w7Aw==
X-Google-Smtp-Source: ABdhPJw4SaKtpUrlRa8kqBZdL7Myt7YbEIE8Xk1YTd7NT9wAik061SrpazfKJ0RlkFO65Y19ocCOGA==
X-Received: by 2002:adf:9507:: with SMTP id 7mr4462650wrs.63.1590068795524;
        Thu, 21 May 2020 06:46:35 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id g69sm1720399wmg.15.2020.05.21.06.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 06:46:35 -0700 (PDT)
Date:   Thu, 21 May 2020 13:46:33 +0000
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
Subject: Re: [PATCH v8 02/14] media: platform: Improve queue set up flow for
 bug fixing
Message-ID: <20200521134633.GB209565@chromium.org>
References: <20200403094033.8288-1-xia.jiang@mediatek.com>
 <20200403094033.8288-3-xia.jiang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403094033.8288-3-xia.jiang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 05:40:21PM +0800, Xia Jiang wrote:
> Add checking created buffer size follow in mtk_jpeg_queue_setup().
> 
> Signed-off-by: Xia Jiang <xia.jiang@mediatek.com>
> ---
> v8: no changes
> ---
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
