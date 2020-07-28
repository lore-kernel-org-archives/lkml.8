Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD23C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026AF2065E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgG1U1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:27:38 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:34546 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgG1U1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:27:38 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 77BD12003E;
        Tue, 28 Jul 2020 22:27:33 +0200 (CEST)
Date:   Tue, 28 Jul 2020 22:27:32 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        zhang.lyra@gmail.com
Subject: Re: [PATCH RFC v6 1/6] dt-bindings: display: add Unisoc's drm master
 bindings
Message-ID: <20200728202732.GB1277651@ravnborg.org>
References: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com>
 <1595930879-2478-2-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595930879-2478-2-git-send-email-kevin3.tang@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=icsG72s9AAAA:8 a=pGLkceISAAAA:8 a=gEfo2CItAAAA:8
        a=7CQSdrXTAAAA:8 a=e5mUnYsNAAAA:8 a=GBQisFtJAYk3vdkUeaMA:9
        a=CjuIK1q_8ugA:10 a=T89tl0cgrjxRNoSN2Dv0:22 a=sptkURWiP4Gy88Gu7hUp:22
        a=a-qgeE7W1pNrGK8U0ZQC:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin

On Tue, Jul 28, 2020 at 06:07:54PM +0800, Kevin Tang wrote:
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
> 
> diff --git a/Documentation/devicetree/bindings/display/sprd/drm.yaml b/Documentation/devicetree/bindings/display/sprd/drm.yaml
> new file mode 100644
> index 0000000..b5792c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sprd/drm.yaml
drm seems like a sub-optimal name.
How about usign the compatible name "display-subsystem" as it is a bit
more specific (but not good).

> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0

Any chance this can be (GPL-2.0-only OR BSD-2-Clause).
I noticed that for example clock/sprd,sc9863a-clk.yaml uses this license
so I hope this is OK.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/sprd/drm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc DRM master device
> +
> +maintainers:
> +  - Mark Rutland <mark.rutland@arm.com>
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
Add type - like this:
$ref: /schemas/types.yaml#/definitions/phandle-array

See for example display/rockchip/rockchip-drm.yaml

Any specific reason why this is not a ports node like used by many other
display bindings?
In other words - I think this is too simple.

> +
> +required:
> +  - compatible
> +  - ports
> +

Add:
additionalProperties: false

so we catch if other properties sneak in.

> +examples:
> +  - |
> +    display-subsystem {
> +        compatible = "sprd,display-subsystem";
> +        ports = <&dpu_out>;
> +    };
> +
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
