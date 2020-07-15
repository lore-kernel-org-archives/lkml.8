Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38798C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176EA2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594837161;
	bh=taJ+5KPPgh1D4VQJC+LpzEH18ropvCeO2aSQWXX/F30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C2teMMi4MQh8ZrQ0zm+q3F4sG2oY16TW5bXKrYWVxf40k3IDxhqKWKY77wNFLShLh
	 5yDdKfdU9jSZKmLyT9ppuZcKr5vNEJfwIAxFnVSOGFfczJGm3zzLa7H0uNEvltCsPe
	 c4oreDsXoLjlLtbuc1srkqk5CVflq2LMyoVP680o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGOSTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:19:19 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41554 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:19:18 -0400
Received: by mail-io1-f65.google.com with SMTP id p205so3248249iod.8;
        Wed, 15 Jul 2020 11:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qir7BYEt1ePlYcSc9kQBoolo/NmI427EpRk3jCnc0E=;
        b=MAMZCEyepTv0b0HymYM9Pt5xXg3EkaTRQOxe5Ec+mPPsIURDQaEDeO3jlLa7mxYqMA
         bvTENVFP/SLmQPzmMrKM5gh9x50livFPdiaUmAyDcj+uzJHrvWArmGTNqUQUpD/SHpsD
         fXAK4BIsT6u5524M8xDCXaYZew/CZGBp39X8S+3hak7cmkOM+caafEL91Wyo7IJh38xk
         mDPkA7LXNGlqS4mVPMCg75+oBIrF5Abh9zL2AJRT/pCGcog8dIqffpzCD7LCJEgjF59J
         QErn2OisfbYQsd7JlA9VjNYZ1veXN8swsLvo7XewKOLwil+Ey5fUdQIIT5nRJHrvQeTa
         2coQ==
X-Gm-Message-State: AOAM532k0gsgn5zO9TWmJBT4B31Os+cpTnpfR2XO+oJkbZfu4DxMNN5n
        r5TYmx71R4uO7IcJj9/v5w==
X-Google-Smtp-Source: ABdhPJy+MnYJTQwPRpfYQ3APxYiqsDRIvjF899R10bA6VgiAK98fT5sRURp5v0MVa13LsRx2/1boXA==
X-Received: by 2002:a5d:8ac3:: with SMTP id e3mr575726iot.9.1594837157634;
        Wed, 15 Jul 2020 11:19:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t11sm1437942ils.3.2020.07.15.11.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 11:19:17 -0700 (PDT)
Received: (nullmailer pid 557898 invoked by uid 1000);
        Wed, 15 Jul 2020 18:19:16 -0000
Date:   Wed, 15 Jul 2020 12:19:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 1/6] dt-bindings: connector: add power-opmode optional
 property to usb-connector
Message-ID: <20200715181916.GA551920@bogus>
References: <20200615161512.19150-1-amelie.delaunay@st.com>
 <20200615161512.19150-2-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615161512.19150-2-amelie.delaunay@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 06:15:07PM +0200, Amelie Delaunay wrote:
> Power operation mode may depends on hardware design, so, add the optional
> property power-opmode for usb-c connector to select the power operation
> mode capability.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../devicetree/bindings/connector/usb-connector.yaml  | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 9bd52e63c935..cd7feb2d4984 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -88,6 +88,17 @@ properties:
>        - device
>        - dual
>  
> +  power-opmode:
> +    description: Determines the power operation mode that the Type C connector
> +      will support.
> +    allOf:
> +      - $ref: /schemas/types.yaml#definitions/string
> +    enum:
> +      - default

Wouldn't this just be no property?

> +      - 1.5A
> +      - 3.0A

You'll need to explain these better.

> +      - usb_power_delivery

I would have thought 'default' would be USB-PD. Though I thought Type-C 
was always USB-PD. 

> +
>    # The following are optional properties for "usb-c-connector" with power
>    # delivery support.
>    source-pdos:
> -- 
> 2.17.1
> 
