Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE1CC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7713C20732
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582650657;
	bh=sL3A5dTa8CoK1C3BOJe8PnrhUUsGjKfqIqHkSZSurZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iaG4XrB9rWdzJSFGtk4RHeUakF+U3rFGkgLEBEisWkxVS7JRogEA+cf6q2GsLWwxC
	 mkzZDVDKHRMO6IDOavd6Nz8f8hRgUMlnzbTvgHRmCO+OiodAxPW2G/Qij2+yJVER+9
	 jvUgSzrs1EWlX8bP+Vh6K9xGXstP+gnBn9XuGNjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgBYRK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:10:56 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46993 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbgBYRKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:10:55 -0500
Received: by mail-oi1-f193.google.com with SMTP id a22so13235335oid.13;
        Tue, 25 Feb 2020 09:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WxYxKuDCjw2ta/VcYxfG6H2pyMpZknzieLnpy09W8ak=;
        b=JZqrBW2dcCONZpZqDyHizIPFtqY7uailyKcnNYnUjBtUv9xHwnEe1TZ5XI0809wfOW
         cP022neZfnRW78v+30xIPdX/aMr9uJ+VTi8FPyRkbZAy5kLIY+2xgSNBAocbdyBYKu1O
         eNJUjLCXE8y5duspEf9cGyswbU4TZfduGQIepZcqLiPOSOxS03Va4hLURdECCZ6Mpls8
         h0uSTue36K1UH04fN3PN6JeXyNLzWeW7cHjzxGbvqsIqPPG0Y1bzKTaKM5vmO00KpN3r
         LMF+097RDXnphB58wiluOAt1V++hUGPXBarUctz4iWaqTKtvrzie1u8wP/vGv7NKuSsj
         fOAw==
X-Gm-Message-State: APjAAAVvqiVuX5AC4WOtnnEeDOKa/QNeU5dI+NUWTpeEJe5dXWPGsbOv
        imiPdjlT6XVd4Ru7Ej/ILw==
X-Google-Smtp-Source: APXvYqyNZeSueBjr4b/f5cuT3NJLbY2PjOkM3NiotToiEr0JE4LRnFFXTwEwBP5qHj5CvNRnu0FATA==
X-Received: by 2002:aca:c401:: with SMTP id u1mr9332oif.62.1582650654724;
        Tue, 25 Feb 2020 09:10:54 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m18sm5830700otf.6.2020.02.25.09.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:10:53 -0800 (PST)
Received: (nullmailer pid 6373 invoked by uid 1000);
        Tue, 25 Feb 2020 17:10:52 -0000
Date:   Tue, 25 Feb 2020 11:10:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com, huijuan.xie@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v8 2/7] dt-bindings: display: mediatek: update dpi
 supported chips
Message-ID: <20200225171052.GA6002@bogus>
References: <20200225094057.120144-1-jitao.shi@mediatek.com>
 <20200225094057.120144-3-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225094057.120144-3-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 17:40:52 +0800, Jitao Shi wrote:
> Add descriptions about supported chips, including MT2701 & MT8173 &
> mt8183
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.txt        | 1 +
>  1 file changed, 1 insertion(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
