Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6E3C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 04:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467362073B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 04:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LmswShr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgE3E4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 00:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3E4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 00:56:30 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E8BC08C5C9;
        Fri, 29 May 2020 21:56:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Yq094BFRz9sPK;
        Sat, 30 May 2020 14:56:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590814585;
        bh=VIZ+Q4shNV+I/Z2StHSif1/UkkXNINi+dqJpBbI/yWs=;
        h=Date:From:To:Cc:Subject:From;
        b=LmswShr1WaZV0Oc6KeXrwDGPr359TXLXYfpdJVNYKgeQpxnHwZDqZqGb2/55DDDvr
         3wpCC3ERwjgJ0NqROuZxlN+yHyaJ+rnbAMfUigBftXk23l46Egm40mOG1hpxpwFAsA
         DTX2z2RUU2x24xxxOaTVkpZMUq5jPfQA6fGg4adaGuoLFAcQnsG7YBHFKPB2JjEiQ6
         WkmQ3O6sCa93cjFtE8dQfVhObfr5FmHC3HuiHl/DG7NDp6monbX+Y96NveXUFKh5jC
         DWH4I+F/ZQNuYs7iUSXE6OFnijpQjeAAFBVn0RXHWvc8qeF2lYZkPmAEnq5Xup2XNw
         pi65SAc95PIOw==
Date:   Sat, 30 May 2020 14:56:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the clk tree
Message-ID: <20200530145624.30d0e400@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I.yNAvAjXABd+W8WWkOIGBS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I.yNAvAjXABd+W8WWkOIGBS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  5f2feacb7639 ("clk: vc5: Add support for IDT VersaClock 5P49V6965")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/I.yNAvAjXABd+W8WWkOIGBS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7R53gACgkQAVBC80lX
0GwM7Qf/WX/RKZ0IvOT56G31IFNnei6FoRmxEKqP4A3UrekTrpoFanmJpE0K+b7u
7wB1LTnNwB2sL78x5jbYoot8scnEVprlcR1ulq/nRjql+X4/xqCEEjd9G9rfOKrE
77Q5KrMFdCZzQVhyRwJ0dGWeYAOtQRK/04t74ao4SRXngKZQPlA1N9IewgGqx3bv
UcuTej64cXDStWFAVTG8W2h8PDeufF403rxYfWvWdXLcu7zYixadEb5PW6a/3qW0
G/n9zJBy+g44vY4pv1FV1SXRM9saCiYKxs7ooONFWrh7QVWwO8xyl/GMXzFlGjNh
0cDKIgTsa0cgdthgKrR4MsZk6hQqXg==
=vifM
-----END PGP SIGNATURE-----

--Sig_/I.yNAvAjXABd+W8WWkOIGBS--
