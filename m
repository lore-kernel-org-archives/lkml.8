Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C36C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E7020781
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="FlowTssU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHKVSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgHKVSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:18:44 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB226C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:18:44 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z17so12289013ill.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zCJzt+BJueo1G2rs0QZq7zeuowqnIxHPn78LDh13kg=;
        b=FlowTssUayfdaL85TriP2RcBUzG/T6vntLnxRx7DdtmcmiqIiV3bH2ED/pB1FCvjq+
         LokfjisnXtGBAQLL+YECpUsyNdAMytoTTAZ5ztFLMVlLx+lGEPmly8iE28Klsvc7m9Nu
         rW8uiNQz+QsV8/gNXH/owhOE1Gr3XvGLYs7sEeg4HsgRYX5YK59C4yWf/cz63g8iGHkX
         v6N8lFRoSD5yLRGWWVCsMSLMRuQBKlHgkOanGuqLjHak4zsryiT50596J4YrA9pfpLnW
         YixCIlT2k0xTm6BLZAwgZ2QaJYMqPvXMnsKIKrGVZYUiWFHwxbYRazU6BEIFJoP87MuW
         JfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zCJzt+BJueo1G2rs0QZq7zeuowqnIxHPn78LDh13kg=;
        b=An4BsrJOHYzMC1xHPmN19MNr6wk1JE+BwixFTsv6vVqu8LLf2YUllJLLk70Z89uk3c
         7afDjlERMxIwViuaAsL/CCZqf7fDG7amgO7UT4vr676u9CdEJf4lkpas+B4PzG4dIp1G
         YNogYnohP33naiciQOJE4lyJMkmbTk+tIiaWwnO1fCYgp4pgsfEdVO08DGdC9xayCOkA
         S979CqSJebCgXlH+Ik5R2UOrUw05vuHgTcsi7w8wuiJtc3EfY1/qQrKN+3xW2btYRAVW
         0hMCjgCLdcQYUgsHQlEsBcXIidtZyI0xhIcSLGARs/oDCia8K0PCLZVVTtx1lwDoBxhi
         v2Pw==
X-Gm-Message-State: AOAM533k5bjgqViUYFAEunYehxK0bQL67h9PPHCug5+WeOht8xjKi4ci
        Tnn1Mv+DNne/3mAgEsmIh63SEoooQ3NBWimGKCoScA==
X-Google-Smtp-Source: ABdhPJydXaSlgITmBtELkzUO4DBmCANUrr1wRTcqhyIrK8VcFT550AeHkpAKa6iE1xor3dBnDr5/Yj0olPjyteNUyc8=
X-Received: by 2002:a92:1d1:: with SMTP id 200mr25295650ilb.71.1597180724140;
 Tue, 11 Aug 2020 14:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200811210938.552939-1-robdclark@gmail.com>
In-Reply-To: <20200811210938.552939-1-robdclark@gmail.com>
From:   Sean Paul <sean@poorly.run>
Date:   Tue, 11 Aug 2020 17:18:08 -0400
Message-ID: <CAMavQKJcRRc=K3m14A5NsFMKC-E84FL3-r7MKcpoPQ_rq7d6gw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: fix unitialized variable error
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        kernel test robot <lkp@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Drew Davenport <ddavenport@chromium.org>,
        Bernard <bernard@vivo.com>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hongbo Yao <yaohongbo@huawei.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 5:08 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:817 dpu_crtc_enable() error: uninitialized symbol 'request_bandwidth'.
>
> Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index f272a8d0f95b..c2729f71e2fa 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -827,7 +827,7 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
>  {
>         struct dpu_crtc *dpu_crtc;
>         struct drm_encoder *encoder;
> -       bool request_bandwidth;
> +       bool request_bandwidth = false;
>
>         if (!crtc) {
>                 DPU_ERROR("invalid crtc\n");
> --
> 2.26.2
>
