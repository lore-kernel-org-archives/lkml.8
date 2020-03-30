Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED97EC2D0EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C1F2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585583049;
	bh=LvNjwC7RztwBb+yi8oI2Bwz5LXahk4iEX7nsDONhykY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tcMe3G1hiRXHF9DWORbD66OVzUsEmm4GJ9bsiCFR2k1q4Z2BsgKNr6ZXIa0two1yQ
	 zwkqOofFdw7A6+E1bE968MCF7jFXbJHlZQG946uKmDh3XGKCGoRnwhrQEO6e3JEExH
	 CfgHo+jlJD9JIRf18sbXNrnhyhTzq2XLTaCcur+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgC3PoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:44:09 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40202 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgC3PoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:44:08 -0400
Received: by mail-il1-f195.google.com with SMTP id j9so16278574ilr.7;
        Mon, 30 Mar 2020 08:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6L0zwcu6TJpBy8ROIw82e95a8IhAis774QnwFUUDei4=;
        b=LQrYUZZVixxLxkn9OUkCOuUoayju9+MeC+otgSACp/Vis/tbS9LzSDW9QpblqngMdN
         rd3CMMOGNsZII8jauFAeD+ZfD0drRogCLcKt8PtdeHSwB4oFlJ78eRH4lNnAnjJeUCyz
         zRSQqajD2J4yQfTP/vGqsolc9gT8A6Cvpfg7b5Ok+Hgq30ZtvANFBZUA8L54WAPYnukN
         JTtlRmz5qbdOP6r7zfotwnRT8Dy4nayma6DCrwhFGFhInCU3Td+Op9EzLcq3e8eFBhyB
         Jjn39LBlRabSs7uVbRH9d0ClOJMb385mzKL5BCC3XOvTZo9vfrU1ykt5b0VKUPq0cRDD
         nllw==
X-Gm-Message-State: ANhLgQ2y0dwvkumeguerueqhHG52HniJnBKvulUEoPmWWBUHlsm90Nnf
        KtNcI3LYIEhvstJShjb0kg==
X-Google-Smtp-Source: ADFU+vtLzoK7bLF3KNLPQffJzUbWf20WdfYgGwLo68WhEGLJBcEYEu+x/FRUoIOGhBcqWrVUOHXMcg==
X-Received: by 2002:a92:8d0e:: with SMTP id s14mr11505607ild.117.1585583046446;
        Mon, 30 Mar 2020 08:44:06 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c88sm4970096ill.15.2020.03.30.08.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:44:05 -0700 (PDT)
Received: (nullmailer pid 27458 invoked by uid 1000);
        Mon, 30 Mar 2020 15:44:04 -0000
Date:   Mon, 30 Mar 2020 09:44:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@collabora.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH v5 5/5] dt-bindings: display: add i.MX6 MIPI DSI host
 controller doc
Message-ID: <20200330154404.GA26389@bogus>
References: <20200330113542.181752-1-adrian.ratiu@collabora.com>
 <20200330113542.181752-6-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330113542.181752-6-adrian.ratiu@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 14:35:42 +0300, Adrian Ratiu wrote:
> This provides an example DT binding for the MIPI DSI host controller
> present on the i.MX6 SoC based on Synopsis DesignWare v1.01 IP.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> Changes since v4:
>   - Fixed yaml binding to pass `make dt_binding_check dtbs_check`
>   and addressed received binding feedback (Rob)
> 
> Changes since v3:
>   - Added commit message (Neil)
>   - Converted to yaml format (Neil)
>   - Minor dt node + driver fixes (Rob)
>   - Added small panel example to the host controller binding
> 
> Changes since v2:
>   - Fixed commit tags (Emil)
> ---
>  .../display/imx/fsl,mipi-dsi-imx6.yaml        | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.example.dts:34.21-31: Warning (reg_format): /example-0/dsi@21e0000/ports/port@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.example.dts:33.24-38.19: Warning (avoid_default_addr_size): /example-0/dsi@21e0000/ports/port@1: Relying on default #address-cells value
Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.example.dts:33.24-38.19: Warning (avoid_default_addr_size): /example-0/dsi@21e0000/ports/port@1: Relying on default #size-cells value
Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.example.dts:33.24-38.19: Warning (graph_port): /example-0/dsi@21e0000/ports/port@1: graph node '#address-cells' is -1, must be 1
Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.example.dts:33.24-38.19: Warning (graph_port): /example-0/dsi@21e0000/ports/port@1: graph node '#size-cells' is -1, must be 0

See https://patchwork.ozlabs.org/patch/1263893

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
