Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E944C2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C882176D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589336382;
	bh=cuvDpkB2QWLR2UzPAOMHb2hamXNutcEhq4Z3EdP/gD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Up2KG3V/U3O1DOwvdvCUv0vWBPugW+fFgSKO1L6mZMBgs8CcdL8Tzz56J+IzxisRf
	 4k1EAmhQc7Ls3QGz75s3iVOLV21ZsCJJfo0D4+0G3gPTdVR8gXxhqEGnX4Z4/MZaHD
	 6xDQsq/byViirajg1x8Sjr4UF5rH4YmAj+bjAWlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgEMCTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:19:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39141 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgEMCTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:19:34 -0400
Received: by mail-oi1-f195.google.com with SMTP id b18so20132823oic.6;
        Tue, 12 May 2020 19:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hVIvDXLUWV7kCm1sjwCAhS0B4yNvu2YKfopgdqGQAZM=;
        b=DNz9MLmAEAmyEayY0k9/L8yyDhKkZmSuIK7e/2cO4AhxMI71EBeAiS/xtdgZEDC/xs
         39OGn5AAtG3ToF3BEZCIqYykLAkyAgaIyNdYnhctyS3EjWt/HSyxJWvrvCvTLzXc+7y8
         u7HKuUjsoz2dlc3rL0WPKYNcw9WD1RWuIEnv4EzWAL7ufcsVKdfuUDYVkA+lVOrp0+89
         wVJjpqP4OLc5avLuCBJEeSMKKAjrY5JS2hIt0QHs/gPzZVsZjdzF88v8S8Lvl4hnkQTV
         teA81iEmHMUY/pNeBYV5KZcvL5BS7atPu03YUtLDrDdoPRubGGlVCa4IKaci82qp4+PS
         BIWA==
X-Gm-Message-State: AGi0PuaSmxxSoPMXOYonUMVC7OulY5kJfDAH0n9QIkRHQDyEiFeGayp6
        qQR5cDZfUhs4JUd4QL4W9A==
X-Google-Smtp-Source: APiQypJpNb4ewDOcjTfOthSaYZtYSP9GLgvpWY9I43vl5aq8csUZu6D+yKwBUHo5BLkimepu0pqGvw==
X-Received: by 2002:a05:6808:24e:: with SMTP id m14mr24102696oie.116.1589336373601;
        Tue, 12 May 2020 19:19:33 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h24sm3910147otj.25.2020.05.12.19.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 19:19:33 -0700 (PDT)
Received: (nullmailer pid 15333 invoked by uid 1000);
        Wed, 13 May 2020 02:19:32 -0000
Date:   Tue, 12 May 2020 21:19:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alain Volmat <alain.volmat@st.com>
Cc:     wsa@kernel.org, mark.rutland@arm.com, pierre-yves.mordret@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
Subject: Re: [PATCH 3/4] dt-bindings: i2c-stm32: add SMBus Alert bindings
Message-ID: <20200513021932.GA9172@bogus>
References: <1588657871-14747-1-git-send-email-alain.volmat@st.com>
 <1588657871-14747-4-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588657871-14747-4-git-send-email-alain.volmat@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 07:51:10AM +0200, Alain Volmat wrote:
> Add a new binding of the i2c-stm32f7 driver to enable the handling
> of the SMBUS-Alert
> 
> Signed-off-by: Alain Volmat <alain.volmat@st.com>
> ---
>  Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml b/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml
> index b50a2f420b36..04c0882c3661 100644
> --- a/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml
> @@ -36,6 +36,10 @@ allOf:
>                  minItems: 3
>                  maxItems: 3
>  
> +        st,smbus-alert:
> +          description: Enable the SMBus Alert feature
> +          $ref: /schemas/types.yaml#/definitions/flag
> +

We already have smbus_alert interrupt. Can't you just check for this in 
the slave nodes and enable if found?

>    - if:
>        properties:
>          compatible:
> -- 
> 2.17.1
> 
