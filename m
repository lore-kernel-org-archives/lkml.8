Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B842C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538A020890
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593723110;
	bh=Swz3Dg5V/CFfCj1lodx5ALSU32uVwjZp4BtMkihvcWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YHhBATrRi9lAokqqt9zsGjicOWHTseE2HAFpmjgdgtL1YxTBiXQzgxclUwcVkwIdI
	 naMpOHiRryC/Jtxb/b4CWXBwiw5XVttQJLUBFxQsAoq1zs2BYK/vMDO2smlusXZ5+c
	 VVFzRNxyXMQi4b4u5OpvM3gjODDqPwjr3OhjbR1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgGBUvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:51:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40554 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgGBUvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:51:48 -0400
Received: by mail-io1-f66.google.com with SMTP id q8so30350426iow.7;
        Thu, 02 Jul 2020 13:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rcmf522YzRsjQGuzsW0MDCpwiVqvv14uH+p7wGyNLDs=;
        b=OmwadRaG+tgvqG5NAEmsqLQ9ouKDJ9/iKeplK3tm6Lwyp8fgqwXGICeyG6XWPTVK30
         Cs1/D8Qhn2XxgkFJJtXoUNAmkndEA7GoJuD0Dou5qL1ULRXVa8UpfXmnGbbZh8QaUolP
         xfrwz6gA0n96fg7DyJ+unO3jXkxuNE7SaXw6iQh9Rr/Ru6EDbw0qDMaNFT8KEXdGVZSx
         UF05Die7h/lYzXfXWxiM7dDBkhYDsFk9XscYaP9chHLta+eAwCJBuep/k2VWUgLH5nEB
         dCX/hUF2K2nfBDNDZXhkHv715cXZGu9hNgb5KW7rklJy5d7yGF6TYq9xIW9p01sfzT7A
         FfEw==
X-Gm-Message-State: AOAM531fL67NhkYc6eoFz1Okkf2D4OHiHaa/XtUlvTurMQdVN9F0Ktsj
        aLYsDOswy8o2GAMsVYInRQ==
X-Google-Smtp-Source: ABdhPJySM9jU/gTpvtpT3zaOet81vYx3jYRYc+7n0XVexCFz3T+hidfEsgv5ZE431Xid0foaBnN57Q==
X-Received: by 2002:a6b:ee02:: with SMTP id i2mr9168719ioh.110.1593723107239;
        Thu, 02 Jul 2020 13:51:47 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w10sm5427766ilo.10.2020.07.02.13.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:51:46 -0700 (PDT)
Received: (nullmailer pid 1671716 invoked by uid 1000);
        Thu, 02 Jul 2020 20:51:43 -0000
Date:   Thu, 2 Jul 2020 14:51:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     David Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, Bhushan Shah <bshah@kde.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-sunxi@googlegroups.com, Luca Weiss <luca@z3ntu.xyz>,
        Martijn Braam <martijn@brixit.nl>,
        Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 02/13] dt-bindings: panel: Convert rocktech,
 jh057n00900 to yaml
Message-ID: <20200702205143.GA1670522@bogus>
References: <20200701162928.1638874-1-megous@megous.com>
 <20200701162928.1638874-3-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701162928.1638874-3-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jul 2020 18:29:17 +0200, Ondrej Jirman wrote:
> Convert Rocktech MIPI DSI panel driver from txt to yaml bindings.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../display/panel/rocktech,jh057n00900.txt    | 23 -------
>  .../display/panel/rocktech,jh057n00900.yaml   | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: '#address-cells', '#size-cells', 'port@0' do not match any of the regexes: 'pinctrl-[0-9]+'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: 'vcc-supply' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: 'iovcc-supply' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: 'reset-gpios' is a required property


See https://patchwork.ozlabs.org/patch/1320690

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

