Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72CCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A262E22D6F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597074001;
	bh=YOM+g/TR562Qnqd9mjPiiw/B/53j8zLV2C2vybC4Y3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V7VHBXGVcfT11mQuVWWglN48/iBu+KNlf0IOzcAGcGsD2a8JQkt4J0SBSjt5w/s3S
	 xGcWUeJccwemaw/obwn35Bdfs3moXcKmoWOdS/1N7ZSxUEHe1I7l0zpI4+oUJctLTT
	 QQ5Z6xJKN+srYm8dZrTQOHnSftlhriNGcdN5dQoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgHJPj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728869AbgHJPj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:39:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C4B022D6F;
        Mon, 10 Aug 2020 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073995;
        bh=YOM+g/TR562Qnqd9mjPiiw/B/53j8zLV2C2vybC4Y3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eesmhdwrQECMSX9NuYuFlxIep7RfnnDf/qDMe8aSjXl/LMrf2xCxCGXH7j00wCKMF
         7NOXfKahT5R1UMzZvwNllwJv6n4hF1rCjZlTOXz2t3fpatBC2a3U9eY/fmlzxYg90R
         doF7JwzAYFgNCJ8lbhzMwAqyI6bye5iRXRRASkDI=
Date:   Mon, 10 Aug 2020 16:39:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: regulator: deadlock vs memory reclaim
Message-ID: <20200810153928.GD6438@sirena.org.uk>
References: <20200809222537.GA5522@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20200809222537.GA5522@qmqm.qmqm.pl>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 12:25:37AM +0200, Micha=C5=82 Miros=C5=82aw wrote:

> regulator_lock_dependent() starts by taking regulator_list_mutex, The
> same mutex covers eg. regulator initialization, including memory allocati=
ons
> that happen there. This will deadlock when you have filesystem on eg. eMMC
> (which uses a regulator to control module voltages) and you register
> a new regulator (hotplug a device?) when under memory pressure.

OK, that's very much a corner case, it only applies in the case of
coupled regulators.  The most obvious thing here would be to move the
allocations on registration out of the locked region, we really only
need this in the regulator_find_coupler() call I think.  If the
regulator isn't coupled we don't need to take the lock at all.

> Basically, we have a BKL for regulator_enable() and we're using ww_mutex
> as a recursive mutex with no deadlock prevention whatsoever. The locks
> also seem to cover way to much (eg. initialization even before making the
> regulator visible to the system).

Could you be more specific about what you're looking at here?  There's
nothing too obvious jumping out from the code here other than the bit
around the coupling allocation, otherwise it looks like we're locking
list walks.

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8xajAACgkQJNaLcl1U
h9BNnQf/VnLzsKZ8MKsJKrUcITrwjL4Ty5NlAVZt14rULY5df4rpXxQ97YKGkwjD
GK0sP3nSmNHte2WUXjPfP86H+JuWk0tpOv6g06miuuFeC0bdrSZ17dchZikGM7n+
cGQHJ7x50NRtIRjjLE01h+huS61aYd/XBGZPcTpPgx8r724FoNGUWq7Ufyw0vc5f
tZFVl0F5BvDmwwgtsFBkv16VtPyDMoZp7W/oEBaECcH1myFmOMdyZ/NYQ4TfEEgt
NADH2+Z6wFJGEH4B6nkXkxAY2lY3Ya5eq8UiE9TuQru6qre59l5rC7lQTKRcRNcf
/O6+7aYsRw36Ij/2ViyNCV929Hn6tQ==
=oiI0
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
