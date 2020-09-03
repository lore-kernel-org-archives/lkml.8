Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493D1C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1337020578
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599151225;
	bh=UiIzmqfGXHwelXZSYJYDxFYAZi/UgotBRq6BD896Hxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=byFvpxLlQ5Pc6DlWKTcKabFMVTVa24Q5/3Kg8g3fAJfEiQGDlm6S3f1dbikASLv84
	 2SIxAR6Rwc/AdLeQjutioPIiTXutaGYr6xJslvCLwCLM///yRhwkDmhmwIPWEQb5kI
	 dsQOJuE5MiD7noK3aj6CwzjcXGMta84JQFjuCu9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgICQkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:40:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45341 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgICQkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:40:22 -0400
Received: by mail-io1-f68.google.com with SMTP id u126so3550520iod.12;
        Thu, 03 Sep 2020 09:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8sPTNyLMjAX2vzuFXiQYDjjubKf1msEl5Z2p+ZrZ6Lo=;
        b=RxwyD3vB90lreMZb5R4zdoJoSB45C8dNzCoC8cnfYJdmK+j5G4bUQP8RCtjZIRawTN
         5H8SngmeA2PN/6OaJnQgWMDkdmzz8hsdsawZ8YU8PCFgr1V2L/nl0SIxbkgR/bC4lKxU
         PSdWWhnfT6lMOypSNsigV1LD8Ap7divPtUdv37VvmNgC4HUCwuGwH7dY5Xd7w9gHs4eU
         DVoeD3PR6z23l3RDd7DsZzaWFb+4jfi2Qw4of464KKW/yCyTkv49sUtdRdtaB7YvtNGI
         FRQUchcr87ITLEb5lgGXJgXNcSP80FaN50IR64m3HadFFGYu31zssSwhunlqXUXtrOl3
         m9tg==
X-Gm-Message-State: AOAM533Q/MpCGRl0QV8KmEXvFTipEuWIqD8cJQ6cKwH6iwxnf6B+9aKZ
        Ki9bmAp0UH5J6u3KNpofgA==
X-Google-Smtp-Source: ABdhPJy+YQ71xhPo9LDk5kKZzDhFUMEpp0nFRwbZF6cszIsV6tyvnefl2UlOOTqSdDoevgNCPnDj9g==
X-Received: by 2002:a02:9986:: with SMTP id a6mr1953790jal.28.1599151221270;
        Thu, 03 Sep 2020 09:40:21 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id m3sm1777806ill.57.2020.09.03.09.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:40:20 -0700 (PDT)
Received: (nullmailer pid 2921054 invoked by uid 1000);
        Thu, 03 Sep 2020 16:40:19 -0000
Date:   Thu, 3 Sep 2020 10:40:19 -0600
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
Subject: Re: [PATCH 3/7] dt-bindings: mailbox: fsl,mu: Use
 unevaluatedProperties
Message-ID: <20200903164019.GA2920343@bogus>
References: <20200829111800.2786-1-krzk@kernel.org>
 <20200829111800.2786-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829111800.2786-3-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 01:17:56PM +0200, Krzysztof Kozlowski wrote:
> Additional properties actually might appear (e.g. power-domains) so use
> unevaluatedProperties to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml:
>     mailbox@5d280000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

NAK. See https://lore.kernel.org/r/CAL_JsqKPXJxsHPS34_TCf9bwgKxZNSV4mvQR-WKRnknQVtGGxQ@mail.gmail.com/
