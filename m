Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2FEC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21417207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgIAVQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 17:16:31 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59678 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgIAVQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 17:16:30 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 221FB1C0B9C; Tue,  1 Sep 2020 23:16:28 +0200 (CEST)
Date:   Tue, 1 Sep 2020 23:16:26 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sean Young <sean@mess.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju@tsinghua.edu.cn>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 016/125] media: pci: ttpci: av7110: fix possible
 buffer overflow caused by bad DMA value in debiirq()
Message-ID: <20200901211626.GA17861@duo.ucw.cz>
References: <20200901150934.576210879@linuxfoundation.org>
 <20200901150935.368387062@linuxfoundation.org>
 <20200901162512.GA30837@gofer.mess.org>
 <20200901163523.GA1458104@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20200901163523.GA1458104@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-09-01 18:35:23, Greg Kroah-Hartman wrote:
> On Tue, Sep 01, 2020 at 05:25:12PM +0100, Sean Young wrote:
> > Greg,
> >=20
> > On Tue, Sep 01, 2020 at 05:09:31PM +0200, Greg Kroah-Hartman wrote:
> > > From: Jia-Ju Bai <baijiaju@tsinghua.edu.cn>
> > >=20
> > > [ Upstream commit 6499a0db9b0f1e903d52f8244eacc1d4be00eea2 ]
> > >=20
> > > The value av7110->debi_virt is stored in DMA memory, and it is assign=
ed
> > > to data, and thus data[0] can be modified at any time by malicious
> > > hardware. In this case, "if (data[0] < 2)" can be passed, but then
> > > data[0] can be changed into a large number, which may cause buffer
> > > overflow when the code "av7110->ci_slot[data[0]]" is used.
> > >=20
> > > To fix this possible bug, data[0] is assigned to a local variable, wh=
ich
> > > replaces the use of data[0].
> >=20
> > See the discussion here:
> >=20
> > https://lkml.org/lkml/2020/8/31/479
> >=20
> > It does not seem worthwhile merging to the stable trees.
>=20
> It doesn't hurt either :)

Update stable kernel rules.

If "patch does not match description and is pretty obviously useless"
but "does not hurt" is acceptable for stable tree, people should know.

You are pushing known junk into stable. Stop that.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX066KgAKCRAw5/Bqldv6
8leEAKCAPPnxVddaWsVzK5zoQhG5xzz8XwCeLZN+mO8+VPzV6i81Rch/gSNDfdg=
=tgI0
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
