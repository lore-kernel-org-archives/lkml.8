Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17A3C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CDC214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PE93tZWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgANQw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:52:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35257 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgANQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:52:55 -0500
Received: by mail-io1-f66.google.com with SMTP id h8so14613719iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 08:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tvuqfPAmqeW5h6hFaCyRKpXD9b4Gjd3nwj+gcAvShZ0=;
        b=PE93tZWV+hg39DY1pUEJSq12EHHeocyMtfjbCr6ey/aNdjanGCOl24Wd3BFEcmEQet
         x8iyqIov7uNNXR1EI8XKsIR6DC8z8BpZIf2f4x55M6W21g94/Hmp1Hogt7ZOK3GXDqHv
         09vied9075nNzXfQBJu47599bfeJMHVmsOLbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tvuqfPAmqeW5h6hFaCyRKpXD9b4Gjd3nwj+gcAvShZ0=;
        b=VWOeZnRmH/GSMMxoAxfme9DdTRdbn4UN1q2jxvMd2HEoPTOEHHNx+Un7G0CCHlULQP
         KaLRD7wmGT23lbFyXgwoZAn62iuU6VOYkAwIOo8+iV/t0xgLalzLpKbv3vyVSs4vO/2d
         K7sC+YnRgmnJKU9x2T5Vk+Pu3WeIZUkpEv73qyp25+GOWF3d3ipp1TB/PP8MDTPl2bUJ
         FDEsufdZf3uXZTlCNcTHkq4AW65ZSl1LK+rJqVsS1UNzn+sn5GpPJRqW2WrX7WVqlEvR
         WCV299GYuaJDnlTs5mCnrWb1Fbu7c0wqEsSrjPt+n7pXASzyz1kRvKLt43bWZsfq1D+r
         Re1g==
X-Gm-Message-State: APjAAAVKS1VATMf6C2U39N+uzh4rMjogXvySMqobhfoetQDiWJiKWlZP
        13wSRkD8tn83eKEcUEbcWt3Y9fQGmbMmXsFfhd8yEg==
X-Google-Smtp-Source: APXvYqxxSfCxs2zloh33teGyEGvf4zfmbUq0cbRO0d/xAKS5BgM2oPkXId2AZGiWDUDB+p8gcRw82UZWfTwiar2I8kc=
X-Received: by 2002:a6b:6f06:: with SMTP id k6mr18407733ioc.204.1579020774522;
 Tue, 14 Jan 2020 08:52:54 -0800 (PST)
MIME-Version: 1.0
References: <20200113153605.52350-1-brian@brkho.com> <20200113153605.52350-3-brian@brkho.com>
 <20200113175148.GC26711@jcrouse1-lnx.qualcomm.com>
In-Reply-To: <20200113175148.GC26711@jcrouse1-lnx.qualcomm.com>
From:   Rob Clark <robdclark@chromium.org>
Date:   Tue, 14 Jan 2020 08:52:43 -0800
Message-ID: <CAJs_Fx6AVwA73eN+Rs=GAvBPD1Leq=WKG9w_2hohpzmecK_C_A@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH 2/2] drm/msm: Add MSM_WAIT_IOVA ioctl
To:     Brian Ho <brian@brkho.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kristian Kristensen <hoegsberg@chromium.org>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 9:51 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Mon, Jan 13, 2020 at 10:36:05AM -0500, Brian Ho wrote:
> > +
> > +     vaddr = base_vaddr + args->offset;
> > +
> > +     /* Assumes WC mapping */
> > +     ret = wait_event_interruptible_timeout(
> > +                     gpu->event, *vaddr >= args->value, remaining_jiffies);
>
> I feel like a barrier might be needed before checking *vaddr just in case you
> get the interrupt and wake up the queue before the write posts from the
> hardware.
>

if the gpu is doing posted (or cached) writes, I don't think there is
even a CPU side barrier primitive that could wait for that?  I think
we rely on the GPU not interrupting the CPU until the write is posted

BR,
-R
