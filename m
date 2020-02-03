Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D345EC3524F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA60120842
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="OG9KdFGA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KhGuh51D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBCIeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:34:07 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33003 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbgBCIeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:34:06 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E370B5E0C;
        Mon,  3 Feb 2020 03:34:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 03 Feb 2020 03:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=nLBFK/U/9FVj2QhUZ4f3HwAHrai
        1iMWaFonW+4I4K0c=; b=OG9KdFGAiPq0zqE/PDLHzu1MLCGdRi5KiJW1u+ArHue
        X8Cs0pIji51zAxpjmMPvWvOlDd28+5Bo7tdaZeGe4U5rdFxXc5HuKqUL6p749jEl
        JQZ0XCuUw7Qf/EB28byQEkOSBc0NrJaLdLouUPJjMCWC7jQQsKrB/RnPvHtiRJhN
        Pe+4PGzpsoKA2yopk8rauKZzAmRb5R5fTL6MxtsJk2pMtNUEhGGMw5Tmh1JCAVIS
        3yGzEEPTmNp/4lWMuoZZEksiXJKj//ITOJ7Vw6kcl8eEpSYNcHHA2BNz1xOmd+xq
        0xQc/yX4vTUitoQRR8+1NQeC31Ifkm6jIe+bPMkKtXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nLBFK/
        U/9FVj2QhUZ4f3HwAHrai1iMWaFonW+4I4K0c=; b=KhGuh51D/CSZ65vh1myQT8
        n4080jUEBAfLd6IDKptRu95IDkPM5XEfSD8lPiB7ZAzD6Dy2leIjyjsR0jz6fuUp
        h2ct+PLKYSsSPvDe+XoH0/DBuMqMNq1fgm/z+TBJ/kzbk05jTtRTkSe2riHhoGhb
        pFzp2SbYzeinjEG2BoWe5cphHewZMzKPngWenRByJbA6EDJK1aB/ix8GP621p9Mo
        JwYm3N3dzmNWSLrMCASiMRM2NghrKnI4Bd0IrmRPp72pPAUu0VkgwfAQn5ApInio
        ga/7VwIW93BfrelbNqsXcbYdwxjjcBbSAPhK+MjRgYFP3ktQe2sdUP9NkD8+Mzsw
        ==
X-ME-Sender: <xms:_No3XvOvOla3tF1qtF3HMGkOBEqVEfLW2waWH19XXLvY6i-BtBNZ9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeeigdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:_No3XmQpwCAipjGOIXx6hkjModXzQzO7vyowyRZLL9dbwyUyKBnfzA>
    <xmx:_No3XhCBMIa7P20bA78hxrNE-hxojAIWbTuGyKYQ0qS4rweRgpS1gw>
    <xmx:_No3Xljz7mk0H9yOHbdQx_AwufJ75RTzT2FDMov30urE1_EqS_cZUQ>
    <xmx:_do3XokOnmeCMkCr77nfM_bhUWmqivs3Zjnyk0eczQy-rDl7et9_ug>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 98B763060187;
        Mon,  3 Feb 2020 03:34:04 -0500 (EST)
Date:   Mon, 3 Feb 2020 09:34:03 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lubomir Rintel <lkundrak@v3.sk>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH 11/12] dt-bindings: arm: Document Broadcom SoCs
 'secondary-boot-reg'
Message-ID: <20200203083403.6wmuduxqsv7quujp@gilmour.lan>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
 <20200202211827.27682-12-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200202211827.27682-12-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2020 at 01:18:26PM -0800, Florian Fainelli wrote:
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index c23c24ff7575..6f56a623c1cd 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -272,6 +272,22 @@ properties:
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

You can make the requirement explicit (and enforced by the schemas) using:

if:
  properties:
    enable-method:
      contains:
        enum:
	  - brcm,bcm11351-cpu-method
	  - brcm,bcm23550
	  - brcm,bcm-nsp-smp

then:
  required:
    - secondary-boot-reg

Maxime
