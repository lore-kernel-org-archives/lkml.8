Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA38C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B6A22CA1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596483752;
	bh=pg1yMp3Q6hDfDOvtQhZxujnkBMxKrKHKTXX1bU4UQxY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ZftMUfyW0g3JCGbS94xGPwvY8LZuPaMheZcsMqYRUtLMwmSIXl80CxyS+7wj2cd17
	 x7RdwpnBds7K3FyXtgEAC1qaCkxSsn2b3N3et0AHM1+fZXKGHHNIOs8PldHQJr3tzN
	 SkcIXN4VI2mMf8EojFp1voBCOOQg8p21Ic4M0eOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgHCTmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgHCTmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:42:31 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D646E22C9F;
        Mon,  3 Aug 2020 19:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596483750;
        bh=pg1yMp3Q6hDfDOvtQhZxujnkBMxKrKHKTXX1bU4UQxY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tWs8XaIn8vAigHR7QF1lMHkQPrbO+/FaTzgbe2uremBsSrlQGNLLcQPmE3I853jNz
         ZtcIi1hFvzQTLRvU2h9u34eJ/fcrfk5MqNg4rE58AN9GAya57cen3qFmMIDONLeDCS
         DwGTePIDL7f1t5brhdkxztm8qmlwrRZLttCgrDKE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1596072174-16358-2-git-send-email-Anson.Huang@nxp.com>
References: <1596072174-16358-1-git-send-email-Anson.Huang@nxp.com> <1596072174-16358-2-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH V9 1/6] clk: imx6sl: Use BIT(x) to avoid shifting signed 32-bit value by 31 bits
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        aisheng.dong@nxp.com, arnd@arndb.de, daniel.baluta@nxp.com,
        festevam@gmail.com, fugang.duan@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
        yuehaibing@huawei.com
Date:   Mon, 03 Aug 2020 12:42:29 -0700
Message-ID: <159648374959.1360974.3090613408656313501@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-07-29 18:22:49)
> Use readl_relaxed() instead of __raw_readl(), and use BIT(x)
> instead of (1 << X) to fix below build warning reported by kernel
> test robot:
>=20
> drivers/clk/imx/clk-imx6sl.c:149:49: warning: Shifting signed 32-bit
> value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
>      while (!(__raw_readl(anatop_base + PLL_ARM) & BM_PLL_ARM_LOCK))
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
