Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96195C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8D920714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiUDYJT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgG1KSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgG1KSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:18:15 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BF0C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:18:14 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h8so10686779lfp.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y5JvHTfL3KAJW7sNZfdf0acUJLJFvSpi5rTiY+++JWk=;
        b=FiUDYJT+DkGKwexMj0wMwhkGRgDEcuVc/KAn2msNbjHHLX1/JES+yjuud3qRe9C2PI
         ExNC87JkNE3M+5OqPO+I1aXaJ8W22p8P9w3/5acFoYZrkV9hO4ajoP0dW/36pXs0A01G
         96RSfc4KUWzSISwDYq/MjjO9K+vgAI+0aPQigtPnrHLBQzIsmGgg7yMS5E9q0RF99BCF
         IOiiokEvncvAYdarjebwAby6cGS8ykq2jgD4A75MQXLF9v73XukOMrCwniaOgLzJXLzJ
         ckH712meXzmUKR4Dl/LnO1JqPurwYOx+PLw4hThG3L+v8THomDZnWa5C5c4n9OgYjv2f
         vmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y5JvHTfL3KAJW7sNZfdf0acUJLJFvSpi5rTiY+++JWk=;
        b=lu1tkcODRjxbK2BUDpeO4qbRfUqQ3u35Jb/keWqqjn6IggJewVi0gHwShL57EQx75k
         k1ay1P/cg0i0RMJDuKvHFrrrxmyNNtUMb6frYKE/u+e2DwHBoRdhvmoxjhDUluLXLNnO
         bSh+PO8nFmedfaHNtX5BgmP0kZ6xHsCtbfGyjfwV/KqeoBd2GGug5fYJ563EYbbCI2L7
         /IpGuai4kGOnxZbPtafrac0OODTWEPD0DqSEsbZlDwfD4/YCJGp1uimpGth/uxjeOl6K
         yf+GkVC865jdpV8taul1D5QIHMM6IVHTytJmvP2QMcRf3e8EFqOBK+RGfCaSEKSDmhEn
         FhXQ==
X-Gm-Message-State: AOAM530blTf6pFNV49KrRKHbcpSnmJHzXeD6IUv1yQUTsVChvUT64cbo
        b3j1HDEVIgsR87Nm/+ak9Ggh9Xi+Qj8oP5xzjaw=
X-Google-Smtp-Source: ABdhPJzArjx6w8VQ21R+BwbyCxSpbtNwUNEm+Wcrn4ZfPf+5dodhqNS4jMNPRiS7XqQEXSQwTmZyaZGvKYkOQ1onUtw=
X-Received: by 2002:a05:6512:3156:: with SMTP id s22mr14053284lfi.140.1595931492732;
 Tue, 28 Jul 2020 03:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <1584105767-11963-1-git-send-email-kevin3.tang@gmail.com>
 <1584105767-11963-5-git-send-email-kevin3.tang@gmail.com> <CACvgo52_KT6O79PujodCPbkegP6LLwuVSFEoRdbarZ=y50B63A@mail.gmail.com>
In-Reply-To: <CACvgo52_KT6O79PujodCPbkegP6LLwuVSFEoRdbarZ=y50B63A@mail.gmail.com>
From:   Kevin Tang <kevin3.tang@gmail.com>
Date:   Tue, 28 Jul 2020 18:18:01 +0800
Message-ID: <CAFPSGXaERhtja=hZdKcuBJf-wtiT4RbM50UcT2wNBBAa2bq-Uw@mail.gmail.com>
Subject: Re: [PATCH RFC v5 4/6] drm/sprd: add Unisoc's drm display controller driver
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

Hi Emil,
Sorry, I left for a long time because of other things. Now i'm back~

V6 fix access registers via readl/writel, check unsupported KMS
properties (format, rotation, blend mode, etc) by plane_check callback
ops
and remove always true checks for dpu core ops

Add changelog within the corresponding patch from now on, thanks for
your advice.

BR,
Kevin


Emil Velikov <emil.l.velikov@gmail.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=882:07=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hey Kevin,
>
> On Sun, 15 Mar 2020 at 23:19, Kevin Tang <kevin3.tang@gmail.com> wrote:
> >
> > Adds DPU(Display Processor Unit) support for the Unisoc's display subsy=
stem.
> > It's support multi planes, scaler, rotation, PQ(Picture Quality) and mo=
re.
> >
> > Cc: Orson Zhai <orsonzhai@gmail.com>
> > Cc: Baolin Wang <baolin.wang@linaro.org>
> > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> > ---
> >  drivers/gpu/drm/sprd/Makefile       |   5 +-
> >  drivers/gpu/drm/sprd/dpu/Makefile   |   7 +
> >  drivers/gpu/drm/sprd/dpu/dpu_r2p0.c | 750 ++++++++++++++++++++++++++++=
++++++++
> >  drivers/gpu/drm/sprd/sprd_dpu.c     | 501 ++++++++++++++++++++++++
> >  drivers/gpu/drm/sprd/sprd_dpu.h     | 170 ++++++++
> >  drivers/gpu/drm/sprd/sprd_drm.c     |   1 +
> >  drivers/gpu/drm/sprd/sprd_drm.h     |   2 +
>
> Seems like v5 (patch at least, I did not look at the rest) does not
> address a handful of the feedback.
>  - Access registers via readl/writel, instead of current approach
>  - With ^^ you can drop the compiler workaround
>  - Checking for unsupported KMS properties (format, rotation, etc)
> should happen in the XXX_check callbacks
>  - Remove always true checks, around the (rather moot) abstraction layer
>
> For the future, please keep the revision/changelog within the
> corresponding patch. This way reviewers can see, from the onset, what
> is addressed.
> Look at `git log -- drivers/gpu/drm` for examples.
>
>
> -Emil
