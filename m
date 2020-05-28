Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96B3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945DA2100A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590632310;
	bh=jvukpDLIP9hjWGOlL+1CqDEZNqUL7PyqfBDQP6F0TRo=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=aAmzwqFbUyY4qVeeZmKwpGgmScfpn6xw7lv/oX+82Hs8R4qy+d2n9nbptxiQkWpb0
	 +OYlWfhnwh9OIkUuL+rs1ZjkaR+hmejeV2N2XY/GNEjzAzy8ZbxmqyYeZAUjmvmwnB
	 cyqfSSyXa6gHiaDe72661AEl53aEjUuhMqDng4+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgE1CS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:18:29 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34719 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgE1CS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:18:29 -0400
Received: by mail-il1-f196.google.com with SMTP id v11so8756644ilh.1;
        Wed, 27 May 2020 19:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kltOMpJbIDHqgiVTyTHUiwKcDlpFvBKVIUzBWkM4zNU=;
        b=Yc+FSqPz2y5P64NVrrxsrchfcoqjaQFiSBZQQQb0IzPAYSEzzJ1K7jQx1hPky1S4JC
         oAwIWNi5GcjUbH4YtpOllys4SyA31HpgOAOg9qBPeFt/4xqHJ0TdvbgfbwKkVwgMS2VD
         MTJXRi1KyAMk39SSKcg/o09XC1AT+AeNp3CnJ8XsH9TefjK4KDdyrT99XB8cARCFLT8w
         XN4pNhbCukDEREJvag3fNVj4ix39YdanGgFM4y2BMd7SH+pMs/U/SccgWsMUZXrY7mzF
         v8Zhe1llY5fmDIX2XJN/WnbNdQJl2pKG4duIG39e38aRPXP0zZeUv680Eu7toVboiwI7
         q4wQ==
X-Gm-Message-State: AOAM531izkwrm/jLMsIf9ijFM0hveSrDHudFI24D9qQEJn5oD9q6qveU
        W/c1fVqTlaSDRqHsLL7JlA==
X-Google-Smtp-Source: ABdhPJyQklBA7zhhBevQrvYgoJ+/iCs+760GP/ErwqCeqexJ7KvCqkPZY0e8thS5U2igqZQbCPbZng==
X-Received: by 2002:a92:9f82:: with SMTP id z2mr950652ilk.59.1590632307912;
        Wed, 27 May 2020 19:18:27 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s71sm2536741ilc.32.2020.05.27.19.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:18:27 -0700 (PDT)
Received: (nullmailer pid 3229541 invoked by uid 1000);
        Thu, 28 May 2020 02:18:26 -0000
Date:   Wed, 27 May 2020 20:18:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Olof Johansson <olof@lixom.net>,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 10/14] dt-bindings: clock: sparx5: Add Sparx5 SoC DPLL
 clock
Message-ID: <20200528021826.GA3221035@bogus>
References: <20200513125532.24585-1-lars.povlsen@microchip.com>
 <20200513125532.24585-11-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513125532.24585-11-lars.povlsen@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 02:55:28PM +0200, Lars Povlsen wrote:
> This add the DT bindings documentation for the Sparx5 SoC DPLL clock
> 
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../bindings/clock/microchip,sparx5-dpll.yaml | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/microchip,sparx5-dpll.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/microchip,sparx5-dpll.yaml b/Documentation/devicetree/bindings/clock/microchip,sparx5-dpll.yaml
> new file mode 100644
> index 0000000000000..594007d8fc59a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/microchip,sparx5-dpll.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/microchip,sparx5-dpll.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip Sparx5 DPLL Clock
> +
> +maintainers:
> +  - Lars Povlsen <lars.povlsen@microchip.com>
> +
> +description: |
> +  The Sparx5 DPLL clock controller generates and supplies clock to
> +  various peripherals within the SoC.
> +
> +  This binding uses common clock bindings
> +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +properties:
> +  compatible:
> +    const: microchip,sparx5-dpll
> +
> +  reg:
> +    items:
> +      - description: dpll registers

For a single entry, just:

maxItems: 1

> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  # Clock provider for eMMC:
> +  - |
> +    clks: clks@61110000c {

clock-controller@1110000c {

> +         compatible = "microchip,sparx5-dpll";
> +         #clock-cells = <1>;
> +         reg = <0x1110000c 0x24>;

Looks like this is a sub-block in some other h/w block. What's the 
parent device? That should be described and this should be part of it 
either as a single node or a child node. Without a complete view of what 
this block has I can't provide any guidance.

Rob
