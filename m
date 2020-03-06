Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BADC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F74C2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxCDkIfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgCFROz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:14:55 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33006 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgCFROz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:14:55 -0500
Received: by mail-vk1-f193.google.com with SMTP id i78so808320vke.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 09:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzpbKokk11BRaCUTE3S0a/MWb4B/MGyZwwWpbEvm8gE=;
        b=oxCDkIfplYvmZlhq6A8KbraYVjcHaKeefRxBL8EIvkKEnpVIYk9BqMe2YAGtaBuacA
         gTxymGa8mmHE4f5Kchdkx5OHQTrN4vkO+8HY7eUjUfycchnS7ZveJa+qE25qaqXvLBUR
         UnV34k/3O9CK7UlH6y1PtGmgqt3iMAxNDqnQz13Ll6ZyjWcf45YAH3rXBMQw17+ytK6L
         q2ZXbgrsMyyfdt91luG8Ewklm02sfdTYkN6sM+NctRvmmCWTTva/8aOGyKylA9iZqxcf
         CAJhyPvic+eQoJKOGrct7AQ3oDtI8TBA/6FW5G2LvYd8lDiK3jEPbEIar6Rlo8khbZoE
         uZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzpbKokk11BRaCUTE3S0a/MWb4B/MGyZwwWpbEvm8gE=;
        b=QnGCemIT+gCD0KwKYzmScaLIGK5Mdo8MdXQr82kuy21Ji5zzZRNvesV6m/FdNQeGvb
         9oSnB8fYYNG7n8eoWVd/bBXyVGfjJ7R9MzI1ibfSBaBZtPaXO0zJPWvGOx85HGpZQebG
         z3uHmzjDguxwxE7fi7LmrEWA++fY+xDhYhDUh9ll2tYskmSiD2W2dT7G7cQTF4cUlDIl
         RzvYqKAbjWRTwb7eLqIoipC802bw4Jqh7a8jfOCx2s16L2v6/TLLC+DdVuv7DNnPYdeW
         h9DuPsufYvN07FXaVydP6+zTrkvyEYlTUPXdmLFEOjoFdTvBYvxOTW6B1+hgZjKAMVdT
         ln/g==
X-Gm-Message-State: ANhLgQ1923RqTTPFk4BQ7+G7VZgFL5xJ8J2jfmHNQ2ksgL+CfetXDddR
        0Tz5DgQSRb3vrTgpFwtB8PFNMkcelJCb23/SaCI=
X-Google-Smtp-Source: ADFU+vtZ5Ro2yv+kU6KSstLAFH2EszWFrIshdXo0f6ZIZ545pmAPHBGaIceGDW3Bo/2It2oOU2BcawGthNkkEJgzTvA=
X-Received: by 2002:a1f:264b:: with SMTP id m72mr2236379vkm.51.1583514893670;
 Fri, 06 Mar 2020 09:14:53 -0800 (PST)
MIME-Version: 1.0
References: <1582710377-15489-1-git-send-email-kevin3.tang@gmail.com>
 <1582710377-15489-5-git-send-email-kevin3.tang@gmail.com> <CACvgo53dME1ioYebimSzdOMvjAudtmzpz_-5Q7rNqQnZoBpaqA@mail.gmail.com>
 <CAFPSGXYgY7=vgX6ZPWRgfxfZfBeVRj7=gUOwrcTyYpkYE1C1cA@mail.gmail.com>
In-Reply-To: <CAFPSGXYgY7=vgX6ZPWRgfxfZfBeVRj7=gUOwrcTyYpkYE1C1cA@mail.gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Fri, 6 Mar 2020 17:14:14 +0000
Message-ID: <CACvgo51ShmP+HvLHzxbpzFg2gNs-cD0iey=nM29prDhZsN7fhQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 4/6] drm/sprd: add Unisoc's drm display controller driver
To:     tang pengchuan <kevin3.tang@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 at 13:15, tang pengchuan <kevin3.tang@gmail.com> wrote:
> On Tue, Mar 3, 2020 at 2:29 AM Emil Velikov <emil.l.velikov@gmail.com> wrote:

>> Have you seen a case where the 0 or default case are reached? AFAICT they will
>> never trigger. So one might as well use:
>>
>>     switch (angle) {
>>     case DRM_MODE_FOO:
>>         return DPU_LAYER_ROTATION_FOO;
>>     ...
>>     case DRM_MODE_BAR:
>>         return DPU_LAYER_ROTATION_BAR;
>>     }
>>
> Yeah, the 0 maybe unused code, i will remove it.
> But i think default is need, because userspace could give an incorrect value .
> So we need to setup a default value and doing error check.

As mentioned in the documentation [0] input (userspace) validation
should happen in atomic_check. This function here is called during
atomic_flush which is _not_ allowed to fail.



>> The default case here should be unreachable. Either it is or the upper layer (or
>> earlier code) should ensure that.
>
> There will be some differences in the formats supported by different chips, but userspace will only have one set of code.
> So it is necessary to check whether the parameters passed by the user layer are wrong. I think it is necessary

As said above - this type of issues should be checked _before_
reaching atomic_flush - aka in atomic_check.


>> > +static struct drm_plane *sprd_plane_init(struct drm_device *drm,
>> > +                                       struct sprd_dpu *dpu)
>> > +{
>> > +       struct drm_plane *primary = NULL;
>> > +       struct sprd_plane *p = NULL;
>> > +       struct dpu_capability cap = {};
>> > +       int err, i;
>> > +
>> > +       if (dpu->core && dpu->core->capability)
>> As mentioned before - this always evaluates to true, so drop the check.
>> Same applies for the other dpu->core->foo checks.
>>
>> Still not a huge fan of the abstraction layer, but I guess you're hesitant on
>> removing it.
>
> Sometimes,  some "dpu->core->foo" maybe always need, compatibility will be better.
> eg:
>
>     if (dpu->glb && dpu->glb->power)
>         dpu->glb->power(ctx, true);
>     if (dpu->glb && dpu->glb->enable)
>         dpu->glb->enable(ctx);
>
>     if (ctx->is_stopped && dpu->glb && dpu->glb->reset)
>         dpu->glb->reset(ctx);
>
>     if (dpu->clk && dpu->clk->init)
>         dpu->clk->init(ctx);
>     if (dpu->clk && dpu->clk->enable)
>         dpu->clk->enable(ctx);
>
>     if (dpu->core && dpu->core->init)
>         dpu->core->init(ctx);
>     if (dpu->core && dpu->core->ifconfig)
>         dpu->core->ifconfig(ctx);
>

If there are no hooks, then the whole thing is dead code. As such it
should not be included.


> >
> > Note: Custom properties should be separate patches. This includes documentation
> > why they are needed and references to open-source userspace.
> This only need for our chips, what documentation do we need to provide?
>

KMS properties should be generic. Reason being is that divergence
causes substantial overhead, and fragility, to each and every
userspace consumer. The documentation has some general notes on the
topic [1]. Don't forget the "Testing and validation" section ;-)

Although I've tried to catch everything, I might have missed a comment
or two due the HTML formatting. Please toggle to plain text [2] for
the future.

Thanks
-Emil

[0] https://www.kernel.org/doc/html/v5.5/gpu/drm-kms.html
[1] Documentation/gpu/drm-uapi.rst in particular "Open-Source
Userspace Requirements"
[2] https://smallbusiness.chron.com/reply-inline-gmail-40679.html
