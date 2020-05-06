Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8AAC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93902075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FYshvVMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgEFUfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726093AbgEFUf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:35:29 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A30C061A0F;
        Wed,  6 May 2020 13:35:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49HSyh6XhJz9sRY;
        Thu,  7 May 2020 06:35:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588797326;
        bh=NwcnAUxzQxfI5RiY9l3BwK9CdPv/e/PbCfVJoOYWUoM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FYshvVMM/U1YFW6ccHtYPqBwXN9gzBFM6KbNPSf8D9LJya7mLJAZO09pReDd/HxBA
         qC7nPQ/xsYpMdL72AnjM4zLiypLJkB7mjfwRq1NYtTTFKOftI3oiuVr1AK4gMUnzmP
         lnaL+Nos6LzPqziaj9wE8D6vbZoZTMZm+GOZd7Sjl6knIQX9HnEeHCBKinav4ObBby
         vjUD/eUfbhTTrWsdwuqV2hnrl3S3uxglxdDglaUajv1qVknQr9Jfr17np26FGH+OY5
         DyN8h++jD9DsgOlQh3zbklaG4qEkdZEZRx16anIK7RPnJlKMGf85hFxYIWwnFRIgig
         2TyJAKyoOAJOQ==
Date:   Thu, 7 May 2020 06:35:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Qian Cai <cai@lca.pw>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Amol Grover <frextrite@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        syzbot <syzbot+1519f497f2f9f08183c6@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: linux-next boot error: WARNING: suspicious RCU usage in
 ipmr_get_table
Message-ID: <20200507063524.5356b923@canb.auug.org.au>
In-Reply-To: <1D570330-8E3E-4596-AD9B-21CE6A86F146@lca.pw>
References: <000000000000df9a9805a455e07b@google.com>
        <CACT4Y+YnjK+kq0pfb5fe-q1bqe2T1jq_mvKHf--Z80Z3wkyK1Q@mail.gmail.com>
        <34558B83-103E-4205-8D3D-534978D5A498@lca.pw>
        <20200507061635.449f9495@canb.auug.org.au>
        <1D570330-8E3E-4596-AD9B-21CE6A86F146@lca.pw>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ucjhpYCb9TG.8NNMwqXguvb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ucjhpYCb9TG.8NNMwqXguvb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Qian,

On Wed, 6 May 2020 16:21:05 -0400 Qian Cai <cai@lca.pw> wrote:
>
> > On May 6, 2020, at 4:16 PM, Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
> >=20
> > Hi Qian,
> >=20
> > On Tue, 28 Apr 2020 09:56:59 -0400 Qian Cai <cai@lca.pw> wrote: =20
> >>  =20
> >>> On Apr 28, 2020, at 4:57 AM, Dmitry Vyukov <dvyukov@google.com> wrote=
:   =20
> >>>> net/ipv4/ipmr.c:136 RCU-list traversed in non-reader section!!   =20
> >>=20
> >> https://lore.kernel.org/netdev/20200222063835.14328-2-frextrite@gmail.=
com/
> >>=20
> >> Never been picked up for a few months due to some reasons. You could p=
robably
> >> need to convince David, Paul, Steven or Linus to unblock the bot or ca=
rry patches
> >> on your own? =20
> >=20
> > Did you resubmit the patch series as Dave Miller asked you to (now that
> > net-next is based on v5.7-rc1+)? =20
>=20
> Actually, it was Amol not me who submit the patch, so let him to answer t=
hat.

Oops, sorry.
--=20
Cheers,
Stephen Rothwell

--Sig_/ucjhpYCb9TG.8NNMwqXguvb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6zH4wACgkQAVBC80lX
0Gw2Lgf/VFgex0t54wjG2dK6n/EDR0ThAd6SoZHRqdGtVbVRAHps0PhM62aD/GQ5
D2KAQzZixnpRDBLLATL+ksUDeDCFm0xWDtuMy82wSSJXw4Klvflxu/PgsNmer104
IrJ8SJ1JYPPmKdA/vdvXr054Hqp9/BRU8PuNV93NjZ/5iSLcYZWUR+WAh3lUrwm1
b9hq27kuMuY7pKVbDZBHpMz7IXxhPjmnupnx/56TdkcPvyojbUCvkCC89fARxpTi
5L+qvYr5PSUMYRiV5TcU4gg0Vq8KBIqhCQ2synBC7Phf6mFwrr8tcAhj0Girhtmg
/KZz18qsGXOpST/GFHMe9qqS23VRqA==
=P1M5
-----END PGP SIGNATURE-----

--Sig_/ucjhpYCb9TG.8NNMwqXguvb--
