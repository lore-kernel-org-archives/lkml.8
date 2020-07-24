Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC940C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF452074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595581617;
	bh=u+8QPLNFWhu22Q1xuFhfB9/1RtBv3ZupfetFjIcaBxI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Fw+Tf9cPfNGLpc8qond3UGd9MiGncjMUENnDQ/2X1e99lb18NtG4HKKZ/3PHJOOCT
	 u14l2ervWJGumydSTMZl84XbSenpHSCRIWGce7SFw5m6LI1JiGbOe138c0Bz3gNfoY
	 Kw3/G8MqK5r/1SBhxwDNgNS66z79AC8HWRijZxsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgGXJG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgGXJG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:06:56 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1F132074F;
        Fri, 24 Jul 2020 09:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595581615;
        bh=u+8QPLNFWhu22Q1xuFhfB9/1RtBv3ZupfetFjIcaBxI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qfS8ar17yiMuou9GAlrOZgpCziAF0PVwKT7fs7T1dwLyTDEt42pL+HUcIUCWJkYEU
         1T4luJsLlvka6C1VPRnUAUVNhPzc5rfHD3VYrB+pAIbXOPBENh+XMaKBBDoaF7JHkq
         88+iQkU+F1BKpirtzj5vmw410V48N0AWi5773Hok=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200630003024.6282-1-mdtipton@codeaurora.org>
References: <20200630003024.6282-1-mdtipton@codeaurora.org>
Subject: Re: [PATCH] clk: Add support for enabling/disabling clocks from debugfs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        tdas@codeaurora.org, Mike Tipton <mdtipton@codeaurora.org>
To:     Mike Tipton <mdtipton@codeaurora.org>, mturquette@baylibre.com
Date:   Fri, 24 Jul 2020 02:06:54 -0700
Message-ID: <159558161499.3847286.16032712002329424951@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Tipton (2020-06-29 17:30:24)
> For test and debug purposes, it's often necessary to enable or disable
> clocks from shell. Add a new debugfs file (clk_prepare_enable) that
> calls clk_prepare_enable() when writing "1" and clk_disable_unprepare()
> when writing "0".
>=20
> This can have security implications, so only support it when the code
> has been modified to #define CLOCK_ALLOW_WRITE_DEBUGS.

DEBUGFS

>=20
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> ---
>  drivers/clk/clk.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 236923b25543..3640bbc56870 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3034,13 +3034,14 @@ static int clk_dump_show(struct seq_file *s, void=
 *data)
>  }
>  DEFINE_SHOW_ATTRIBUTE(clk_dump);
> =20
> -#undef CLOCK_ALLOW_WRITE_DEBUGFS
> -#ifdef CLOCK_ALLOW_WRITE_DEBUGFS

This didn't need to change.

>  /*
> - * This can be dangerous, therefore don't provide any real compile time
> - * configuration option for this feature.
> + * These features can be dangerous, therefore don't provide any real com=
pile
> + * time configuration option for them.
>   * People who want to use this will need to modify the source code direc=
tly.
>   */
> +#undef CLOCK_ALLOW_WRITE_DEBUGFS
> +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS

So I put it back and dropped your rewording.

> +
>  static int clk_rate_set(void *data, u64 val)
>  {
>         struct clk_core *core =3D data;
> @@ -3054,6 +3055,31 @@ static int clk_rate_set(void *data, u64 val)
>  }
> =20
>  #define clk_rate_mode  0644
> +
> +static int clk_prepare_enable_set(void *data, u64 val)
> +{
> +       struct clk_core *core =3D data;
> +       int ret =3D 0;
> +
> +       if (val)
> +               ret =3D clk_prepare_enable(core->hw->clk);
> +       else
> +               clk_disable_unprepare(core->hw->clk);
> +
> +       return ret;
> +}
> +
> +static int clk_prepare_enable_get(void *data, u64 *val)
> +{
> +       struct clk_core *core =3D data;
> +
> +       *val =3D core->enable_count && core->prepare_count;
> +       return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(clk_prepare_enable_fops, clk_prepare_enable_get,
> +                        clk_prepare_enable_set, "%llu\n");
> +
>  #else
>  #define clk_rate_set   NULL
>  #define clk_rate_mode  0444
> @@ -3231,6 +3257,10 @@ static void clk_debug_create_one(struct clk_core *=
core, struct dentry *pdentry)
>         debugfs_create_u32("clk_notifier_count", 0444, root, &core->notif=
ier_count);
>         debugfs_create_file("clk_duty_cycle", 0444, root, core,
>                             &clk_duty_cycle_fops);
> +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS

This is ugly but I guess we can't do much.

> +       debugfs_create_file("clk_prepare_enable", 0644, root, core,
> +                           &clk_prepare_enable_fops);
> +#endif
> =20

Applied to clk-next.
