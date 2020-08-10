Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF45CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB5220709
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597062203;
	bh=riUHGJxEN2MgIeUVakW29w6l3LZAx+87Su4vu8zrUvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mvAsQ/fy8EjBZ69N99by7QIBq1iWMP95kO6Dr0FjPf7tkend4VZgtNULjFVYXY51Q
	 wBs3+oV6CMdE5ereAaAa6YuwN541vQcPUlKp4GeuNqU2BwRM7XEJszhaFvlh3qw1G2
	 upnl1I7xWXWZ2QjeLI51BWToj1KwKNwKLDxdulsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHJMXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgHJMXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:23:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 340F820709;
        Mon, 10 Aug 2020 12:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597062200;
        bh=riUHGJxEN2MgIeUVakW29w6l3LZAx+87Su4vu8zrUvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8RHntfeMc0goME66sM569RbeEXpLaBVBPXYVFyFDgT0zNoEcMTPa6PhegDsE9aq7
         ubApH/iItYHwFax6zq4iZa+ls6kfaOpVrqfNKPKD3s0MmgCMd90S+fxw1HgEn9KMJZ
         VzYhZtyXnaRgpVzxJUfoT3AqN+yPs033GxdSqMnQ=
Date:   Mon, 10 Aug 2020 13:22:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [GIT PULL] sound updates for 5.9
Message-ID: <20200810122254.GA6438@sirena.org.uk>
References: <s5hbljocbxl.wl-tiwai@suse.de>
 <CANcMJZCPPOOmKyRMKYRe5sRsqf-rrO6wXK5BPVwFrAPLZOEyMg@mail.gmail.com>
 <s5hv9ht7hz9.wl-tiwai@suse.de>
 <s5ho8nl7e7r.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <s5ho8nl7e7r.wl-tiwai@suse.de>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 08, 2020 at 10:07:36AM +0200, Takashi Iwai wrote:
> Takashi Iwai wrote:

> > Does the patch below fix the bug?  If so, it's rather a bug in the
> > commit cf6e26c71bfd ("ASoC: soc-component: merge
> > snd_soc_component_read() and snd_soc_component_read32()").

> That said, the commit cf6e26c71bfd dropped the capability of returning
> an error code from snd_soc_component_read() completely, while many
> code still expect an error gets returned.  The assumption mentioned in
> the patch (the error can be ignored) looks too naive.

I did an audit of the users when the series was posted and wasn't able
to turn up any code doing anything constructive with the return values,
but then once you're past probe error handling often makes things worse
if you try.  This is the first one which actually seems to have had an
impact.

> Morimoto-san, Mark, could you address it?  IMO, we may still need two
> variants in the end again: the former snd_soc_component_read32() that
> returns the value directly and snd_soc_component_read() that returns 0
> or an error.  Only once after we deal with the error handling in each
> caller side, we can unify the read functions.

I'm not sure if that specifically is what we need but yeah we should do
something, if it fixes things your change is certainly good for the
immediate problem so could you send it with a signoff please? =20

With the new code we do now have the core code printing an error message
if the I/O fails, before they were just being ignored more often than
not.  This did turn up a couple of cases where drivers were relying on
being able to do things like silently read from registers that just
don't exist or aren't currently accessible without any diagnostics which
is it's own problem :/ (especially the volatile cases).

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8xPB0ACgkQJNaLcl1U
h9CRSgf+PxXdAuu2YdptI3oe+dSKPcwnBRojaZipHcco4GP47CI0YM+TbvBqa+2c
FNWr4erpHrT1o8Rf+3v6z6Uidj42CQH00NVXCbUX6Vyy1ZMcBt0FRUz0NENJ0rRD
u9Mzsupi7CCdElLtaP+QQRsDmdv9SN6AU4rWzkfIcDO8XrXedXfoQfGqHMHz30Yq
Bzkd6kDojBCBTlN+XCl6s0sTtfYcYthjjRXUdC/f3yzBkzOXsKs2OwlJEBtWVKhs
B3o3DNjYXhDCa8JBqRye3gKLmO8/Xm2U0Ei/zFdEvtFhr8K2NyJW6ReUR8vUlBUp
M652ROvq6t7aRPztI2nn6BgKoiCWGA==
=c8WD
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
