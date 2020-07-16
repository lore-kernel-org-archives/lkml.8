Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8363EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE7F2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594861220;
	bh=EfHJnarvNG/86632LUS98Ny1D7rHG3S4L10bIx8jeIM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=WGKMdMyeC78WuF6pNB0+usnM104BlewF2Ltvt9j4szoluTaQQsb5J7R1DiLNfqJyw
	 VaoJ8+pmG9pM9VqkKcrcjIF+lWzYIBWhvwfKs22y9yKsWFjNwJQBgKAtNyckuEBqan
	 rsnH8TrwwJqT80nhkjPn4+3cJ3reQ002+QHO54II=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGPBAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgGPBAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:00:18 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 270CF2077D;
        Thu, 16 Jul 2020 01:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594861218;
        bh=EfHJnarvNG/86632LUS98Ny1D7rHG3S4L10bIx8jeIM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lB+dv5rAC/0qNlXHk7jlCeiwIc338r+YiPuKHNWs171PqWRZugcXjOEan6lXIi5Ld
         iXZtgbGvrHWylJLyGvUJGXZ6MyjEZf5TOd82AWemam12Q3i2Dv0nyk8LHCdSRFS7ZK
         h8rP8jMoTSH8036vDdZO9eGuZ6izaEdZsJghxXlk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1594098579-25050-7-git-send-email-Anson.Huang@nxp.com>
References: <1594098579-25050-1-git-send-email-Anson.Huang@nxp.com> <1594098579-25050-7-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH V6 6/6] clk: imx6sl: Fix build warning reported by kernel test robot
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
Date:   Wed, 15 Jul 2020 18:00:17 -0700
Message-ID: <159486121748.1987609.16422613903444902156@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-07-06 22:09:39)
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

The subject is poor. Please improve it so that it summarizes the change
instead of the reaction to a warning from a robot.

> New patch.
> ---
>  drivers/clk/imx/clk-imx6sl.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20

This should come earlier in the series too so that the build warning
doesn't come out before this patch is applied.
