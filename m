Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA19C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652B72067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ctMItyku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgFDUeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgFDUeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:34:21 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB7DC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 13:34:20 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id c1so4310444vsc.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QccmPOAwdRsqU+gseuKb7TceQ37JHCZ0c4E7yU4KiQA=;
        b=ctMItykuizT2FjCtlj3c7yeA8hejo1Eu0YvNGbgfHWNvUAZmSu1iqvjTuxpl6Rm/XM
         /bOQT4clHDMwkaa7CQpWJ+/aULE1pYzv7SNXe1g+1d4Jvdus2Zf/u2kDn//UPtypAuEw
         ce+XSToUwc8hZkd4Z5GjQqIAIMzFGI0iD70BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QccmPOAwdRsqU+gseuKb7TceQ37JHCZ0c4E7yU4KiQA=;
        b=ZlTt8w/uc/F4hgfV2N7HroOdWxba0VgbGS6iKaZ2bZu+YaoBcihRxrjaaZ6OBY0YdR
         Vb8LNbm+aSC62SzCnhaVHpVcPzUiUlvT/jHpGnsLt/aAkua2QfyvZDKPQyCU1xYFXTVs
         ah0G5HQnl9fW/kcBfxfIFY/295BHHU2NrUfcLAtloWR7mnuekVt2WIjlmGAnzo4wgC+e
         ibbhQtkxN1Og/7Qvq717YwhM1TPF9yxofNaIKiakxYyS1YuE/+6mUVpVnGl/lNNuuSUv
         9u9RWe7ca8+6pooUFCPpznHGew2A/RMuNkHfJwH+A+MD1kMccdh1+rnpxdc4GaNoqdM7
         yHeQ==
X-Gm-Message-State: AOAM5324FyF3Ut7PWZ8NbSSyQagIiqnICGPOtp/AUH5cUjhIoDhi7cqx
        4lEmSt5btb3OLNaJtFbDjvXAB1E/ncw=
X-Google-Smtp-Source: ABdhPJzBZ0W+Vb3bd6RvKhc94OMKFh7YiFpuJmzz3ughImkG2VD97GXYBdO6VUUmvq7ryEotQu58oQ==
X-Received: by 2002:a67:d381:: with SMTP id b1mr4724561vsj.148.1591302859591;
        Thu, 04 Jun 2020 13:34:19 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id l14sm850014vkl.47.2020.06.04.13.34.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 13:34:18 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id r11so4337248vsj.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:34:17 -0700 (PDT)
X-Received: by 2002:a67:8881:: with SMTP id k123mr5087675vsd.198.1591302857244;
 Thu, 04 Jun 2020 13:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <1591276775-13949-1-git-send-email-kalyan_t@codeaurora.org>
In-Reply-To: <1591276775-13949-1-git-send-email-kalyan_t@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 Jun 2020 13:34:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V7ce7EGqJh6aga4yH3NqdgXMHBe=EOONtcd2LFDX75_A@mail.gmail.com>
Message-ID: <CAD=FV=V7ce7EGqJh6aga4yH3NqdgXMHBe=EOONtcd2LFDX75_A@mail.gmail.com>
Subject: Re: [PATCH v6] drm/msm/dpu: ensure device suspend happens during PM sleep
To:     Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        mkrishn@codeaurora.org, travitej@codeaurora.org,
        nganji@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 4, 2020 at 6:20 AM Kalyan Thota <kalyan_t@codeaurora.org> wrote:
>
> -#ifdef CONFIG_PM
> -static int msm_runtime_suspend(struct device *dev)
> +#ifdef CONFIG_PM_SLEEP
> +static int msm_pm_suspend(struct device *dev)
>  {
> -       struct drm_device *ddev = dev_get_drvdata(dev);
> -       struct msm_drm_private *priv = ddev->dev_private;
> -       struct msm_mdss *mdss = priv->mdss;
>

nit: remove blank line at the start of this function

>  static const struct dev_pm_ops msm_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(msm_pm_suspend, msm_pm_resume)
>         SET_RUNTIME_PM_OPS(msm_runtime_suspend, msm_runtime_resume, NULL)
> +       .prepare = msm_pm_prepare,
> +       .complete = msm_pm_complete,

Presumably you will get a compile failure if someone compiles without
CONFIG_PM_SLEEP since msm_pm_prepare() and msm_pm_complete() won't be
defined but you refer to them unconditionally.  Probably the best
solution is to just add "__maybe_unused" to your prepare/complete
function and then always define them.


I can't say I've thought through every corner case but at least this
change no longer raises alarm bells in my mind when I look at it.  ;-)
 If it works for you and nobody else has objections then it seems good
enough and we can always make more improvements later.  Feel free to
add my Reviewed-by tag when my nit is fixed and you make sure it
compiles even if CONFIG_PM_SLEEP isn't defined.

-Doug
