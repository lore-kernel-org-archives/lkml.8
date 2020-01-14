Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB47C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FC524676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LnbKflAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgANRaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:30:13 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41386 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgANRaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:30:13 -0500
Received: by mail-ua1-f66.google.com with SMTP id f7so5116929uaa.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 09:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=08Szw5rYnIOLShLCG3gwbLPH4sjtaB7lisEPfvsjIZY=;
        b=LnbKflAscr1aUly+5WmN1eTnDSd4zt+Zd8UQCGHbkHm+nM2N5IIqWO4+/Een5M7jPM
         DyV2DCDIffyeoT6z3Txamx03jePku6m6flVc/UGCYaN2ZMpIPOGS6xQjmA1Wg+ep/KjC
         mJtufklgX42r0nEj5CCyYom8QmILBecLtonzgHa5DjXNTtWtk4McRaKE9QtElWd1LIc2
         mWb67uny0umZAbK4iGqhCLy+rFcZfCMpNENzoxKTWFNXQo5sy9lEhW48XfdY3NdS6GTF
         1Ia7vyt5yOIUkZgxal/imNBERl7A8o1njV2/Y51Bs3caiyftIfojJGdBgkTAuSdHFH/h
         LrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=08Szw5rYnIOLShLCG3gwbLPH4sjtaB7lisEPfvsjIZY=;
        b=RchLNy4Fup2VSLIpkhbdBU9+7YazyYu7VnqPGHQ2bY5n09nwfvxJslKR9797yG8NtQ
         x67slSwYT+Rus0uSGSyyiZjTuJvTciDUfhKI3AdfqmHBXaNgDZHHovZM0lD3VUqSf9gG
         sJMOzOnjlDbhp3Uyf7X0/XHpWatoTLPxZIVTKuvD97OuqDGEp+nZ0NOkXnW3n/nPx6Xh
         s4RXlJxcstn4/BiGjXj84jBjk/wYDVQS7QmoTAfeeK8Ixr6wMzjCdLuCBVYL7++EoSRJ
         qcNADOi05gxN9XcdJsb/a1EL/lbPAZwlWKImHIxO9QPppfY+nvr1wyBkSG1+ZhprKrRO
         MBDg==
X-Gm-Message-State: APjAAAXjjTSyj7LrE/vywAIp3IfM8T22EjCaN0lElr1sFus+yM+tWgaz
        cnX9DeGNtfvAZFBs6Chc3rjmDP9XQl9R352cu4A3cA==
X-Google-Smtp-Source: APXvYqzgZX1el1nJ4YE3skMK6r5CjnHOZNOcFgoe3GQU2ULdnQrysHQjwdF5QM0DTkgZ8ylTIIdO9xuKbZduccGuIIE=
X-Received: by 2002:ab0:2a0c:: with SMTP id o12mr11322534uar.72.1579023011862;
 Tue, 14 Jan 2020 09:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20200113153605.52350-1-brian@brkho.com> <20200113153605.52350-3-brian@brkho.com>
 <20200113175148.GC26711@jcrouse1-lnx.qualcomm.com> <CAJs_Fx6AVwA73eN+Rs=GAvBPD1Leq=WKG9w_2hohpzmecK_C_A@mail.gmail.com>
 <20200114172319.GA2371@jcrouse1-lnx.qualcomm.com>
In-Reply-To: <20200114172319.GA2371@jcrouse1-lnx.qualcomm.com>
From:   Kristian Kristensen <hoegsberg@google.com>
Date:   Tue, 14 Jan 2020 09:30:00 -0800
Message-ID: <CAOPc6TnEZY9zxz-JPzh-7awWOtLrP_tiv+Sa0b3gh5HFp09QaA@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH 2/2] drm/msm: Add MSM_WAIT_IOVA ioctl
To:     Rob Clark <robdclark@chromium.org>, Brian Ho <brian@brkho.com>,
        freedreno <freedreno@lists.freedesktop.org>,
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

On Tue, Jan 14, 2020 at 9:23 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Tue, Jan 14, 2020 at 08:52:43AM -0800, Rob Clark wrote:
> > On Mon, Jan 13, 2020 at 9:51 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > >
> > > On Mon, Jan 13, 2020 at 10:36:05AM -0500, Brian Ho wrote:
> > > > +
> > > > +     vaddr = base_vaddr + args->offset;
> > > > +
> > > > +     /* Assumes WC mapping */
> > > > +     ret = wait_event_interruptible_timeout(
> > > > +                     gpu->event, *vaddr >= args->value, remaining_jiffies);
> > >
> > > I feel like a barrier might be needed before checking *vaddr just in case you
> > > get the interrupt and wake up the queue before the write posts from the
> > > hardware.
> > >
> >
> > if the gpu is doing posted (or cached) writes, I don't think there is
> > even a CPU side barrier primitive that could wait for that?  I think
> > we rely on the GPU not interrupting the CPU until the write is posted
>
> Once the GPU puts the write on the bus then it is up to the whims of the CPU
> architecture. If the writes are being done out of order you run a chance of
> firing the interrupt and making it all the way to your handler before the writes
> catch up.
>
> Since you are scheduling and doing a bunch of things in between you probably
> don't need to worry but if you start missing events and you don't know why then
> this could be why. A rmb() would give you piece of mind at the cost of being
> Yet Another Barrier (TM).

Doesn't the fence case do the same thing without a barrier?

> Jordan
>
> > BR,
> > -R
> > _______________________________________________
> > Freedreno mailing list
> > Freedreno@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/freedreno
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
