Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AF9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77512088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590695325;
	bh=D2r1sFVCo87uGvflG87lx9zXVSyz6xCgbRu8Nf53FjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WeH+9d5mXPtzmiPnN4cM1R2eDIznkLupPxO5WIK6hjBbTbzRGNA3YxS+qbu/Gi7Ld
	 z2S1u2WWPvt5Ew+mf3E8zLtqV2/hcM8CagYgqADMUOmIUHbcXZ+Jo2weKdqqsxYwBf
	 fPoC1FiQD2ZnCRwi/tYXyxwpnM0I3FJw7XvVHiQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406792AbgE1Tsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:48:45 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45776 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406780AbgE1Tsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:48:38 -0400
Received: by mail-il1-f195.google.com with SMTP id 9so68670ilg.12;
        Thu, 28 May 2020 12:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Go6xO5WoC3zEQRJwVmH9bUe++RxJSEnlCwIRvUl4+dQ=;
        b=fLOPCfN3UPdZMn+WVDutvbQQORGLazd0mnxnXTvMwrVZAV4TnOpaNt5l77yLUiV9RN
         JhECmQLNPRjPNFYkeEk9q0G13S50XFZX1diPrsbMiY3/1FfciCbw3rk6LGKTNTzpPSki
         awsZuuUE/uEC8BcgIYKS8wR7tawrzvqUy0oyRUdypEQZ9jL/hhVcw3l0jVSD1n/QBgmd
         rtPwOURwim2kSv9UiEj64EUbLMBW5UVbgA8XoHowAqgN7DTtaxz+9wfj5AfTIFrqHYHq
         qG/RefjXpH/u+LlaJ4wtodIU/wVFCEtYYCq/SbuAoI/cJeuL2MG6n4NNu3Q98Nl7NL1o
         RahA==
X-Gm-Message-State: AOAM533O3x9SFUZGHx8D78aR0maXmHx7frBx0kI7AxQzTICZCQdnnAV3
        fdvdx6N35jwIizqG2h3X/Q==
X-Google-Smtp-Source: ABdhPJxdVc8I3c5Wd+1g7euGl5ed0EkKErorxTkquQmiCvhOLVCyVbgdKy+eSwMN7mVRv2h0Ec4qUQ==
X-Received: by 2002:a92:c809:: with SMTP id v9mr4288575iln.209.1590695318014;
        Thu, 28 May 2020 12:48:38 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y13sm2960819iob.51.2020.05.28.12.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:48:16 -0700 (PDT)
Received: (nullmailer pid 568649 invoked by uid 1000);
        Thu, 28 May 2020 19:48:04 -0000
Date:   Thu, 28 May 2020 13:48:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/6] dt-bindings: display/bridge: Add binding for
 input mux bridge
Message-ID: <20200528194804.GA541078@bogus>
References: <cover.1589548223.git.agx@sigxcpu.org>
 <14a44a664f40584ffa25c1764aab5ebf97809c71.1589548223.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14a44a664f40584ffa25c1764aab5ebf97809c71.1589548223.git.agx@sigxcpu.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:12:10PM +0200, Guido Günther wrote:
> The bridge allows to select the input source via a mux controller.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../display/bridge/mux-input-bridge.yaml      | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/mux-input-bridge.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/mux-input-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/mux-input-bridge.yaml
> new file mode 100644
> index 000000000000..4029cf63ee5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/mux-input-bridge.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/mux-input-bridge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DRM input source selection via multiplexer

DRM is not a hardware thing.

The graph binding is already designed to support muxing. Generally, 
multiple endpoints on an input node is a mux. So either the device with 
the input ports knows how to select the input, or you just need a 
mux-control property for the port to have some other device implement 
the control.

You could do it like you have below. That would be appropriate if 
there's a separate h/w device controlling the muxing. Say for example 
some board level device controlled by i2c.

Rob
