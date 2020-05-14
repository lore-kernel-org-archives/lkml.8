Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B909AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959562065C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589488648;
	bh=uuyonOVzZlqOqi/2AgdgCj2JP37ZDmCHYgPvRRf19Dc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=uDmF5Yzm+8Y/KHJxxL2LTc/B88B6EnlHMCAW44X+s2RYlH+Bwqj2aEvNZ8PqgLQov
	 hSyWJx4Ng/w7hPzS0D8azvboRsdmer/ycFX6d/215xUvms4cEdxvFKAUMfqCakKYGP
	 lUFhFg1o26zJiXPMg9KeYIlG/5UhQ9/3cMk4R8ZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgENUh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgENUh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:37:27 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F93A2065C;
        Thu, 14 May 2020 20:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589488646;
        bh=uuyonOVzZlqOqi/2AgdgCj2JP37ZDmCHYgPvRRf19Dc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=2VQgOl4ELKbRsJEzLTZeBfkE1w/iYlNe/5tiddRy+3CWlzE7rsSRsSxkqY74t5x7c
         FHAXFmyO46R7q/U1Rsu+w5Qo2rm2BxyMeECVOUIEpVtieCUS94mFO5tQ1l7E0FGUGa
         E8/GSx5lKDGO7WCN2E0vn+6cJDJIytOOmWxlyCWE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFBinCBHuPLS8BDzO4Gb86TG3tNTtqmW5BSWy8jhPuN3STOTUA@mail.gmail.com>
References: <CAFBinCBHuPLS8BDzO4Gb86TG3tNTtqmW5BSWy8jhPuN3STOTUA@mail.gmail.com>
Subject: Re: clk_hw.init and -EPROBE_DEFER / driver re-load
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org
Date:   Thu, 14 May 2020 13:37:25 -0700
Message-ID: <158948864581.215346.7236327959062539884@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2020-04-27 12:57:33)
> Hello Stephen et al.
>=20
> I am working on a driver for the "SDHC" controller on older Amlogic Meson=
 SoCs.
> This has some clock controller bits built into.
> Using CCF for the whole rate management makes things a lot easier, so
> I decided to use that instead of poking register bits manually.
> The code can be seen here: [0] - but don't take it too seriously
> because I have to move some of that in the next patch revision.
>=20
> I solved an "interesting" problem where I'm not sure if it works as
> intended (which is what I assumed) or if there's an actual problem (as
> suggested by Jerome).
>=20
> The flow in the driver is basically:
> (the clk_hws are defined as "static" variables inside the driver)
> 1) fetch related OF properties
> 2) initialize and register the built-in (into the MMC controller
> driver) clock controller part
> 3) initialize the MMC controller
>=20
> Step 3) can fail for example because one of the regulators is not ready.
> In this case I'm de-registering the clock controller part again.
> Finally the driver returns -EPROBE_DEFER
> (so far everything is working fine)
>=20
> However, once the regulator (in this example) becomes ready the the
> same flow as above is being executed.
> Only this time the clock controller registration fails because
> hw->init is NULL (before it had the values which I defined in the
> driver).
> This is due to the following line in __clk_register():
>   hw->init =3D NULL;
>=20
> My way to "solve" this is to clone the clk_hws while registering the
> clock controller.
> Unfortunately this means that I can't easily use clk_hw references to
> describe the parent/child relation between these clocks.
>=20
> I'm not sure if my way of defining the clk_hws is wrong, there's a bug
> in CCF, this is a new feature request or something completely
> different :-)
> My motivation is to understand how I should to consider this behavior
> for my next version of the MMC controller patches.
>=20

Maybe the patch to make hw->init be NULL is just not useful and we
should revert it. The intent was to catch misbehaving drivers that tried
to use the init data after registration but then it causes problems like
we see here where drivers have static clk data mixed with static init
data that they unregister later and expect to be able to register again.

This is one of the failed design decisions we made early on to associate
the init data with the clk_hw struct instead of passing it as another
argument to clk_register().

Maybe a better workaround would be to always assign hw->init in the
driver before registering the clks? Basically make a clk registration
API that we should have made before.

int my_clk_register(struct clk_hw *hw, struct clk_init_data *init)
{
	hw->init =3D init;
	ret =3D clk_hw_register(dev, hw);
	...
}

Do you have some sort of array of clk_hw pointers to register? Maybe we
could make a new clk registration structure to simplify this for users,
but I'm not super interested in introducing yet another registration
API! :/

struct clk_hw_desc {
	struct clk_hw *hw;
	struct clk_init_data *init;
};

and then drivers can call clk_hw_register_bulk() or something like this:

int clk_hw_register_bulk(struct device *dev, const struct clk_hw_desc **des=
cs, size_t num_descs)
{
	int ret;
	int i;

	for (i =3D 0; i < num_descs; i++) {
		ret =3D some_internal_clk_register_func(dev, descs[i]->hw, descs[i]->init=
);
		if (ret)
			goto error;
	}

	return 0;
error:
	while (--i >=3D 0)
		clk_hw_unregister(...)

	return ret;
}
