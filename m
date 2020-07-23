Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74AEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91AFD2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595535733;
	bh=CNQV4A/gJa9ekEXoraO4Xsym+lJNWuxUV9TZNHOO0MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wSUd+7plRGO7hlgrK8P5IInOtLYC8U9mtrUSVK8TsNgZW2FwsKCI5iU+mj3FJLAMp
	 17PHZxc7HC0fog6G6y8Xgdbhw2G2qaUtA8J9uXI6DB5OJG5WG3fUh2xXzfqw5FH0Kx
	 HRONn1jEO+3D9anSfJnlerQUfAA9G8IjXraK/oKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgGWUWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:22:12 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35246 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgGWUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:22:10 -0400
Received: by mail-il1-f193.google.com with SMTP id t18so5459992ilh.2;
        Thu, 23 Jul 2020 13:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8PtLd/nQS2KeriszStyvu2vlXIzpEo/AUp7+ugOv89o=;
        b=c5V9pqZ90K/QBW8bBNraGN8MI8becA9d6toG6SEjrZvOyX9wjiolgwfMDDjwJvnSZW
         XFNHx2NGvdz4EK2HQqOhXtnTM24yrJvQuVqcF9vXGWdhUUlSKCcpi9LMTzrt2WH+1/j9
         fCVO/jMZd7YWVQJAR9Z5WR72p+PfWahA9prz4PzSr89ZMa+nrl2tSXALkhNAbl5lfERW
         fR4Pb33RroWIJRPg2bGYPI6pX8bTi9LDaxBhX/vQ3aeE77YBK936R/+cF4wcZfV4j0mE
         sYiaxVzobfO6opE1drpx81+9Watml/jQ17UQDsPIYkCzTZXiJ0SLHsJ5/H39nhV+IkuP
         Im8g==
X-Gm-Message-State: AOAM533glWsAof/eo9VChyua2IpwSK5Q8YotXvCQwKTI8kqcKWd34qLf
        cXUFwgfin6apNKxKlqilZg==
X-Google-Smtp-Source: ABdhPJz9ETfckL7Gs2paXfossxHdDkoov3qmWJsBQD6PRGMZvUczCXOPfNMswMcsmYkyKV0QjfdKbQ==
X-Received: by 2002:a92:8b51:: with SMTP id i78mr6376682ild.179.1595535729652;
        Thu, 23 Jul 2020 13:22:09 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u3sm1965948iol.41.2020.07.23.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:22:07 -0700 (PDT)
Received: (nullmailer pid 798999 invoked by uid 1000);
        Thu, 23 Jul 2020 20:22:07 -0000
Date:   Thu, 23 Jul 2020 14:22:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: arm: rockchip: Update ROCKPi 4 with
 4A binding
Message-ID: <20200723202207.GA794123@bogus>
References: <20200722190949.215656-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722190949.215656-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 12:39:44AM +0530, Jagan Teki wrote:
> ROCKPi 4 has 3 variants of hardware platforms called
> ROCKPi 4A, 4B, and 4C.
> 
> - ROCKPi 4A has no Wif/BT.
> - ROCKPi 4B has AP6256 Wifi/BT, PoE.
> - ROCKPi 4C has AP6256 Wifi/BT, PoE, miniDP, USB Host enabled
>   GPIO pin change compared to 4B, 4C
> 
> So, update the existing ROCKPi 4 with ROCKPi 4A binding.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - new patch
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 41f919de1ad4..36057c9e4b83 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -442,9 +442,10 @@ properties:
>            - const: radxa,rock
>            - const: rockchip,rk3188
>  
> -      - description: Radxa ROCK Pi 4
> +      - description: Radxa ROCK Pi 4A
>          items:
>            - const: radxa,rockpi4
> +          - const: radxa,rockpi4a
>            - const: rockchip,rk3399

That's not what I suggested. And this is just wrong as the order is most 
specific to least specific.

This is what I suggest:

items:
  - enum:
      - radxa,rockpi4    # ROCK Pi 4A
      - radxa,rockpi4b
      - radxa,rockpi4c
  - const: rockchip,rk3399

>  
>        - description: Radxa ROCK Pi N8
> -- 
> 2.25.1
> 
