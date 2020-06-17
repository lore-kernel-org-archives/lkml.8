Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3032CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0CB206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592413520;
	bh=XIMLY6BhInjMoTyqDt0EF+eUnNRnI0xH3FZNQB5JAR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zpw6L0naKCIvOvM0RoJE19xijNbTfetyX0CBtK0s2BR/gxvRDPC+uurpLx2/xQrK4
	 0Lkydxgd3Er3Hu9RTO8NSZBZRL3E6blcCTe3QDYWRqXZDuK6dAoIYr26WjIEF14cFB
	 wMIn2qTWcxnK2K0oQhpxGS0HnTYQ6PaIXj1K4VHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgFQRFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:05:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43064 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFQRFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:05:18 -0400
Received: by mail-io1-f66.google.com with SMTP id u13so3592167iol.10;
        Wed, 17 Jun 2020 10:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HPxsEuG2Ekjg7Hds/kVbwy4+RHNKxxhI4PPschCmgkM=;
        b=RDT+JG49FSNzk3ZbetyEs02pzOmhpDMJXxn/VaDpboEh5w+tOIQQOesNMMhFEdUAYL
         7flU2rk1M7I1BLTh17sbua2EDs3+yj1b5fxbItc2vvnqwaSQt9+HBy+CNhxZBx7dLhid
         g2mG5px08tNOOKu6TjyU1+m/nr2TRHBQo7jDTdDuwxDf1kdEkl21OUU9slf7ktpFWUeF
         I/Uzwr+5JpP0BSlQY7ePyW84VwKbJkmdxaLIus4NhODy8gv1JTmRMySir5JgaIjzbKJu
         IY22lQSiv8zdfpfmDsKwLAmreqPIsLDoVgM1mHTbZS7+xtbEQULamYk/s3Vi69Zbh2Zw
         +mQA==
X-Gm-Message-State: AOAM532KBVPeqUBeThmPDERsbnZ5WyUmNNE5dKfIUxSWemO/wFzg4K9c
        +RWBid97NhZvPkAgxfeg/D0GnaPFZg==
X-Google-Smtp-Source: ABdhPJxOueUOpkABb/OhgZnN7xdWgVuzrEQS51Ltu7wGIP6FvZw5VBXvVUAcxQRRSAHmmWE6Fgb+Kw==
X-Received: by 2002:a02:1c4a:: with SMTP id c71mr229254jac.142.1592413517160;
        Wed, 17 Jun 2020 10:05:17 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id d71sm130223ill.9.2020.06.17.10.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 10:05:16 -0700 (PDT)
Received: (nullmailer pid 2311373 invoked by uid 1000);
        Wed, 17 Jun 2020 17:05:15 -0000
Date:   Wed, 17 Jun 2020 11:05:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     gregkh@linuxfoundation.org, alcooperx@gmail.com,
        robh+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        vkoul@kernel.org, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, simon@fire.lp0.eu, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
Message-ID: <20200617170515.GA2310896@bogus>
References: <20200616181802.3498745-1-noltari@gmail.com>
 <20200616181802.3498745-2-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616181802.3498745-2-noltari@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 20:18:01 +0200, Álvaro Fernández Rojas wrote:
> Document BCM63xx USBH PHY bindings.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  v2: phy-cells changed to 1.
> 
>  .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.example.dts:22.33-34 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:315: recipe for target 'Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1310646

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

