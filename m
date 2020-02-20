Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC81AC11D25
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A145A207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="c9KyT9T+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgBTXnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:43:32 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:39125 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729234AbgBTXnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:43:32 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48Nrkn1947z9sRR;
        Fri, 21 Feb 2020 10:43:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1582242210;
        bh=q6JOLFwV0pd9s/BMEZd2p784PrNxjvaNV+hyRcvmy5o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c9KyT9T+kScpHjSaeprvrUeP/wZ5eNQDkDiMvVex3aVtfy4jcgGJ/6KcpvyVhZKkG
         /uVP+AV/hOKkxn8dQ1yqoj5Q43fm4LYVyv1bC7rsJOOBPXLU8M8IRmYFE1PEr5vhDs
         T1+ZSlg4Khj8SixBv/Dmko0F89dAZsNsJD6KQ1weJCDOtPko3FdDMy0TYl3Z/pcp4U
         rGjQypAyR9RakUkYHTxXuQxVCdtQC5VPOhd10VJ8kAfd67YegwvUbQr9etH9bezi43
         HxQJ3aWsnn5RjoN6HT8WbeLkVyv2Nz5irk7GiytpBld1HCitFjloJD3t70GFQ0/euj
         NdLOCXKEeCfWQ==
Date:   Fri, 21 Feb 2020 10:43:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arjun Roy <arjunroy@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: linux-next: build failure after merge of the akpm tree
Message-ID: <20200221104328.0f897efd@canb.auug.org.au>
In-Reply-To: <CAOFY-A2ndGCSEDstOmXs-u1XjNsaj8wkLezYsMbzeZeVTJGC5g@mail.gmail.com>
References: <20200217145711.4af495a3@canb.auug.org.au>
        <CAOFY-A1nfPjf3EcQB6KiEifbFR+aUtdSgK=CHGt_k3ziSG6T_Q@mail.gmail.com>
        <CAOFY-A3q_pmtHKAoOJdbB09wy=dxs9SdpXjCsU1wBxU5EDHVmw@mail.gmail.com>
        <20200221101845.21c0c8c5@canb.auug.org.au>
        <CAOFY-A2ndGCSEDstOmXs-u1XjNsaj8wkLezYsMbzeZeVTJGC5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4J=0WKQyZX..F3pWxR4vRyW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4J=0WKQyZX..F3pWxR4vRyW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arjun,

On Thu, 20 Feb 2020 15:22:04 -0800 Arjun Roy <arjunroy@google.com> wrote:
>=20
> I have a possible solution in mind, but it would involve a slight
> change in the SPARC macro (to be more inline with the semantics of the
> other platforms).
> If you're open to such a change, I can send it out.

Its not up to me :-)

If it is not too much work, I would say, do the patch, test it as you
can, then send it out cc'ing the Sparc maintainer (DaveM cc'd) and see
what happens.

--=20
Cheers,
Stephen Rothwell

--Sig_/4J=0WKQyZX..F3pWxR4vRyW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5PGaAACgkQAVBC80lX
0GwjsAf7Bdk1+lRxBFjF18KTiQuPjjw+tQ0APU51qFJ7Bn7FWzoPu9HQ5rqUX+3v
frWHoAqqXsPsxTOKQh0Tc17yVk+I5g4FB0Smdm7PcL+nr0T1xPjpa51aOtMvyquS
T+15PODoRwqwmUDIv6fYN5Clr3ofTMowfLb95Sif2Wq6dVFC9vnHJxvg6wEE+kTa
FqsrRcCRidHrcxBgPPMKukBD+WWHe8rpdGWuwKbTa77f8HRZTT99ys99ZowC2Vbz
+vtun37zSe1lPqc8p5RPq4J+zBflV7YF3w2F7uAY8hIY7/OkP6+U09zEcPibineX
faKCR/8nYiBr1Q28ZElAHOXaPPr4DA==
=CGZF
-----END PGP SIGNATURE-----

--Sig_/4J=0WKQyZX..F3pWxR4vRyW--
