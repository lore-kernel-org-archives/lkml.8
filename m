Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F71C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0583A20771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595519516;
	bh=zMWSJizp4P4FI2PLdeym4OuU829+C1a0LVKY61WFaiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QatqGKhpOrcYqWAs0rOf9ZEyqkNPHCB7z8Qt1VBrwHY04WErlhx6vFwa81ZXjPCvc
	 Jz5PefOK1vmDzak6mUyciDwN9m4+tsrFVa65Rh37YKvVh8vsXP8ZKmuS0hbItW31NF
	 +yhULjidDiICacrv+qy9toIF3u2IDF73/Yn39tqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgGWPvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:51:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45944 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgGWPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:51:54 -0400
Received: by mail-io1-f68.google.com with SMTP id e64so6715912iof.12;
        Thu, 23 Jul 2020 08:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NbSdHK3uJS+qqL6vrqQbHy+2Anft4wIWgOtjJFjijYg=;
        b=UXhi1lXa5W/abt1AtrfVQJiKTsyu9rEcQyMx5iG5MXyk6jeLzQyT4C1lDVsU0+M39y
         ZPXUmWLJO2iT8V8BO3mAK3s/FsWUc5A+vrIM9oFT47B2veX4V/fHoAviDkti+2iDlEYd
         FKcEgNPP5vd6e4UowqJfjCGpxrY6p3EUTWZugJX1us5f8gAGEiQytdjXtQAXysiKFLpW
         TvKmnkyC0tywu4t4gYKPRdkitTUNLO81mP9SYuzqdfEfuAc4Yfov4doQydHq6PREdMqS
         nUlNznnMyUsLnL3rbazbKy5LEqUq4diuPz4YW3B2KB0L4njqRPFZoLF2lr3gaUW8nPVc
         oOyw==
X-Gm-Message-State: AOAM533bdXTDeMJmmfZbuet0RGeVJ8VZBNav7rciQrdleFq0bEbu3bmC
        08XJZVL0k1+HG30YLWAl5Q==
X-Google-Smtp-Source: ABdhPJzIGK0WM0f/vwsNRxuo8j8mErlyCWIqu1SV6ppAJYTQ2bSFq72hCWI+k2Pgg/xIlXhZlztyrg==
X-Received: by 2002:a5d:8ac3:: with SMTP id e3mr5728872iot.9.1595519513344;
        Thu, 23 Jul 2020 08:51:53 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 5sm1633003ion.7.2020.07.23.08.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:51:52 -0700 (PDT)
Received: (nullmailer pid 437306 invoked by uid 1000);
        Thu, 23 Jul 2020 15:51:49 -0000
Date:   Thu, 23 Jul 2020 09:51:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     linux-rockchip@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: rockchip: Update ROCKPi 4
 binding
Message-ID: <20200723155149.GA436360@bogus>
References: <20200723090210.41201-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723090210.41201-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 14:32:07 +0530, Jagan Teki wrote:
> ROCKPi 4 has 3 variants of hardware platforms called
> ROCKPi 4A, 4B, and 4C.
> 
> - ROCKPi 4A has no Wif/BT.
> - ROCKPi 4B has AP6256 Wifi/BT, PoE.
> - ROCKPi 4C has AP6256 Wifi/BT, PoE, miniDP, USB Host enabled
>   GPIO pin change compared to 4B, 4C
> 
> So, update the existing ROCKPi 4 binding to support
> ROCKPi 4A/B/C hardware platforms.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - new patch
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/rockchip.yaml: properties:compatible:oneOf:48:items: [{'enum': [{'const': 'radxa,rockpi4a'}, {'const': 'radxa,rockpi4b'}, {'const': 'radxa,rockpi4c'}]}, {'const': 'radxa,rockpi4'}, {'const': 'rockchip,rk3399'}] is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/rockchip.yaml: properties:compatible:oneOf:48:items: [{'enum': [{'const': 'radxa,rockpi4a'}, {'const': 'radxa,rockpi4b'}, {'const': 'radxa,rockpi4c'}]}, {'const': 'radxa,rockpi4'}, {'const': 'rockchip,rk3399'}] is not of type 'object'
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/rockchip.yaml: properties:compatible:oneOf:48:items:0:enum:0: {'const': 'radxa,rockpi4a'} is not of type 'string'
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/rockchip.yaml: properties:compatible:oneOf:48:items:0:enum:1: {'const': 'radxa,rockpi4b'} is not of type 'string'
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/rockchip.yaml: properties:compatible:oneOf:48:items:0:enum:2: {'const': 'radxa,rockpi4c'} is not of type 'string'

Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/arm/rockchip.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/arm/rockchip.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/rockchip.yaml: ignoring, error in schema: properties: compatible: oneOf: 48: items
warning: no schema found in file: ./Documentation/devicetree/bindings/arm/rockchip.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/rockchip.yaml: ignoring, error in schema: properties: compatible: oneOf: 48: items
warning: no schema found in file: ./Documentation/devicetree/bindings/arm/rockchip.yaml
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1334641

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

