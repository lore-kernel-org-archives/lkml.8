Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0164C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6DC206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467736;
	bh=kN8hm+JWHOFmoeGOxJtnCUh+sCzPl/wp/K+w6SF7GLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iCYNk2x6ai8LtA1KevZNMyNpJmsuCRi8kp1VVRMHz2y0O/2nBHGyJRe6KqvlVGiXc
	 seTSTEbmriRjD3dYYTLOWHJElkoEuH5l81mzQXV6dYj0w115ACVy4TsVndkvTVyRMJ
	 dNNlQoWGR9wQp0CklZs1W7v/HatxLtVeWbEXPVqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391579AbgF2Vze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:55:34 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45504 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391553AbgF2VzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:55:24 -0400
Received: by mail-il1-f194.google.com with SMTP id l9so15864742ilq.12;
        Mon, 29 Jun 2020 14:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z06gzP1D2QcJaBResbDn25dzkFa7czoMHbRABLK66e4=;
        b=cidmVQoGlvZsu7yNTl5fFl8waOzFhwhgnxCTmm2w2tLvbo51oEEK0IDYE+nIwaBWe5
         +Y+lySu7hJ8jBHkHANyAPraBQckilytV5WU7xO/d/D7EE/BPHLwbPhTm4ijaKt3FGz9q
         X8WzhJCHttAfRuYCzxOu7RGu52ZDGvdMq1d+60X+y++QSoQurfFIaFhYqmBaaajOML08
         fPF8CxGu9zYGH52XIvhiRnEbPxhbLIYyBmlLSQhW6K9OFcx0H9Ldf77tEMDSvg6HCcEE
         pBUKvn3qbTAlo+k7fVYI3t7VFTbzz5+Un0UjhPIg/MKNsS7fG1bxqVLwBp6xjd0LjZXP
         UKSg==
X-Gm-Message-State: AOAM531DVd3P0AAp1Gjsjr4mDnNMJVWltK/+IyXQDdhtL6Frex1gNxIm
        o+zRnySHTGQdRC/BNQtu8g==
X-Google-Smtp-Source: ABdhPJwKg65QGLzlMM3KQdjO48s4QdfD6Lc3M0zgovxzCYpjPdp4mi+repNQ1psb8xWSS+aFBfPUfg==
X-Received: by 2002:a92:8e41:: with SMTP id k1mr11387622ilh.250.1593467723506;
        Mon, 29 Jun 2020 14:55:23 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id w10sm619584ilo.10.2020.06.29.14.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:55:22 -0700 (PDT)
Received: (nullmailer pid 2999258 invoked by uid 1000);
        Mon, 29 Jun 2020 21:55:20 -0000
Date:   Mon, 29 Jun 2020 15:55:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add UniPhier AHCI PHY description
Message-ID: <20200629215520.GA2998145@bogus>
References: <1592534207-13550-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1592534207-13550-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592534207-13550-2-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 11:36:46 +0900, Kunihiko Hayashi wrote:
> Add DT bindings for PHY interface built into ahci controller implemented
> in UniPhier SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/phy/socionext,uniphier-ahci-phy.yaml  | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml: properties:reset-names: [{'items': [{'const': 'link'}, {'const': 'phy'}]}] is not of type 'object', 'boolean'
Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1312535

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

