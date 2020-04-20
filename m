Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093E8C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D123D2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aWh5j9Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDTKAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:00:15 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379B5C061A0C;
        Mon, 20 Apr 2020 03:00:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 495Md72prFz9sR4;
        Mon, 20 Apr 2020 20:00:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587376811;
        bh=caY1OP0J6oABYU8JBu4Bfiaq8JqnE3bugkLUSiYfA9Q=;
        h=Date:From:To:Cc:Subject:From;
        b=aWh5j9Tzwvb3mV4qNJ6Vyz/ruGGan6qN2iBvNyatyDXwO0JLRmXpcRjYIcqkYZete
         AbW1jqxrxr0HzpphNc6jcjvJGHBa1tmHPj3Unx2nm5SQ0WRCk1ZlU9T/x9RDvVHu9C
         jDKZbp7eKBk8FgSrmYpSTzBY7TeM0cqqK8nUz7WP/je58sMwsz0qLkw/XaIvqxtznH
         YpBSmg66poU/iTs5jK7IxxJyRvLyFbahiZwV9fKs08x5wdsf/v3M0OT2te3E8F9QLU
         7g82HeMH9vS3xrPkuNt3NE8EQRKnaKpaeUeBvBBXBYDOMf5YM+6h62Y0WOLPLLkniM
         gvJroP3LUxP+A==
Date:   Mon, 20 Apr 2020 20:00:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20200420200009.54554500@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/G34Af7zk6tHg0L6qyC29KWS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G34Af7zk6tHg0L6qyC29KWS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[also reported by the kernelci.org bot]

After merging the akpm-current tree, today's linux-next build (microblaze
nommu_defconfig and serveral others) failed like this:

mm/nommu.c: In function '__vmalloc_node_range':
mm/nommu.c:158:25: error: 'flags' undeclared (first use in this function)
  return __vmalloc(size, flags);
                         ^
mm/nommu.c: In function '__vmalloc_node':
mm/nommu.c:164:25: error: 'flags' undeclared (first use in this function)
  return __vmalloc(size, flags);
                         ^

Caused by commits

  be950c0b6fb2 ("mm: remove __vmalloc_node_flags_caller")
  a18681b211ea ("mm: remove vmalloc_user_node_flags")

--=20
Cheers,
Stephen Rothwell

--Sig_/G34Af7zk6tHg0L6qyC29KWS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6dcqkACgkQAVBC80lX
0Gw3AQf/W/WrKL6z026kBJykPOVYAK/+tp2Xq0fi2f7ooT/bZ9y+8KVTzVBSf7FE
Cb5x4dz5IFbtpyqcJrguF+mRV7Ih5zuk0jgkDDOYWyCFR7VWGoY6okI97gVP065e
oeMQTBSYy47wXIhEuIPjyQ8pI8pbzOd9UcuR/L/uppQVo0itFv460pRGgrcDt++A
cvwLEXWoKYft1iymoO2kBVwKs5m/jU20wwUseD8G9A4eI7LlSyKq6KwKq07rPUcm
kE3E4qE4Hq2gFvcW7tbm6DxqkOdasU0cAsVMAMqyqPL9skxUHFjmgcEov8lPeGPa
HwmcAzAvNLlTH/yT6uiI/sOaGRP2VQ==
=oHbu
-----END PGP SIGNATURE-----

--Sig_/G34Af7zk6tHg0L6qyC29KWS--
