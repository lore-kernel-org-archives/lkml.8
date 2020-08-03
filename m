Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19571C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C22206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgHCOZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:25:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:52558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgHCOZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:25:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A3CEACC3;
        Mon,  3 Aug 2020 14:26:04 +0000 (UTC)
Message-ID: <9200970a917a9cabdc5b17483b5a8725111eb9d0.camel@suse.de>
Subject: [PATCH] of: unittest: Use bigger address cells to catch parser
 regressions
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 03 Aug 2020 16:25:47 +0200
In-Reply-To: <CAL_JsqKu4CB7-b_hRvu63c9jQ_S91epWMr=P__9Fu-h_WFR-_Q@mail.gmail.com>
References: <20200731100248.26982-1-nsaenzjulienne@suse.de>
         <CAL_JsqKu4CB7-b_hRvu63c9jQ_S91epWMr=P__9Fu-h_WFR-_Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ivQUVYgzUHw4VCNNTbEO"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ivQUVYgzUHw4VCNNTbEO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Getting address and size cells for dma-ranges/ranges parsing is tricky
and shouldn't rely on the node's count_cells() method. The function
starts looking for cells on the parent node, as its supposed to work
with device nodes, which doesn't work when input with bus nodes, as
generally done when parsing ranges.

Add test to catch regressions on that specific quirk as developers will
be tempted to edit it out in favor of the default method.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/of/unittest-data/tests-address.dtsi | 10 +++++-----
 drivers/of/unittest.c                       |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/of/unittest-data/tests-address.dtsi b/drivers/of/unitt=
est-data/tests-address.dtsi
index 3fe5d3987beb..6604a52bf6cb 100644
--- a/drivers/of/unittest-data/tests-address.dtsi
+++ b/drivers/of/unittest-data/tests-address.dtsi
@@ -23,13 +23,13 @@ device@70000000 {
 			};
=20
 			bus@80000000 {
-				#address-cells =3D <1>;
-				#size-cells =3D <1>;
-				ranges =3D <0x0 0x80000000 0x100000>;
-				dma-ranges =3D <0x10000000 0x0 0x40000000>;
+				#address-cells =3D <2>;
+				#size-cells =3D <2>;
+				ranges =3D <0x0 0x0 0x80000000 0x0 0x100000>;
+				dma-ranges =3D <0x1 0x0 0x0 0x20 0x0>;
=20
 				device@1000 {
-					reg =3D <0x1000 0x1000>;
+					reg =3D <0x0 0x1000 0x0 0x1000>;
 				};
 			};
=20
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 398de04fd19c..9b7e84bdc7d4 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -900,7 +900,7 @@ static void __init of_unittest_parse_dma_ranges(void)
 	of_unittest_dma_ranges_one("/testcase-data/address-tests/device@70000000"=
,
 		0x0, 0x20000000, 0x40000000);
 	of_unittest_dma_ranges_one("/testcase-data/address-tests/bus@80000000/dev=
ice@1000",
-		0x10000000, 0x20000000, 0x40000000);
+		0x100000000, 0x20000000, 0x2000000000);
 	of_unittest_dma_ranges_one("/testcase-data/address-tests/pci@90000000",
 		0x80000000, 0x20000000, 0x10000000);
 }
--=20
2.28.0



--=-ivQUVYgzUHw4VCNNTbEO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8oHmsACgkQlfZmHno8
x/7E7Qf+OOvK2j5/TLbzr9HCeeQU+tUJlMB/8OaT/q7Ua9Aderb9K9Y8xs7WXvdf
FHNwMq5gdmmBSisG+3gS8Ekdp2CWZKQmg03JE8ZUhdt6Yp9D+z2tIF7jy2udZdNI
p3lJFxA3u608htW6lXnwHwvllvQOFDEBpHngF8KwoSZMhhbxInHOKzGnggU57sAY
FB2MtCzzzw0e85jHjoGrguKGqxPv1d4E7jyr6LgYil3zH2lYUvClZzPR89J8ZAVl
5xc5mQpk8XB+27+lb4e+H43ufypyxAftMYrEuiRkC+Lez1CfbU/QuJtIfAw2z7dk
rRrbduOOXb/K2mRA8f1WWgztYgWHGw==
=1rhk
-----END PGP SIGNATURE-----

--=-ivQUVYgzUHw4VCNNTbEO--

