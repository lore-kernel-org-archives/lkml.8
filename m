Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC01C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E393B2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PDEe9kz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgGPXKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:10:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39635 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgGPXJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:09:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B792D01SRz9sSd;
        Fri, 17 Jul 2020 09:09:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594940996;
        bh=QWdrxFBpnc+5yuo/EXWfNKKKZ2K+Toci8Qlf1n0C6y0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PDEe9kz4oTwEwQL1l+VwLcW6E6k3EgHZQ1rVzPjU6atoGl6I+EWivth53CB0cj/Ff
         XcAGKp66vPBeKN4jx51BfkfGO9RnBvoTXLlMb5coShUzXMkKEZt+NKSuO0NRZzMFcU
         O4Us8lrYYeOGHGd4XpK4wgYgHzMIP01ATXhmNI5pIHcIsdmW9vQegA2jZQkfXDYr5g
         QJ4aJnLCh8RavotRrhJ85U631r3KjlkBCjx8TGHG6YUh6vfxE5HarM00BggWawG2yl
         AGVWzLBtUIuUzQyh8waUfmLMpZUE9D/wimIyrRYx6uvzwEhvHMK26VuEXbOWFW1sLr
         XYIfSSohdea7A==
Date:   Fri, 17 Jul 2020 09:09:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Qian Cai <cai@lca.pw>
Cc:     Bharata B Rao <bharata@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Off-load TLB invalidations to host for !GTSE
Message-ID: <20200717090954.51b5e952@canb.auug.org.au>
In-Reply-To: <20200716172713.GA4565@lca.pw>
References: <20200703053608.12884-1-bharata@linux.ibm.com>
        <20200716172713.GA4565@lca.pw>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LrU42vrRqFzVHW8kLZ7IOY.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LrU42vrRqFzVHW8kLZ7IOY.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 16 Jul 2020 13:27:14 -0400 Qian Cai <cai@lca.pw> wrote:
>
> Reverting the whole series fixed random memory corruptions during boot on
> POWER9 PowerNV systems below.

I will revert those commits from linux-next today as well (they revert
cleanly).

--=20
Cheers,
Stephen Rothwell

--Sig_/LrU42vrRqFzVHW8kLZ7IOY.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8Q3kIACgkQAVBC80lX
0Gx0EAgAgGAiEBdzR5nyLORIZM/X+qAx7M26k7TbqqYdKD9yzUyQlly6tj8yyOEz
ivEg8oZYzNeoiqxPkYr/HLNzR/4ckQQ5RxTxXXI3r/nSj7nG4TI6vN+tSIomNs0p
hZMh6QMkN52Yf179tutfBOhMdD4Gu5PIeQcgI7qd6VhOFfrZd17WS44i0oIWb1N7
bxGLDbfH7dWO/b3imxj2rsnUZd6Qfs7jrCEExl/88mHPrRkfXlj4IWPdXoQ8R6wV
mkhaEu3JZHlhgVoTebHsTyzlI9mIjKlx0UaOkBX+G6awc/msTlxuKmdBIKxDcj1b
xCwR3sZinXugs1SFocbfj6SGmA9uvQ==
=Nze4
-----END PGP SIGNATURE-----

--Sig_/LrU42vrRqFzVHW8kLZ7IOY.--
