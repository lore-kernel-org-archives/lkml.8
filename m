Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D0BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 10:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2AC20776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 10:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgE3KN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 06:13:57 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35442 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3KN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 06:13:56 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 197F31C0BD2; Sat, 30 May 2020 12:13:55 +0200 (CEST)
Date:   Sat, 30 May 2020 12:13:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Edward Shishkin <edward.shishkin@gmail.com>
Cc:     ReiserFS development mailing list 
        <reiserfs-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Reiser5: Data Tiering. Burst Buffers. Speedup
 synchronous modifications
Message-ID: <20200530101354.GA630@duo.ucw.cz>
References: <4f919dee-5b72-9269-2bd0-6818a7167864@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <4f919dee-5b72-9269-2bd0-6818a7167864@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> For example, you can use proxy device to store hot data only. With
> such strategy new logical blocks (which are always "cold") will always
> go to the main storage (in contrast with Burst Buffers, where new
> logical blocks first get written to the proxy disk). Once in a while
> you need to scan your volume in order to push colder data out, and
> pull hotter data in the proxy disk. Reiser5 contains a common
> interface for this. It is possible to maintain per-file, or even per-
> blocks-extent "temperature" of data (e.g. as a generation counter),

Would it be possible to offer userland interface for this? I can
probably say that mp3/video files should be cold, while some source
files should be hot, etc...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXtIx4gAKCRAw5/Bqldv6
8oF2AJ4hfCKfuD86iK8M3DhcyfcE3WlYlACbBEXlg9NI2nOms1moiyGTWJQjS68=
=x8me
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
