Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81C6C43333
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA1420753
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584751621;
	bh=6pnnCkGAWpOfxYh0ESxdk4ldG8q3cVJOC3KgYkzWFWU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=jJru6HVqV2/PUm1VLjvKlYrQ79UoGd6ogsXKqrHbwmlWk5GXgwFE81tRWpFkAIZyM
	 I4yZjrT3pdyligvNETVPH5bcCt7pEsjlODs+JOXseGV73RikNgewF4Or1wDziCA0AO
	 r8MCS5YKLFy5u1wtMg9Zda08o5eG0qu4VcJ1WMkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgCUArA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgCUArA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:47:00 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDA8E2070A;
        Sat, 21 Mar 2020 00:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584751620;
        bh=6pnnCkGAWpOfxYh0ESxdk4ldG8q3cVJOC3KgYkzWFWU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pX5wPcHbJKG7W1+YS4CcbPrdYJnxdIpp1hLyEkF1b/vDs9Jc26mHuubqvjx8eEpfF
         rLlCRyfMNgEUR7AJEbMu25yUKBLRJqThL9lnBgh9W6+kU1i2gh63av9A4IIjY4RwVt
         T+R4Anj6Cz96leRFhdmuvdHUl+W+UyRK76HiW0lE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1583226206-19758-7-git-send-email-abel.vesa@nxp.com>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com> <1583226206-19758-7-git-send-email-abel.vesa@nxp.com>
Subject: Re: [RFC 06/11] clk: imx: Add helpers for passing the device as argument
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
Date:   Fri, 20 Mar 2020 17:46:59 -0700
Message-ID: <158475161915.125146.8348743269126342394@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2020-03-03 01:03:21)
> All the imx clocks that need to be registered by the audiomix need to pass
> on the device so that the runtime PM support could work properly.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
