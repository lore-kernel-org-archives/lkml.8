Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C57DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB492074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YoLH9s/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgFHWhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgFHWhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:37:01 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C97AC08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 15:37:01 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a3so4923149oid.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 15:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2/QowlQF5mc64F4D/RIrE7YecSYcNfpv5/vBazsU68=;
        b=YoLH9s/K/Q9F2icLGQ4XsZ8yu34FpvCJWwojbzdGbDurrkiHcXCFSCy3FoJkWSiy3v
         ttxN1tKlG+tKqtaDuusQXGxcoYxAqVReyLgBQl1PcyR1ZwZp0pBpPOPsPo71/MhepPX1
         TAlNJPez35trLSgzDHzZEhmRB9+n4fqnr8UMqQoTNeTg6jg6EdOASp/qq4C7sepzG9Cd
         dZJWCGvrEIyu5+XKoLiiqXIf6j+5wBS8cSdu1lwUmBNGajuww2Lml136v36elMFLLBlr
         Ka/gIOFoy6ErsrRJZh6TEMEyVDIeFEF0Mg+ikohuWdsdh0ciUnmL46WhAoOe+rkmwelJ
         +EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2/QowlQF5mc64F4D/RIrE7YecSYcNfpv5/vBazsU68=;
        b=JaCJTlsiDwt0NN04+hfh1tn+eYW/HdmJYmVPCKle7lYWtprm7CwdptfsBbcvnSM/M1
         5uqO9Iemnw0cJ9fRvpwbNnRKOVsACeLhGfBlkOAzsI1ZE+vNTxiusvFBVhtlmFFx1Vxu
         Q39e6ONRiJihFXVyMj395KwHzffik9zNY9bn1rUElLAthSxD8BPqDUlVO6ODg5zNYNLQ
         YSBXb+OUC5eKLTyk3SatNVQzv+w5J58P+1NikSFe7MayJBRWHX37QSgvem9olOMCRhHs
         0spV3aEx+SA79DhVRuRqe4cjaPHmGyPe6djxgjOUTp5YCflWLDF2umI8eG7MGuX+2DqQ
         /oaw==
X-Gm-Message-State: AOAM531P4l0o8Jm531g9EhrlSp1UQY8hdr0G+ikO0EFsdJoS4WJHuF3V
        Pu7LEtfHmCHwCqd2RbgrLzPZAIs13vsGHVlq9f+6i4EX/e0=
X-Google-Smtp-Source: ABdhPJxIVKuOn/EYkNbXNpa9saF5jSFauCOTybMaENNZXSr0SEt5psJ1bIFC5jcp72iD0nqj2OOCaxBHUwukVfcj1E4=
X-Received: by 2002:aca:2108:: with SMTP id 8mr1330741oiz.10.1591655819262;
 Mon, 08 Jun 2020 15:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <1585044079-358-1-git-send-email-kalyan_t@codeaurora.org> <CALAqxLViRrga-XW2o1J1JutFdS1d-qmmgOrEP2beNygw3A7H4A@mail.gmail.com>
In-Reply-To: <CALAqxLViRrga-XW2o1J1JutFdS1d-qmmgOrEP2beNygw3A7H4A@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 8 Jun 2020 15:36:47 -0700
Message-ID: <CALAqxLWbhioSH4pFyM348VrGWxRXHQV1s9bdz6HArYguLtAFcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm/dpu: add support for color processing blocks
 in dpu driver
To:     Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, mkrishn@codeaurora.org,
        travitej@codeaurora.org, Doug Anderson <dianders@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>, hoegsberg@chromium.org,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 3:25 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Mar 25, 2020 at 1:17 AM Kalyan Thota <kalyan_t@codeaurora.org> wrote:
> >
> > This change adds support to configure dspp blocks in
> > the dpu driver.
> >
> > Macro description of the changes coming in this patch.
> > 1) Add dspp definitions in the hw catalog.
> > 2) Add capability to reserve dspp blocks in the display data path.
> > 3) Attach the reserved block to the encoder.
> >
> > Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>
>
> Hey all,
>   With this patch now merged upstream, I'm seeing a regression on
> db845c that I bisected down to it.
>
> When I boot up I see:
> [   40.976737] [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu
> error]failed to get dspp on lm 0
> [   40.985600] [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu
> error]failed to get dspp on lm 0
> [   40.994587] [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu
> error]failed to get dspp on lm 0
> [   41.003492] [drm:_dpu_rm_check_lm_and_get_connected_blks] [dpu
> error]failed to get dspp on lm 0
> [   41.012283] [drm:_dpu_rm_make_reservation] [dpu error]unable to
> find appropriate mixers
> [   41.020369] [drm:dpu_rm_reserve] [dpu error]failed to reserve hw
> resources: -119
>
> Over and over, and the display doesn't start up.
>
> I suspect we're supposed to catch the following check before the failure:
>
> +       if (!reqs->topology.num_dspp)
> +               return true;
>
> I suspect the issue is in dpu_encoder_get_topology() we don't fully
> initialize the topology structure on the stack before returning it.
>
> Does that sound plausible or is there likely some other cause?

This guess is wrong. The topology.num_dspp is 2, but lm_cfg->dspp is
coming back as zero.

I'll continue digging to see if I can understand better whats going wrong.

thanks
-john
