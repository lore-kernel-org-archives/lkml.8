Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29339C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F234D20767
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587584556;
	bh=GaIW5oMP5B+NAcRQLApP7i3Ktal9N5ktABFE84KEc30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MgStD9om52vV6XcFrski0kLwnBDU05Xz0KkFGG8V9A4eP+VefET78c4dbsjCaP3Z8
	 xWloC/uBR8RpYNhEowb2+J200YyEeumKcjMtqtH2L9pbcRKKAf5QKaLi++LAbC1CVu
	 J6xMpCSRS84vg2VkY2j0ELz1IWeAkWvZubVf/tiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDVTmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:42:35 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43089 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgDVTme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 15:42:34 -0400
Received: by mail-oi1-f193.google.com with SMTP id j16so2933318oih.10;
        Wed, 22 Apr 2020 12:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=huAsohfgPjKhobu8tGI0Z2yU/DwK8rb6r7ozAP98pjc=;
        b=IIgXHfjX57dWu0hHrecCag8mSCshPtXuJ83sV431C3F+xVEjSu1zbd5Ldh1W2EKdS4
         ONHilFmOk/OAd5HwmdsYLwUmuO5EfQJFGEC1wqF3i0pBWjnVYkoJQjK67FbTjGo2FjGQ
         LKOYQ9kghqInybHYM//AHpKCkszw/M+AETIk/X01IyGwI9I0pQeNMTRYxIyh8rohEG9E
         CcyskEVJ4TEtfjNxctdpdvJiDAuESNNXaDqqh/uiaCdpAvXudUcPl4lFMrur77VHKddr
         3x/8XIdgDDLEqnEHR2uyRvvKH7h27SpJAMyeKeTzPd0mQMUHRWhGjhmQASdOXwv6HSnA
         v3MQ==
X-Gm-Message-State: AGi0PuahJULyXMDAcvFijhh1u5F4860OmJt243KgA/bZ3cGOkFqgiWUZ
        2zoUrUoCzg9Y+8AcuVzOJA==
X-Google-Smtp-Source: APiQypIhe/Vj/x+9Tj76bJkE00Ecb+4p/RQomG76rndQXNYWtXWXHpxdZCnJwyfvOc0r/Nbba51iYQ==
X-Received: by 2002:aca:ecd7:: with SMTP id k206mr432558oih.113.1587584553937;
        Wed, 22 Apr 2020 12:42:33 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h137sm46208oib.33.2020.04.22.12.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 12:42:33 -0700 (PDT)
Received: (nullmailer pid 8268 invoked by uid 1000);
        Wed, 22 Apr 2020 19:42:31 -0000
Date:   Wed, 22 Apr 2020 14:42:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-imx@nxp.com, Neil Armstrong <narmstrong@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adrian Pop <pop.adrian61@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH v7 5/8] dt-bindings: display: add i.MX6 MIPI DSI host
 controller doc
Message-ID: <20200422194231.GA6333@bogus>
References: <20200421161610.1501827-1-adrian.ratiu@collabora.com>
 <20200421161610.1501827-6-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421161610.1501827-6-adrian.ratiu@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 19:16:07 +0300, Adrian Ratiu wrote:
> This provides an example DT binding for the MIPI DSI host controller
> present on the i.MX6 SoC based on Synopsis DesignWare v1.01 IP.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: devicetree@vger.kernel.org
> Tested-by: Adrian Pop <pop.adrian61@gmail.com>
> Tested-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> Changes since v6:
>   - Added ref to the newly created snps,dw-mipi-dsi.yaml (Laurent)
>   - Moved *-cells properties outside patternProperties (Laurent)
>   - Removed the panel port documentation (Laurent)
>   - Wrapped lines at 80 chars, typo fixes, sort includes (Laurent)
> 
> Changes since v5:
>   - Fixed missing reg warning (Fabio)
>   - Updated dt-schema and fixed warnings (Rob)
> 
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
>  .../display/imx/fsl,mipi-dsi-imx6.yaml        | 135 ++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.6/dist-packages/dtschema/schemas/display/bridge/snps,dw-mipi-dsi.yaml'
Documentation/devicetree/bindings/Makefile:11: recipe for target 'Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.example.dts] Error 255
make[1]: *** Waiting for unfinished jobs....
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1274360

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
