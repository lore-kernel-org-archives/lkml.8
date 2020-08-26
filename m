Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC4EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B88720737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwxjW6+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgHZRLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZRLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:11:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A94EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:11:49 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so3210056ljc.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LFBTd716RTKzMlke2Bib1bgfXmFyBkoFUVEct/Y6DRA=;
        b=YwxjW6+o2vGoYl+vXaN2bUB/cyKaLR3dQi1gfh4LPQA8otX3dHgmEYatnbcAArwz8k
         9n+j/mmo6rJUDbzF3JLsqQeCLxb3FCI4SCVnJDpH4TiOGozKtLeWMLbtKNuqM62j6A3X
         iyiFuo75r95o3jDdltei6yugz0va77EZFEgLFPSZGmLCeTDmFXWgwBqMgSJ0VOkkl8/S
         gkH7wVs8DpZmr0ljmmThlG1ebPZQva8ROeHVoJMGrk8TLoCbH/G8kF1Iq24JFI1K7ktw
         YjPW8XPqVxZzFcEMRZE/nd6wmt5vx4l2Yy56NkpkJNO/ugWHSNxMOQrb/67fLz7C4j3x
         gPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LFBTd716RTKzMlke2Bib1bgfXmFyBkoFUVEct/Y6DRA=;
        b=FQLSkHCLvfhzMia86MCKtILiViXdqlpB9fseyD0SiXk7l0Pb3F76T/Mtomlj1EFvb/
         XrwuJne7huR6Pnpk5Kmc3vOJFoVZHDf4r0ECtFPcOmweibhbohZRN5zXcyZ4KUDWSqzC
         +SwHawqYO8GpBGfwEKXRI3mxpd31CiqvI/i7vsqZU8ZRRHyV07/PuYOsEkJfFFOa9onE
         kDUXA0MsAL3NtXsgePJk3kdeyldFsruyTzZypZALEPsz8SKAsEyvssS6GNNmT3cgeETv
         d+yamrv5opy0853O91Iw3OBd6X3Mm+zQn0cqgE9OR6UTGVGhYZLbvDz4gymlfHVFF4IY
         SUaw==
X-Gm-Message-State: AOAM531d+zR2y/ZouKTK8lsw6ZP+RboVnLzAiqj9WBHF3T0a9R3zJQgr
        65cqLKLhoFWDwy9LiyTMxn7krjC1DPydy4xSxoI=
X-Google-Smtp-Source: ABdhPJx57uWoraE16kCejHtyOP5BsDGkUiZUrEzS2O4wiHfYgqfvD65l9TiO5QgUwg1e5mx34TP0nMRZLCi7HuxF0L8=
X-Received: by 2002:a2e:321a:: with SMTP id y26mr7157687ljy.388.1598461905380;
 Wed, 26 Aug 2020 10:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com>
 <1595930879-2478-2-git-send-email-kevin3.tang@gmail.com> <20200728202732.GB1277651@ravnborg.org>
In-Reply-To: <20200728202732.GB1277651@ravnborg.org>
From:   Kevin Tang <kevin3.tang@gmail.com>
Date:   Thu, 27 Aug 2020 01:11:34 +0800
Message-ID: <CAFPSGXahb7KzsM3iZFjW=JjZAYr0h1vwMx2ROrwR=x8MCchn1Q@mail.gmail.com>
Subject: Re: [PATCH RFC v6 1/6] dt-bindings: display: add Unisoc's drm master bindings
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> =E4=BA=8E2020=E5=B9=B47=E6=9C=8829=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=884:27=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Kevin
>
> On Tue, Jul 28, 2020 at 06:07:54PM +0800, Kevin Tang wrote:
> > From: Kevin Tang <kevin.tang@unisoc.com>
> >
> > The Unisoc DRM master device is a virtual device needed to list all
> > DPU devices or other display interface nodes that comprise the
> > graphics subsystem
> >
> > Cc: Orson Zhai <orsonzhai@gmail.com>
> > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> > ---
> >  .../devicetree/bindings/display/sprd/drm.yaml      | 36 ++++++++++++++=
++++++++
> >  1 file changed, 36 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/sprd/drm.=
yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/sprd/drm.yaml b/=
Documentation/devicetree/bindings/display/sprd/drm.yaml
> > new file mode 100644
> > index 0000000..b5792c0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/sprd/drm.yaml
> drm seems like a sub-optimal name.
> How about usign the compatible name "display-subsystem" as it is a bit
> more specific (but not good).
You're right, maybe "sprd,drm.yaml" or "sprd-drm.yaml" will be better
>
> > @@ -0,0 +1,36 @@
> > +# SPDX-License-Identifier: GPL-2.0
>
> Any chance this can be (GPL-2.0-only OR BSD-2-Clause).
> I noticed that for example clock/sprd,sc9863a-clk.yaml uses this license
> so I hope this is OK.
I will add GPL-2.0-only to it.
>
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/sprd/drm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Unisoc DRM master device
> > +
> > +maintainers:
> > +  - Mark Rutland <mark.rutland@arm.com>
> > +
> > +description: |
> > +  The Unisoc DRM master device is a virtual device needed to list all
> > +  DPU devices or other display interface nodes that comprise the
> > +  graphics subsystem.
> > +
> > +properties:
> > +  compatible:
> > +    const: sprd,display-subsystem
> > +
> > +  ports:
> > +    description:
> > +      Should contain a list of phandles pointing to display interface =
port
> > +      of DPU devices.
> Add type - like this:
> $ref: /schemas/types.yaml#/definitions/phandle-array
>
> See for example display/rockchip/rockchip-drm.yaml
>
> Any specific reason why this is not a ports node like used by many other
> display bindings?
> In other words - I think this is too simple.
We only support one display pipeline now, other interface, like
DP(DisplayPort), HDMI...will be add later...

  ports:
    $ref: /schemas/types.yaml#/definitions/phandle-array
    description: |
      Should contain a list of phandles pointing to display interface port
      of dpu devices.. dpu definitions as defined in
      Documentation/devicetree/bindings/display/sprd/sprd,dpu.yaml


>
> > +
> > +required:
> > +  - compatible
> > +  - ports
> > +
>
> Add:
> additionalProperties: false
>
> so we catch if other properties sneak in.
>
> > +examples:
> > +  - |
> > +    display-subsystem {
> > +        compatible =3D "sprd,display-subsystem";
> > +        ports =3D <&dpu_out>;
> > +    };
> > +
> > --
> > 2.7.4
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
