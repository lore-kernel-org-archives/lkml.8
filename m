Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E615EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B90222084D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mG6WvpR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405306AbgFXQ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405297AbgFXQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:57:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA45C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:57:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jz3so1399592pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CmjIW8R8o5r2lBV1s31ea71JUTHcO/wI+cUm5Z7J13I=;
        b=mG6WvpR98paCQbz/iHfb07cJGGOD2+q40Ra14ZRfvRUEETTcl4Ka/lUveyjjpHB6G5
         Ju/6TESVKwG44SgDilOCn+26m3E8OlV7lRBczDoZ7u4nDMlJiEYjHFph6ib2Fy3dvn6Z
         FuV7JfBukoUvAnHscRTBFaTwnfBjk96ZjZ2z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CmjIW8R8o5r2lBV1s31ea71JUTHcO/wI+cUm5Z7J13I=;
        b=umBAXe5yW+ooQLyTks3MWiRdLXzSrjPmqOgc6DtVXObZMFXRRhAtlbKaH6gpH0a5eX
         gW94glnZf3ctaaa6tv3yvbgEG6RsIi7S1IsebNmu5iJXREAI6Oqxs5zem0+R63JU2zbm
         PLe1Mnl7MPVPJ8IpCs8ooH/DClb5X0cR0x/6KFYeMGJw/cs25MSAohZKrfru7aLGjtM+
         pd4qTKVJ/aoof2XVbOYIciTCVDan9K1ruqZq06HxyD9ngJ49e19mVd0dU82FXL7W+Jm7
         KV8BxwB7KHMRU1IcA3JUqx/SAkXF40kucpMSsYkzHAbIbLgYWu3RE4C7LHtD4exNlvBz
         3eAw==
X-Gm-Message-State: AOAM530veJOENlcG1rK845IV62vL98o9wgIOSXfYuVxClMEMbmIxH6J7
        lO+zHyiHiXrO40DPDO/seMAdKA==
X-Google-Smtp-Source: ABdhPJwcLj6W7e3dXuyoYT2CvePVH4Ccxc3lYrIKl6UXZvF7YtKEJWq8hq+uSRU1E/2jR+KVFLoDQA==
X-Received: by 2002:a17:902:704a:: with SMTP id h10mr28656684plt.85.1593017875159;
        Wed, 24 Jun 2020 09:57:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id mp15sm5731457pjb.45.2020.06.24.09.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 09:57:54 -0700 (PDT)
Date:   Wed, 24 Jun 2020 09:57:52 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Sharat Masetty <smasetty@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, saravanak@google.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan <jonathan@marek.ca>
Subject: Re: [PATCH v3 2/6] drm: msm: a6xx: send opp instead of a frequency
Message-ID: <20200624165752.GA39073@google.com>
References: <1591417551-38051-1-git-send-email-smasetty@codeaurora.org>
 <1591417551-38051-3-git-send-email-smasetty@codeaurora.org>
 <CAF6AEGva1DyFc1P_5+U=P+Sh-ngN9PyN6Hh2ZXBnxB952UQ54w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF6AEGva1DyFc1P_5+U=P+Sh-ngN9PyN6Hh2ZXBnxB952UQ54w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 18, 2020 at 10:52:09AM -0700, Rob Clark wrote:
> On Fri, Jun 5, 2020 at 9:26 PM Sharat Masetty <smasetty@codeaurora.org> wrote:
> >
> > This patch changes the plumbing to send the devfreq recommended opp rather
> > than the frequency. Also consolidate and rearrange the code in a6xx to set
> > the GPU frequency and the icc vote in preparation for the upcoming
> > changes for GPU->DDR scaling votes.
> >
> > Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 62 +++++++++++++++++++----------------
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 +-
> >  drivers/gpu/drm/msm/msm_gpu.c         |  3 +-
> >  drivers/gpu/drm/msm/msm_gpu.h         |  3 +-
> >  4 files changed, 38 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > index 748cd37..2d8124b 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > @@ -100,17 +100,30 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
> >                 A6XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_CLK_OFF));
> >  }
> >
> > -static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> > +void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
> >  {
> > -       struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> > -       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > -       struct msm_gpu *gpu = &adreno_gpu->base;
> > -       int ret;
> > +       struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> > +       struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> > +       struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> > +       u32 perf_index;
> > +       unsigned long gpu_freq;
> > +       int ret = 0;
> > +
> > +       gpu_freq = dev_pm_opp_get_freq(opp);
> > +
> > +       if (gpu_freq == gmu->freq)
> > +               return;
> > +
> > +       for (perf_index = 0; perf_index < gmu->nr_gpu_freqs - 1; perf_index++)
> > +               if (gpu_freq == gmu->gpu_freqs[perf_index])
> > +                       break;
> > +
> > +       gmu->current_perf_index = perf_index;
> >
> >         gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
> >
> >         gmu_write(gmu, REG_A6XX_GMU_DCVS_PERF_SETTING,
> > -               ((3 & 0xf) << 28) | index);
> > +                       ((3 & 0xf) << 28) | perf_index);
> >
> >         /*
> >          * Send an invalid index as a vote for the bus bandwidth and let the
> > @@ -126,7 +139,7 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> >         if (ret)
> >                 dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
> >
> > -       gmu->freq = gmu->gpu_freqs[index];
> > +       gmu->freq = gmu->gpu_freqs[perf_index];
> >
> >         /*
> >          * Eventually we will want to scale the path vote with the frequency but
> > @@ -135,25 +148,6 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> >         icc_set_bw(gpu->icc_path, 0, MBps_to_icc(7216));
> >  }
> >
> > -void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
> > -{
> > -       struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> > -       struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> > -       struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> > -       u32 perf_index = 0;
> > -
> > -       if (freq == gmu->freq)
> > -               return;
> > -
> > -       for (perf_index = 0; perf_index < gmu->nr_gpu_freqs - 1; perf_index++)
> > -               if (freq == gmu->gpu_freqs[perf_index])
> > -                       break;
> > -
> > -       gmu->current_perf_index = perf_index;
> > -
> > -       __a6xx_gmu_set_freq(gmu, perf_index);
> > -}
> 
> this does end up conflicting a bit with some of the newer stuff that
> landed this cycle, in particular "drm/msm/a6xx: HFI v2 for A640 and
> A650"
> 
> Adding Jonathan on CC since I think he will want to test this on
> a650/a640 as well..

Sharat, please send an updated version that is rebased on the latest drm-msm.

Thanks

Matthias
