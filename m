Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D95BC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17502080C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UpiOUVjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgCSQFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:05:34 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55651 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727064AbgCSQFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:05:34 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C5CA65C020F;
        Thu, 19 Mar 2020 12:05:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 19 Mar 2020 12:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wWFORM
        IkzrdKUS43ENF76LKOdqMsS2ZRBw2Ost6Bedk=; b=UpiOUVjNjhubGU+xk98dcZ
        +pBWDcBQKE0scE+jmFJkt8CwffNG9cakLSwvN+FlsU5Upb/Fuwx3GsoN70U2jMRY
        6OXKbuo5XnITjcGDjdnRF/C+Vk4LZv61ySbhMBasYhYdGkgzzQmwaZQRC/1RRQBB
        hjMyEVE5UfjeH2WbMHcEMqg+2bRs02GqBFpSJ/ZdSCm/L6/ZnKrgf1BI93Y2+9Ss
        Q+aoGkY68+MnhGqz1PujRA3JLxZ5/uKX7RDJ8gCL7hMasVDQ6h83uIQ4BNSuFCoL
        0jiS7yUJTI13GQN0a6XMYqDbWJr7dSfxOcV5iO4b0c50fwUc9NeGyNfAoAnVHT1w
        ==
X-ME-Sender: <xms:TJhzXt7yPI9118_5BN3joj3j7JwD9wTXuf8vwNgTspPhZ8-PqtJu7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefledgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucfkphepledurdeihedrfeegrdef
    feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    hrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:TJhzXiXUoNnHka3YRbjFwxVTlOT11qUyGRA_CaK7q2ZXMIlrnNcNEg>
    <xmx:TJhzXh2arQRsRd0lV3hTFp67helnAXBaKjQIIDc13LOmErjn85H6Yg>
    <xmx:TJhzXv0v5xepb7d2yfGtutEncQQQEM3DfEuU6auMqJXsFfC-5YWJfQ>
    <xmx:TJhzXpHkJOrxQJAypVl9S32j4_DGuuda2GrZT93FgdOMvtYkKLyk9w>
Received: from mail-itl (ip5b412221.dynamic.kabel-deutschland.de [91.65.34.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id 51E47328005E;
        Thu, 19 Mar 2020 12:05:31 -0400 (EDT)
Date:   Thu, 19 Mar 2020 17:05:24 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-pciback: fix INTERRUPT_TYPE_* defines
Message-ID: <20200319160524.GX18599@mail-itl>
References: <20200319040648.10396-1-marmarek@invisiblethingslab.com>
 <e6c48552-9866-497c-7d2f-62849122f867@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xaJmculcd5PV2weY"
Content-Disposition: inline
In-Reply-To: <e6c48552-9866-497c-7d2f-62849122f867@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xaJmculcd5PV2weY
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] xen-pciback: fix INTERRUPT_TYPE_* defines

On Thu, Mar 19, 2020 at 11:07:13AM -0400, Boris Ostrovsky wrote:
>=20
> On 3/19/20 12:06 AM, Marek Marczykowski-G=C3=B3recki wrote:
> > INTERRUPT_TYPE_NONE should be 0,
>=20
>=20
> Would
>=20
> =C2=A0 return ret ?: INTERRUPT_TYPE_NONE
>=20
> in xen_pcibk_get_interrupt_type() work?
>=20
>=20
> I think it's better not to tie macro name to a particular value.

I can do that too. But I'd change INTERRUPT_TYPE_NONE to 0 anyway, as
more logical value (as the value is a bitmask).

> -boris
>=20
>=20
> >   as it is assumed in
> > xen_pcibk_get_interrupt_type(). Fix the definition, and also shift other
> > values to not leave holes.
> > But also use INTERRUPT_TYPE_NONE in xen_pcibk_get_interrupt_type() to
> > avoid similar confusions in the future.
> >=20
> > Fixes: 476878e4b2be ("xen-pciback: optionally allow interrupt enable fl=
ag writes")
> > Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblething=
slab.com>
> >=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--xaJmculcd5PV2weY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl5zmEQACgkQ24/THMrX
1yyYtwf+Pg91y5j0VuyfObz5D6ca2GNocsfVmm3WdXCHHpgx6nmJMWkfq+JWk+De
Qqp/HjmenfTPVnYbkRgE9A9qiCT/eQ1WTkfAmk+0oqQIcuNrv4lssV5QtS+b3D8X
ToKagzMOYGS0WMcMEbbAs9N9rLnJVOJw0PRI3HcTsoNoWNymyIVrLgoyoBYTGx0O
J8vHvSydTsAuwf1KESUnglaEBr/KTLwNOya5lccQaSEYYu2vbqIhinyOI1v2pP27
cTMYNR5TGxjcCCAWB7BvzhUq0Xe4OTYEbB3WMhHnq+OsxrHKsAMYpm+3CCBI/suJ
oJ22cTJ/CG7dyGddWmdrkbbtUHuVFA==
=uRFZ
-----END PGP SIGNATURE-----

--xaJmculcd5PV2weY--
