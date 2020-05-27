Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59748C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35BEB20B80
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="A8UwiX4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgE0B0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:26:31 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13588 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE0B0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:26:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecdc1730001>; Tue, 26 May 2020 18:25:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 May 2020 18:26:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 May 2020 18:26:30 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 May
 2020 01:26:29 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 May 2020 01:26:29 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.50.17]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ecdc1c50004>; Tue, 26 May 2020 18:26:29 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/3] misc: xilinx-sdfec: improve get_user_pages_fast() error handling
Date:   Tue, 26 May 2020 18:26:26 -0700
Message-ID: <20200527012628.1100649-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527012628.1100649-1-jhubbard@nvidia.com>
References: <20200527012628.1100649-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590542707; bh=Z0H0NZ0azdDBw/pz6UaXScJeua7CgszsKUI21rNpIIc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=A8UwiX4zwnd0jIKivrFW1WRvjUMNk0bhMGLDQydxVtXYlh9U/1D/h8QUT4RVJSryq
         BRY0WYKCu1Gcvx0n9z19TiS0jBZtZuVoHRyy+ZbyEQztjj66vY+dTPfRosbo2uSsgD
         ADGiYR4EScHloc8SrbdXxAfUgtaQLNAxZHmtgVtnKtxAJINkGsx7qlqC3Gb4YP4/UD
         aM+1SfGtF/Yy6j1DfnjNNcr+ASerSgFkpMfQsK/L6j4lztD5i8TOU4GShn8O8zWpab
         VAgP6OLlntY0JSi0Se/r9D9Q9r8lE1kyIantgllKdq77Np8d8b+qgAZJEUufvH8Sqh
         hRmQjiA9iUueg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the case of get_user_pages_fast() returning a -errno.
The result needs to be stored in a signed integer. And for safe
signed/unsigned comparisons, it's best to keep everything signed.
And get_user_pages_fast() also expects a signed value for number
of pages to pin.

Therefore, change most relevant variables, from u32 to int. Leave
"n" unsigned, for convenience in checking for overflow. And provide
a WARN_ON_ONCE() and early return, if overflow occurs.

Also, as long as we're tidying up: rename the page array from page,
to pages, in order to match the conventions used in most other call
sites.

Fixes: 20ec628e8007e ("misc: xilinx_sdfec: Add ability to configure LDPC")
Cc: Derek Kiernan <derek.kiernan@xilinx.com>
Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/misc/xilinx_sdfec.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 71bbaa56bdb5..e2766aad9e14 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -602,10 +602,10 @@ static int xsdfec_table_write(struct xsdfec_dev *xsdf=
ec, u32 offset,
 			      const u32 depth)
 {
 	u32 reg =3D 0;
-	u32 res;
-	u32 n, i;
+	int res, i, nr_pages;
+	u32 n;
 	u32 *addr =3D NULL;
-	struct page *page[MAX_NUM_PAGES];
+	struct page *pages[MAX_NUM_PAGES];
=20
 	/*
 	 * Writes that go beyond the length of
@@ -622,15 +622,22 @@ static int xsdfec_table_write(struct xsdfec_dev *xsdf=
ec, u32 offset,
 	if ((len * XSDFEC_REG_WIDTH_JUMP) % PAGE_SIZE)
 		n +=3D 1;
=20
-	res =3D get_user_pages_fast((unsigned long)src_ptr, n, 0, page);
-	if (res < n) {
-		for (i =3D 0; i < res; i++)
-			put_page(page[i]);
+	if (WARN_ON_ONCE(n > INT_MAX))
+		return -EINVAL;
+
+	nr_pages =3D n;
+
+	res =3D get_user_pages_fast((unsigned long)src_ptr, nr_pages, 0, pages);
+	if (res < nr_pages) {
+		if (res > 0) {
+			for (i =3D 0; i < res; i++)
+				put_page(pages[i]);
+		}
 		return -EINVAL;
 	}
=20
-	for (i =3D 0; i < n; i++) {
-		addr =3D kmap(page[i]);
+	for (i =3D 0; i < nr_pages; i++) {
+		addr =3D kmap(pages[i]);
 		do {
 			xsdfec_regwrite(xsdfec,
 					base_addr + ((offset + reg) *
@@ -639,7 +646,7 @@ static int xsdfec_table_write(struct xsdfec_dev *xsdfec=
, u32 offset,
 			reg++;
 		} while ((reg < len) &&
 			 ((reg * XSDFEC_REG_WIDTH_JUMP) % PAGE_SIZE));
-		put_page(page[i]);
+		put_page(pages[i]);
 	}
 	return reg;
 }
--=20
2.26.2

