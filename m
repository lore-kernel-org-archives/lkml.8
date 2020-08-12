Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C8CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF7A420771
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597218756;
	bh=lYGnGkLHu1hG+xc/o4ReH2xXsUyzFmXjEImOntyD4ws=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Z8PeabkMvlnmwcGkWrQDYewPUBvRVrrTgo+9rUt6pFJStMqbzORbaDKm+EpRyNYdb
	 VutbSNB4NN5CKX6hfnQT1jGqdZFAY+D+vZmgJZSp1cEzkeDZoqciTduN4r5/idHTW8
	 aj3zaKgfhhL/xlNhW5b6MxBZ97Hh5SChZojIL3Uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgHLHwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgHLHwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:52:33 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65F02206B5;
        Wed, 12 Aug 2020 07:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597218753;
        bh=lYGnGkLHu1hG+xc/o4ReH2xXsUyzFmXjEImOntyD4ws=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=1p4LHA72BP10qSH06MuALxEGL+GU2nbkV9CWNkn7+vzYlWNNa2iKUE7l2t2sNjo87
         097ws6IFpDJ2P3anL6PUXIcGnhWnHUm+WEEkiKkVvGdz9NhD2BwpbfB2/UyB/xievf
         kX/NCz4f7O+i1NWsIh4cgBHOC7WzfgCLvMNrQO6c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200810044020.2063350-1-natechancellor@gmail.com>
References: <20200810044020.2063350-1-natechancellor@gmail.com>
Subject: Re: [PATCH] clk: rockchip: Fix initialization of mux_pll_src_4plls_p
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Date:   Wed, 12 Aug 2020 00:52:32 -0700
Message-ID: <159721875227.33733.9237826555988566719@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Chancellor (2020-08-09 21:40:20)
> A new warning in Clang points out that the initialization of
> mux_pll_src_4plls_p appears incorrect:
>=20
> ../drivers/clk/rockchip/clk-rk3228.c:140:58: warning: suspicious
> concatenation of string literals in an array initialization; did you
> mean to separate the elements with a comma? [-Wstring-concatenation]
> PNAME(mux_pll_src_4plls_p)      =3D { "cpll", "gpll", "hdmiphy" "usb480m"=
 };
>                                                               ^
>                                                              ,
> ../drivers/clk/rockchip/clk-rk3228.c:140:48: note: place parentheses
> around the string literal to silence warning
> PNAME(mux_pll_src_4plls_p)      =3D { "cpll", "gpll", "hdmiphy" "usb480m"=
 };
>                                                     ^
> 1 warning generated.
>=20
> Given the name of the variable and the same variable name in rv1108, it
> seems that this should have been four distinct elements. Fix it up by
> adding the comma as suggested.
>=20
> Fixes: 307a2e9ac524 ("clk: rockchip: add clock controller for rk3228")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1123
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Looks good to me. I can pick it up for clk-fixes if Heiko agrees.
