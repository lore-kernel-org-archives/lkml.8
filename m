Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B01C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EC220665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QlbTTwbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHYVKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:10:51 -0400
Received: from ozlabs.org ([203.11.71.1]:41271 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYVKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 17:10:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BbhVH30g0z9sPB;
        Wed, 26 Aug 2020 07:10:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1598389848;
        bh=QO0VFcTYeT00h9+sR3A8pseHdrBg8aKdHYb6On8HQrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QlbTTwbuKi9SZo3famM1SYPZOR24DM7Mbk2NPkexjSIoJ20RVbSgG6q7I3A2jWTrG
         F/TMd9QU0OrnnrOxtMmyhBIDaLSOgrPvHiRuXZkx+H3v/G/AvDXxysKQuQ3z18VeeK
         0YziGBwEG8kfxEsBBSVqVqC8lixCVoUXGJAoLxpKgb4SGL5fCxhle2LSoOFKS2kmoi
         jGkbI28jr+ggDk45JBaLf77maxQX3YfVfJ/B/Z67Rxq1/ZXdnBlJ9PU3goD6Eri4GS
         f4ZmqhStPwGFC2RAW3LWvMwbeUkDgNeBMoHra6/c78nufN/PcMuqkd3uRYJbnrBpya
         0dHukJO7Ocsjg==
Date:   Wed, 26 Aug 2020 07:10:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20200826071046.263e0c24@canb.auug.org.au>
In-Reply-To: <CAADnVQ+SZj-Q=vijGkoUkmWeA=MM2S2oaVvJ7fj6=c4S4y-LMA@mail.gmail.com>
References: <20200821111111.6c04acd6@canb.auug.org.au>
        <20200825112020.43ce26bb@canb.auug.org.au>
        <CAADnVQLr8dU799ZrUnrBBDCtDxPyybZwrMFs5CAOHHW5pnLHHA@mail.gmail.com>
        <20200825130445.655885f8@canb.auug.org.au>
        <CAADnVQKGf7o8gJ60m_zjh+QcmRTNH+y1ha_B2q-1ixcCSAoHaw@mail.gmail.com>
        <20200825165029.795a8428@canb.auug.org.au>
        <CAADnVQ+SZj-Q=vijGkoUkmWeA=MM2S2oaVvJ7fj6=c4S4y-LMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/y/.zqijQVP+YmB_bY0J/fw2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y/.zqijQVP+YmB_bY0J/fw2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Tue, 25 Aug 2020 07:33:51 -0700 Alexei Starovoitov <alexei.starovoitov@g=
mail.com> wrote:
>
> what do you suggest to use to make it 'manually enabled' ?
> All I could think of is to add:
> depends on !COMPILE_TEST
> so that allmodconfig doesn't pick it up.

That is probably sufficient.  Some gcc plugins and kasan bits, etc use
just that.

--=20
Cheers,
Stephen Rothwell

--Sig_/y/.zqijQVP+YmB_bY0J/fw2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9FflYACgkQAVBC80lX
0Gyrrgf+NknsvQw7owFtB5Pel/msT4aHC2kMQZM6gItF8wEutI6YJ2hcsYDThS8L
y/4m6LPsYaBDlVcevw2lzwKiROs+3DyeSbc/j0l2fE6ndWNbKL7NCnmqpwAMRrz/
HMxxs/4AEsGuwfzfVxT+yY2K6FD0dsdQySktPHoxsLR1uMVTIat/daPWtTXNiojI
YusSanCdtztGqKlv5p+rkBaMVsdC4zehmcH0TrrkXNSPn+2CL6UAKfQTVRcxa5wv
xzoFCreq+R0tmm2jDlLaNz6HUiNotIbW64o5sOQObHpUpIpFiX12twv98IUO1QZn
qz6pNpLa1CAA5zkQXkRPjOg6GFOQ0Q==
=+8xn
-----END PGP SIGNATURE-----

--Sig_/y/.zqijQVP+YmB_bY0J/fw2--
