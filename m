Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A10C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D491206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597437193;
	bh=XxTu24VoE5/0bzSq7BFkNbRK8XcH+TniZ4snFxsPu68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lX6mZIZ/GYr/rC9+osQea6ndiUzgMnwER0cHUSsrrrdU+zRT4mTcXMoRAAwAb3+qf
	 ypYfRxwv/Oa7mD2XZcEtBUcR3hxwdZb8FldJ3zvgE1djbW1MzNJo3wlTztN5+eboKu
	 luu7dsBJK/iIX+hYSG7A8ORs7kmMpjtvWoSAz9P8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHNUdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:33:12 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:46820 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHNUdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 16:33:12 -0400
Received: by mail-il1-f195.google.com with SMTP id c6so9491380ilo.13;
        Fri, 14 Aug 2020 13:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H36X60cFHtdfQYeByEjdGMshsCCiKEDcpUM/kCiexr0=;
        b=ldkfjxxxrFB27YApDdTWhtGlPMkyotarkZO23Lhc+baqYfrC4opcsrK2OaV3TOHcFd
         QZYQB/lkrn/N45h0mUdqx8E4uj2+Y1Iv6a/ydghkwDSYdBYgGAbw7bBhPRgwAqOPmSRl
         gXLOVQF7LGU5VoVWmOFD1oqMbQnk9I4dyCW4oCyOWiLtM+imWWnxor8f2lsDxH6vGS2Z
         yYmAmyCQJmiuxsPCHjiCiNMkczhdmQWUaRDcSrxN7ezn9Jd07X1mrgy3TR5yb/RODMm6
         b+xSGO1bqZWpGNlnejkKDpmNb+O5Ji8iW3wXOGPf3ipCu86XnISzElvltIOcN2LCGOgl
         K+yQ==
X-Gm-Message-State: AOAM533je2cesU5CG3ymLUpgT9wucQ7KcKt7G3WGw0zBWp+keVHkLDan
        iuRZc3tb1vd9MgsErXW1NPRiww0Uag==
X-Google-Smtp-Source: ABdhPJw2RLizyrbRiQ8kpQlD4iP0gO9ovcGZc/bjSfQVXgtYpDv26nhtnV/lx+JA8J+uOoyo/TnOnw==
X-Received: by 2002:a05:6e02:c09:: with SMTP id d9mr4104248ile.289.1597437191292;
        Fri, 14 Aug 2020 13:33:11 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id w13sm4957898ilj.70.2020.08.14.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 13:33:10 -0700 (PDT)
Received: (nullmailer pid 2724126 invoked by uid 1000);
        Fri, 14 Aug 2020 20:33:08 -0000
Date:   Fri, 14 Aug 2020 14:33:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     broonie@kernel.org, gene_chen@richtek.com, robh+dt@kernel.org,
        cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH] regulator: Add support for RT4801 Display Bias regulator
 driver
Message-ID: <20200814203308.GA2723423@bogus>
References: <1597384773-18078-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597384773-18078-1-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 13:59:33 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds support for the RT4801 DSV. It has two regulators (DSVP/DSVN) with an I2C
> interface. DSVP/DSVN can provide the display panel module for the positive/negative
> voltage range from (+/-)4V to (+/-)6V.
> ---
>  .../regulator/richtek,rt4801-regulator.yaml        |  80 ++++++++
>  drivers/regulator/Kconfig                          |   7 +
>  drivers/regulator/Makefile                         |   1 +
>  drivers/regulator/rt4801-regulator.c               | 223 +++++++++++++++++++++
>  4 files changed, 311 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
>  create mode 100644 drivers/regulator/rt4801-regulator.c
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml: additionalProperties: ['enable-gpios'] is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml: additionalProperties: ['enable-gpios'] is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml: additionalProperties: ['enable-gpios'] is not of type 'object'

make[1]: *** [Documentation/devicetree/bindings/Makefile:19: Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml: ignoring, error in schema: additionalProperties
warning: no schema found in file: ./Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
make: *** [Makefile:1334: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1344633

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

