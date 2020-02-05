Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB6CC3524F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 07:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2306D217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 07:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="jwf+Qbf1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dJvD9bND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBEHtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 02:49:13 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60285 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbgBEHtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 02:49:13 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 06AD66FE9;
        Wed,  5 Feb 2020 02:49:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 05 Feb 2020 02:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=klnBhs3icmG873ARFeW0I55GIqv
        Bct2WyDKkuastGyo=; b=jwf+Qbf1/dIOpQQPu6d5faHN3Z6Nv1tEzdcooIugMth
        1avbUSzp56VsATlVcfZS4dAfADLi8S4qu/j6jsF7Zb43cVOD/zjIJ3rKAaFIlmjB
        7yE7GKchPOAUw0QAFwXscVn+R8J2xLbSw7mplWO8w4ODugAY/eFEXTmjQSSJi4ir
        R9t3n1+ga5wKgN9dhZgGpA6b1V6S7sRBSRDrbcekZNERahh5kTneYXC1+53SrlBR
        CRlpAJyACUCokmEmQu0RB1gZMl0bdoaYrgIyGVYUP3rfWImjHA/PkRsPAy54uDag
        OSYkxhZNlFbdzy0ABW3VgifxRNK0MfSIkN7mbZQWoBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=klnBhs
        3icmG873ARFeW0I55GIqvBct2WyDKkuastGyo=; b=dJvD9bNDzk98V5EJjwjbLX
        z/jqP7Y8Z4SGado2htR38gfwWtfB9jHHAJyZUvdd0l0Dlaqa5LLY0f6iBDWHqqv2
        ZNZYOuzMod1M5vjBbNjUMnRFqDstAwnK2wROivOVgyeFNznPTGjfLQpOnHgMhnUS
        +OF/Tuv3B1coSez3a2FM5b3Cd4RpOwct9mAwc0vI/2j8N1LnPPGKP6tiZdnKH8ES
        Fn4sbCYM/59xrLrRM19pVhPfW0SNHTM98Qfsz1QrTlhXQUfi52jJEjMBmPtZ1liZ
        XY4yB1hJI/5z0WqqB8wXyh0fLFto0jqby/jBpmSn3AeQf1kjohNqzDOdKjZIf4AQ
        ==
X-ME-Sender: <xms:dnM6XpEULNBgxpV7IuDuGHtWsEwpv4vI8j1lg3kb7G6-VzY-QfuY1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrhedtgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:dnM6Xgt0evq26rLEpnUD07S8oq9BA9S2eDUWqQfmW-FOGo1hdY6UIQ>
    <xmx:dnM6XsmFFPc77gnLfW67-HeRJd-hfQfxPxgdwgEK943FmGAu-CUh8A>
    <xmx:dnM6XgyfuUHKvwyo9-Cc9FXCActuE6qPfkDXSLBnQUqpNXYS5VaHBA>
    <xmx:d3M6XvKw6IGTWtKFAkvMrL3VaXUa2KseZuISM1x1FzF4V0ahHgfzzQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3FBB33280059;
        Wed,  5 Feb 2020 02:49:10 -0500 (EST)
Date:   Wed, 5 Feb 2020 08:49:08 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Vinod Koul <vkoul@kernel.org>,
        "james.tai" <james.tai@realtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 11/12] dt-bindings: arm: Document Broadcom SoCs
 'secondary-boot-reg'
Message-ID: <20200205074908.kwtqadfcwo2mtefk@gilmour.lan>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
 <20200204235552.7466-12-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wa2xbnbegqf4phpr"
Content-Disposition: inline
In-Reply-To: <20200204235552.7466-12-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wa2xbnbegqf4phpr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2020 at 03:55:51PM -0800, Florian Fainelli wrote:
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index c23c24ff7575..d7b181a44789 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -272,6 +272,39 @@ properties:
>        While optional, it is the preferred way to get access to
>        the cpu-core power-domains.
>
> +  secondary-boot-reg:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: |
> +      Required for systems that have an "enable-method" property value of
> +      "brcm,bcm11351-cpu-method", "brcm,bcm23550" or "brcm,bcm-nsp-smp".
> +
> +      This includes the following SoCs: |
> +      BCM11130, BCM11140, BCM11351, BCM28145, BCM28155, BCM21664, BCM23550
> +      BCM58522, BCM58525, BCM58535, BCM58622, BCM58623, BCM58625, BCM88312
> +
> +      The secondary-boot-reg property is a u32 value that specifies the
> +      physical address of the register used to request the ROM holding pen
> +      code release a secondary CPU. The value written to the register is
> +      formed by encoding the target CPU id into the low bits of the
> +      physical start address it should jump to.
> +
> +if:
> +  # If the enable-method property contains one of those values
> +  properties:
> +    enable-method:
> +      contains:
> +        enum:
> +          - brcm,bcm11351-cpu-method
> +          - brcm,bcm23550
> +          - brcm,bcm-nsp-smp
> +  # and if enable-method is present

Those comments were purely for the explanation, but you can keep them
I guess :)

Regardless on whether or not you keep them, for the whole series
Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--wa2xbnbegqf4phpr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXjpzdAAKCRDj7w1vZxhR
xUq2AQDV+M4Nkim7RmuY3y8QYuA2P6xeHBu487XApQ5G8aH+fwEAlmF1WVwn93es
CiiM9/4giVvGZGr3rNoZg/tgdu0GZQs=
=+UYd
-----END PGP SIGNATURE-----

--wa2xbnbegqf4phpr--
