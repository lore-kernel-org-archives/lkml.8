Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2020C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26CF2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598385528;
	bh=euL7dOwygreMqJCxJDu/rwV87sFHsXjDSxU+JvTAe3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uLWNX9GWU/4I2bmR+O/Y60PCCJ99mIbkvj7Bv/bW9tdvs/Xl/uCtm0SV3AHqI/aW1
	 rAFlqkdlQeLtLoIW2qm3m0O1NBrTQF1+cUrkyc1KhKg09RCvrvPjGTNkBMiRVbjpFc
	 pCeNknq/vAf/FK6g79bg88WzbFyXS0kbhvgPHbjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHYT6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYT6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:58:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5311F2076C;
        Tue, 25 Aug 2020 19:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598385524;
        bh=euL7dOwygreMqJCxJDu/rwV87sFHsXjDSxU+JvTAe3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wonZ3hHlyHR+4Pgn+d5Km+fta1URsRAG4cdcnh6HDW+UR0qHHc5nlGYMW+Tg6oif5
         usIQiq0uVlDqppbA++v96ifW14Yr6pg/SQF++fD1F62r5s1lX9T/cHPV2SOiCdSZWv
         ecLnBHTEyA9ONi6YI1ouW3V35BLWCfVOQy12wQE8=
Date:   Tue, 25 Aug 2020 20:58:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 3/4] regulator: core: Add basic enable/disable support
 for sync_state() callbacks
Message-ID: <20200825195809.GH5379@sirena.org.uk>
References: <20200716042053.1927676-4-saravanak@google.com>
 <20200720142753.GF4601@sirena.org.uk>
 <CAGETcx96AuV=1rcyMAv5QGpGp0BqfWa40Fq-DShrBeY5Q61zkQ@mail.gmail.com>
 <20200721201808.GD4845@sirena.org.uk>
 <CAGETcx9+DUXyLnu0Rjom6oMpJvsdewbzvz=uW6xYOUjPD_Z=9A@mail.gmail.com>
 <20200804211049.GC5249@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v2Uk6McLiE8OV1El"
Content-Disposition: inline
In-Reply-To: <20200804211049.GC5249@sirena.org.uk>
X-Cookie: Don't get to bragging.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v2Uk6McLiE8OV1El
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 04, 2020 at 10:10:49PM +0100, Mark Brown wrote:
> On Tue, Jul 28, 2020 at 02:14:52PM -0700, Saravana Kannan wrote:

> > So, say you have a callback that you get for every single consumer
> > binding successfully. What can you do there? For every consumer, you
> > have to parse their firmware (Eg: DT node) to see what all resources
> > they use (Eg: all the -supply properties)

> Again off the top of my head we could also do this the other way around
> and when making a link go and ask the subsystems if it's their link and
> they have a better idea about where to put it.  Actually, having found
> the code that adds the links we don't even need to ask the subsystems if
> it's their link - we already know at the time we're doing the parsing
> which subsystem a link relates to!  Perhaps we could do some of this
> checking/notification at the time links are connected/satisfied rather
> than at parse time, or perhaps when the suppliers register they could
> look at outgoing links.

> We already have a set of links and we already have the ability to figure
> out which resources they're talking about, we just need to join those
> two things up which shouldn't be an intractable problem.

So, having taken a look at the device_link stuff in the driver core it
seems like it should be easy enough to add another parameter to
device_link_add() or a variant thereof so we can get a supplier ID of
some kind to the core (eg, a callback plus ID) along with the link so I
don't see any issue with getting the data in there.

We then need to figure out how to use that in device_links_driver_bound(),
that is currently unconditionally kicking _queue_sync_state() for every
supplier to go check if we need to do the sync_state() so would seem to
be the logical place to schedule a per subsystem callback.  It also
deletes the link if it was a _SYNC_STATE link which does make things a
bit more fun but we can always remember which link we're deleting and
pass that on when scheduling the kick.  Indeed, it occurs to me that we
could be cute here and in _queue_sync_state() have it check while
scanning the consumer links to see if we find a consumer with the same
subsystem callback information and if we don't then that must've been
the last link that just got deleted and we can call the callback.

That's not quite everything, in particular at least for any subsystem
where the core can be modular you'd need to have a layer of indirection
for the callback (it's possibly a good idea to do that anyway), but I'm
not seeing anything new with regard to locking or whatever.  It looks
like the work already done for basic sync_state() should be reusable
unless there's some nasty gotchas I'm not seeing, that was pretty much
what I was expecting to see TBH.

BTW doesn't the fact that we throw away the _SYNC_STATE_ONLY links cause
fun if the provider driver gets unbound then rebound?  We don't reparse
the DT to re-add those links.  I'm also not seeing where we ever clear
the state_synced flag that gets set which seems like it'd break things
if a supplier gets removed and reprobed.

--v2Uk6McLiE8OV1El
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9FbVAACgkQJNaLcl1U
h9DQ0Qf9Hhs1px2Xm6vG0gCm68TCOey66Ff6ZwDgzGm0yxYXmoMfLMnw9NvGa+oR
E8EbENQjIEignUSMxqlZZSJRaCAlSd+isvNV0k6vsum2gD2R0HV1mtZRtWWXovn1
Z87Tzlts10xDqmBPI07DpPcz1zIkk1NyFXM340locH2v6PvVJDPW2SWllO4sT+LX
TGe7cfaqKuOKS7qQH+sAwQGpG8YQGJFJlrniMsWoW6zV2DhLsVj4OTJCl3nFVtun
a6e7biwHtNKPPz8p2jtTRlObEVpHYXghFgL5QB1ZBv9G1YT4ERtPxfhzbfCTdmVs
glQ04+l+2DOvdCyIkdIisn0E9g+aiw==
=l5xc
-----END PGP SIGNATURE-----

--v2Uk6McLiE8OV1El--
