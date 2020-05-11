Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEADCC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6A320882
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589233652;
	bh=vkDdbbEy6MDNO8gZtGeK75dnppeu60N3UXzwgEKCMug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HvkfWm2RQebaxMb4Br5Nqv44Ic4Sa7xOw56jsCHhCLXWizcPCQzuCPGkGNB1bawBv
	 RMoNk1H07CyNvJZ+RauSiJYpobi7iflLfrMNlf6SyuSI4uQ2kTU/HyVDgm9ptbOY/K
	 JRXUXo+qVWdsSZ3Q24KgjM4MnqHnkXkDtPe5vtY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgEKVrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:47:32 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43812 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgEKVrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:47:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id a68so363423otb.10;
        Mon, 11 May 2020 14:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kr536AH92tCs886e1ZVZycHlp8zzTbbAYS9sSy9+r90=;
        b=C7CU+9iklE7uWgSyZqpkn0Mmp9A8eVC2djzpQol9E+yuAj9dR3UuNIAaP2E8vnJcnB
         DdZKvlU6BWNc+XCRRETXpMbfJv+QGX/2CFiX0diX5/Lbpp0e4TMVUIbYI1OhKlIdqpux
         I38dprvehVST2WNUviRkyIOx9haLK9CxtLSEnn944tmRKVLvrlpdGU5zeijN40CeIcPF
         bvposrPlj4YrbURGrcdTId8rNTVrykyZYALsvg5k63KxtICi1Wm3NOLy4XVGyWqvXUFq
         QfHfW6IZD67l8Tno/MiZs5525IP/au6fMXYoT5wPfcxkz8lOrPAF50sbdbYPGuZHDCHZ
         181Q==
X-Gm-Message-State: AGi0PuZNR9oURXF1G6q8BvUdZUSrgWbOWIpCzWBuA1zXw2tswn/aYpiK
        zFfVtJR5T3bFRZ7N7ML1WA==
X-Google-Smtp-Source: APiQypL9c25jA4qb587PTmaLEbxVx0mD5FwZCOgGZkDio2qGfy6/FFbMg2/4qBhezaAEnuubpNLpxA==
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr14832489otr.318.1589233650111;
        Mon, 11 May 2020 14:47:30 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l187sm4956929oig.0.2020.05.11.14.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 14:47:29 -0700 (PDT)
Received: (nullmailer pid 4611 invoked by uid 1000);
        Mon, 11 May 2020 21:47:27 -0000
Date:   Mon, 11 May 2020 16:47:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/91] dt-bindings: clock: Add a binding for the RPi
 Firmware clocks
Message-ID: <20200511214727.GA20924@bogus>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
 <69e869b0a79ea17f2cdb79df986409963672495a.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e869b0a79ea17f2cdb79df986409963672495a.1587742492.git-series.maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 05:33:44PM +0200, Maxime Ripard wrote:
> The firmware running on the RPi VideoCore can be used to discover and
> change the various clocks running in the BCM2711. Since devices will
> need to use them through the DT, let's add a pretty simple binding.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> index cec540c052b6..b48ed875eb8e 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> @@ -22,6 +22,25 @@ properties:
>        Phandle to the firmware device's Mailbox.
>        (See: ../mailbox/mailbox.txt for more information)
>  
> +  clocks:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: raspberrypi,firmware-clocks
> +
> +      "#clock-cells":
> +        const: 1
> +        description: >
> +          The argument is the ID of the clocks contained by the
> +          firmware messages.

Not really any reason to make this a child node. The parent can be a 
clock provider.

> +
> +    required:
> +      - compatible
> +      - "#clock-cells"
> +
> +    additionalProperties: false
> +
>  required:
>    - compatible
>    - mboxes
> @@ -31,5 +50,10 @@ examples:
>      firmware {
>          compatible = "raspberrypi,bcm2835-firmware", "simple-bus";
>          mboxes = <&mailbox>;
> +
> +        firmware_clocks: clocks {
> +            compatible = "raspberrypi,firmware-clocks";
> +            #clock-cells = <1>;
> +        };
>      };
>  ...
> -- 
> git-series 0.9.1
