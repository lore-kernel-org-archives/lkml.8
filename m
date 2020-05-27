Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6E0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAEB2071A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IUG2VDZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgE0B0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:26:32 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8781 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgE0B0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:26:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecdc1ba0000>; Tue, 26 May 2020 18:26:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 May 2020 18:26:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 May 2020 18:26:30 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 May
 2020 01:26:30 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 May 2020 01:26:30 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.50.17]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ecdc1c50006>; Tue, 26 May 2020 18:26:29 -0700
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
Subject: [PATCH 3/3] misc: xilinx-sdfec: convert get_user_pages() --> pin_user_pages()
Date:   Tue, 26 May 2020 18:26:28 -0700
Message-ID: <20200527012628.1100649-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527012628.1100649-1-jhubbard@nvidia.com>
References: <20200527012628.1100649-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590542778; bh=pIs/SexR7/3J3Zjm6Xj7h9EQRh/1TTydznodYn91aGk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=IUG2VDZp6/dk88r0F4O3ym0mwyEuNNu0CeTrd1/j470r4ImZ6HD1mtRg/2AOizQqv
         9nWKC3H+q29wkZ25dAd0b0swAgKQ88GWlqaK8RjHwFKND6qe0Bw0k/Uv9HssztrUkw
         1T5u3wvw3yKBetOKp+aCtbahP0kv0l5WygMe7r1XfmvIQi709dq9H5CGw/MTi/gjFy
         EurNZqrtpbtU3YupZp/E2yFAO/TSNPsqdFfCs+axZuRnYq0PWi/8AJVDhahN3F/0is
         0YjoEL7EWKgFmcjV4cYAcHNE5GwjmGakNJiwJ8Dyz44GYDzqmXq4sU502j3R4NF/Ic
         v6+Uuh8oBYr3A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was using get_user_pages*(), in approximately a "Case 1"
scenario (Direct IO), using the categorization from [1]. That means
that it's time to convert the get_user_pages*() + put_page() calls to
pin_user_pages*() + unpin_user_pages() calls.

There is some helpful background in [2]: basically, this is a small
part of fixing a long-standing disconnect between pinning pages, and
file systems' use of those pages.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

Cc: Derek Kiernan <derek.kiernan@xilinx.com>
Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/misc/xilinx_sdfec.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 7e2ee3e547f2..cda3559025d5 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -627,12 +627,11 @@ static int xsdfec_table_write(struct xsdfec_dev *xsdf=
ec, u32 offset,
=20
 	nr_pages =3D n;
=20
-	res =3D get_user_pages_fast((unsigned long)src_ptr, nr_pages, 0, pages);
+	res =3D pin_user_pages_fast((unsigned long)src_ptr, nr_pages, 0, pages);
 	if (res < nr_pages) {
-		if (res > 0) {
-			for (i =3D 0; i < res; i++)
-				put_page(pages[i]);
-		}
+		if (res > 0)
+			unpin_user_pages(pages, res);
+
 		return -EINVAL;
 	}
=20
@@ -646,7 +645,7 @@ static int xsdfec_table_write(struct xsdfec_dev *xsdfec=
, u32 offset,
 			reg++;
 		} while ((reg < len) &&
 			 ((reg * XSDFEC_REG_WIDTH_JUMP) % PAGE_SIZE));
-		put_page(pages[i]);
+		unpin_user_page(pages[i]);
 	}
 	return 0;
 }
--=20
2.26.2

