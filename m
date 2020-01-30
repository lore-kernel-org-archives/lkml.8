Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99E7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 00:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78432206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 00:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="grNsHxWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgA3A2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 19:28:19 -0500
Received: from ozlabs.org ([203.11.71.1]:37551 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgA3A2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 19:28:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 487LmY13B6z9sNT;
        Thu, 30 Jan 2020 11:28:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580344096;
        bh=A1LOcUzbmFRu6CnaeSbsIxpubXWf7iaUrsoWSAhT7Qk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=grNsHxWYo7SM4pRivp69oihfw7xir2AUHllKF2NFQDRtY6+oC0Y6CPTCcJ7o2K2SG
         tMZAk1rBUhdTeXVKIrFTEAtcEEXRZcoGGzsq1O8K3YnqDSPPp3WWSRCOnTltiJj27n
         Ea3AkE2M3mnhALHSzfWYTtMOyN5XSLcY4+j8Wr3zO+BgwXNWj4urJCGF7sr6r/8DIf
         Ugl7BraC2R7Fj8APihP+ggs46G88WgzgKCyW6CRR9ojFUcGUkcAvedOlIKjdARNGV1
         tKP15ht5JyKP7zT33DRntpLUHT/QLvMtGcJF/bXp7fOSwLHRAeFljEUG/CqTg1WBs1
         FxsUlzQ5uDKTw==
Date:   Thu, 30 Jan 2020 11:28:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        dan.j.williams@intel.com, aneesh.kumar@linux.ibm.com,
        kirill@shutemov.name, yang.shi@linux.alibaba.com,
        thellstrom@vmware.com, Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 3/5] mm/mremap: use pmd_addr_end to calculate next in
 move_page_tables()
Message-ID: <20200130112812.68e938e6@canb.auug.org.au>
In-Reply-To: <20200129155907.75868e8a36c5fffc3ec354b9@linux-foundation.org>
References: <20200117232254.2792-1-richardw.yang@linux.intel.com>
        <20200117232254.2792-4-richardw.yang@linux.intel.com>
        <7147774a-14e9-4ff3-1548-4565f0d214d5@gmail.com>
        <20200126185951.c9246349befcccce210a4ab8@linux-foundation.org>
        <b5eb4766-38ba-0153-2844-cc303fe0dc07@gmail.com>
        <20200129155907.75868e8a36c5fffc3ec354b9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EI5dG3bZDZkFOYbEr0C/aGP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EI5dG3bZDZkFOYbEr0C/aGP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, 29 Jan 2020 15:59:07 -0800 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> hm, me too.  Stephen, it's unexpected that 9ff4452912d63f ("mm/mremap:
> use pmd_addr_end to calculate next in move_page_tables()") is still in
> the -next lineup?  It was dropped from -mm on Jan 26?

The mmotm 2020-01-28-20-05 arrived just to late for yesterday's
linux-next (it will be in today's linux-next).  The mmotm before that
was 2020-01-23-21-12.  I attempt to fetch mmotm (along with all the
remaining unmerged trees) about every 30 minutes (sometimes more often)
during the day.

--=20
Cheers,
Stephen Rothwell

--Sig_/EI5dG3bZDZkFOYbEr0C/aGP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4yIxwACgkQAVBC80lX
0GzDOAf/fiHwH2H1LxPeGl4/FqwYomv7u+okT+m0GPTVqLAiVNAxj5TLh4k0af7I
M6kISX8+QqZ6XSgPNj9D/xZHXTOI7pmnz6IzUnCexRMC7F94VpTncYIwf+WnTeKs
M5maby2/zgL+WJaJLQ0Pf7BkQtCWpAx4wH2IEjWSC0sBbQjSs5YzTXstuEgxrSLB
rx6aquyCi/aXVfauszE/7bV/q++5oCj262wk0aL7EtQIeW9MRa0DiOE0g5avjIvG
YeifUfZK8q52OVr1/PqBaj1LkfLw6D6pQ2JtzARxdqxc27E2i8WDROeBP+h0hnD1
3QP05IaRjqht0vavjwNoxrVO4Eitkw==
=h1dM
-----END PGP SIGNATURE-----

--Sig_/EI5dG3bZDZkFOYbEr0C/aGP--
