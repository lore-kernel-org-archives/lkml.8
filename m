Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59870C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE33208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="gEWMwmOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgIKBeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 21:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIKBeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 21:34:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C84DC061573;
        Thu, 10 Sep 2020 18:34:02 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i22so11563147eja.5;
        Thu, 10 Sep 2020 18:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zul1Nw9Eq2BdOpetRpWHxzz4+/VY91T8rqh4YA+EBic=;
        b=gEWMwmOrbB/LYJOtJWKIPzwH6SGa/CfYkilzx1UOv3nDPHNrqMURijPx+S+LNyZS9s
         g5YGaNLua3+1IFMr6UjmNZ+zZB03PYIR4vwT+XMxr1qbXF8Pvz/4BFZeAt54rm+HRZO5
         z4muUw8+DXycixI0L1n2dJx2KciCMIiDNf05g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zul1Nw9Eq2BdOpetRpWHxzz4+/VY91T8rqh4YA+EBic=;
        b=dAicJnB07s3h3SjKa8YeZDAFO6GRTmaH4daqTApV4FgnSs39igrACLsrvywjv1zBep
         UkU8nyP6z42pjTxZvsD5hQZ2rXxSrVHoim2u+t0DRCxzLT56uACRbmH7yXwAjbeK5Jtq
         0t8XLsegvT5uqfmUiQQHlXtjVtGuvig01U4W9NdTdUbC9RwgHRyDII1/NldXhO2opmas
         l4ybrzDguO+T8pk90ZS/by4eAD+ivKK0KAT6/gItfYlOdNV+gQD6FdhkKcgqgLCjNsfw
         sZFI/O4LpCJK1GXM5u46uWK10kLkQ7jEXHJbGobhkQiN1a5iKecittc/o+R0Ao4hNc9T
         QVzQ==
X-Gm-Message-State: AOAM5331NRL1nebI3RtP3ylJIRfSNHVcuC6Q5NSgJN+l/exDa+ndQqQy
        B3lJeEMBekrHa/ZubaJ+3X3IlJBbYtr5ycHbYeQ=
X-Google-Smtp-Source: ABdhPJx2ir+MlnMFHJUzyxfU0Dt11F/+kuo/3+cMlKIRJNz0n3WGSvpgprWg3nu2Xy48NKFqcDLAQWy5mIVP/T7J0Q4=
X-Received: by 2002:a17:906:b6d5:: with SMTP id ec21mr11272409ejb.396.1599788040951;
 Thu, 10 Sep 2020 18:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200910151840.25333-1-eajames@linux.ibm.com> <20200910151840.25333-2-eajames@linux.ibm.com>
In-Reply-To: <20200910151840.25333-2-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 11 Sep 2020 01:33:49 +0000
Message-ID: <CACPK8XcywanG8BN0-0a41CeTJEAb89OR7SnsPRgbddaC01vO-w@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: clock: Add AST2600 APLLdivN definition
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        linux-fsi@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Alistair Popple <alistair@popple.id.au>,
        Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 at 15:18, Eddie James <eajames@linux.ibm.com> wrote:
>
> Add a new clock definition for the "APLLdivN" as described in the
> AST2600 specification. This clock is simply the APLL divided by a
> factor defined in the SCU registers. It is the input to the FSI
> bus.

Ah, that's where the name comes from. Would calling it APLL_DIV make more sense?

>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  include/dt-bindings/clock/ast2600-clock.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
> index 62b9520a00fd..5a9ae0a1d574 100644
> --- a/include/dt-bindings/clock/ast2600-clock.h
> +++ b/include/dt-bindings/clock/ast2600-clock.h
> @@ -87,6 +87,7 @@
>  #define ASPEED_CLK_MAC2RCLK            68
>  #define ASPEED_CLK_MAC3RCLK            69
>  #define ASPEED_CLK_MAC4RCLK            70
> +#define ASPEED_CLK_APLLN               71
>
>  /* Only list resets here that are not part of a gate */
>  #define ASPEED_RESET_ADC               55
> --
> 2.26.2
>
