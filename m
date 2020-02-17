Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5D2C761A0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371FB2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="EAuUGbIu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lik8Lr7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgBQJO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:14:29 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57169 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728272AbgBQJO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:14:28 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 23E8158D9;
        Mon, 17 Feb 2020 04:14:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 17 Feb 2020 04:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=I14qqSa44pqibysylqjnJvoStph
        owXN60qAH0HmIOOk=; b=EAuUGbIuhZh0DXzoXVHHztJTrb8eBm2mp9htdM6LVn/
        B4yzXZmGWryVzz9Fw8WCCnvJumnVY1EdR78GNUh9O/S4NzDZzeMieTUCK+KTLW95
        9SXL7yIrbv0MrpjZzRs29MBVa7AAey6KOVjkCrfMeTlGgOe29OomQ5W/3KhfdHEB
        2I5CkHHJpJ+tiQe+1huTRXXvfla2buzQbUWGLEtd0QpruMmX4P4tic+4rr3m9nZR
        uZ9HhmwQuWxJ/wYeKwtRGMLIMSsceuTg/J4y8PryN/u62SBmoP4ldSsAPytMHtuX
        aeXiNViClRaOK4gHgmwfPvbuadUde+HnJEY36xUeGRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=I14qqS
        a44pqibysylqjnJvoStphowXN60qAH0HmIOOk=; b=lik8Lr7RVQqNSV3aPYfoUp
        H90Xt8Fpw3L2KIrMaoRynRmRd9D9C24cDxR8GAusJRkQEwWT2rHg7d+m4wOdyBcu
        AXthhxe+m8akQCKbyUJEdzv2aHGTXaQqxDXR77IqiiC4s0fvzgLT/PtwpMKItwYZ
        h3qtxU10iXxprv/nPOY5AR3ekqWqrWNy86YDf85SGHiO4MK9B+qmW8d3UeSfYPw/
        6xcdTni4SXTveWcYtzegbp3NmNPy5CSl8Q2Vdq+f2x34PWZQ+3IG8eADG9cQU4hs
        G8+ZgJXCvqIhg/DYfdqlGlgIRzv/Tne7gU2+J3Kdswk7PZcIaeA+2OgCtz4YGSrQ
        ==
X-ME-Sender: <xms:cVlKXg51H4uoiVdRpFvbxv5WaiiJHys340EmbcV2izrGll7g2Mp8eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:cVlKXjjKhtDjlU7U-ryVkWl9vjdPNTrE9gGOjfgHuR5pNC-o8u0TsQ>
    <xmx:cVlKXuITpIJ3ig2bMMiZbsUXKDTNM7wC1G_wEqOrfpQOLSOyqN_IXw>
    <xmx:cVlKXtraCBKH8gXKGfliAISdaG5b0xo3twF3iliEFo1SKbIXb1_DqA>
    <xmx:c1lKXgelgsQq-uTX3XtfZK319DHI1tQY9w1Fd2bvLlqtsutqVCD8oA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 83F823280062;
        Mon, 17 Feb 2020 04:14:25 -0500 (EST)
Date:   Mon, 17 Feb 2020 10:14:23 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?utf-8?Q?Myl=C3=A8ne?= Josserand 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/34] sun8i-codec fixes and new features
Message-ID: <20200217091423.y2muniz3hosquho6@gilmour.lan>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 17, 2020 at 12:42:16AM -0600, Samuel Holland wrote:
> The sun8i-codec driver, as used in the Allwinner A33 and A64, currently
> only exposes a small subset of the available hardware features. In order
> to use the A64 in a smartphone (the PinePhone), I've added the necessary
> functionality to the driver:
>   * The full set of supported DAI format options
>   * Support for AIF2 and AIF3
>   * Additional routing knobs
>   * Additional volume controls
>
> Unfortunately, due to preexisting issues with the driver, there are some
> breaking changes, as explained further in the commit messages:
>   * The LRCK inversion issue means we need a new compatible for the A64.
>   * Some controls are named inaccurately, so they are renamed.
>   * Likewise, the DAPM widgets used in device trees were either named
>     wrong, or the device trees were using the wrong widgets in the first
>     place. (Specifically, the links between the analog codec and digital
>     codec happen at the ADC and DAC, not AIF1.)
>
> I tended to take the philosophy of "while I'm breaking things, I might
> as well do them right", so I've probably made a few more changes than
> absolutely necessary. I'm not sure about where all of the policy
> boundaries are, about how far I should go to maintain compatibility. For
> example, for the DT widget usage, I could:
>   * Rename everything and update the DTS files (which is what I did)
>   * Keep the old (misleading/wrong) name for the widgets, but repurpose
>     them to work correctly
>       (i.e. "ADC Left" would be named "AIF1 Slot 0 Left ADC", but it
>        would work just like "ADC Left" does in this patchset)
>   * Keep the old widgets around as a compatibility layer, but add new
>     widgets and update the in-tree DTS files to use them
>       (i.e. "ADC Left" would have a path from "AIF1 Slot 0 Left ADC",
>        but "AIF1 Slot 0 Left ADC" would be a no-op widget)
>   * Something else entirely

I'm not sure this is really a concern here. We need to maintain the
compatibility with old DT's, but those will have an A33 compatible
too, and as far as I can see, you're not changing anything for that
compatible, so we're in the clear?

If not, then the third option would probably be the best, especially
since it's only a couple of them.

Maxime
