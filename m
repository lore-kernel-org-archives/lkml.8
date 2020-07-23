Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F5BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887A42086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595465495;
	bh=UOqOpWdE600erSJp21wbDCbCsu79Ba86K1D9303jh5Y=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=FmgW0Z6YMJQbnZ43VibgSkwvVyaXzoM8R7EHJ4J+V2/Hgo2AgVU1fOCGKrEBeJE1p
	 CTguZNLv5i0EEjxvwUO4S2QOfE5f2RLLnQmJCgUzsv8VZeEGIFHeb5dHwYQrW+VgMJ
	 qOw17WZJKrd+pwCU5u9+FyepyMTWnt9Cn2gL7sBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbgGWAve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 20:51:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbgGWAve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 20:51:34 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC0620825;
        Thu, 23 Jul 2020 00:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595465494;
        bh=UOqOpWdE600erSJp21wbDCbCsu79Ba86K1D9303jh5Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gb7uwAcJGBIgBNBWFGIpPmwHbV9KKIIbRDJTO54mML9mQXeSM/YtBDuB2p/EYsX53
         XE4DHkX4dErTcPMCJsjSvqUy+M/C/ijxQamDTKo64uAkep/FKTQ77cncoyc/vgC8S+
         dLYr9IHgMwFvoKvJcmHe0CMHHDeqS7HxARDuNVkY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <14639646.VOZsFJ8Tpa@phil>
References: <20200722023230.10826-1-zhangqing@rock-chips.com> <14639646.VOZsFJ8Tpa@phil>
Subject: Re: [PATCH v1] clk: Export __clk_lookup()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com
To:     Elaine Zhang <zhangqing@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Date:   Wed, 22 Jul 2020 17:51:33 -0700
Message-ID: <159546549321.3847286.4678382117195983280@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heiko Stuebner (2020-07-22 11:26:50)
> Hi Elaine,
>=20
> Am Mittwoch, 22. Juli 2020, 04:32:30 CEST schrieb Elaine Zhang:
> > Export __clk_lookup() to support user built as module.
> >=20
> > ERROR:
> > drivers/clk/rockchip/clk.ko: In function
> > `rockchip_clk_protect_critical':
> > drivers/clk/rockchip/clk.c:741:
> > undefined reference to `__clk_lookup'
>=20
> can you elaborate a bit more on why this would be needed?
>=20
> Because right now the Rockchip clocks are of course built into
> the main kernel image (especially due to them being needed during early
> boot) and __clk_lookup actually is a pretty deep part of the clock-
> framework itself, as probably also denoted by the "__" in the function
> name.
>=20

Can you stop using __clk_lookup()? The plan is to remove it.
