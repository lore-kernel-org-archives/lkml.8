Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A106C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46EBC208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588367514;
	bh=TtzIKEJMzh08aobkLktb15xMCU+OvC8wQYmZ/Y9PVZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rmb644uTiBx0O4pyoA3Y+I+ijpaCwNsOkRu2K2FqMIAqY+sQRqbgySkmLckklZJAH
	 h4TZkjabeeSu5gwsYVsUf5T8irYXGE6aF2M47mIi9lGM25/wWteTClxIkVnGHVdZVH
	 QzV6Pz6DJy9KcNhdAiVWM0ENOkJ9fctMkFh8MNU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgEAVLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:11:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37078 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgEAVLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:11:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id z17so3643994oto.4;
        Fri, 01 May 2020 14:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xqacNoPDzEhoIlaSFiZ7M/nYt8g4Eq6ioZ6f5ZQzoGk=;
        b=XnHXyxE1YG3/OuHFTur35dUUgo3ihUNzPOzrHyP5FsX/YxiiLN+GxBK0j+HdfvKLzS
         6aiRQK54uhKjvEigjaYeNr2WsxqOTiueYN/Vl7vudUWFeA6wOWU5ONS17dcbw5QvkWf+
         Iu0Rytj2dFAbRoVNcI6GAXZFFgG5FCgZNb7PZT1ndIeLeGo571A8IT8BMOziDXKoDhqV
         uNjC6NDoejZzDCJ4tGsKUpXrfVLtfdmZC4LQRW0d/bEUCEpf5vZhHS8RTe5Vq51RbSGK
         8QJ3V4NllAdG7kx8UEh+TVYjSnfOJC3+11RCHAMved2AA7Ef15lsWpP8eG3snLi1g7P9
         zRWw==
X-Gm-Message-State: AGi0PuZPppZSfNJCA3c1ohOBYLQJ4R6MFYhpSoVEU1JLSfWILQVnP0Zf
        csMKt5cSUA0wWWI4sz2Hjg==
X-Google-Smtp-Source: APiQypJPe8AZoHgqxvdb7h4mgNCU3orWjlvJ4UdLPdx21xltnwFsvEVM5yqH47FVpb1SJsX2/IROAg==
X-Received: by 2002:a05:6830:2090:: with SMTP id y16mr5315996otq.131.1588367512101;
        Fri, 01 May 2020 14:11:52 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v8sm1151555oos.0.2020.05.01.14.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:11:51 -0700 (PDT)
Received: (nullmailer pid 2201 invoked by uid 1000);
        Fri, 01 May 2020 21:11:50 -0000
Date:   Fri, 1 May 2020 16:11:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
  transmitter binding
Message-ID: <20200501211150.GA537@bogus>
References: <cover.1588236052.git.xji@analogixsemi.com>
 <a5d43ffb0250468050be5b9271567fadd0fe4e1c.1588236052.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d43ffb0250468050be5b9271567fadd0fe4e1c.1588236052.git.xji@analogixsemi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 17:34:11 +0800, Xin Ji wrote:
> The ANX7625 is an ultra-low power 4K Mobile HD Transmitter designed
> for portable device. It converts MIPI to DisplayPort 1.3 4K.
> 
> You can add support to your board with binding.
> 
> Example:
> 	anx7625_bridge: encoder@58 {
> 		compatible = "analogix,anx7625";
> 		reg = <0x58>;
> 		status = "okay";
> 		enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
> 		reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		ports {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			mipi2dp_bridge_in: port@0 {
> 				reg = <0>;
> 				anx7625_in: endpoint {
> 					remote-endpoint = <&mipi_dsi>;
> 				};
> 			};
> 
> 			mipi2dp_bridge_out: port@1 {
> 				reg = <1>;
> 				anx7625_out: endpoint {
> 					remote-endpoint = <&panel_in>;
> 				};
> 			};
> 		};
> 	};
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../bindings/display/bridge/analogix,anx7625.yaml  | 97 ++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/bridge/analogix,anx7625.example.dts:21.13-26: Warning (reg_format): /example-0/encoder@58:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/display/bridge/analogix,anx7625.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/bridge/analogix,anx7625.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/bridge/analogix,anx7625.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/bridge/analogix,anx7625.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/bridge/analogix,anx7625.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

See https://patchwork.ozlabs.org/patch/1280084

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
