Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E94C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 01:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD472078C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 01:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XUCGWfXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgDUBzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 21:55:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35371 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgDUBzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 21:55:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 495mq85RYpz9sP7;
        Tue, 21 Apr 2020 11:55:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587434116;
        bh=XmHiPC7lZ0dEZn4DKBgZwzVGUg0htSmYqbl+Qt3iSuc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XUCGWfXsOk0evL3z33dZwKX/WQ3G2EJZHDO+2M46wdW9QzIKYVJ090JtPi8qUO1vr
         0gHETW41lghGXLB6P5M1u4IjjBV5yOykn/bpKbRfybeFDKgWwcg3i5rFRUb8P2hy8H
         QVA5iViRuSZcjylOTbG+ZR3tCPsMDxv1G8dkDi1iCBPyazd+vsbNurDQKZRZOKgWCE
         QnSfous65T4wffw1fXY7LI745HaC5D7nhEu2wlZuaxp+G1+hczVPyEkCyLTpEhp5+0
         QRhIV3c/d5A4VaYK8hcvZmjk2WRlYrg1BLBWQYGIVYpOLmlDV6B+4+UuohwCPPG7BF
         R8fGGV3REelqw==
Date:   Tue, 21 Apr 2020 11:55:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Qu Wenruo <wqu@suse.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the btrfs tree
Message-ID: <20200421115516.5678f11a@canb.auug.org.au>
In-Reply-To: <10d92c2f-7120-18bb-1412-e3627d2d8f4c@suse.com>
References: <20200421102520.53623f09@canb.auug.org.au>
        <9aee72df-9140-c86b-cf37-568a546d8b76@suse.com>
        <20200421111324.2148fe05@canb.auug.org.au>
        <10d92c2f-7120-18bb-1412-e3627d2d8f4c@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ctVHHByWt05a3Uyw7_cl7ye";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ctVHHByWt05a3Uyw7_cl7ye
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Qu,

On Tue, 21 Apr 2020 09:33:56 +0800 Qu Wenruo <wqu@suse.com> wrote:
>
> On 2020/4/21 =E4=B8=8A=E5=8D=889:13, Stephen Rothwell wrote:
> >=20
> > That is a build test of the uapi headers to make syre that they are
> > self contained. =20
>=20
> Any command to reproduce it?
> As I want to avoid such problem in future development.

You need to enable CONFIG_UAPI_HEADER_TEST (which allmodconfig does).

--=20
Cheers,
Stephen Rothwell

--Sig_/ctVHHByWt05a3Uyw7_cl7ye
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6eUoQACgkQAVBC80lX
0GyqpggAhzEEFWXrVTfmJDYlb/EGvRA/L1htFF47rLT8CgrZNbC0G6neOOLvr83E
KDzR5BEYPXGyes85WqZCdEsiME5LAd3YwzwUJ4pjUdIsXF/bgyVG1PBmdcRfdrfi
JEOkny1dKYfoIoSt5l4csVF5gkBuZ0DjfNxDeHp0CISpySWUmUjxno1h6PvTSJgY
HwB6XAh0Eig27E+lhqhUMNR+tUGRBwXuB9WX64HYUnEvBMe3/KjoncF1AjPM10/N
dSuMOIkXdaJ+k5m5lFqLC3QDCrPO6GX3mHQBnZ0QUrwHHhDlpq44FsIP4Z+lEW91
6Q53rknWye+EWoGrDn6ylCJ4qey6lw==
=7ON+
-----END PGP SIGNATURE-----

--Sig_/ctVHHByWt05a3Uyw7_cl7ye--
