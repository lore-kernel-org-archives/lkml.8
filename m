Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3757CC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 11:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11510206D9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 11:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YtE/Av3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgGKLtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 07:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgGKLtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 07:49:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBF6C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 04:49:07 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f5so9306894ljj.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 04:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtfKot8ZssXyPkPO+I+4ExwhCSPuFUl0sOsDrmkzlC8=;
        b=YtE/Av3bVbWUb1Iwokjhs3fiSvRQhLlfVYgp/g+LQvy4d1OYBXcE63gXGMOzz574Ot
         PUMdmLBd6z6GvBfYr91kbor5HYfdQsENqFiK7APq0QwO8lSHcsrcnfA7BDE/2UqLY2CT
         3BfyOUSumHxubjzqcC9uuxxttUexSVN67Cc+VTcuelCjZKcRdUgdv3oaQxFx3joG/XyI
         9avcLEjRIpQ9AKIMaqp1cG8s0mnFkZvG3XBtJ29FsoJzpV3R8y1861DGlRrZRwiXcGtb
         cYEvRsBhVJHaZG2+v4Wh5Ur9pbx5Nzal8KCiODnZYinrki/jYJIp1HLWRC0LXlvysmI4
         tATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtfKot8ZssXyPkPO+I+4ExwhCSPuFUl0sOsDrmkzlC8=;
        b=KnYfAbLenBv7ed0/tx2rb56IPgWq9RiRqXxVhaj7kb2+N4xobAQWASJ2eVMHCFXMZ1
         cFXev09HOUQUsazZxin2fCaUC6WnxdpkMy4fLxkMecynCFz+nPD0xDjfAYvhZdTmPee6
         RRKLaSp7caxEApM9wCBz2c3VKS50I2Ce3TPOrJPbG+J7FgFiRBX0AQRLVxnPG/z+t2A3
         W+pmt25mNB63QT/XpoW2Rth/Q7NoCREJ2CVknvmJepd+TmGxnKD+kMVTgRl5iMgSpQ66
         tEPo7DggaUYAsSXL+S+JeFPEoBXXtgbMyQ3429z1UwSl6Xb4iv0H/DxhteH07yRLUYwW
         NzCQ==
X-Gm-Message-State: AOAM531yA6F1e3fd6kX2xOmG/RfIbBCU4DCeKCr/KtQ7XzMF+uLS6e6/
        F27yv0MeHtlGgEK+Gr6aAQlmxkDxuMtBulad/GJLdsnl
X-Google-Smtp-Source: ABdhPJxxFmrJz7/vRwpDkqiIuwv2rWq4N6yDKkszqYRfmcjiTZlBxgzh+2T4uIrxNxpy8O4zOPyOVBKyMRyXLYBeKnw=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr26485425ljc.104.1594468145646;
 Sat, 11 Jul 2020 04:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200707203529.2098979-1-robdclark@gmail.com> <20200707203529.2098979-2-robdclark@gmail.com>
In-Reply-To: <20200707203529.2098979-2-robdclark@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 11 Jul 2020 13:48:54 +0200
Message-ID: <CACRpkdb0+V7AmvG0JXXETzayr4Q785OLhBWjU414tUJo1toJOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm: sync generated headers
To:     Rob Clark <robdclark@gmail.com>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Harigovindan P <harigovi@codeaurora.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        zhengbin <zhengbin13@huawei.com>,
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

On Tue, Jul 7, 2020 at 10:36 PM Rob Clark <robdclark@gmail.com> wrote:

> From: Rob Clark <robdclark@chromium.org>
>
> We haven't sync'd for a while.. pull in updates to get definitions for
> some fields in pkt7 payloads.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Out of curiosity : where are the syncs coming from? Mesa?

Yours,
Linus Walleij
