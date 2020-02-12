Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547D9C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2191F20658
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581527341;
	bh=XP/tWg8/Bvso3LG+TpY7EF6anCoNlsWPN1Xlkisvfqo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=xZ/GrQ5otRPAonyWx86bXhmqGJNmZpq7jHjTURogIyHbXOtpk/aijHRusxYU0UGPc
	 k8V8D/m0iPGClFUnJy2Gv+vLsZvmjBL0qTzwUc5gPM/dMML5YOLZp6knIvOD64Nw1p
	 3zI1ADetmVrdFcQpqelEQ9e+7SZJUUw90W/7txI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgBLRJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:09:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbgBLRI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:08:59 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF099217F4;
        Wed, 12 Feb 2020 17:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581527339;
        bh=XP/tWg8/Bvso3LG+TpY7EF6anCoNlsWPN1Xlkisvfqo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=wzBy9omPl53yRjTW7Rf/aiD7rRcu3y81b3OLuafGCt9b0g46tEBgMMI7nwZ/r/DV9
         QQrF8NUXRyCCs1m6ktYfed5eKBYUkCZddVJSRU2nPS32NYh16ui+zVHMPn5p7tZbW3
         BxMBKpuIME+FX3bHuE8Ge4F++hdbn0tEWeJiSxro=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200212100830.446-3-geert+renesas@glider.be>
References: <20200212100830.446-1-geert+renesas@glider.be> <20200212100830.446-3-geert+renesas@glider.be>
Subject: Re: [PATCH 2/7] ARM: mediatek: Replace <linux/clk-provider.h> by <linux/of_clk.h>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Chen-Yu Tsai <wens@csie.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Magnus Damm <magnus.damm@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Russell King <linux@armlinux.org.uk>
Date:   Wed, 12 Feb 2020 09:08:58 -0800
Message-ID: <158152733826.121156.5780809579454137553@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-12 02:08:25)
> The Mediatek platform code is not a clock provider, and just needs to
> call of_clk_init().
>=20
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
