Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DCCC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5392467E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uMEXpdVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgAODlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 22:41:08 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:51867 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgAODlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 22:41:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47yClt5xcVz9sRm;
        Wed, 15 Jan 2020 14:40:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1579059659;
        bh=VAvZvVR15vPdcx+T1ys/TSqLDnhWyjaURUFwoNhttGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uMEXpdVOW+s6yy7uQLy3dBFKOFpR9lXk5oNz7VEqA5T/6TGKsiPJLEavzMeth/ou8
         Khdhq4ge7vdj1TExB85I9q83MVgwIEKcw6YEtu/QFew6MQYcVxuJ21LCZtKARy8cHx
         aqRdSX/1IIJJkDh+WPMv4WgHAImxQBJs3XSJmdk3gJAuDtBGKufT34sjB/pfsR0tU9
         a8M18txb8rF9qCm1qlX5APRZkjDKgK678drMlfrNj+Ok0ryv2TOpS8ohZGvWrK9CQP
         Eaw9v1mjtAYFBim2NA9gbhJWVWZVzQB0ZLoNVvvnUbJRHV9LKYmbjsMCi2t3HjiliA
         haALCePNMuRIw==
Date:   Wed, 15 Jan 2020 14:40:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jayshri Pawar <jpawar@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: linux-next: manual merge of the usb-gadget tree with Linus'
 tree
Message-ID: <20200115144057.7b72d7b9@canb.auug.org.au>
In-Reply-To: <CAMuHMdVY2W1=9paE+WpJUHprocOdutRMcNUJenn+jz9A-iv90A@mail.gmail.com>
References: <20200110153207.70c888cd@canb.auug.org.au>
        <CAMuHMdVY2W1=9paE+WpJUHprocOdutRMcNUJenn+jz9A-iv90A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZmWZVVMQHE/=k9OQRCnD3CJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZmWZVVMQHE/=k9OQRCnD3CJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, 14 Jan 2020 09:41:57 +0100 Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>
> For today's renesas-drivers, I'm using the attached conflict resolution.

Thanks, I will use your resolution from now on.
--=20
Cheers,
Stephen Rothwell

--Sig_/ZmWZVVMQHE/=k9OQRCnD3CJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4eickACgkQAVBC80lX
0Gx3WQf+ISvunKWj6CeTwh6faiTYiSC7RBDTJ+iJ1SDnsWjFH5ZpMZgW2Hk4Qwtc
ZpV1OnJUvdl1fRMXaq1kQKPzCECio47lnHqk/GGGGpVTwcKXfOzOtva1VPoD7ba7
lnH5ZiGF968gynqTuPP6yostnLFcor9mlbRt/ADZKB6VOmx3Ly4GUgjlkeCKh/X9
wOEKbZYStyYeqbtyMB2j7I1bNq+Y8jC53f3dw0Pr8FNWfDVw97cUGAMTeuwK2JM4
BHDkKz9NO87va4cXeBhAnWIoR+jnU79xLpO+cU3YMd0LLMopt2+hBg2ZbRUkAjbh
uijM7GaGV2uFJwlczg0xUGQwmaw3tA==
=uYy6
-----END PGP SIGNATURE-----

--Sig_/ZmWZVVMQHE/=k9OQRCnD3CJ--
