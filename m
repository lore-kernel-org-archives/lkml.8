Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8284C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 01:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83CB21883
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 01:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DKREwuM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGNBMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 21:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgGNBMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 21:12:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCF1C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 18:12:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w2so6829413pgg.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 18:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5yjaTy96iRFPTsi26P18yq64D5S2151Zztu56aP2UQk=;
        b=DKREwuM1AdDK/M5PRjMceNQQ5PSr4Xfy3P/tz5j9KLqG7xpQvwFBtF6iqOKNiHJeHz
         0LtGhspN0cAeU/1/I6hlmRFzPP+PakMNDDWkk+6neyLAw6VjOq3PKxLlGjVYFwnl71jY
         CvuZix9jHtiIZKtZpVPiMHxs6yo596oGk6UAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5yjaTy96iRFPTsi26P18yq64D5S2151Zztu56aP2UQk=;
        b=WVqgnKVmMbNsHE6pPZrVnGYwvFCW/WfmTO93bMTnbcgtLHTkcB/67PQBaykoHHAjk9
         yUrFKf28JlPY2WcEQIshkrO5VQ6WDTNjlk59k+UB4HaNZyv1XkYzFg1OKZPh1R9RML2c
         YIL1EVR9NAs03uumCbfhaczx6D8toF4JI77LmfEoca3qBC2T9egA+ccMZKwPJ6NrVprq
         r5bZeWJCMwolRGWnmjxeN7Q2/WfSf9SefqG2OyRFLVIOhBKKvXdkjE+vqh94J/A4Cc4V
         vP4XWIx47s/NoAa3ZAPil5DE7bdLBRbuIiiKA4j7mpFSd7+j0lWGj5K4Y9LH9DIVA16S
         SkOA==
X-Gm-Message-State: AOAM530iqwRdYMoJ3bUbgVqzxHC0Dq599oFYwbXBzXHwJ7IO5u3loGtt
        6VHhIn3bT22QBn32x+FXTbFdQA==
X-Google-Smtp-Source: ABdhPJzURU5w7Tj+O39sbKidAAXjNVHx+XXYlAgKEyC4g8eI7DWw01L8nI4SKvyRTPsf2//G04xEaQ==
X-Received: by 2002:a05:6a00:14ce:: with SMTP id w14mr2275557pfu.121.1594689141507;
        Mon, 13 Jul 2020 18:12:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id e8sm15972489pfl.125.2020.07.13.18.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 18:12:20 -0700 (PDT)
Date:   Mon, 13 Jul 2020 18:12:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        dianders@chromium.org, mkrishn@codeaurora.org,
        travitej@codeaurora.org, nganji@codeaurora.org
Subject: Re: [v1] drm/msm/dpu: add support for clk and bw scaling for display
Message-ID: <20200714011219.GQ3191083@google.com>
References: <1592489321-29213-1-git-send-email-kalyan_t@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1592489321-29213-1-git-send-email-kalyan_t@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 07:38:41PM +0530, Kalyan Thota wrote:
> This change adds support to scale src clk and bandwidth as
> per composition requirements.
> 
> Interconnect registration for bw has been moved to mdp
> device node from mdss to facilitate the scaling.
> 
> Changes in v1:
>  - Address armv7 compilation issues with the patch (Rob)
> 
> Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>

It seems this is an evolution of this series: https://patchwork.kernel.org/project/linux-arm-msm/list/?series=265351

Are the DT bits of the series still valid? If so please include them in the
series, otherwise please add DT patches to allow folks to test and review,
and get them landed in Bjorn's tree after the driver changes have landed.
