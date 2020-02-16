Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD98C7619B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 15:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3464F20857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 15:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="B62hACUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgBPPf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 10:35:59 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:58610 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbgBPPf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 10:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1581867357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ERM3RGanh1fJgg7kpnX8A1AoqKzN5Z7w2qMVfhCXT1I=;
        b=B62hACUiCwcx0eJVymY+ugJzprPBeXkRoSzSZAHbzM4bleKfk4DDX6TUntzaHJKanWzBnk
        D1HxNnRqj64HXoh1XTy5wSRdUXKwpTmMgvcCNaEqpOK8iku8iNtg6+e3jxpjxeka9e2G/H
        Sk6wU7zF21xY4t1PKhmMROuotTo+VII=
From:   Sven Eckelmann <sven@narfation.org>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc:     mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
        davem@davemloft.net, b.a.t.m.a.n@lists.open-mesh.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] net: batman-adv: Use built-in RCU list checking
Date:   Sun, 16 Feb 2020 16:35:54 +0100
Message-ID: <1634394.jP7ydfi60B@sven-edge>
In-Reply-To: <20200216153324.GA4542@madhuparna-HP-Notebook>
References: <20200216144718.2841-1-madhuparnabhowmik10@gmail.com> <3655191.udZcvKk8tv@sven-edge> <20200216153324.GA4542@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2119546.QtC4LbVagd"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2119546.QtC4LbVagd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 16 February 2020 16:33:24 CET Madhuparna Bhowmik wrote:
[...]
> > Can you tell us how you've identified these four hlist_for_each_entry_rcu?
>
> The other hlist_for_each_entry_rcu() are used under the protection of
> rcu_read_lock(). We only need to pass the cond when
> hlist_for_each_entry_rcu() is used under a
> different lock (not under rcu_red_lock()) because according to the current scheme a lockdep splat
> is generated when hlist_for_each_entry_rcu() is used outside of
> rcu_read_lock() or the lockdep condition (the cond argument) evaluates
> to false. So, we need to pass this cond when it is used under the
> protection of spinlock or mutex etc. and not required if rcu_read_lock()
> is used.

I understand this part. I was asking how you've identified them. Did you use 
any tool for that? coccinelle, sparse, ...

Kind regards,
	Sven

--nextPart2119546.QtC4LbVagd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl5JYVoACgkQXYcKB8Em
e0ZuPRAAmCB3qGjKpbrldhlDz7BJwE/RY7I7K2zMd0bsx9IV/WmU0fmsplSNNf9m
m7LaBD/F+4BxSBvaPlE19OXOTLurtetpsL9J7/RgP67jl9SBGglvTwNUtx45PoNZ
QTteXCARAK9DpzpYJzMZjeplDkJ0kH7OmTFlDypKNxFyRH+29ePII0TADeYfRo/7
B9TYrS/sT/idL15gm1KimGNbwjUpr+9KlBg6ASs2HlhhX/dI5Ah2Cpt9xZYD4FZ+
IF5AsS+s0wEln3Yycd4xyHEHUoYrP+MjF9k7MR+o7EalZD3/2LDUUPGy8akkkZ36
xOgDyfVVOWQ6Ew6r1fl5Tty4pz3Kkt7HewRsOkPUkJrX6JvxGoq+FlxEJwDv0oL7
fLsCl/A3otfLCqxGTlZaIKOJmBg1t/eeFGHx6c31yza6HxgH3X8uQ7i6RtRy7Vac
FNciX8lPZjqjldm3rRpVweopBB/11v72mZRsV/L50tx1piVfQtmYvtseSXPvyTfS
mQufCXGXdZ0UI6rVda9bzzO7Yi1c+I2sczMw5YA7mDrAeEWldVBT/mcJsoRTz4dh
uWGnh+fUbD5GFOSnkctXZkN4BVN75ZGztTfcsDdOF9Aa+JOq6mrljeSPsAgKxuly
DhbSVonE5CHUVgCD/4Mv8phrEbKRIBPbFFZjlmQ9fKz6cT+Rz/s=
=AU3U
-----END PGP SIGNATURE-----

--nextPart2119546.QtC4LbVagd--



