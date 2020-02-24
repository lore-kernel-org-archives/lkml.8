Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2337C38BE1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72D120836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582569521;
	bh=hi7JVfRDoeyGdxQwYXLmOT+g7MYjuTMVBzMDWJXeBDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wObPzXYKmjQZjvruGkmmBR9IG2ouLWKwnq/g2aBagAkgxJQN0FuZJEPAOF/ng7QzC
	 u4AaggNx82uR4SUCdwW7Pgy2+JzD2Dl1eIhmD7i93gi9pyVXMDLp1ezBSJqCYwIVRP
	 Sj2TzAnglUHARzfrH8Waygj/2H6mG1U5c3dWDprs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgBXSik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:38:40 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42516 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBXSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:38:40 -0500
Received: by mail-oi1-f195.google.com with SMTP id j132so9914181oih.9;
        Mon, 24 Feb 2020 10:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KIxNc55NxgvE6j0xfm1Sga8uXN4KJSN+Vsg27kwf7bU=;
        b=mKktKwbglu9GqnkhcORY7KXfzfcZFnoBo0KKTZerphRK84SZfhmhBozIk6MUNvFTso
         Wih/r0tJp6AKjBjIaI0Go6/ONYL25QggMs7PzbwXQ5xguCkoXgS5MS8IA0/RfI43rv6S
         z6aauZ1PpBOKLDs4cqiwiVoO4tpdFHwxCag2hkowExlSdMn7HhzpjVHzLQu/d3B3Zcts
         GW7qnEgo/chJSp9blh2By47WHSagYT2x3VZ1AVclbendyQWLcsvYGLdbkGd2mCTUoa3M
         iPTiE02fziQRNVsoAYsthD1em/n6ABTxBZvFigbnBpLuyUhBfiPp70jvLTx2S9NcnFzD
         NXDA==
X-Gm-Message-State: APjAAAUX5S37DakqBTa3VX2Wj4iO/jiSkpV0W1op1uhXqUJvgAsqsvyw
        xE/habjThRYT6PjBjXys3tTTWBo=
X-Google-Smtp-Source: APXvYqxC6zs4BbgyhbSt2wk1ri78YubmFXP2o6p/yzAa8uQASyj3D+CsBlGjSGUpt95oH0h+E4uoQw==
X-Received: by 2002:aca:f20b:: with SMTP id q11mr353554oih.78.1582569519126;
        Mon, 24 Feb 2020 10:38:39 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v202sm4296761oie.10.2020.02.24.10.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:38:38 -0800 (PST)
Received: (nullmailer pid 1132 invoked by uid 1000);
        Mon, 24 Feb 2020 18:38:37 -0000
Date:   Mon, 24 Feb 2020 12:38:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next 4/9] dt-binding: ti: am65x: document mcu cpsw
 nuss
Message-ID: <20200224183837.GA476@bogus>
References: <20200222155752.22021-1-grygorii.strashko@ti.com>
 <20200222155752.22021-5-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222155752.22021-5-grygorii.strashko@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2020 17:57:47 +0200, Grygorii Strashko wrote:
> Document device tree bindings for The TI AM654x/J721E SoC Gigabit Ethernet MAC
> (Media Access Controller - CPSW2G NUSS). The CPSW NUSS provides Ethernet packet
> communication for the device.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   | 226 ++++++++++++++++++
>  1 file changed, 226 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml: properties:ethernet-ports:patternProperties:^port@[0-9]+$: 'minItems' is not one of ['type', 'description', 'dependencies', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'allOf', 'anyOf', 'oneOf', '$ref']
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1242523
Please check and re-submit.
