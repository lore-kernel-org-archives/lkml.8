Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8B3C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16C82078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589229305;
	bh=wZu2QvR91WC41QmzoIY8JNxlOBqCk1UY+9nOgrl0Y6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2CoADTpKq5rv8wd4yXXLPfExP3OBmBj9D3Z/lP/Q9fHEt5E+yT1mJsy5FtVNVkj9k
	 qZAgM1hZkneU6+wS7EuKP8kDL9gZYzPZIncNpGugFXGJnZ7+lGGpz67GAJEkunoJUh
	 ijK0Voh0tBa0jo+6YeP9z1q5nEAGQDLvOUudw6SA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbgEKUfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:35:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43341 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:35:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id j16so16281447oih.10;
        Mon, 11 May 2020 13:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xPfARJBDe31edRqTmB22eqqJ1jCXSCt4soTep9+eCZE=;
        b=I3feRbee1STlb3Rm82R2kiNQj+ZBEHmm5dfpcX0CGR32SIzX3MEBRcYiC+WFuLk8eo
         ZZKAmlyK/kUcZ2K1TyQntfaGIP46H1wKL2nQ4LqSlmRFNOXWSS6ceAiMJy02a2g6iBQ9
         YDTdvAGeFYIEQ243RGt5YXfM66y4bcSxwy9vL5o066SZbkvH5JBhneU5IyKH/ymgT+8y
         fsGjdcKN940bS+/XJ62nD9oRvPpyb4rgPOJtjy6PBWU0Lr04pDi5DYwBqDYK/qkXBKnH
         dQvquvJgDKQInlbusEpYRcf5C411lG9BhU/X6rmKtdVd3fPhRuQ+pNSR6EntiUCCsbR8
         tAjQ==
X-Gm-Message-State: AGi0PuZUrCLP/Nx+RwYfy5lD5+6gRkDg/Tm9WkE5brEj4LelOc+UkGVp
        DnrxKhkArVk3iHePTsA2d5oDEGc=
X-Google-Smtp-Source: APiQypLhCz0Iweh6mDeRxFs1JldCYPCWFDZ/eWcgs5VYLylwJuEA3ROhRph1lzQha6aqqe17WNMHUA==
X-Received: by 2002:aca:5643:: with SMTP id k64mr19984093oib.152.1589229303517;
        Mon, 11 May 2020 13:35:03 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y25sm1875229oto.29.2020.05.11.13.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 13:35:02 -0700 (PDT)
Received: (nullmailer pid 32429 invoked by uid 1000);
        Mon, 11 May 2020 20:35:01 -0000
Date:   Mon, 11 May 2020 15:35:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        shawn.guo@linaro.org, p.zabel@pengutronix.de
Subject: Re: [PATCH v3 2/2] clk: qcom: gcc-msm8939: Add MSM8939 Generic Clock
 Controller
Message-ID: <20200511203501.GA29988@bogus>
References: <20200423103406.481289-1-bryan.odonoghue@linaro.org>
 <20200423103406.481289-3-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423103406.481289-3-bryan.odonoghue@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 11:34:06AM +0100, Bryan O'Donoghue wrote:
> This patch adds support for the MSM8939 GCC. The MSM8939 is based on the
> MSM8916. MSM8939 is compatible in several ways with MSM8916 but, has
> additional functional blocks added which require additional PLL sources. In
> some cases functional blocks from the MSM8916 have different clock sources
> or different supported frequencies.
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig                     |    8 +
>  drivers/clk/qcom/Makefile                    |    1 +
>  drivers/clk/qcom/gcc-msm8939.c               | 3999 ++++++++++++++++++

>  include/dt-bindings/clock/qcom,gcc-msm8939.h |   27 +
>  include/dt-bindings/reset/qcom,gcc-msm8939.h |   10 +

These go in patch 1.

>  5 files changed, 4045 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-msm8939.c
