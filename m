Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93331C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D802051A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCSpKCl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgCGN0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 08:26:14 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45728 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgCGN0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 08:26:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id a4so3822760qto.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 05:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gUkOL+11Z97b0R8dLesbdAOICKoUveakPMdqkDVaXPw=;
        b=FCSpKCl3xTu6d6RPwPExKuQvWmsrK2EB78TKjILnxJPa+UpIxtxOVvNnWKXRFB88Ll
         vPm8VOBT5vO0pp6woGvHyKnC42aGjvI7twA3zh9/7LX1pQfx2iPjb6hijH7LQ2xj1ETx
         9ioZmBv7xabiBvQkDhlQr37ot8O7LK39233beulWcyabEN/qNmsircIkKL3a2AS56fSe
         PklbBRo/eI++ReUT5GJq2nBteuOblJOyusZm2BBB3TuM9bvhcT2s6RcCmpmORblNamzf
         fQLnIPbbsMMp7NfzIVWFJu0IdcmW9oqxhc/E+agaH26mIQlRlZEBktMwSo1jw9WJrt7X
         PFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gUkOL+11Z97b0R8dLesbdAOICKoUveakPMdqkDVaXPw=;
        b=p+MN0+GqKZM0hKHOugrcrhkrP++z1x21LcI0rIsIrdGAVnihvpBlhb45jmB4Z9MEbm
         5p+5h9zUnqvV5tL37HJ3S+eC1vRsKpDhQVuBVYVO/ReBpbWRLFgXc9bO0yb8YLeCACwH
         8CU+KfwCHBOZFykA1XRAvYJihboGMkPVH+Q/gYv5FrVxLedFIugyuTuXfI5jX9gMW1QA
         9AiG053tGY32vfDXbJERbxoFeS7jpC5q9N8RfuXwURHMrXo+BDHbtnWtX+XE9pzdsrfk
         2w5KvZLccWxmrXOse87bvsvzoAJv23mxRS5JPS59A6jbm/Dw9wEFaj9XZ3c4KJ0FdT4V
         IKgA==
X-Gm-Message-State: ANhLgQ3fBOTN7i8hy6y+ZNeU26s4jkZFh/0vQm66MNsMJMdcLyJvko4E
        0z0VRTmBWuw1OBxV6uCLkRBWzMJLnPoikJNoDBo=
X-Google-Smtp-Source: ADFU+vsPBOnuFWqKRzkIUHW++Zi8SPyndB8lUM1yQ+d/1kC4rwrelmYqzbuQq2uzF6MTG+aoV2pIBUn52W9JxDJ0UI4=
X-Received: by 2002:ac8:694c:: with SMTP id n12mr7341692qtr.15.1583587572604;
 Sat, 07 Mar 2020 05:26:12 -0800 (PST)
MIME-Version: 1.0
References: <1582710377-15489-1-git-send-email-kevin3.tang@gmail.com>
 <1582710377-15489-5-git-send-email-kevin3.tang@gmail.com> <CACvgo53dME1ioYebimSzdOMvjAudtmzpz_-5Q7rNqQnZoBpaqA@mail.gmail.com>
 <CAFPSGXYgY7=vgX6ZPWRgfxfZfBeVRj7=gUOwrcTyYpkYE1C1cA@mail.gmail.com> <CACvgo51ShmP+HvLHzxbpzFg2gNs-cD0iey=nM29prDhZsN7fhQ@mail.gmail.com>
In-Reply-To: <CACvgo51ShmP+HvLHzxbpzFg2gNs-cD0iey=nM29prDhZsN7fhQ@mail.gmail.com>
From:   tang pengchuan <kevin3.tang@gmail.com>
Date:   Sat, 7 Mar 2020 21:26:01 +0800
Message-ID: <CAFPSGXY=erOF8ouU-JkQbncghity6AP_3W=5YSuAHV=wsesQLA@mail.gmail.com>
Subject: Re: [PATCH RFC v4 4/6] drm/sprd: add Unisoc's drm display controller driver
To:     Emil Velikov <emil.l.velikov@gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emil Velikov <emil.l.velikov@gmail.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=887=
=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:14=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Thu, 5 Mar 2020 at 13:15, tang pengchuan <kevin3.tang@gmail.com> wrote=
:
> > On Tue, Mar 3, 2020 at 2:29 AM Emil Velikov <emil.l.velikov@gmail.com> =
wrote:
>
> >> Have you seen a case where the 0 or default case are reached? AFAICT t=
hey will
> >> never trigger. So one might as well use:
> >>
> >>     switch (angle) {
> >>     case DRM_MODE_FOO:
> >>         return DPU_LAYER_ROTATION_FOO;
> >>     ...
> >>     case DRM_MODE_BAR:
> >>         return DPU_LAYER_ROTATION_BAR;
> >>     }
> >>
> > Yeah, the 0 maybe unused code, i will remove it.
> > But i think default is need, because userspace could give an incorrect =
value .
> > So we need to setup a default value and doing error check.
>
> As mentioned in the documentation [0] input (userspace) validation
> should happen in atomic_check. This function here is called during
> atomic_flush which is _not_ allowed to fail.
In drm atomic commit codepath:
drm_atomic_commit-->drm_atomic_plane_check--->drm_plane_check_pixel_format
already helped us check DRM_FORMAT_XXX, so default laber is dead code.
Is just a waste of time and increases the complexity of the code for no rea=
son.

We can't use "return" replace "break"
Because "switch(format)" and "switch(blending)"exist at the same
funtion, and I don't think it's a good idea to split them.
I think there are two solutions=EF=BC=9A
1. Remove default label completely
2. Add "default: // Do nothing", Eg:
int flag =3D value > 1000 ? 1 : 0;
swich(flag) {
    case 0:
        // do something
        break;
    case 1:
        // do something
        break;
    default: // do nothing
         break;
}

>
>
>
> >> The default case here should be unreachable. Either it is or the upper=
 layer (or
> >> earlier code) should ensure that.
> >
> > There will be some differences in the formats supported by different ch=
ips, but userspace will only have one set of code.
> > So it is necessary to check whether the parameters passed by the user l=
ayer are wrong. I think it is necessary
>
> As said above - this type of issues should be checked _before_
> reaching atomic_flush - aka in atomic_check.
Your are right, switch(format) and switch(blending) will never reach
default label, so it's dead code.
As for rotation, we will ensure it is correct at the user layer.
>
>
> >> > +static struct drm_plane *sprd_plane_init(struct drm_device *drm,
> >> > +                                       struct sprd_dpu *dpu)
> >> > +{
> >> > +       struct drm_plane *primary =3D NULL;
> >> > +       struct sprd_plane *p =3D NULL;
> >> > +       struct dpu_capability cap =3D {};
> >> > +       int err, i;
> >> > +
> >> > +       if (dpu->core && dpu->core->capability)
> >> As mentioned before - this always evaluates to true, so drop the check=
.
> >> Same applies for the other dpu->core->foo checks.
> >>
> >> Still not a huge fan of the abstraction layer, but I guess you're hesi=
tant on
> >> removing it.
> >
> > Sometimes,  some "dpu->core->foo" maybe always need, compatibility will=
 be better.
> > eg:
> >
> >     if (dpu->glb && dpu->glb->power)
> >         dpu->glb->power(ctx, true);
> >     if (dpu->glb && dpu->glb->enable)
> >         dpu->glb->enable(ctx);
> >
> >     if (ctx->is_stopped && dpu->glb && dpu->glb->reset)
> >         dpu->glb->reset(ctx);
> >
> >     if (dpu->clk && dpu->clk->init)
> >         dpu->clk->init(ctx);
> >     if (dpu->clk && dpu->clk->enable)
> >         dpu->clk->enable(ctx);
> >
> >     if (dpu->core && dpu->core->init)
> >         dpu->core->init(ctx);
> >     if (dpu->core && dpu->core->ifconfig)
> >         dpu->core->ifconfig(ctx);
> >
>
> If there are no hooks, then the whole thing is dead code. As such it
> should not be included.
>
>
> > >
> > > Note: Custom properties should be separate patches. This includes doc=
umentation
> > > why they are needed and references to open-source userspace.
> > This only need for our chips, what documentation do we need to provide?
> >
>
> KMS properties should be generic. Reason being is that divergence
> causes substantial overhead, and fragility, to each and every
> userspace consumer. The documentation has some general notes on the
> topic [1]. Don't forget the "Testing and validation" section ;-)
>
> Although I've tried to catch everything, I might have missed a comment
> or two due the HTML formatting. Please toggle to plain text [2] for
> the future.
I got it
>
> Thanks
> -Emil
>
> [0] https://www.kernel.org/doc/html/v5.5/gpu/drm-kms.html
> [1] Documentation/gpu/drm-uapi.rst in particular "Open-Source
> Userspace Requirements"
> [2] https://smallbusiness.chron.com/reply-inline-gmail-40679.html
