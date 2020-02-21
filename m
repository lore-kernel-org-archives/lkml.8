Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7765DC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA0424673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="x5yRZJgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgBUPDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:03:33 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.252]:30095 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727315AbgBUPDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:03:32 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 39A48C3F5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:03:30 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 59pyj6g2nXVkQ59pyjT0xJ; Fri, 21 Feb 2020 09:03:30 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TuEkwNZ6abk0dgqShh1c2Fq2egiakxYWlYBo+Zgc8WU=; b=x5yRZJgjXzVicfceegBOAKBOdJ
        Q2jboBFw7Q+2WEItU6X2mnaKFGW9xZqw4FYg0/SzY1AoIwOsIZzQDXlRz7JJC5FuMcGCt70pYrPkT
        G/8GyingLPF7ZcV8950kLcZEcJWIB1b+OrZV2w8vMIBUHvDKBTd8ZgqK7szI4LdDp0NMQEgPcDO30
        A6/bZzTz6ehOXR0cGRBycJPw+PPLjMSo08DwQ6miVqQPfv5/lMsLKC1geJjNybCcZgYUtuxdSRQD3
        WeQCxVjk0XYNsfyVnaMCmQIxaNdm0AU5cVUzhbGfGhPvPJMkSqZCXvooo0sOo5WGis/kv27AZjiC5
        HDJ3iamQ==;
Received: from [200.68.141.13] (port=18984 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j59pw-003Uak-6R; Fri, 21 Feb 2020 09:03:28 -0600
Date:   Fri, 21 Feb 2020 09:06:12 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] s390: Replace zero-length array with flexible-array member
Message-ID: <20200221150612.GA9717@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.141.13
X-Source-L: No
X-Exim-ID: 1j59pw-003Uak-6R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.141.13]:18984
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/s390/appldata/appldata_os.c      | 2 +-
 drivers/s390/block/dasd_diag.c        | 2 +-
 drivers/s390/block/dasd_eckd.h        | 2 +-
 drivers/s390/char/raw3270.h           | 2 +-
 drivers/s390/char/sclp_pci.c          | 2 +-
 drivers/s390/cio/idset.c              | 2 +-
 drivers/s390/crypto/pkey_api.c        | 2 +-
 drivers/s390/crypto/zcrypt_ccamisc.h  | 2 +-
 drivers/s390/crypto/zcrypt_msgtype6.c | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/s390/appldata/appldata_os.c b/arch/s390/appldata/appldata_os.c
index 54f375627532..8bf46d705957 100644
--- a/arch/s390/appldata/appldata_os.c
+++ b/arch/s390/appldata/appldata_os.c
@@ -75,7 +75,7 @@ struct appldata_os_data {
 				   (waiting for I/O)               */
 
 	/* per cpu data */
-	struct appldata_os_per_cpu os_cpu[0];
+	struct appldata_os_per_cpu os_cpu[];
 } __attribute__((packed));
 
 static struct appldata_os_data *appldata_os_data;
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 8d4971645cf1..facb588d09e4 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -58,7 +58,7 @@ struct dasd_diag_private {
 
 struct dasd_diag_req {
 	unsigned int block_count;
-	struct dasd_diag_bio bio[0];
+	struct dasd_diag_bio bio[];
 };
 
 static const u8 DASD_DIAG_CMS1[] = { 0xc3, 0xd4, 0xe2, 0xf1 };/* EBCDIC CMS1 */
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 6943508d0f1d..ca24a78a256e 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -220,7 +220,7 @@ struct LRE_eckd_data {
 	__u8 imbedded_count;
 	__u8 extended_operation;
 	__u16 extended_parameter_length;
-	__u8 extended_parameter[0];
+	__u8 extended_parameter[];
 } __attribute__ ((packed));
 
 /* Prefix data for format 0x00 and 0x01 */
diff --git a/drivers/s390/char/raw3270.h b/drivers/s390/char/raw3270.h
index 3afaa35f7351..08f36e973b43 100644
--- a/drivers/s390/char/raw3270.h
+++ b/drivers/s390/char/raw3270.h
@@ -211,7 +211,7 @@ struct string
 	struct list_head update;
 	unsigned long size;
 	unsigned long len;
-	char string[0];
+	char string[];
 } __attribute__ ((aligned(8)));
 
 static inline struct string *
diff --git a/drivers/s390/char/sclp_pci.c b/drivers/s390/char/sclp_pci.c
index 995e9196852e..a3e5a5fb0c1e 100644
--- a/drivers/s390/char/sclp_pci.c
+++ b/drivers/s390/char/sclp_pci.c
@@ -39,7 +39,7 @@ struct err_notify_evbuf {
 	u8 atype;
 	u32 fh;
 	u32 fid;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 struct err_notify_sccb {
diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
index 835de44dbbcc..77d0ea7b381b 100644
--- a/drivers/s390/cio/idset.c
+++ b/drivers/s390/cio/idset.c
@@ -13,7 +13,7 @@
 struct idset {
 	int num_ssid;
 	int num_id;
-	unsigned long bitmap[0];
+	unsigned long bitmap[];
 };
 
 static inline unsigned long bitmap_size(int num_ssid, int num_id)
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 2f33c5fcf676..74e63ec49068 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -80,7 +80,7 @@ struct clearaeskeytoken {
 	u8  res1[3];
 	u32 keytype;	 /* key type, one of the PKEY_KEYTYPE values */
 	u32 len;	 /* bytes actually stored in clearkey[] */
-	u8  clearkey[0]; /* clear key value */
+	u8  clearkey[]; /* clear key value */
 } __packed;
 
 /*
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h b/drivers/s390/crypto/zcrypt_ccamisc.h
index 3a9876d5ab0e..8b7a641671c9 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.h
+++ b/drivers/s390/crypto/zcrypt_ccamisc.h
@@ -90,7 +90,7 @@ struct cipherkeytoken {
 	u16 kmf1;     /* key management field 1 */
 	u16 kmf2;     /* key management field 2 */
 	u16 kmf3;     /* key management field 3 */
-	u8  vdata[0]; /* variable part data follows */
+	u8  vdata[]; /* variable part data follows */
 } __packed;
 
 /* Some defines for the CCA AES cipherkeytoken kmf1 field */
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index a36251d138fb..eadd3a438a4b 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -590,7 +590,7 @@ struct type86x_reply {
 	struct CPRBX cprbx;
 	unsigned char pad[4];	/* 4 byte function code/rules block ? */
 	unsigned short length;
-	char text[0];
+	char text[];
 } __packed;
 
 struct type86_ep11_reply {
-- 
2.25.0

