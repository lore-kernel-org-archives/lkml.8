Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843DEC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F791207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597876536;
	bh=4SyqOor5hsM6SNyfMpQkv5T0yyloegxdW5C4+Kx49DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j4lJmVoOo4w7V6e5gIOxEwrEyl0P32j3KIDFAFABxCY0QE5gRPmhaexwu5R+NA7/D
	 +d/RQWfsuRDSUuei064QTHGhe5xTWLUvXrGlyAPYtzLgksPgUHjA7lW5BRPOfEKC47
	 b2uTCYZguhFV2W/KNQenOX3TA5XKkhFXqYa5c1pU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHSWff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:35:35 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39656 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSWfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:35:34 -0400
Received: by mail-il1-f193.google.com with SMTP id f12so139219ils.6;
        Wed, 19 Aug 2020 15:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6B+QtEzPN1sVC0eGYcsuWTFOiOpQyG+uCCm3azOM3t0=;
        b=NBZ2L1jPdT2j2SfI6uq36wWhtsvgJF6nBtC2Cmj3PLfZUClk9tTwUi8ki7d9xm6dgr
         U5+M0z793xFBzXo+anbTcOY2XNnhTXAPhKEXZlqoPyX+vmQwMFM0caaPZFI6U8MBjx3N
         Bp2KNSB8n+482+nu3IEx09nZNVCM5131pU/z7qDVIvIxksySWUhArRxdHKWtT3cuBmzh
         63SLIdhYdTcyAa0WuqDEAPitEqGfgPR1m1GVGR1MOYY6EbsgLgc4ghqKmMCQvMHLg+k+
         g8wEMRDdSZ79BpzOFzALx+8kY8qQH4121vCWZkMybzi4Oukf+X+rzBPG6Ih9NEspaHGt
         r57A==
X-Gm-Message-State: AOAM533NeWp01q6VTD3K22Uii6MrE/RfTw3kQ5gbSMzL+EZD+21rt3HA
        pe7qnZ1NwsrZCCGaotOw+g==
X-Google-Smtp-Source: ABdhPJzMa9dA5WjrTU+fcuAjVNSLdCDEUtDVRbc+XaDoRZEBT/nyroDUEHNUrHOkUeFtT1yxggcIuA==
X-Received: by 2002:a92:b05:: with SMTP id b5mr228806ilf.14.1597876532950;
        Wed, 19 Aug 2020 15:35:32 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id d1sm217816ila.67.2020.08.19.15.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 15:35:32 -0700 (PDT)
Received: (nullmailer pid 2085740 invoked by uid 1000);
        Wed, 19 Aug 2020 22:35:30 -0000
Date:   Wed, 19 Aug 2020 16:35:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Reto Schneider <code@reto-schneider.ch>
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Michael Zimmermann <michael.zimmermann@grandcentrix.net>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        open list <linux-kernel@vger.kernel.org>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, Stefan Roese <sr@denx.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] ARM: at91: Add GARDENA smart Gateway (Art. 19000)
 board
Message-ID: <20200819223530.GA2083518@bogus>
References: <20200810171921.8679-1-code@reto-schneider.ch>
 <20200819112550.16494-1-code@reto-schneider.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819112550.16494-1-code@reto-schneider.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 13:25:47 +0200, Reto Schneider wrote:
> From: Reto Schneider <reto.schneider@husqvarnagroup.com>
> 
> This patch adds support for the GARDENA smart Gateway, which is based on
> the Atmel AT91SAM9G25. It is equipped with 128 MiB of DDR2 RAM and
> 256 MiB NAND storage.
> 
> Please note that this gateway is not actually based on a AT91SAM9x5 EK
> board, but is close enough to allow its DT to be used.
> 
> Co-developed-by: Stefan Roese <sr@denx.de>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Co-developed-by: Michael Zimmermann <michael.zimmermann@grandcentrix.net>
> Signed-off-by: Michael Zimmermann <michael.zimmermann@grandcentrix.net>
> Signed-off-by: Reto Schneider <reto.schneider@husqvarnagroup.com>
> ---
>  .../devicetree/bindings/arm/atmel-at91.yaml   |   2 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/at91sam9g25-gardena-smart-gateway.dts | 157 ++++++++++++++++++
>  3 files changed, 160 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/atmel-at91.yaml: properties:compatible:oneOf:2:items: [{'enum': ['overkiz,kizboxmini-base', 'overkiz,kizboxmini-mb', 'overkiz,kizboxmini-rd', 'overkiz,smartkiz', 'gardena,smart-gateway-at91sam"']}, {'const': 'atmel,at91sam9g25'}, {'const': 'atmel,at91sam9x5'}, {'const': 'atmel,at91sam9'}] is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/atmel-at91.yaml: properties:compatible:oneOf:2:items: [{'enum': ['overkiz,kizboxmini-base', 'overkiz,kizboxmini-mb', 'overkiz,kizboxmini-rd', 'overkiz,smartkiz', 'gardena,smart-gateway-at91sam"']}, {'const': 'atmel,at91sam9g25'}, {'const': 'atmel,at91sam9x5'}, {'const': 'atmel,at91sam9'}] is not of type 'object'
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/atmel-at91.yaml: properties:compatible:oneOf:2:items:0:enum:4: 'gardena,smart-gateway-at91sam"' does not match '^[a-zA-Z0-9,.\\-_ #+/]+$'

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/atmel-at91.yaml: ignoring, error in schema: properties: compatible: oneOf: 2: items
warning: no schema found in file: ./Documentation/devicetree/bindings/arm/atmel-at91.yaml


See https://patchwork.ozlabs.org/patch/1347723

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

