Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C64CC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 09:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D108020684
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 09:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kjatv9F1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgBVJKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 04:10:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43246 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgBVJKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 04:10:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so4734569ljm.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 01:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aeinKijMUvwZffs1jb5awpoaXApbMpKIiMbRpFs/dbw=;
        b=Kjatv9F1CvG3i9rnmPS47G+S0+d40cd2EOCjbdtsXxDsabaarlCeMWFMAqK2q0noIy
         5h/9NqOtPOp/FH7nMCuZUuoII5mH70iSWXZj9BFWZAjCASNMdib+O6tSiVD3Wc3RItmW
         QaFwzWHILgVGi+FnTmPtNdDQA3TnlxEFQGVsKoR8CwgVjXU7bskgIBR8ZgL9D67AZ18d
         bmQggADFpvq8q5joCPrMJrvFy51UHQi7ShnnCAoF66o/nllDXj3rGE58aMoFUQQMNcjr
         +aqq6YQz92TEE+9tSndZwwwnfngxErNP2pk382zGcGKVKmtgh7OiDW8GTQSnQOFMzyjE
         JENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aeinKijMUvwZffs1jb5awpoaXApbMpKIiMbRpFs/dbw=;
        b=Ijg/Uq8DR0WKIbm0noPQnToxmAUDIlLdf/yWqzCIMmdlFsuAMcqtyJjhrz4l+PBpjG
         bXUTNwBVLsTUK86PKxKCM9fDWiLoG4j79zOUeqpGBv3j4tpfyS8YZlxBxW8lOZOmK/8c
         qJs/HuGIVD+9Nyo5Dm+WANeDfzrmvh5FY+6qeTeSmBC/2J7hFZBPtkLbmHdT7Po+Ak+A
         xFOk60wJ8XTK0krO0JaeXYR0ydBOlIasyw1G96kRkHNK0vAmSqsw7eOtQlyAVqMX+/mG
         lwwxYfl7y0a0RAWvApdi4nqZwggrDUoKqitt2LsDPkVSAo8k/Co4BEuk7iLtYJRzVift
         mrig==
X-Gm-Message-State: APjAAAVxgX8PmKrp9P4y58WsVGObENgzp3+UQMOlImdSbn12WKjuz9HO
        gvabKyFYdfMb0r5qW/pyFXizLOKmflP0WA+dAJU=
X-Google-Smtp-Source: APXvYqzt2fy0OQ5cPwyyek5jwcKfEoqt6c4Hu862dkrXlpEJwEOvQtp47c7eLwisjrbcC7pPh4VAEOKrgrd53lPiHEY=
X-Received: by 2002:a2e:5056:: with SMTP id v22mr24598753ljd.164.1582362634527;
 Sat, 22 Feb 2020 01:10:34 -0800 (PST)
MIME-Version: 1.0
References: <1582271336-3708-1-git-send-email-kevin3.tang@gmail.com>
 <1582271336-3708-2-git-send-email-kevin3.tang@gmail.com> <20200221212118.GC3456@ravnborg.org>
In-Reply-To: <20200221212118.GC3456@ravnborg.org>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Sat, 22 Feb 2020 17:10:22 +0800
Message-ID: <CA+H2tpF-cYUBq5cKDzZ0n+OLemtrDnPKcdN=KV_tc38S2y+yoA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/6] dt-bindings: display: add Unisoc's drm master bindings
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Kevin Tang <kevin3.tang@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 5:21 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Kevin.
>
> On Fri, Feb 21, 2020 at 03:48:51PM +0800, Kevin Tang wrote:
> > From: Kevin Tang <kevin.tang@unisoc.com>
> >
> > The Unisoc DRM master device is a virtual device needed to list all
> > DPU devices or other display interface nodes that comprise the
> > graphics subsystem
> >
> > Cc: Orson Zhai <orsonzhai@gmail.com>
> > Cc: Baolin Wang <baolin.wang@linaro.org>
> > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> > ---
> >  .../devicetree/bindings/display/sprd/drm.yaml      | 38 ++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/sprd/drm.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/sprd/drm.yaml b/Documentation/devicetree/bindings/display/sprd/drm.yaml
> > new file mode 100644
> > index 0000000..1614ca6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/sprd/drm.yaml
> > @@ -0,0 +1,38 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/sprd/drm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Unisoc DRM master device
> > +
> > +maintainers:
> > +  - David Airlie <airlied@linux.ie>
> > +  - Daniel Vetter <daniel@ffwll.ch>
> > +  - Rob Herring <robh+dt@kernel.org>
> > +  - Mark Rutland <mark.rutland@arm.com>
>
> Rob is king of a super-maintainer.
> He should not be listed unless he has special
> relations to sprd.
> David + Daniel - likewise. Unless they are closely related to sprd drop
> them.
>
> > +
> > +description: |
> > +  The Unisoc DRM master device is a virtual device needed to list all
> > +  DPU devices or other display interface nodes that comprise the
> > +  graphics subsystem.
>
> I wonder why you name it "Unisoc" when all other places references sprd.

sprd is abbreviation for Spreadtrum who was acquired by Unigroup and
combined with
another company RDA into Unisoc recently.
Unfortunately these 2 companies already have had their vendor prefix
in kernel tree as sprd and
rda for each.
So far each of their prefix is kept unchanging.

-Orson
>
>
> > +
> > +properties:
> > +  compatible:
> > +    const: sprd,display-subsystem
> > +
> > +  ports:
> > +    description:
> > +      Should contain a list of phandles pointing to display interface port
> > +      of DPU devices.
> > +
> > +required:
> > +  - compatible
> > +  - ports
> So you want to force the driver to support ports - and no panel
> referenced directly?
>
> > +
> > +examples:
> > +  - |
> > +    display-subsystem {
> > +        compatible = "sprd,display-subsystem";
> > +        ports = <&dpu_out>;
> > +    };
> > \ No newline at end of file
> Please fix.
>
>         Sam
