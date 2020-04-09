Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DC3C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0315520730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586462893;
	bh=pX1yFzz3pFt10pbXAcR7vDj5Thmq7QVeIwvpaqgU98I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=lMT3SB7PhyFBCYhWREBtFZlcGrsj2cGGak9n8dgu0P3OkEM5q+WJmkLt0CDrJd/GR
	 dua23bm9MP0A9OU+Be4Dl36Ktiv0mgUUug9FQvA+1i76+TuGrIdqbU+0sRKpIrBgYB
	 iJWEMkhZG79uYFs+wWBTRHrVzLf5qEA72RlmoVEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgDIUIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgDIUIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:08:11 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F1D820730;
        Thu,  9 Apr 2020 20:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586462891;
        bh=pX1yFzz3pFt10pbXAcR7vDj5Thmq7QVeIwvpaqgU98I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=t4//RAlFmxXq0i6O7cTwZ7qK1rgoLWcl1kSdh8/DiX5Q9JrzFvNSRZR1rRaQjsJ6R
         ymBfkEmXJmQfnXFvsb7ZynbMSjr+UMVPBNEDHK7vPyi839/36fVtaSg5WxfN7iuUWg
         Y5vlCIrHQdsODQ+yadrVBqsIFAqiSDiQqAWGT+Ug=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1585338485-31820-4-git-send-email-tdas@codeaurora.org>
References: <1585338485-31820-1-git-send-email-tdas@codeaurora.org> <1585338485-31820-4-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v1 3/4] clk: qcom: gcc: Add support for GCC LPASS clock for SC7180
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 09 Apr 2020 13:08:10 -0700
Message-ID: <158646289064.77611.10114179517777308856@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2020-03-27 12:48:04)
> @@ -2406,6 +2419,7 @@ static struct clk_regmap *gcc_sc7180_clocks[] =3D {
>         [GCC_MSS_NAV_AXI_CLK] =3D &gcc_mss_nav_axi_clk.clkr,
>         [GCC_MSS_Q6_MEMNOC_AXI_CLK] =3D &gcc_mss_q6_memnoc_axi_clk.clkr,
>         [GCC_MSS_SNOC_AXI_CLK] =3D &gcc_mss_snoc_axi_clk.clkr,
> +       [GCC_LPASS_CFG_NOC_SWAY_CLK] =3D &gcc_lpass_cfg_noc_sway_clk.clkr,

Sad to see that more defines are being added slowly to the header file.
It would be better to have all the defines there so the binding header
file isn't updated in small updates over months and months.

>  };
>
