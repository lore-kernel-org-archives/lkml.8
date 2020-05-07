Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2D1C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94DD9216FD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877768;
	bh=zfyJqFsl52hg8MspTQ7ZLvYaM+kZM5XIzKGPNp9tS0M=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=GrDdtQ2THS5sn6jB0pEZ8lyEr+mB1GIHvpv6nylupUlzwFuo9hxKlRGiyFxnVncuZ
	 keZ7C6oVEo6xS7lLqdBMi4zj5l7j+FIrOnmw7otr5YAcnQ4ouh3Is/3m3sENoFdxzU
	 230k42o5bCRbgx+6io8PU556uUTNst9YcogXfhW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgEGS4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgEGS4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:56:07 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59D6D20575;
        Thu,  7 May 2020 18:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877766;
        bh=zfyJqFsl52hg8MspTQ7ZLvYaM+kZM5XIzKGPNp9tS0M=;
        h=Date:From:To:Cc:Subject:From;
        b=lUIjDc43mnN3s1tQ3rk7rBVGyC4MQITWAKNnSvlP9Os25A3B2tkhR7fBcPW0JBvHk
         NRIC3bHkeU4TjjB/eGKYGj9P8FFvdPIyHfZUg03GQZIDfJGEAomxShu/5ZWSu5uPvf
         0wXiAARkdO4CTdsE34effG0LjFiwQxu12v4CmONc=
Date:   Thu, 7 May 2020 14:00:33 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: Replace zero-length array with flexible-array
Message-ID: <20200507190033.GA15215@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/mtd/cfi.h   |    6 +++---
 include/linux/mtd/qinfo.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
index c98a21108688..fd1ecb821106 100644
--- a/include/linux/mtd/cfi.h
+++ b/include/linux/mtd/cfi.h
@@ -138,7 +138,7 @@ struct cfi_ident {
 	uint16_t InterfaceDesc;
 	uint16_t MaxBufWriteSize;
 	uint8_t  NumEraseRegions;
-	uint32_t EraseRegionInfo[0]; /* Not host ordered */
+	uint32_t EraseRegionInfo[]; /* Not host ordered */
 } __packed;
 
 /* Extended Query Structure for both PRI and ALT */
@@ -165,7 +165,7 @@ struct cfi_pri_intelext {
 	uint16_t ProtRegAddr;
 	uint8_t  FactProtRegSize;
 	uint8_t  UserProtRegSize;
-	uint8_t  extra[0];
+	uint8_t  extra[];
 } __packed;
 
 struct cfi_intelext_otpinfo {
@@ -286,7 +286,7 @@ struct cfi_private {
 	map_word sector_erase_cmd;
 	unsigned long chipshift; /* Because they're of the same type */
 	const char *im_name;	 /* inter_module name for cmdset_setup */
-	struct flchip chips[0];  /* per-chip data structure for each chip */
+	struct flchip chips[];  /* per-chip data structure for each chip */
 };
 
 uint32_t cfi_build_cmd_addr(uint32_t cmd_ofs,
diff --git a/include/linux/mtd/qinfo.h b/include/linux/mtd/qinfo.h
index df5b9fddea16..2e3f43788d48 100644
--- a/include/linux/mtd/qinfo.h
+++ b/include/linux/mtd/qinfo.h
@@ -24,7 +24,7 @@ struct lpddr_private {
 	struct qinfo_chip *qinfo;
 	int numchips;
 	unsigned long chipshift;
-	struct flchip chips[0];
+	struct flchip chips[];
 };
 
 /* qinfo_query_info structure contains request information for

