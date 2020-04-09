Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E3AC2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CD920BED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586421045;
	bh=tecY0VJsbe8EdmmXXtksU0Y0zBQ4pnIaVfI2igeka+g=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=mpS87GjVe66x4KNgk2QhkrmpCUtJv7mext01V16khlNtoGZfOdE0pXlCTx7imM1UL
	 a7c1eaUnBAcCh1mFZtZtkJK43OXS3l17OS5Cm+6sd4n5cQkMwtVGHxjwGt2zHMdIKE
	 ED1mmiaf+8P3rxfAIe5mtW0F0OjKOfvo/mVxGN88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDIIan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgDIIan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:30:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D2E620784;
        Thu,  9 Apr 2020 08:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586421042;
        bh=tecY0VJsbe8EdmmXXtksU0Y0zBQ4pnIaVfI2igeka+g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ptohimgNcSS6YVP6voh44L9Sg9U4vla0zIuPhH//YJlP0Pij9fyw2K+ZNUAEHVrPo
         Ro/p1DceVy1DmnpHiLRWeBbTqOmFjwO56VpfspN5AASuHpAIJ7hqo6PYHpZolmT3RQ
         PQprX0YetLoQeGYubZAI1tdqQfcS3ncgfxC7byN4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200408160044.2550437-1-arnd@arndb.de>
References: <20200408160044.2550437-1-arnd@arndb.de>
Subject: Re: [PATCH] [RFC] clk: sprd: fix compile-testing
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
To:     Arnd Bergmann <arnd@arndb.de>, catalin.marinas@arm.com,
        chunyan.zhang@unisoc.com, mturquette@baylibre.com, will@kernel.org
Date:   Thu, 09 Apr 2020 01:30:41 -0700
Message-ID: <158642104168.126188.8440219577017239983@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2020-04-08 09:00:44)
> I got a build failure with CONFIG_ARCH_SPRD=3Dm when the
> main portion of the clock driver failed to get linked into
> the kernel:
>=20
> ERROR: modpost: "sprd_pll_sc_gate_ops" [drivers/clk/sprd/sc9863a-clk.ko] =
undefined!
> ERROR: modpost: "sprd_pll_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefine=
d!
> ERROR: modpost: "sprd_div_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefine=
d!
> ERROR: modpost: "sprd_comp_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefin=
ed!
> ERROR: modpost: "sprd_mux_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefine=
d!
> ERROR: modpost: "sprd_gate_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefin=
ed!
> ERROR: modpost: "sprd_sc_gate_ops" [drivers/clk/sprd/sc9863a-clk.ko] unde=
fined!
> ERROR: modpost: "sprd_clk_probe" [drivers/clk/sprd/sc9863a-clk.ko] undefi=
ned!
> ERROR: modpost: "sprd_clk_regmap_init" [drivers/clk/sprd/sc9863a-clk.ko] =
undefined!
> ERROR: modpost: "sprd_pll_ops" [drivers/clk/sprd/sc9860-clk.ko] undefined!
> ERROR: modpost: "sprd_div_ops" [drivers/clk/sprd/sc9860-clk.ko] undefined!
> ERROR: modpost: "sprd_mux_ops" [drivers/clk/sprd/sc9860-clk.ko] undefined!
>=20
> This is a combination of two trivial bugs:
>=20
> - A platform should not be 'tristate', it should be a 'bool' symbol
>   like the other platforms, if only for consistency, and to avoid
>   surprises like this one.
>=20
> - The clk Makefile does not traverse into the sprd subdirectory
>   if the platform is disabled but the drivers are enabled for
>   compile-testing.
>=20
> Fixing either of the two would be sufficient to address the link failure,
> but for correctness, both need to be changed.
>=20
> Fixes: 2b1b799d7630 ("arm64: change ARCH_SPRD Kconfig to tristate")
> Fixes: d41f59fd92f2 ("clk: sprd: Add common infrastructure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/Kconfig.platforms | 2 +-
>  drivers/clk/Makefile         | 2 +-

For clk part

Acked-by: Stephen Boyd <sboyd@kernel.org>
