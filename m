Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AC8C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C96E2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599151299;
	bh=6cpdviohtv3vZjqY7LuQ3IG4O2P/Cri0vfrA28APcqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wq2sYBEXquskyhHtPYM4COyVb3lW75veuLpHsbVI8irL9OoTZLPqdEtkCmusCT0ue
	 dmj/SaWpCPfXdWeHoymDJeUOxLEZV2pvtHiMbdNAJ9E4Azq+ap6JaFyQiwBcaw3oRd
	 fbXPkFEzxEGh57ovmG1iOt1wvpXDOHzX/bcVgD+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgICQlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:41:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46848 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgICQlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:41:20 -0400
Received: by mail-io1-f68.google.com with SMTP id d18so3558417iop.13;
        Thu, 03 Sep 2020 09:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4vBaLMLY8rxge37mhzzCjC1bHRv/tkxvPHZcyC6yaGw=;
        b=bfpp373JsCHTnLkZtTD5N0W1TVuFJgzcZTWdB5y/zs7cOzW6N6FSeOJyocLAXPDbyg
         L5Mf01LZYNBahD080qaGAyg7av7+a0R1qvXdOLefTBiK4ooMd+fAveYzzNiGdkIT4XKF
         IWf8ld7FCihHUBe3NL6lKGAm72T80Sp/VHYRdr1S5IUUC+JmBlMbheYdrO/GiIdBmy4o
         5K+XsrU8VxI43m5pbcV0rbzT+X9Am6yC+qcB/oYeqKViYoilcbq6ha9icKbdOBLRJDza
         NgtWBr2s6RwvSSE8CfBKhlOaoBmb9bwKBm/SNIHWopgarr3reDZz/SFwufxf1Heq20iF
         6eCQ==
X-Gm-Message-State: AOAM5315A27roasBDnza44co2GRXfV4gyXXp91l6OAOcd2W5VCsr7Yfx
        cUtqeiiqo6PpBoOuZ6KlUQ==
X-Google-Smtp-Source: ABdhPJyy9gHqTnOdvUDQ2CPzDzHKM8pRYtgJgzw1Dw1NrcA19Ts6CzEfhTG5AWfKYl8sUZi0hH5zHQ==
X-Received: by 2002:a05:6602:cb:: with SMTP id z11mr3728690ioe.96.1599151279481;
        Thu, 03 Sep 2020 09:41:19 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id m18sm1005371ilc.37.2020.09.03.09.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:41:19 -0700 (PDT)
Received: (nullmailer pid 2922528 invoked by uid 1000);
        Thu, 03 Sep 2020 16:41:17 -0000
Date:   Thu, 3 Sep 2020 10:41:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Wolfram Sang <wolfram@the-dreams.de>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 6/7] dt-bindings: i2c: imx: Use unevaluatedProperties
Message-ID: <20200903164117.GA2922218@bogus>
References: <20200829111800.2786-1-krzk@kernel.org>
 <20200829111800.2786-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829111800.2786-6-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 01:17:59PM +0200, Krzysztof Kozlowski wrote:
> Additional properties actually might appear (e.g. power-domains or child
> nodes) so use unevaluatedProperties to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: i2c@30a20000:
>     '#address-cells', '#size-cells', 'pmic@25' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-imx.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

NAK. See https://lore.kernel.org/r/CAL_JsqKPXJxsHPS34_TCf9bwgKxZNSV4mvQR-WKRnknQVtGGxQ@mail.gmail.com/
