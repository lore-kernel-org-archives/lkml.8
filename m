Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13E1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 744322071A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RkYxm/hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgE0B0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:26:32 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12945 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgE0B0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:26:31 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecdc16d0000>; Tue, 26 May 2020 18:25:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 May 2020 18:26:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 May 2020 18:26:30 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 May
 2020 01:26:29 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 May 2020 01:26:29 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.50.17]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ecdc1c50005>; Tue, 26 May 2020 18:26:29 -0700
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
Subject: [PATCH 2/3] misc: xilinx-sdfec: cleanup return value in xsdfec_table_write()
Date:   Tue, 26 May 2020 18:26:27 -0700
Message-ID: <20200527012628.1100649-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527012628.1100649-1-jhubbard@nvidia.com>
References: <20200527012628.1100649-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590542701; bh=dh1gzeuNEWLitRp0xsCGNIPzRAxdFNy5pUtT9em+Tw0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=RkYxm/hyg+xoYnaGAzqo/4SyN6yQRENIXgDZ9qxIHMh/KZ4fOzJUcaP7+B/a9SDNl
         YoqGTptxuumMIO5ZZq4QTlffi7hw/e4yfS0CwoQw8LAaVDfzOBvshWlmeC26sT7mHN
         L2yf0tBOGlRWxYRoQygEkTNNAyt3kCnHXZX69t+VTxDb2gdzBBnoNMut81OwQCC/Ea
         dqx2Lg5lIii0ycJl/pJcLf8rjcaRcO8YqW+FdaX6vH4yiIPMwn82EqwIo4YavaGlQk
         2uulzrko8VtwRn52Jpzh2CjY6Y4bDuUw8XFWOHGL06rjMLfXwdp6fBUM30y7zoVp0P
         uCHE6n6G2n2/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return 0 for success, rather than the value of an incrementing
"reg" index. The reg value was never actually used, so this
simplifies the caller slightly.

Cc: Derek Kiernan <derek.kiernan@xilinx.com>
Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/misc/xilinx_sdfec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index e2766aad9e14..7e2ee3e547f2 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -648,7 +648,7 @@ static int xsdfec_table_write(struct xsdfec_dev *xsdfec=
, u32 offset,
 			 ((reg * XSDFEC_REG_WIDTH_JUMP) % PAGE_SIZE));
 		put_page(pages[i]);
 	}
-	return reg;
+	return 0;
 }
=20
 static int xsdfec_add_ldpc(struct xsdfec_dev *xsdfec, void __user *arg)
@@ -727,8 +727,6 @@ static int xsdfec_add_ldpc(struct xsdfec_dev *xsdfec, v=
oid __user *arg)
 	ret =3D xsdfec_table_write(xsdfec, 4 * ldpc->qc_off, ldpc->qc_table,
 				 ldpc->nqc, XSDFEC_LDPC_QC_TABLE_ADDR_BASE,
 				 XSDFEC_QC_TABLE_DEPTH);
-	if (ret > 0)
-		ret =3D 0;
 err_out:
 	kfree(ldpc);
 	return ret;
--=20
2.26.2

