Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E824CC43333
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D562072D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584751574;
	bh=/JcfAMvxxLAjC67oF8WIwUtc3/I5GfMcGDCtdaVAHiU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=GQaY+NGE5XEk/J/PZFvSuP9htN0+7sxSMX/+O8J68sX+l2QtZo556EKtOywuWhepc
	 4SDSf36/BbABR3rGgMYnPSFodq+alhY8y57tOVcU5YWS/0M0rzKKzks7GGsiiOYRbu
	 /N8iyzX5BLwtV+e0XKQeeCqthnynq2kI28xtwjiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCUAqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:46:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCUAqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:46:13 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E44BF2070A;
        Sat, 21 Mar 2020 00:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584751573;
        bh=/JcfAMvxxLAjC67oF8WIwUtc3/I5GfMcGDCtdaVAHiU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=1j3WiPvM5MEcdeeN3OSQ8boz7u+tX5tty1iyQKkouH0Au5dKbNrK+veUkiIcQbsc6
         YSGgUwKQSlQJyvnoBYNey8njDfiAx15T18riLjQe9UGhaDaSH1tlursoX8vy86/nAm
         TQBKjmrU1mrViYNCgLhRkqoFclzNKaLEp5JhVhQw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1583226206-19758-6-git-send-email-abel.vesa@nxp.com>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com> <1583226206-19758-6-git-send-email-abel.vesa@nxp.com>
Subject: Re: [RFC 05/11] clk: imx: pll14xx: Add the device as argument when registering
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Lee Jones <lee.jones@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Fri, 20 Mar 2020 17:46:12 -0700
Message-ID: <158475157216.125146.12954744026833185927@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2020-03-03 01:03:20)
> In order to allow runtime PM, the device needs to be passed on
> to the register function. Audiomix clock controller, used on
> i.MX8MP and future platforms, registers a pll14xx and has runtime
> PM support.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
