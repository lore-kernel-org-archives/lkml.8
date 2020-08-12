Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EFDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF67C20774
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597262767;
	bh=2VWwmpkVznPunxuAQlBtAZXvL6orBK9iBc7tcjFoXL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XPTnHkSCBe0uAsbVKmB3twsBqZGMoGJm0hrDnT/RMEnC0NS81lvyUMNAHd+DFdLFj
	 sl6gX/IJqR4QyLOfNeRego6QfXLTsY8f4LxqSXvYd4pIwHbAvD/phFyrNBDW18g2ap
	 2VE0nHdhgRRC3CS9H445XeCzDRKoPRE5KjCi/uxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgHLUGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:06:06 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:41676 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgHLUGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:06:06 -0400
Received: by mail-il1-f196.google.com with SMTP id q14so3125839ilj.8;
        Wed, 12 Aug 2020 13:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sdw79P/b8ad4oz6D+MvgiHI8TVk9LcAmrvQU+/ipUlU=;
        b=UbW2jzv01eFaV4+rLDiqgOGCH91SlYp/Hn5d0BoA84Y26WGr6uO2EpJjDHmErr9O1Q
         EhlCle4/uEE1WHTtTs8RkTyfEf41CyfMuDm3x9C1DCeruCysFzXktTQdsWQlkOCl1GR0
         zTTDgoPM4waCsXBRkyCvrbvgHf7WcRWMJpVWvCRYGSb7V/l8c9FyrXoYkbduawQ2JGfR
         PlOdhXYTIrhjQ4/CQEqIm9tX/aYrMSphMQ42OjEsJWNhPDmTg5TLiZvhG7lxWUfN0TZZ
         3xfVvwrtriwllq59++jK3w5o2Df4LXRBNUmr7Sbu/pJ6kHDO2WLs1hGFqap+mg3xhUiW
         6LHQ==
X-Gm-Message-State: AOAM532txzg7drehsm1J+caVUouIUDP/y8DbKKCexnhUzmfN5pdpOHZE
        Zw7muFZkG+5lp9GaFEFwTQ==
X-Google-Smtp-Source: ABdhPJw95pjXXqED1L9WxNpMIlkk/ghd8MNBAHlgMlqvDLcv08qX7/s5+H/BNE5Cd5Z8u3sHKPWkmA==
X-Received: by 2002:a92:cf52:: with SMTP id c18mr1367470ilr.44.1597262764996;
        Wed, 12 Aug 2020 13:06:04 -0700 (PDT)
Received: from xps15 ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u124sm1473531iod.20.2020.08.12.13.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 13:06:04 -0700 (PDT)
Received: (nullmailer pid 2617083 invoked by uid 1000);
        Wed, 12 Aug 2020 20:06:02 -0000
Date:   Wed, 12 Aug 2020 14:06:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: at25: convert the binding document to
 yaml
Message-ID: <20200812200602.GA2612803@bogus>
References: <20200803221206.GA3211829@bogus>
 <20200804063307.10029-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804063307.10029-1-ceggers@arri.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 08:33:07AM +0200, Christian Eggers wrote:
> Convert the binding document for at25 EEPROMs from txt to yaml.
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
> On Tuesday, 4 August 2020, 00:12:06 CEST, Rob Herring wrote:
> > On Sun, Aug 02, 2020 at 07:46:26PM +0200, Christian Eggers wrote:
> > > As there is virtually an infinite list of possible vendors and products
> > > for such type of hardware, is there any value to use expressions like in
> > > the at24 binding?
> > 
> > Maybe so, but there are only 4 compatible strings to document in the
> > tree. That's not a lot to cover and we already have some of them in
> > free-form text. If the infinite number becomes a problem we can always
> > address that later. I'm sure that less than infinite buyers/products
> > will prevent infinite producers.
> 
> Added the following devices to the new yaml binding:
> - Examples from description of previous txt binding.
> - Result of grepping .dts and .dtsi files for atmel,at25
> - Devices I personally use (dts files not mainlined yet).
> 
>  .../devicetree/bindings/eeprom/at25.txt       |  46 +------
>  .../devicetree/bindings/eeprom/at25.yaml      | 129 ++++++++++++++++++
>  2 files changed, 130 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/eeprom/at25.yaml
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/at25.txt b/Documentation/devicetree/bindings/eeprom/at25.txt
> index fe91ecf1f61b..d9ef7dc5fb8e 100644
> --- a/Documentation/devicetree/bindings/eeprom/at25.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at25.txt
> @@ -1,45 +1 @@
> -EEPROMs (SPI) compatible with Atmel at25.
> -
> -Required properties:
> -- compatible : Should be "<vendor>,<type>", and generic value "atmel,at25".
> -  Example "<vendor>,<type>" values:
> -    "anvo,anv32e61w"
> -    "microchip,25lc040"
> -    "st,m95m02"
> -    "st,m95256"
> -
> -- reg : chip select number
> -- spi-max-frequency : max spi frequency to use
> -- pagesize : size of the eeprom page
> -- size : total eeprom size in bytes
> -- address-width : number of address bits (one of 8, 9, 16, or 24).
> -  For 9 bits, the MSB of the address is sent as bit 3 of the instruction
> -  byte, before the address byte.
> -
> -Optional properties:
> -- spi-cpha : SPI shifted clock phase, as per spi-bus bindings.
> -- spi-cpol : SPI inverse clock polarity, as per spi-bus bindings.
> -- read-only : this parameter-less property disables writes to the eeprom
> -- wp-gpios : GPIO to which the write-protect pin of the chip is connected
> -
> -Obsolete legacy properties can be used in place of "size", "pagesize",
> -"address-width", and "read-only":
> -- at25,byte-len : total eeprom size in bytes
> -- at25,addr-mode : addr-mode flags, as defined in include/linux/spi/eeprom.h
> -- at25,page-size : size of the eeprom page
> -
> -Additional compatible properties are also allowed.
> -
> -Example:
> -	eeprom@0 {
> -		compatible = "st,m95256", "atmel,at25";
> -		reg = <0>;
> -		spi-max-frequency = <5000000>;
> -		spi-cpha;
> -		spi-cpol;
> -		wp-gpios = <&gpio1 3 0>;
> -
> -		pagesize = <64>;
> -		size = <32768>;
> -		address-width = <16>;
> -	};
> +This file has been moved to at25.yaml.

We only do this to save updating a bunch of references and there aren't 
any, so just remove the file.

I'd just fix it up, but this wouldn't apply for me on Linus' current 
master. Please rebase and resend (You can want til rc1 if you want 
because that's what I'll ultimately apply it too).

Rob
