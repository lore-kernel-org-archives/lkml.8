Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8E7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9867206F6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aXXvr3Nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgHCEKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 00:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHCEKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 00:10:23 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2A9C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 21:10:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BKktz1RXGz9s1x;
        Mon,  3 Aug 2020 14:10:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1596427820;
        bh=YhI2SWaVaWNDumeeexvmrh3MFFyaXPRDfwzsb+cIWZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aXXvr3NkybheAI34Dh7/+ZYft4PAnsJ9hBV3Er1bpQgKdYY+VNpQ85ZcrDUaptjPq
         dqw969Pb+4MTgV7/WPK6d4U6f98juepVfJnHumwGi9JqyIYJhHmnwq0Vo3va8voCZI
         4+40cqs39L3FDHHodiy8TS7DQkm1XXQVux0O+6N3vJBIRH+x7uv4LuWB8EFpOPSCum
         I9eV9NBXdHYBbmV4LImZ3YzqdLoKYliW6M+cLj9novevfxDEYU0M9yCit+xLS1SHJN
         cSTWPoOEUgfh2jXdEIq7rZrL5DRD/QIhK8G5Sq+okOev1VP8P7slN4XLTfOpgS72St
         /cpqkqfbGBgKw==
Date:   Mon, 3 Aug 2020 14:10:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: powerpc: build failures in Linus' tree
Message-ID: <20200803141017.55dd6cc7@canb.auug.org.au>
In-Reply-To: <20200803034547.GA15501@1wt.eu>
References: <20200802204842.36bca162@canb.auug.org.au>
        <20200802172019.GB26677@1wt.eu>
        <20200803034547.GA15501@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VtS.Fz8QmP_QcKN9Y_/nvuK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VtS.Fz8QmP_QcKN9Y_/nvuK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Willy,

On Mon, 3 Aug 2020 05:45:47 +0200 Willy Tarreau <w@1wt.eu> wrote:
>
> On Sun, Aug 02, 2020 at 07:20:19PM +0200, Willy Tarreau wrote:
> > On Sun, Aug 02, 2020 at 08:48:42PM +1000, Stephen Rothwell wrote:
> > >=20
> > > We are getting build failures in some PowerPC configs for Linus' tree.
> > > See e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/14306515/
> > >=20
> > > In file included from /kisskb/src/arch/powerpc/include/asm/paca.h:18,
> > >                  from /kisskb/src/arch/powerpc/include/asm/percpu.h:1=
3,
> > >                  from /kisskb/src/include/linux/random.h:14,
> > >                  from /kisskb/src/include/linux/net.h:18,
> > >                  from /kisskb/src/net/ipv6/ip6_fib.c:20:
> > > /kisskb/src/arch/powerpc/include/asm/mmu.h:139:22: error: unknown typ=
e name 'next_tlbcam_idx'
> > >   139 | DECLARE_PER_CPU(int, next_tlbcam_idx);
> > >=20
> > > I assume this is caused by commit
> > >=20
> > >   1c9df907da83 ("random: fix circular include dependency on arm64 aft=
er addition of percpu.h")
> > >=20
> > > But I can't see how, sorry.
> >=20
> > So there, asm/mmu.h includes asm/percpu.h, which includes asm/paca.h, w=
hich
> > includes asm/mmu.h.
> >=20
> > I suspect that we can remove asm/paca.h from asm/percpu.h as it *seems*
> > to be only used by the #define __my_cpu_offset but I don't know if anyt=
hing
> > will break further, especially if this __my_cpu_offset is used anywhere
> > without this paca definition.
>=20
> I tried this and it fixed 5.8 for me with your config above. I'm appending
> a patch that does just this. I didn't test other configs as I don't know
> which ones to test though. If it fixes the problem for you, maybe it can
> be picked by the PPC maintainers.

Our mails have crossed.  I just sent a more comprehensive patch.  I
think your patch would require a lot of build testing and even then may
fail for some CONFIG combination that we didn't test or added in the
future (or someone just made up).

--=20
Cheers,
Stephen Rothwell

--Sig_/VtS.Fz8QmP_QcKN9Y_/nvuK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8njikACgkQAVBC80lX
0GxI0ggAgFHUOVKcLiTKMUDyziwTW2zq4UM2G950FogluMsm24YrfvOYeb3+u8H+
8lsdLMcfs/IDXHTIRLa5EXmCqOwF4kQrWq0N4UDCxT3xnOUxCqDEFk/3C8XhLa1V
dLn8YRzz6WRoaDYDdv9A+X69aBViuxfKZiuOJebL+qLvHtHjXDKtAgY+IntYaBy9
YalXdqYVzTkFmwncatLOXcnbi4UMgHpJhWCdQv1MvA8/iPU9aJSOW0MV2auHv0Qa
Ehwb55Mg0wBW9Nt8/A0UUSxZoacz83tS8uIwl5mebIfhkgq+xWLKOaz2LS5+UgMn
Z+NLkYZ6JAo6qkNFiYJ0E+zRhhfTuw==
=AS/6
-----END PGP SIGNATURE-----

--Sig_/VtS.Fz8QmP_QcKN9Y_/nvuK--
