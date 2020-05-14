Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9846C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BB420758
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mYnOUX8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgENXiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 19:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgENXiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 19:38:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4111FC05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:38:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so99249pfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QK2T0t/Jj0JFQe8jONLMLZrHIHWtDY8wi6hh+6HVsZc=;
        b=mYnOUX8GzYHSabSOa5Twez7NHxPD2GmAYqgM4bH8a0VNgWLtlOkVTW5tuAvMEvimR7
         Etu0z5LT+oPBLhSpHfTCojRjVsrV0q4wrwVu37uzHLuWl78dm4a7u8QwE6iJ/SwN/uBR
         hs/g4khJraR7/bYg5/+yRId7SUocqo1MZCIUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QK2T0t/Jj0JFQe8jONLMLZrHIHWtDY8wi6hh+6HVsZc=;
        b=T1UyU/rZranAlvCnS0WYhNevKiQLOLUcNz3M5XMUQOg4+XyAu6usuke7fbt2opEHNB
         QzH1Sk0w7DXvZMWoKr130ftzgc4NGbT/RTz9wNOZKsoZQi84oRoWNBsJVNWYmXRJywKZ
         /Kg5Hic/Sm+sgp+OXrlxX5mhYrBZbzW4mrq+nTE7XeojUn5a7x5f6PxdeXtxTqMSwJ/W
         P+dX/E76Zvip/DaNr0gCLGyk5EWll/gOFICmFox9PQt3w9rIneR8PnHu0L5RDIlD8tjP
         v62mZE5WWwpWPgQsBp+Shtd33+b/EOibuoEIdZLYQudZCoUU5tveRt/xseQEX/x7kOwG
         GaCw==
X-Gm-Message-State: AOAM532/mim6Lmtz5CpiUUERm4xUjSysoXITXQ1IHh6ZqQDLk2nEEFDc
        7mADWMvfnEDvjG5JRBXlXszlXA==
X-Google-Smtp-Source: ABdhPJzr+P5MYAMvALz8QCCQYXEbupCUs1nuQKmzDf3JHLzo0/rZUuIfcPI9IrPK0NfSNUeQxUHy5g==
X-Received: by 2002:a63:4c5b:: with SMTP id m27mr502104pgl.198.1589499481632;
        Thu, 14 May 2020 16:38:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 14sm276163pfy.38.2020.05.14.16.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 16:38:00 -0700 (PDT)
Date:   Thu, 14 May 2020 16:37:59 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        georgi.djakov@linaro.org
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sc7180: Add interconnect bindings
 for GPU
Message-ID: <20200514233759.GR4525@google.com>
References: <1589453659-27581-1-git-send-email-smasetty@codeaurora.org>
 <1589453659-27581-2-git-send-email-smasetty@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1589453659-27581-2-git-send-email-smasetty@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sharat,

On Thu, May 14, 2020 at 04:24:14PM +0530, Sharat Masetty wrote:

> Subject: arm64: dts: qcom: sc7180: Add interconnect bindings for GPU
>
> This patch adds the interconnect bindings to the GPU node. This enables
> the GPU->DDR path bandwidth voting.

This patch doesn't add any bindings, it adds the interconnects/interconnect
configuration for the GPU

The order of the patches in this series is a bit odd. Typically you would
start with the binding changes ("dt-bindings: drm/msm/gpu: Document gpu
opp table" in this case), then the code needed to support these changes,
and finally the DT bits for the specific devices/platforms making use
of the new 'feature'.

It doesn't really matter once the series has landed since the end result
is exactly the same, however it's the logical order in which most
reviewers read your patches, and typically also the order in which the
patches land (especially when multiple trees are involved).
