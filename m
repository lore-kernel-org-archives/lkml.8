Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4A2C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C39420722
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587523880;
	bh=I46/5F1aUhtPqz6RdGMRl7ho5eerZkpYwLtKJ6Bog4s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=UFv/9pLsl3d6f4zVzIXMi7JUg1n9PTKZALsHqjxcgCLmkpbKOEkkloXNKky7o1ysi
	 xQklke/LunuEVR7JGXdse2olUeTeDFW5htok07MN/KzVgJhBsyh0UxIEWrUCTw+fyl
	 JaVaqi/o7jByo62ixvD21GBHCtaoQe6a8V7rakyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgDVCvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 22:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgDVCvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 22:51:18 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CF7D206D5;
        Wed, 22 Apr 2020 02:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587523878;
        bh=I46/5F1aUhtPqz6RdGMRl7ho5eerZkpYwLtKJ6Bog4s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=n8zLV8et2rtyCIgt8Kb8RALMswehb3MEUvs1roN3a+0v1+uL6/JuBG9snFRzdmd50
         lUxE1L73AcX7dBbg57T/lC5fdwvoehLifnatAmciOmrzqvhHu+MABoTVYjvfR21dZh
         p6BhyTQzp8DP3vsCtztdxlW9SoLtNDLk879kfIzA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200419121808.440780-3-bryan.odonoghue@linaro.org>
References: <20200419121808.440780-1-bryan.odonoghue@linaro.org> <20200419121808.440780-3-bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 2/3] clk: qcom: gcc-msm8939: Add gcc-msm8939 driver by copying gcc-msm8916
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        shawn.guo@linaro.org, p.zabel@pengutronix.de,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org
Date:   Tue, 21 Apr 2020 19:51:17 -0700
Message-ID: <158752387776.132238.1325437671673808624@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bryan O'Donoghue (2020-04-19 05:18:07)
> From: Shawn Guo <shawn.guo@linaro.org>
>=20
> It's a copy of following files with zero changes.
>=20
>  drivers/clk/qcom/gcc-msm8916.c
>  include/dt-bindings/clock/qcom,gcc-msm8916.h
>  include/dt-bindings/reset/qcom,gcc-msm8916.h
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Squash this patch into the one after and generate the patch wit
'git format-patch -C'. Does it find the copy? Probably would, and then
we could figure out what changed.
