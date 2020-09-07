Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D916EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E15320757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfsQVh5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgIGQbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729834AbgIGOYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:24:20 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA54C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 07:24:19 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u4so15458178ljd.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c3o7vSrPtfVLY+L0kjQIwvaz2ovSHjf+IEqBu3OCb/o=;
        b=ZfsQVh5sOFI6WXpScSWpbNwdBgiRHlDc06CeoPETYDVo+zJ2ZfpvWawcA10tLMKKD9
         KXZ1Uvms4FAp8JxcirPU3z6GhpGTlnOK1EZ6D0+CZNjDsZm8WZFPHPlX9+1edSK5LOVb
         s4cXB5Rw1O8xiYBKLdol3oQMaZOCHO4uolymrxNK1Xv5zLDX55nfQDY7dZxoIfRxoTqr
         AvbaMT0+vfuRN3JXo1OAcDTmPRmS34ql8nFZKAiKqucLL5+UJ9MdfJMTZRAmqLDMkDEW
         WWS6JlMemfEFb6yXqAF9NK8gplj4KJ58tMQcA1mFVxOSQnSg9dvyflu+8f1BhLcNmLyx
         Gw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c3o7vSrPtfVLY+L0kjQIwvaz2ovSHjf+IEqBu3OCb/o=;
        b=U+J5Lte7kReAR/TVVFMBSUwS8Y822l5d5KjWyDht0ly/J28EON37fcJKE7WrORqzOU
         nTOd3+OJeGZ0n//oTubbwpZ9Lw3YWagt4bJmxWU4p03mZD4n+mFHhFUY+tzAhOptX0uC
         DhJqgPxJw/SxeK/E58rSVXqJVONJlZ6g2Nh3nHI7Zaix58PDFitps+hj3MOBA7KKc2v/
         XAwRHL9C6i7sDWgycZdCSVBbH2h0c4/1wECDv5mK8ntcMtCHdRILeLTOQZMGZmRt0s5U
         WrUByJln99moWEhhRuJ/Rl7G1TvGpqF9Nqy1KutgAWWT7tu8tmf8g8w/YRQzmkvAgrDp
         BXWA==
X-Gm-Message-State: AOAM533KpDuhjoXHKOx1jidz1HbWKzytfikosZExj4Y0d8XgEoIhhW+x
        aY4mICo9FnAwS7+/el5GOvZnRw==
X-Google-Smtp-Source: ABdhPJziSj5qaeVTYIzqn7mGp3GSDS6K4Y8Yf+iGVKSihjNsDajXJdMvFBL//9rql7id5+Q2WjAVlQ==
X-Received: by 2002:a2e:97c1:: with SMTP id m1mr10319433ljj.289.1599488657317;
        Mon, 07 Sep 2020 07:24:17 -0700 (PDT)
Received: from [192.168.1.211] ([188.162.64.144])
        by smtp.gmail.com with ESMTPSA id t14sm7558507lfp.77.2020.09.07.07.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 07:24:16 -0700 (PDT)
Subject: Re: [PATCH 0/3] drm/msm/dsi: support SM8150 and SM8250
To:     Jonathan Marek <jonathan@marek.ca>, freedreno@lists.freedesktop.org
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>,
        zhengbin <zhengbin13@huawei.com>
References: <20200904172859.25633-1-jonathan@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <87a45d1e-328b-99f5-4990-d4746a24c864@linaro.org>
Date:   Mon, 7 Sep 2020 17:24:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200904172859.25633-1-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2020 20:28, Jonathan Marek wrote:
> Add support for SM8150 and SM8250 DSI.
> 
> Note I haven't tested SM8150 recently, but DSI is almost identical to SM8250.

On SM8250:
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Jonathan Marek (3):
>    drm/msm/dsi: remove unused clk_pre/clk_post in msm_dsi_dphy_timing
>    drm/msm/dsi: add DSI config for sm8150 and sm8250
>    drm/msm/dsi: add support for 7nm DSI PHY/PLL
> 
>   .../devicetree/bindings/display/msm/dsi.txt   |   6 +-
>   drivers/gpu/drm/msm/Kconfig                   |   7 +
>   drivers/gpu/drm/msm/Makefile                  |   2 +
>   drivers/gpu/drm/msm/dsi/dsi.h                 |   2 +
>   drivers/gpu/drm/msm/dsi/dsi.xml.h             | 423 ++++++++
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c             |   5 +-
>   drivers/gpu/drm/msm/dsi/dsi_cfg.h             |   2 +
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c         | 102 ++
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.h         |   6 +-
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c     | 255 +++++
>   drivers/gpu/drm/msm/dsi/pll/dsi_pll.c         |   4 +
>   drivers/gpu/drm/msm/dsi/pll/dsi_pll.h         |  10 +
>   drivers/gpu/drm/msm/dsi/pll/dsi_pll_7nm.c     | 902 ++++++++++++++++++
>   13 files changed, 1721 insertions(+), 5 deletions(-)
>   create mode 100644 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
>   create mode 100644 drivers/gpu/drm/msm/dsi/pll/dsi_pll_7nm.c
> 


-- 
With best wishes
Dmitry
