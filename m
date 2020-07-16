Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BF7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31FB22071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594861098;
	bh=fN+S2Gc6/8TG8x5I2ww/JDGn/O6BB81s/hlqQZypqk0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=PNPA15UzK1Y+fQaaEQVHJeroPo2Mhip7XzvxW1yudrBbpmvAmi0ia/t8CsXSXsTwX
	 eubEJKOkolLkAiqlpv5O1zw6pVzgBZgTaCnLF80yy+TEAao/0f6f3FviAIXYRWzkvf
	 uQHqKhonYerUM6RhzEgEcM4HUre0MIGKII8n0QUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgGPA6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGPA6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:58:16 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2F2420714;
        Thu, 16 Jul 2020 00:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594861096;
        bh=fN+S2Gc6/8TG8x5I2ww/JDGn/O6BB81s/hlqQZypqk0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KKK+fy4l8n0stQsuGCcUCcGebL1cYd4C9N7ZF0fSEucbIBO9ukEG/fwOZWt34yMTO
         t56cdxSARMT6/t23Whzy7u/8pKh/JOb4FCYDRuA1LZ6/HDBtnO2E9zW2URgwTmQU7Z
         hIiAwpWg5Asky97YrWBYOy5HQtqghrYQU46bN/kw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1594098579-25050-4-git-send-email-Anson.Huang@nxp.com>
References: <1594098579-25050-1-git-send-email-Anson.Huang@nxp.com> <1594098579-25050-4-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH V6 3/6] clk: imx: Add clock configuration for ARMv7 platforms
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>,
        Georg.Waibel@wiedemann-group.com, abel.vesa@nxp.com,
        aisheng.dong@nxp.com, andrew.smirnov@gmail.com, chen.fang@nxp.com,
        daniel.baluta@nxp.com, festevam@gmail.com, fugang.duan@nxp.com,
        georg.waibel@wiedemann-group.de, horia.geanta@nxp.com,
        j.remmet@phytec.de, kernel@pengutronix.de,
        laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, s.hauer@pengutronix.de, sfr@canb.auug.org.au,
        shawnguo@kernel.org, yuehaibing@huawei.com
Date:   Wed, 15 Jul 2020 17:58:15 -0700
Message-ID: <159486109533.1987609.1468645632345218617@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-07-06 22:09:36)
> Add CONFIG_CLK_xxx for i.MX ARMv7 platforms, and use it as build option
> instead of CONFIG_SOC_xxx, the CONFIG_CLK_xxx will be selected by default
> according to CONFIG_SOC_xxx.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
