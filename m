Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33104C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FAE206D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="L5qd+7Ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgEHGns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725971AbgEHGnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:43:47 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9123FC05BD43;
        Thu,  7 May 2020 23:43:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id k8so453153ejv.3;
        Thu, 07 May 2020 23:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9Xoapspv8vGV7nEwvWW2+N5IsDixtdSReSbwJRE2/c=;
        b=L5qd+7EpMZZs5/wx0CljAG9CckY6MhQ9+1CFG0tQg39HJAPSo2muPvlxbE6Ylbl1va
         vzoDtc8vqIp24kIKz3+MVYoz8Jty74c3gNxXSqgeYxWozlRVc7p4MlJbsvT6wET7kut8
         jTkB6gMZIO0CxyiHv1gRWm7bz+lEvAyvmXcOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9Xoapspv8vGV7nEwvWW2+N5IsDixtdSReSbwJRE2/c=;
        b=heFj+s0IJhOIZAwluCz0doIIS214izn6W5/ni9DY6L7K/X2sV1jIAMMUIN8/9+D3b4
         vSL1aLfj5Ep1W9xTKzYdiO0Bh6spdUv+x52C6n43kZ4oqkjKnPHQSJ4E2D/2yrzjKtJv
         Aq6mkRIGGUcS8fMNvY3Ocr/PkSk+iRvINYv0Kr6qGZa9N4EVmPvxmqRTEAFNISRNyrzu
         BEufuOWgSzpRolxlxis2H0mV8nWBEu7c13wJ4mgHYZi+hAUiYg31h/dWNE5WdEPP7LrD
         OHUz8ZisHxrPNnISGBLrX2Ob5QSTHZk51wyFGUmF4iu3MJlOVON4gp6sWx31LJh2zLPl
         3S1Q==
X-Gm-Message-State: AGi0PuahXYoelyrwXYaRwpfIcJWoU7xOLXWfehL2zHy9cViYWEKR8qwe
        PwmmM8W4b847Ft31f1yCMqN6RHxlLnFlVB9LI4g=
X-Google-Smtp-Source: APiQypIfqJJksuAv8txSnGre3V121iR923e+Y2QhA6G7HWWF52f7u5PXJ9qldpQXGV//lwdBurqHJ/wMPJc22gMcsxA=
X-Received: by 2002:a17:906:3607:: with SMTP id q7mr580759ejb.313.1588920226192;
 Thu, 07 May 2020 23:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200508063904.60162-1-joel@jms.id.au>
In-Reply-To: <20200508063904.60162-1-joel@jms.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 8 May 2020 06:43:34 +0000
Message-ID: <CACPK8XdSzNOHs1o59jEy66fUW4n=7cFvwpROF+Nys_jaaZ83sA@mail.gmail.com>
Subject: Re: [PATCH] dtc: Remove warning for I2C_OWN_SLAVE_ADDRESS
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 at 06:39, Joel Stanley <joel@jms.id.au> wrote:
>
> dtc does a sanity check on reg properties that they are within the 10
> bit address range for i2c slave addresses. In the case of multi-master
> buses the binding may describe an address that the bus will listen on as
> a device. Do not warn when this flag is set.
>
> This fixes the following build warnings reported by Stephen:
>
> arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:126.11-130.4:
>   Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@80/ipmb1@10:
>     I2C bus unit address format error, expected "40000010"
> arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:128.3-30:
>   Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@80/ipmb1@10:reg:
>     I2C address must be less than 10-bits, got "0x40000010"
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  scripts/dtc/checks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> index 4b3c486f1399..986754f858cf 100644
> --- a/scripts/dtc/checks.c
> +++ b/scripts/dtc/checks.c
> @@ -1022,6 +1022,8 @@ static void check_i2c_bus_bridge(struct check *c, struct dt_info *dti, struct no
>  }
>  WARNING(i2c_bus_bridge, check_i2c_bus_bridge, NULL, &addr_size_cells);
>
> +#define I2C_OWN_SLAVE_ADDRESS  (1 << 30)
> +
>  static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node *node)
>  {
>         struct property *prop;
> @@ -1044,6 +1046,8 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
>         }
>
>         reg = fdt32_to_cpu(*cells);
> +       /* Ingore I2C_OWN_SLAVE_ADDRESS */

Obviously that should say "Ignore", and similarly below. The wonders
of Friday afternoon patches.

> +       reg &= ~I2C_OWN_SLAVE_ADDRESS;
>         snprintf(unit_addr, sizeof(unit_addr), "%x", reg);
>         if (!streq(unitname, unit_addr))
>                 FAIL(c, dti, node, "I2C bus unit address format error, expected \"%s\"",
> @@ -1051,6 +1055,8 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
>
>         for (len = prop->val.len; len > 0; len -= 4) {
>                 reg = fdt32_to_cpu(*(cells++));
> +               /* Ingore I2C_OWN_SLAVE_ADDRESS */
> +               reg &= ~I2C_OWN_SLAVE_ADDRESS;
>                 if (reg > 0x3ff)
>                         FAIL_PROP(c, dti, node, prop, "I2C address must be less than 10-bits, got \"0x%x\"",
>                                   reg);
> --
> 2.26.2
>
