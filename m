Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20957C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FF520873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vqHnJfYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgE0MmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:42:24 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:57411 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728746AbgE0MmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:42:23 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 311C6D1D;
        Wed, 27 May 2020 08:42:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 27 May 2020 08:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=YAzT/i
        0ebKx3FpLJN9H2EfUuYMjgSleYWEoLvMZTlsE=; b=vqHnJfYXRqig7SVo6y+0sT
        K1+kSxInKVF3Tb3dsZYV9MV1LeL95oP0JUyuT3H8Z9eloOrAMEQnvhApifzzdd3P
        DCnoCtgE6/ppISTecgqZkiTEGeADCsx0nSe26bqogtDQq3/MkWF2EdVI4CHPL++d
        izQmOSHvkYipuM379y9OZDuIZO9fY5uHqgXedRESO7iXrgAUmKpE/RsiEhCQsmqe
        16wgBagd/QYyeVVMemtIgWYH1+j05F8I9QMtBPf3QhjDP60xOzh3FQ21Xywz1QfC
        nseda01f2Keu3akl16vx9dJ1Uq6q4/m4qkzbc0qWuep2403IW+VY+iHlMJo1f8GA
        ==
X-ME-Sender: <xms:LGDOXvAk0XHeHk6jpB8ZXa_blTWuypqUNuuwieV5CcKstxNVdj65sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesghdtreertdervdenucfhrhhomhephghojhht
    vghkucfrohhrtgiihihkuceofihojhhusehinhhvihhsihgslhgvthhhihhnghhslhgrsg
    drtghomheqnecuggftrfgrthhtvghrnhepleejheekjeevheeljeekfefhvddvieetjeei
    keetheeigeduhfdttdeihfdvleejnecuffhomhgrihhnpehrthhfugdrihhopdhgihhthh
    husgdrtghomhenucfkphepledurddugeehrdduieelrdeiheenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifohhjuhesihhnvhhishhisghlvg
    hthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:LGDOXlh2ctKov0IoVlHx1a-Km4nWC6BLiMy7EmzVzEAN5cWwunMrxw>
    <xmx:LGDOXqnLj9GsYEJfzE5h433zxrYzj3YztpjbRE8hfPS0I5bbfIc-iQ>
    <xmx:LGDOXhz54v1Nf8IsKXCTMVJSvf-oDyzIHH5yUv_MeCUXhBUd6w39qQ>
    <xmx:LWDOXnHwXDWy0VVphbBb80ndm8v0dOgNAL4Z1191amchCqX2_2H40xplqMg>
Received: from mail-itl.localdomain (91-145-169-65.internetia.net.pl [91.145.169.65])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7937E3061DC5;
        Wed, 27 May 2020 08:42:20 -0400 (EDT)
Received: by mail-itl.localdomain (Postfix, from userid 1000)
        id 017915D516; Wed, 27 May 2020 14:42:15 +0200 (CEST)
Date:   Wed, 27 May 2020 14:42:15 +0200
From:   Wojtek Porczyk <woju@invisiblethingslab.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Don Porter <porter@cs.unc.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200527124215.GK14256@invisiblethingslab.com>
References: <20200511045311.4785-1-sashal@kernel.org>
 <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
 <20200515164013.GF29995@sasha-vm>
 <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
 <20200518153407.GA499505@tassilo.jf.intel.com>
 <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
 <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
 <20200519164853.GA19706@linux.intel.com>
 <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
 <1276588f1ea395bdedf8b5e3af15666f0095dc0d.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Kynn+LdAwU9N+JqL"
Content-Disposition: inline
In-Reply-To: <1276588f1ea395bdedf8b5e3af15666f0095dc0d.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kynn+LdAwU9N+JqL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2020 at 11:20:08AM +0300, Jarkko Sakkinen wrote:
> On Fri, 2020-05-22 at 16:14 -0400, Don Porter wrote:
> > legacy code in SGX.  We have been following LKML discussions on this=20
> > instruction for years, and hoping this feature would be supported by=20
> > Linux, so that we can retire this module.  To our knowledge, every SGX=
=20
>=20
> Why have you followed this for years and never tried the patches?

For all the reasons stated before (we preferred a module, not a patchset, a=
nd
we didn't really care about implications), and because the general situation
about kernel drivers is a mess: Intel made three, mutually incompatible lin=
ux
drivers [1] and we used SDK driver, which incidentally is also how people
learn SGX programming in general.

With three different drivers and unclear future directions, we chose to wait
and see how the situation settles, so we stuck to the driver that was alrea=
dy
working.

Also, we're no kernel developers and there were/still are more urgent things
to fix in the graphene proper. For example we only recently have support for
running non-debug enclaves using DCAP LE [2].

[1] Here are my notes from when I was figuring out:
    https://graphene.rtfd.io/en/latest/sgx-intro.html#linux-kernel-drivers

[2] https://github.com/oscarlab/graphene/issues/881
    https://github.com/oscarlab/graphene/pull/978

--=20
pozdrawiam / best regards
Wojtek Porczyk
Graphene / Invisible Things Lab
=20
 I do not fear computers,
 I fear lack of them.
    -- Isaac Asimov

--Kynn+LdAwU9N+JqL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEaO0VFfpr0tEF6hYkv2vZMhA6I1EFAl7OYCgACgkQv2vZMhA6
I1EnzRAAreQQvrt9oGbSrtNJ9t2bQRyG5l0jT7OhCTRWX5Wtfkv6q5KO4IkRodbW
bBLhAs5kSo75oXiisJD+otDO03Do+wEeQIfGoPqewARqwPS90d/gcZUG7Wgyopvu
beFRssdIwjf3SM/0GpvnUyHKdq5Ewk0REyrY2yrUVnFX82J13Cg8REuDREtOOdra
HYeBwO84uRHGEG/Om3dBDRyujO0rWRB7w6etr6ZSEGhgPZV1Nq7fv/QMFCW0RTpm
NapBcgjnKNARZSYw+cy/PR5SFad0qTdluwN/g4OUE4Daei2/NwoXjvNkRAMI7DB8
itfPVPQqalunGSva2hWj1wwyGa3aToTsZGW/2wQXjijiDoaoGku49lg2DBkvphZs
CIieYeX1y2NY7PUozLGbLEZ/lEFLfPIJSanBYh1vIsM0Q+HKD/HCandC2mw7gNLD
QOH4LRflKm57UYhqtdokbQXKJAde992t+CMKtIg6snh/nIVo3HcIK0StQnMMdSn/
T/GXLxxA3I9SoKN1+Ua50Qww/SDXw7LX+isWcNv7fTUtLrn0i47O//m1OlsZ1Qj9
0qlRX5eec5xWmE/R+LwtVUSjGtLtpI4g5nWgpud/NVz6C8rcXVsTy1BeehrJCpXH
ZmmO6W+WKlG7C8XiBKL4HZyzQr0lLFhTQ2oz/pIksiehue5QP+E=
=rRZW
-----END PGP SIGNATURE-----

--Kynn+LdAwU9N+JqL--
