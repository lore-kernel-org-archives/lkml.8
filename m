Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23449C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0157B2072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hF9rAdqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgFKO2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgFKO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:28:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E962C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:28:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so6410046wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+MwiHwTDigrZz/osHSq5jwVMysur4yPnyLBBwzskG3k=;
        b=hF9rAdqc/Vs5/6fKuks+MMwm5u0HPIk5I3T763FaYv8nJfRnzVmYS6TkZwBkpQEK58
         OabTcSTw/chyT3nEYjpMZQDEOQc+ToSeZ2/XR3JxMVn51VBleocqPt81rwrJnQrtsfTu
         fNHm+OBopt1RhC9Zm1Z4ugCbwiZh785kwWvlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+MwiHwTDigrZz/osHSq5jwVMysur4yPnyLBBwzskG3k=;
        b=jGA94KxQ+6nFuTG/lUdeexaBVgvxP8NfMGBNhN6kjxGyY9WKg2n2SyP8rYThfnLtFt
         jvewg9yiDHU1ZbpZ++uBNFF3PtojFxC52iSGb/iCF5HNw9vYnOzs8fD478Y0S/nbdwQk
         ygv2puqBRZEXnmb6Cny2BCheWDSXvlGiQjwkjgwmBXm1AnaMxEXVBkqd6Cn9EmlEuA6n
         YC6PW2RTJ0Yz3KtosPlFcsetBFh8imqWI7t+QQrOmxswN0cSodR25JCR1Cw1loKl33tN
         DVrTKs7dLv2MG30lCJajrd87rgTR8IZWDe2YjJ0fBS0qHL+hf9FyyUBhksc5dbY8WNXX
         LsaA==
X-Gm-Message-State: AOAM533AL0q+IDoaMiQ149GvrJsAAvR8WdsQ8TcHA1VSOo8kRZA/wEfB
        sVxp92EELlaj5Yo6xibDPlv6vQ==
X-Google-Smtp-Source: ABdhPJzQ9+KT5Krp0KhPaomhJuRwTmw/IshQSBBRqrbY7XioECHFV8tO/RyEuLgOWZRGG4tI3GvR+g==
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr10081847wru.252.1591885698879;
        Thu, 11 Jun 2020 07:28:18 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id w17sm5219529wra.71.2020.06.11.07.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 07:28:18 -0700 (PDT)
Date:   Thu, 11 Jun 2020 14:28:17 +0000
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
Subject: Re: [PATCH RESEND v9 10/18] media: platform: Stylistic changes for
 improving code quality
Message-ID: <20200611142817.GD158633@chromium.org>
References: <20200604090553.10861-1-xia.jiang@mediatek.com>
 <20200604090553.10861-12-xia.jiang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604090553.10861-12-xia.jiang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xia,

On Thu, Jun 04, 2020 at 05:05:45PM +0800, Xia Jiang wrote:
> Change register offset hex numerals from uppercase to lowercase.
> Change data type of max/min width/height from integer to unsigned
> integer.
> 
> Signed-off-by: Xia Jiang <xia.jiang@mediatek.com>
> ---
> v9: move changing data type of max/min width/height to this patch
> ---
>  .../media/platform/mtk-jpeg/mtk_jpeg_core.h    |  8 ++++----
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_reg.h | 18 +++++++++---------
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
