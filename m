Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C65BC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C80F207D0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592939335;
	bh=BlTLROcajuvf6wPLoEzW1weh5p9WvRSaQ89FkLzeY/0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=sBHetuhb0SvonruwcurGZFtisEW2f+6tDPlJq5sZDKpAl2ghQqNi/GWeyiDvpM8VX
	 8ZFnD8uQuFmPwDQrMjKUMgDfBw96YmpSPVyUhoVGul1it6BkhgoBMJxoBk04bK6Foq
	 gGKK10dCtPYqctEhgXQ5hGjSjWaEs668jzUMOBa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbgFWTIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:08:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733220AbgFWTIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:08:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1FD1207D0;
        Tue, 23 Jun 2020 19:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592939332;
        bh=BlTLROcajuvf6wPLoEzW1weh5p9WvRSaQ89FkLzeY/0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jOTYkjJbzaf4BjFZ3qCwPmrk2w6U14U9q8wpnRoCz3NHtGRgklc0vX9DBYaLRtf7b
         LJ5VDsLKHtMJGqhGM5OlrtXQLSsIN3pHfFsdCK1XXxGPbcbuP/XqCg5j0Vn+mWM1tD
         TPEbT0mA38RUgRBCyVU+qt0nY6sAAURzZBkBIZuk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200616055223.119360-1-ikjn@chromium.org>
References: <20200616055223.119360-1-ikjn@chromium.org>
Subject: Re: [PATCH] clk: Provide future parent in clk notification
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
To:     Ikjoon Jang <ikjn@chromium.org>, linux-clk@vger.kernel.org
Date:   Tue, 23 Jun 2020 12:08:52 -0700
Message-ID: <159293933210.62212.706350398043250620@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ikjoon Jang (2020-06-15 22:52:23)
> Current clk notification handlers cannot know its new parent in
> PRE_RATE_CHANGE event. This patch simply adds parent clk to
> clk_notifier_data so the child clk is now able to know its future
> parent prior to reparenting.

Yes, but why is that important?

>=20
> Change-Id: I099a784d5302a93951bdc6254d85f8df8c770462

Please remove these.

> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
>  drivers/clk/clk.c   | 30 +++++++++++++++++-------------
>  include/linux/clk.h |  9 ++++++---
>  2 files changed, 23 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 3f588ed06ce3..62c4e7b50ae5 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1846,7 +1849,7 @@ static int __clk_set_parent(struct clk_core *core, =
struct clk_core *parent,
>   * take on the rate of its parent.
>   */
>  static int __clk_speculate_rates(struct clk_core *core,
> -                                unsigned long parent_rate)
> +                                struct clk_core *parent)
>  {
>         struct clk_core *child;
>         unsigned long new_rate;
> @@ -1854,11 +1857,12 @@ static int __clk_speculate_rates(struct clk_core =
*core,
> =20
>         lockdep_assert_held(&prepare_lock);
> =20
> -       new_rate =3D clk_recalc(core, parent_rate);
> +       new_rate =3D clk_recalc(core, parent ? parent->rate : 0);
> =20
>         /* abort rate change if a driver returns NOTIFY_BAD or NOTIFY_STO=
P */
>         if (core->notifier_count)
> -               ret =3D __clk_notify(core, PRE_RATE_CHANGE, core->rate, n=
ew_rate);
> +               ret =3D __clk_notify(core, parent, PRE_RATE_CHANGE,
> +                                  core->rate, new_rate);
> =20
>         if (ret & NOTIFY_STOP_MASK) {
>                 pr_debug("%s: clk notifier callback for clock %s aborted =
with error %d\n",
> @@ -1867,7 +1871,7 @@ static int __clk_speculate_rates(struct clk_core *c=
ore,
>         }
> =20
>         hlist_for_each_entry(child, &core->children, child_node) {
> -               ret =3D __clk_speculate_rates(child, new_rate);
> +               ret =3D __clk_speculate_rates(child, core);

How does this work? core->rate isn't assigned yet when we're speculating
rates down the tree to the leaves. So that clk_recalc() in the above
hunk would need to save the rate away, which is wrong because it isn't
changed yet, for this line to make sense.

Given that I had to read this for a few minutes to figure this out it
seems that trying to combine the parent and the rate as arguments is
actually more complicated than adding another parameter. Please just add
another argument.

>                 if (ret & NOTIFY_STOP_MASK)
>                         break;
>         }
