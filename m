Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A61C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9372B20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597076618;
	bh=ZKceNH2ULa9iPquC7TZxDyNWDhEer5e3FG/Ncr9/4Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fd11Pk/cqfX/J9XyQzN/BbKWcZL34hSbY52V8SjutEt6zUpJBsD+RrEwI3wyjkPnf
	 VtITVhtSALYOdVlb7aL31SzASICJJRCu68E1mEh6awlb3LH3TO7rMxdJMdxvUSK+1M
	 6oR88aVIiNt0HxL+qB1EgCOA4+0aHu0QeVSAe0UQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgHJQXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgHJQXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:23:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A174E2083B;
        Mon, 10 Aug 2020 16:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597076616;
        bh=ZKceNH2ULa9iPquC7TZxDyNWDhEer5e3FG/Ncr9/4Lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HLvO0zwndQbDbK9b7T4caLTKRbqThzUSbvcNFSecZvNwXXiJtzeB3Sg/TKpPp+C9i
         9zeqwg0cEdhupkx7QC1+n5qpetjaSkg4TpI8JhujyDgNd0yTgDl3tt4edSJuRgWXi9
         z7Kg25n2K73ncgNmp4X+aQsLMzJm5AWDjAO6HYaM=
Date:   Mon, 10 Aug 2020 17:23:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: simplify locking
Message-ID: <20200810162310.GE6438@sirena.org.uk>
References: <b22fadc413fd7a1f4018c2c9dc261abf837731cb.1597007683.git.mirq-linux@rere.qmqm.pl>
 <40871bc7-2d6c-10d4-53b3-0aded21edf3b@gmail.com>
 <20200809223030.GB5522@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20200809223030.GB5522@qmqm.qmqm.pl>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 12:30:30AM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> On Mon, Aug 10, 2020 at 12:40:04AM +0300, Dmitry Osipenko wrote:
> > 10.08.2020 00:16, Micha=C5=82 Miros=C5=82aw =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:

> > > -	mutex_lock(&regulator_nesting_mutex);
> > > +	if (ww_ctx || !mutex_trylock_recursive(&rdev->mutex.base))

> > Have you seen comment to the mutex_trylock_recursive()?

> > https://elixir.bootlin.com/linux/v5.8/source/include/linux/mutex.h#L205

> >  * This function should not be used, _ever_. It is purely for hysterica=
l GEM
> >  * raisins, and once those are gone this will be removed.

> I think that reimplementing the function just to not use it is not the
> right solution. The whole locking protocol is problematic and this patch
> just uncovers one side of it.

OTOH if this is just making the issue more obvious rather than fixing it
then it's much harder to justify adding a new usage of a function people
are trying to remove.  The coupled regulator stuff is definitely a mess
as far as locking is concerned, it really interferes with the model we
had handling regulators separately as much as possible since we're no
longer just walking back up the tree.  ww does seem like the way
forwards.

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8xdG0ACgkQJNaLcl1U
h9BWoQf+JbDPp8Tfh2/5nFAzZWTICCoW0YcHtderHiFcH3N+rRdKk3rWi9CdRdsO
+kuAnfInlBb3RmwDRLNc3Fa3EiRgFjN2uOErdL/VpThkf9U2rHheuR7IxmzWUn8k
alJ4rvIbTgRrvRce4FBAz8O/mldWPFh1bAl+WU7CTc8pZzQh4V9o9khJriZDQ0vi
eIcr6K0/Kds2RGHZe3uODo9QRp73q9OBcGaaGk1+6Mf6CDqIRlW72VjpIGYJbr+J
JYymVcmusiMUpKKCRhMwWFzwoA5lTD2A2f1rNI29AljyBCQ7eSu6PkLqUtQJvRXE
NrOJHgMY7fwAWXn9r2e6CVsNTWh/DA==
=2G3K
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
