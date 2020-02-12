Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0368C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9834424677
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581541111;
	bh=2vpa1skMHHv9Ha3+HKM2dSp/5etVHrkhSZVxv7QjBc4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=u8qzuH7YROvv9bj5tZfrBuF0SRJg/GZ7u0JzhJnpcectxGjMr+X0fjeVpTp5t3dGE
	 3jZhw2ZqFNtTutOmdTHp24JbWCGqNDaVVBKAGhe7fP85UDN7oHzzbMWWIVISfcB0jC
	 9jTQpyB3XhQt8aSOZQUb+iJHbh3aBz4m28dA6940=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgBLU6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:58:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbgBLU6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:58:30 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B3D9206D7;
        Wed, 12 Feb 2020 20:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581541109;
        bh=2vpa1skMHHv9Ha3+HKM2dSp/5etVHrkhSZVxv7QjBc4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NfTnP7cKKKy2a1j5JTEK3r4kcg7buqdLFwNdkk97cDqmkWgjo98aE9cFpTUewSkYx
         L/3Snkn4R0zlcWAl7P3lE5+oXF3XfC5qvno5l0he7pNDRwP+zhuJOPO+YT14keSPZ5
         bBUpczqAMTrTqybgXDCY03WArDERNSjglw7DAAuE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581498584-14674-1-git-send-email-Anson.Huang@nxp.com>
References: <1581498584-14674-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH] clk: imx7ulp: Include clk-provider.h instead of clk.h
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        chen.fang@nxp.com, festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Wed, 12 Feb 2020 12:58:28 -0800
Message-ID: <158154110894.184098.12745716367701333930@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-02-12 01:09:43)
> The i.MX7ULP clock driver is provider, NOT consumer, so clk-provider.h
> should be used instead of clk.h.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
