Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745C0C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461132086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580754835;
	bh=ogTpQblq7X7LXPjruSHmMr4Qg+QUkxaUQIGLeGqyC5w=;
	h=In-Reply-To:References:From:To:Subject:Cc:Date:List-ID:From;
	b=fCYn50IIYA14fxAusQQ7AY2R07pr1oo6uu7KWb/SoV9OCEevKQCNtT0V7N0VdvAEl
	 rxfngahDSdhBxyAGypjqf38O51JydA/rxD0IEOpftyoJlw9xr9VKtCkLhouyioT9yv
	 6+yU45d9hlfcLyRcm1K6gctAi2e4LlfmDzeuKlrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgBCSdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbgBCSdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:33:54 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 833852082E;
        Mon,  3 Feb 2020 18:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580754833;
        bh=ogTpQblq7X7LXPjruSHmMr4Qg+QUkxaUQIGLeGqyC5w=;
        h=In-Reply-To:References:From:To:Subject:Cc:Date:From;
        b=1ykvGVRP+B9EVMnCFYXva1nvJ6Hans1Cuto5L7GzraNQLbUf92jBB3I2g8vH0duyQ
         WWBunExw6/pkR9UIfTFu2XjfCmgYNeyM7P/UPNO1Dt+SxAI5+YIK1m8oSLUwBVvhhF
         k9gua0npusFqLJ8fbCvS8xeciz2U8uNPnRtyVzdc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200203052507.93215-1-sboyd@kernel.org>
References: <20200203052507.93215-1-sboyd@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/2] clk: ls1028a: Fix warning on clamp() usage
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wen He <wen.he_1@nxp.com>
User-Agent: alot/0.8.1
Date:   Mon, 03 Feb 2020 10:33:52 -0800
Message-Id: <20200203183353.833852082E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-02-02 21:25:06)
> These constants are used in clamp() with the value being clamped an
> unsigned long. Make them unsigned long defines so that clamp() doesn't
> complain about comparing different types.
>=20
> In file included from include/linux/list.h:9,
>                  from include/linux/kobject.h:19,
>                  from include/linux/of.h:17,
>                  from include/linux/clk-provider.h:9,
>                  from drivers/clk/clk-plldig.c:8:
> drivers/clk/clk-plldig.c: In function 'plldig_determine_rate':
> include/linux/kernel.h:835:29: warning: comparison of distinct pointer ty=
pes lacks a cast
>   835 |   (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
>       |
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Wen He <wen.he_1@nxp.com>
> Fixes: d37010a3c162 ("clk: ls1028a: Add clock driver for Display output i=
nterface")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

