Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA6FC35666
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8E42072C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBUVVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:21:22 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:46920 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgBUVVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:21:22 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 6670620083;
        Fri, 21 Feb 2020 22:21:19 +0100 (CET)
Date:   Fri, 21 Feb 2020 22:21:18 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, baolin.wang@linaro.org
Subject: Re: [PATCH RFC v3 1/6] dt-bindings: display: add Unisoc's drm master
 bindings
Message-ID: <20200221212118.GC3456@ravnborg.org>
References: <1582271336-3708-1-git-send-email-kevin3.tang@gmail.com>
 <1582271336-3708-2-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582271336-3708-2-git-send-email-kevin3.tang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=icsG72s9AAAA:8
        a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8
        a=7CQSdrXTAAAA:8 a=crxGqJoGa4JPo5xfP4sA:9 a=58J9oS6OoW3ROaZk:21
        a=itk5MRJ4zDJvAorz:21 a=CjuIK1q_8ugA:10 a=T89tl0cgrjxRNoSN2Dv0:22
        a=cvBusfyB2V15izCimMoJ:22 a=sptkURWiP4Gy88Gu7hUp:22
        a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin.

On Fri, Feb 21, 2020 at 03:48:51PM +0800, Kevin Tang wrote:
> From: Kevin Tang <kevin.tang@unisoc.com>
> 
> The Unisoc DRM master device is a virtual device needed to list all
> DPU devices or other display interface nodes that comprise the
> graphics subsystem
> 
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  .../devicetree/bindings/display/sprd/drm.yaml      | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/drm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/sprd/drm.yaml b/Documentation/devicetree/bindings/display/sprd/drm.yaml
> new file mode 100644
> index 0000000..1614ca6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sprd/drm.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/sprd/drm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc DRM master device
> +
> +maintainers:
> +  - David Airlie <airlied@linux.ie>
> +  - Daniel Vetter <daniel@ffwll.ch>
> +  - Rob Herring <robh+dt@kernel.org>
> +  - Mark Rutland <mark.rutland@arm.com>

Rob is king of a super-maintainer.
He should not be listed unless he has special
relations to sprd.
David + Daniel - likewise. Unless they are closely related to sprd drop
them.

> +
> +description: |
> +  The Unisoc DRM master device is a virtual device needed to list all
> +  DPU devices or other display interface nodes that comprise the
> +  graphics subsystem.

I wonder why you name it "Unisoc" when all other places references sprd.


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
So you want to force the driver to support ports - and no panel
referenced directly?

> +
> +examples:
> +  - |
> +    display-subsystem {
> +        compatible = "sprd,display-subsystem";
> +        ports = <&dpu_out>;
> +    };
> \ No newline at end of file
Please fix.

	Sam
