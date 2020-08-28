Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D46C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02D92087D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598643590;
	bh=xUFISk9C2T5Th/TVRS1zOH9gJGTo5NUogulgUtWd1kU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ey248CS1ekEvR31dTAErNP+S1LbVLu2YEMNXLp5pEyZSphsHWFJR4FsKKuBa7P2Go
	 w34q4NIptmvxb7b2K0W9HdNXVqF2MN5dsIsq3csSoEEJcWr2CBn/MQva258CMnWB1e
	 wGyGrwRHn7pE//7pgy8mO55cgMVLXnX9TNaaV6Qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgH1Tjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgH1Tjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:39:46 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0FDA2087D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 19:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598643585;
        bh=xUFISk9C2T5Th/TVRS1zOH9gJGTo5NUogulgUtWd1kU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N9hZCAXitny7X+xFMoghz/azRkTxxqJGZFJfVUgNxDYJYQcrYH3BO5cNXbM+ukhm1
         UC5gCezt1fG/ImIewN9HfE4Wd4zSz/KAAZov6JPbCZoojn5jtiBQa1b8sF6+PgXedL
         LtrMlfbi8Bh1Gg/5eVQ0jIlz6UwPjm4l5v9jHI5c=
Received: by mail-ot1-f47.google.com with SMTP id 5so181070otp.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:39:45 -0700 (PDT)
X-Gm-Message-State: AOAM533CFaZK84bl++E6Lor3VZglFcfmLkUlyOyjGw4j0RPI+8bIXQPg
        F2Sk39Txwkt5Ivevbl9I7s0lbdL22ozt3Ysz7w==
X-Google-Smtp-Source: ABdhPJyi4hrkJ9gGCQ7RWa0qmwaJus2XjYIXCWK0Rz7SdHaCJdzgpAplFiv/WVecDA/b30q8ixGX5hi9dJRXZEEjFy8=
X-Received: by 2002:a05:6830:1d94:: with SMTP id y20mr159768oti.129.1598643585206;
 Fri, 28 Aug 2020 12:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com> <1595930879-2478-2-git-send-email-kevin3.tang@gmail.com>
In-Reply-To: <1595930879-2478-2-git-send-email-kevin3.tang@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 28 Aug 2020 13:39:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKn+=idtoRiSqwSNQwfsiVRSrDSznQXWrpm=RET_hegRw@mail.gmail.com>
Message-ID: <CAL_JsqKn+=idtoRiSqwSNQwfsiVRSrDSznQXWrpm=RET_hegRw@mail.gmail.com>
Subject: Re: [PATCH RFC v6 1/6] dt-bindings: display: add Unisoc's drm master bindings
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 4:08 AM Kevin Tang <kevin3.tang@gmail.com> wrote:
>
> From: Kevin Tang <kevin.tang@unisoc.com>
>
> The Unisoc DRM master device is a virtual device needed to list all
> DPU devices or other display interface nodes that comprise the
> graphics subsystem
>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  .../devicetree/bindings/display/sprd/drm.yaml      | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/drm.yaml

If you want bindings reviewed, then you need to Cc
devicetree@vger.kernel.org. Otherwise you may be waiting until the 6th
version or later or never.

>
> diff --git a/Documentation/devicetree/bindings/display/sprd/drm.yaml b/Documentation/devicetree/bindings/display/sprd/drm.yaml
> new file mode 100644
> index 0000000..b5792c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sprd/drm.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0

New bindings should be dual licensed:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/sprd/drm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc DRM master device

DRM is a Linux thing and shouldn't be part of a binding.

> +
> +maintainers:
> +  - Mark Rutland <mark.rutland@arm.com>

No, this should be you or someone that knows the h/w.

> +
> +description: |
> +  The Unisoc DRM master device is a virtual device needed to list all
> +  DPU devices or other display interface nodes that comprise the
> +  graphics subsystem.
> +
> +properties:
> +  compatible:
> +    const: sprd,display-subsystem
> +
> +  ports:
> +    description:
> +      Should contain a list of phandles pointing to display interface port
> +      of DPU devices.
> +
> +required:
> +  - compatible
> +  - ports
> +
> +examples:
> +  - |
> +    display-subsystem {
> +        compatible = "sprd,display-subsystem";
> +        ports = <&dpu_out>;

We generally try to avoid this virtual node as it doesn't represent
any h/w. Can't you bind the driver to the DPU directly?

Rob
