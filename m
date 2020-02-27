Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3FDC35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C9F246A3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582822223;
	bh=FyWAvV9W4uLcTtFZzaV8oagBiwmxzHMrlZt2Nl+L7BY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=g4+ZBslfkdT9YDB2Jjj4FP6Lk++plyAmqnXGzyJBzBM6EHRsJi0yGQCLe7q72agHa
	 auUApupTFtNbOhd+xRvS8VM0pLu0T3OghWdNfunP1h0BAZqgv9Sc0xzv9VLhDWCC/H
	 zRXCl11cdgx+Ws/kO2Sjb5cHy5yTR1OMwjTlpyzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgB0QuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbgB0QuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:50:22 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2FC4246A3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582822220;
        bh=FyWAvV9W4uLcTtFZzaV8oagBiwmxzHMrlZt2Nl+L7BY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fBa0giuWcebLxY6glY2aWH6VZ3VxxBO9cYQwUAJW9/BS97BIiN+5ISHAPlSVyBlMT
         NYtbtOUbPUv2uAP1m/KfyR2gT8T+sw5rJc91B6JBvTZcnW7ECsY6PW0Ctua3vFiH88
         alOqc9YW0g6HF5mYsmlSBEzCQgM1jJ3qmdBV2qWg=
Received: by mail-qk1-f178.google.com with SMTP id m9so3794536qke.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 08:50:20 -0800 (PST)
X-Gm-Message-State: APjAAAXJhqxwn4+OnOArMMHE+usAa0boaZyYDWuvGH96Y7XUwjOGA6YF
        jAr2C/sQI5czy0CDyzgoz5aaGWkOPXGGKByuGg==
X-Google-Smtp-Source: APXvYqyWrls57v0p+99llkshAFrLOH8Ax4ge+p84ASrUSG0BZ+VtTRV6ts66XH20u13O6L6wKhBS+1IxasPsZX079IY=
X-Received: by 2002:a37:a750:: with SMTP id q77mr88866qke.119.1582822219778;
 Thu, 27 Feb 2020 08:50:19 -0800 (PST)
MIME-Version: 1.0
References: <1582710377-15489-1-git-send-email-kevin3.tang@gmail.com> <1582710377-15489-2-git-send-email-kevin3.tang@gmail.com>
In-Reply-To: <1582710377-15489-2-git-send-email-kevin3.tang@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 27 Feb 2020 10:50:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL08g0TaNob7gcKgTx5OXgwBEfKy6f5AK73xuYhMRMNkw@mail.gmail.com>
Message-ID: <CAL_JsqL08g0TaNob7gcKgTx5OXgwBEfKy6f5AK73xuYhMRMNkw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/6] dt-bindings: display: add Unisoc's drm master bindings
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 3:46 AM Kevin Tang <kevin3.tang@gmail.com> wrote:
>
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
>  .../devicetree/bindings/display/sprd/drm.yaml      | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/drm.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/sprd/drm.yaml b/Documentation/devicetree/bindings/display/sprd/drm.yaml
> new file mode 100644
> index 0000000..b5792c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sprd/drm.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0
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

We try to avoid these virtual nodes and bind with actual h/w nodes.
Can you have more than one DPU and if so does it need to be a single
DRM driver instance?

Rob
