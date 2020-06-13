Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDBCC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2392E20789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgFMTnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 15:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgFMTnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 15:43:16 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 13 Jun 2020 12:43:15 PDT
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30802C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 12:43:14 -0700 (PDT)
Received: (qmail 15989 invoked from network); 13 Jun 2020 19:35:46 -0000
Received: from p548c722b.dip0.t-ipconnect.de ([::ffff:84.140.114.43]:44238 HELO daneel.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.37dev) with (DHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA
        for <deller@gmx.de>; Sat, 13 Jun 2020 21:35:46 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     Helge Deller <deller@gmx.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] parisc: suppress error messages for 'make clean'
Date:   Sat, 13 Jun 2020 21:36:23 +0200
Message-ID: <2867805.ELcs8R50RY@daneel.sf-tec.de>
In-Reply-To: <11e05a6d-e4bd-e381-7015-2d52e8fdef39@gmx.de>
References: <20200425054659.814774-1-masahiroy@kernel.org> <CAK7LNAR+jEzqqFJbCzfEbdnt-H4ZRpfLFA30ODfhhH=QXSk5nQ@mail.gmail.com> <11e05a6d-e4bd-e381-7015-2d52e8fdef39@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4463957.xWWP958Aob"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4463957.xWWP958Aob
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Helge Deller wrote:
> On 10.05.20 03:19, Masahiro Yamada wrote:
> > Hi Helge,
> > 
> > On Sun, May 10, 2020 at 2:39 AM Helge Deller <deller@gmx.de> wrote:

> > I will drop this patch from my kbuild tree,
> > then you will apply what you think is best
> > to your tree.
> > 
> > What do you think?
> 
> Sure, I'll take it through the parisc tree.

Is this already in 5.7.2? I get these:

pioneer /usr/src/linux-5.7.1-gentoo #  make distclean
gcc: error: missing argument to '-Wframe-larger-than='
gcc: error: missing argument to '-Wframe-larger-than='
  CLEAN   arch/parisc/kernel
gcc: error: missing argument to '-Wframe-larger-than='
gcc: error: missing argument to '-Wframe-larger-than='

Eike
--nextPart4463957.xWWP958Aob
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCXuUqtwAKCRBcpIk+abn8
TlUNAJ9D579FJ31GZv8t6k7kM0O0cXFgNwCgmsbSbWM3NWagMGuRJWuIO6tC1K4=
=fnC1
-----END PGP SIGNATURE-----

--nextPart4463957.xWWP958Aob--



