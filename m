Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE57C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 13:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2031820684
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 13:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="BPaJKluO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmrHIqVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBVNyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 08:54:41 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42205 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbgBVNyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 08:54:40 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 61127769C;
        Sat, 22 Feb 2020 08:54:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 22 Feb 2020 08:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=0cjuZ1FokHkr7VejpQgGbhNPCo9
        LC+1ql4eCmuopToU=; b=BPaJKluOePR8Oz0j8SQsF0RzdUX63vXBAdpjPvQxBaV
        +T8U58SaAuHyzcwBJ4EnIEphJa8oKLu335NJNY/cwj5h6m9gV7+NvmFblXQiiWZP
        CtQPYvEVLO733sId5cESKvaY7NF1JvrRQHhOxBlFHgeKjLzd9lnhXTFIEIsPh6No
        Ix5CcfNPwA9xOEBgGAGCsF44v6YNQAMvqiGTimQ6b0Ew02L2XikrfGv7mdJ5RvUX
        LIcG28M7isDk+8jynWAxkAMLy0mGfSWNP1WgAejdYLHhSsWQGj1LnnyXDEzqppHb
        bJvThNoDwvZH4Lmrqw3AqiROZdyOSTwhDAS1tRz0b9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=0cjuZ1
        FokHkr7VejpQgGbhNPCo9LC+1ql4eCmuopToU=; b=kmrHIqVXqpghKYGvb1jPMG
        Rsuf5H8GhfRr8lJE4m3GwMRvhvQoCVEmujBVwOKunCCQ7l3DqTszKh3f4zPpUnIG
        TFoA8a/vfHZTgfuhsisT6nfBlQHR48cY6jw6zKnMS0dURebqauhE0W4L8rmZa8XE
        aCXn4i9+s7Bd+VV6akY/3ySSR6hlECMUVXtHSwcbx6w1iokfMRS0CFHxKs++kgRx
        qNajrqHax8aBhGlCPQHcD9XrdaYEC7AcuTI0j40Qa0SsAHYRsiCPGQUNlq0lab+8
        8I0b4Gb2poi1rdZIdTyRSihLRZ152LJ4IbwPPtNlBd5I2xGrjhguV3pkhH7IAxRw
        ==
X-ME-Sender: <xms:mzJRXuSELrfvd7cQNfNxA6mQN3HzEKbZnkqA08SeB-eLBsFue5Nsow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeeigdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:mzJRXnRSJWs-rkG1TDQY3sIzkiTiOg06Oo2s7eJEX9IA3LaDWIqN8g>
    <xmx:mzJRXkX6-YfnuyXmJr34XYNzLay0onPMOcBsyZD--oG9CzOnWyIKGA>
    <xmx:mzJRXs0p4NeA2aVnWzQZPf6_D_Vwa6Dsob5kUDcFftqd5-7661FE6g>
    <xmx:nTJRXkYaCFvFs62KLk55rsr1R7oQLe9aqOyzQS1ggtPG7hkcJojTjQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A18A23280059;
        Sat, 22 Feb 2020 08:54:35 -0500 (EST)
Date:   Sat, 22 Feb 2020 14:54:34 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Vinod Koul <vkoul@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] dt-bindings: Fix dtc warnings in examples
Message-ID: <20200222135434.xou7zhix4u6vymbc@gilmour.lan>
References: <20200221222711.15973-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221222711.15973-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 04:27:10PM -0600, Rob Herring wrote:
> Fix all the warnings in the DT binding schema examples when built with
> 'W=1'. This is in preparation to make that the default for examples.
>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime
