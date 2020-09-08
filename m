Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A015AC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C3DF2080C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599601689;
	bh=DUQEhnmzitWNXyCjsqya+C3j/PfigMyAaCk9ZvzUggQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=hWNA73Z6klJ9IzG7pmnXnhm3rMa92WzJKDVeBAu3J47pX427dd7EAwjLsRBFgsp6n
	 wqpS9IDDWefEBt6NDwG1QF4t2STmqg8srYDyByjEGWmZWG4UsaiKu17pulVi2LXSTr
	 eDGqNQp0CBpAyFJp0D2TqGxsoPf7aKekHdv2HjoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgIHVsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgIHVr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 17:47:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5DB82137B;
        Tue,  8 Sep 2020 21:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599601678;
        bh=DUQEhnmzitWNXyCjsqya+C3j/PfigMyAaCk9ZvzUggQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lsJoBdQ0r1sVB0OvgPYno3C8N1o7mVQOti48nrzCfg0oTCEvX8rBovIYn5PtQfmyP
         kH1d34Mk/NeTsTwpit3EG49yUJsV/welEW+8KPXl3aZT2vkRzvuyLFIL2ihezoHqNq
         bOsvEzF0tH6JDbWTpTHJwuyEDvFsliG1KMgNQy7Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200827152827.1661050-1-thierry.reding@gmail.com>
References: <20200827152827.1661050-1-thierry.reding@gmail.com>
Subject: Re: [PATCH] clk: Make kerneldoc consistent
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>
Date:   Tue, 08 Sep 2020 14:47:57 -0700
Message-ID: <159960167744.454335.12801752971428122073@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thierry Reding (2020-08-27 08:28:27)
> From: Thierry Reding <treding@nvidia.com>
>=20
> The kerneldoc comment for of_parse_clkspec() mentions in one place that
> the value of the index parameter dictates how name is used, whereas in
> reality it's the name parameter that dictates whether or not the index
> parameter is used.

It's both name being non-null and index being >=3D 0. With this change we
lose that information.

>=20
> In a later paragraph the kerneldoc comment does mention that the index
> will be ignored if the name is non-NULL, so make the parameter
> description consistent.

Agreed. We indicate that if name is non-NULL then this parameter is
ignored.

>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/clk/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 0a9261a099bd..cf6774abebb0 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4600,7 +4600,7 @@ EXPORT_SYMBOL(devm_of_clk_del_provider);
>  /**
>   * of_parse_clkspec() - Parse a DT clock specifier for a given device no=
de
>   * @np: device node to parse clock specifier from
> - * @index: index of phandle to parse clock out of. If index < 0, @name i=
s used
> + * @index: index of phandle to parse clock out of; ignored if @name is n=
on-NULL

Maybe, ignored if @name is non-NULL. @name should be used if @index is < 0.

>   * @name: clock name to find and parse. If name is NULL, the index is us=
ed

This could say "If name is NULL, @index should be used"

>   * @out_args: Result of parsing the clock specifier
>   *
> --=20
> 2.28.0
>
