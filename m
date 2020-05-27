Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A477C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7E6207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzODA/cB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390895AbgE0Rcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388017AbgE0Rce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:32:34 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27A1C08C5C2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:32:33 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g18so2948130qtu.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2BXWCTTNBns33NDU0HybwyfZx0pKtO1nI+1NJmXgJE=;
        b=pzODA/cBQXw/CEtKpRqf9bB5Am/l0I4597dz6MLmQeN2ifmLqZSlDgaAtCARJDivD6
         9Kw418h/RetRSvPvlL+x1EYvHZCt7sD4zm0d+hDZx69Tfhz0qgQ11EsKjvSEYaOBzTgp
         b5DZHfScEflBLAaKm+uce0alcIP4cqrff/9d1LxSimEuSPCTi+XHIizQkk/F06h9VE6S
         6DN9TecBtt8FayDYBd3oNgyeUAZTz0aJYB/hXdCXK0Z5zIkG2cdLLzw7lx9I2VrvchJf
         EIe/6mDvet+14KdS1N0+L3YEdhjUBQSpsBmrCwEzjmfgZ8SIWs7uAYXrJ1EmpEsx4G5t
         8uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2BXWCTTNBns33NDU0HybwyfZx0pKtO1nI+1NJmXgJE=;
        b=tkayOCTbcNaONOiLUCkMPtxXAVOoS8zMJzmnjQzvzP2eJn0J00ZabTXvs5ZxZKIwvc
         W2cqgU3d0aRa7eXAuGvMy5muWa7uHd9ZoX9VCXmdIWPlK7/kL0JOJqIb6x//ETZITuQW
         oxArgSLmVHr7ZYWpu50v6ZDEu3JJGM9u5sseAITSG28TFLPYudcCKQ316Bp4b3MtMqM3
         tPcNOo5l11ziEwUwibm0d+G5N7oJ4y/7U1ruKamre75SGPgQcn9EJ88DbXQgD+2mm86o
         dU3RbCCTQVH2drItMRoevamwWGzPWYvohJL/ubCSihi/r3it2lTABR5o9Uz8VGreAb3r
         EZwA==
X-Gm-Message-State: AOAM531TmrP/ndoWdHBnY6FdfsQhJ+P3mmr6Ugbx8/rdiZAY+g+eHAAM
        teTHhCu1Lun8uj5Eix6ux4R05X0hVlqOFh6F5Z1KDA==
X-Google-Smtp-Source: ABdhPJwXpn5szmnzOAoismmK3gW+NO2iRmAMAWoX2x9kLxI2DQOfwiJkkj58xfMAJP5sIq8ExwuoK929yeVdXcjTQns=
X-Received: by 2002:aed:312a:: with SMTP id 39mr5473720qtg.6.1590600752651;
 Wed, 27 May 2020 10:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <1589453659-27581-1-git-send-email-smasetty@codeaurora.org>
 <1589453659-27581-6-git-send-email-smasetty@codeaurora.org>
 <20200518142333.GA10796@jcrouse1-lnx.qualcomm.com> <CAF6AEGtoNwUGX-r7QytGn5hSU-VD4RJZyhcb3WdgAgAFR5BK4A@mail.gmail.com>
 <c8a514c9-5e48-b561-4b45-47cde3bdfb34@codeaurora.org> <CAF6AEGvOtgpHMuiw01QgRYGEBB2rp5QOdVMpkTMsi0c-QSSv1Q@mail.gmail.com>
In-Reply-To: <CAF6AEGvOtgpHMuiw01QgRYGEBB2rp5QOdVMpkTMsi0c-QSSv1Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 27 May 2020 10:31:55 -0700
Message-ID: <CAGETcx_fuS8cmTwCbZ024gqWOmeAc_ytZZ2P6yReBi7Y9O+qMQ@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH 5/6] drm: msm: a6xx: use dev_pm_opp_set_bw to
 set DDR bandwidth
To:     Rob Clark <robdclark@gmail.com>
Cc:     Sharat Masetty <smasetty@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 8:38 AM Rob Clark <robdclark@gmail.com> wrote:
>
> On Wed, May 27, 2020 at 1:47 AM Sharat Masetty <smasetty@codeaurora.org> wrote:
> >
> > + more folks
> >
> > On 5/18/2020 9:55 PM, Rob Clark wrote:
> > > On Mon, May 18, 2020 at 7:23 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > >> On Thu, May 14, 2020 at 04:24:18PM +0530, Sharat Masetty wrote:
> > >>> This patches replaces the previously used static DDR vote and uses
> > >>> dev_pm_opp_set_bw() to scale GPU->DDR bandwidth along with scaling
> > >>> GPU frequency.
> > >>>
> > >>> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> > >>> ---
> > >>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 +-----
> > >>>   1 file changed, 1 insertion(+), 5 deletions(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > >>> index 2d8124b..79433d3 100644
> > >>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > >>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > >>> @@ -141,11 +141,7 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
> > >>>
> > >>>        gmu->freq = gmu->gpu_freqs[perf_index];
> > >>>
> > >>> -     /*
> > >>> -      * Eventually we will want to scale the path vote with the frequency but
> > >>> -      * for now leave it at max so that the performance is nominal.
> > >>> -      */
> > >>> -     icc_set_bw(gpu->icc_path, 0, MBps_to_icc(7216));
> > >>> +     dev_pm_opp_set_bw(&gpu->pdev->dev, opp);
> > >>>   }
> > >> This adds an implicit requirement that all targets need bandwidth settings
> > >> defined in the OPP or they won't get a bus vote at all. I would prefer that
> > >> there be an default escape valve but if not you'll need to add
> > >> bandwidth values for the sdm845 OPP that target doesn't regress.
> > >>
> > > it looks like we could maybe do something like:
> > >
> > >    ret = dev_pm_opp_set_bw(...);
> > >    if (ret) {
> > >        dev_warn_once(dev, "no bandwidth settings");
> > >        icc_set_bw(...);
> > >    }
> > >
> > > ?
> > >
> > > BR,
> > > -R
> >
> > There is a bit of an issue here - Looks like its not possible to two icc
> > handles to the same path.  Its causing double enumeration of the paths
> > in the icc core and messing up path votes. With [1] Since opp/core
> > already gets a handle to the icc path as part of table add,  drm/msm
> > could do either

Are you sure this is the real issue? I'd be surprised if this is a
real limitation. And if it is, it either needs to be fixed in the ICC
framework or OPP shouldn't be getting path handles by default (and
maybe let the driver set the handles before using OPP APIs to change
BW). I'd lean towards the former.

> > a) Conditionally enumerate gpu->icc_path handle only when pm/opp core
> > has not got the icc path handle. I could use something like [2] to
> > determine if should initialize gpu->icc_path*

This seems like a bandaid. Let's fix it correctly in ICC framework or
OPP framework.

> > b) Add peak-opp-configs in 845 dt and mandate all future versions to use
> > this bindings. With this, I can remove gpu->icc_path from msm/drm
> > completely and only rely on opp/core for bw voting.

I don't know what you mean by "peak-opp-configs" but I guess you are
referring to some kind of DT flag to say if you should vote for BW
directly or use the OPP framework? If so, I'm pretty sure that won't
fly. That's an OS implementation specific flag.

-Saravana
