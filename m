Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED40DC35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F6220828
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582329420;
	bh=fk/YQP5SqHC5/xALq1lEjx5wBLsm/IH4cAaLZzmHAPg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=r0dEzG/nqAefRDIlhmCpRV1fEK4xj5nw/nUHDr/juo7jhfHFgNqZzzvwICLb+HsvA
	 JAUEk6OILHMGcpCXqpYB0KqTrPdf/8DRxzTNxNJ3/s+PpxxXZXxPS6ImmtGsgzqQkt
	 /OxbiYFVyQgSV76mJ4oJ2o3wqcIe8Md71Jg+O8aA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgBUX47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:56:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgBUX47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:56:59 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92CFD2068F;
        Fri, 21 Feb 2020 23:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582329418;
        bh=fk/YQP5SqHC5/xALq1lEjx5wBLsm/IH4cAaLZzmHAPg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AEHESv3Zesc1BEyLLdYIsRbTzzExMjve9OEYjVQMyIhVZhH4lGOD//LeI/S+b+VQX
         /MHAgApH+QG36Lfy+/CQkiGw0yjV/FQqDmEjY4xULd/u3JDq/8L1W42uHRAT8klh/b
         UPgH6+KFUtvVb+Ur/DIW4UQSvxquZUGJN2IAI4ek=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200221222711.15973-1-robh@kernel.org>
References: <20200221222711.15973-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Fix dtc warnings in examples
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
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
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Date:   Fri, 21 Feb 2020 15:56:57 -0800
Message-ID: <158232941781.258574.300391553464223520@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2020-02-21 14:27:10)
> Fix all the warnings in the DT binding schema examples when built with
> 'W=3D1'. This is in preparation to make that the default for examples.
>=20
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
> ---
>  .../clock/allwinner,sun4i-a10-osc-clk.yaml         |  2 +-
>  .../bindings/clock/allwinner,sun9i-a80-gt-clk.yaml |  2 +-

Acked-by: Stephen Boyd <sboyd@kernel.org>
