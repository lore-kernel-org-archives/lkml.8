Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7074C35641
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5902206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582518986;
	bh=/4yI/EmjrZA0BYlRei8XKfUb9S0CAu/7EaLhXrGl1ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JEyugRXR1W7SodA39FVcD5+czKsNyPeqR+BMg1JKZSAKKXoNtN5QKVQQGu/emPhLS
	 ayW52s2QA/42SDqGZUBjEf7TPGD9S4ewj688RECCp1tQzAzTLFaKsSgMYuVps4snqG
	 wEORNX2eF4QRdbpxUZ+4MnPXnapg2O7nlWZznrw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgBXEgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:36:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbgBXEgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:36:25 -0500
Received: from localhost (unknown [122.182.199.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F62C20658;
        Mon, 24 Feb 2020 04:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582518984;
        bh=/4yI/EmjrZA0BYlRei8XKfUb9S0CAu/7EaLhXrGl1ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lvn3yXXeFP97NyX/cctvAFkNpXvDs5frfR5b2WU+WX48PSjNSjq4heS4n+XRb/06h
         Mef1kqZSjAGz78wE7IsrHpbECrGo39ABGQnKLuSsstTPLrcGKITFibkbqgW+9FFAtz
         geKvomcOZGuenkEti1zgBFSVxWIQ4iJbWCi3jENo=
Date:   Mon, 24 Feb 2020 10:06:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
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
Message-ID: <20200224043618.GR2618@vkoul-mobl>
References: <20200221222711.15973-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221222711.15973-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-20, 16:27, Rob Herring wrote:
> Fix all the warnings in the DT binding schema examples when built with
> 'W=1'. This is in preparation to make that the default for examples.
> 

For this:

>  .../devicetree/bindings/dma/ti/k3-udma.yaml        | 14 +-------------

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
