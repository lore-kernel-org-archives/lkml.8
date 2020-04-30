Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A31C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE57920873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgD3Vc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:32:59 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43541 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgD3Vc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:32:56 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MmDVA-1imRaR2Lgm-00iDFn; Thu, 30 Apr 2020 23:32:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 09/15] udf: avoid gcc-10 zero-length-bounds warnings
Date:   Thu, 30 Apr 2020 23:30:51 +0200
Message-Id: <20200430213101.135134-10-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200430213101.135134-1-arnd@arndb.de>
References: <20200430213101.135134-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:07qp34xh3mqepOFKvyRAb4y0v5X363uNQ9u6Ix633Cw+M61Nfjr
 CTbcSuvJbJp7t0RNzR9PxtJtufMDOX+YR5/gkvov6Z9AR+TyNLlsUAxnjf6ex31DvAiCr+K
 3hRGamOPrbmuxvm7S1U8fKpD8FjdWEw103dmSlsmecxEqSfPFP5/2BJbyrDSGAl7rKCzHik
 uRXNTiXo9Qq+O0KOvSz4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KnYxXNvNgMs=:Tmmb0sOO/qsMTf3wN63dYB
 g9ONZfKjLoib9ju565Eop7oCroJmGFMFVwgukAccYflXQgMKk226ZBVrwYYm9GSruVDnHsVyU
 RSYVVw/NigRJCDMinU95+HQ3Oy2QPp5r5BolQDOi5Z2TQksaTGg27U5yOXGBzhAyQvT42qzCF
 5YGA7B3vvAty5Vph1dBWftUUO851btP5zLS7vFVVKTwwlWfIh3IOvF8SctBD82PEh9OBVs4D2
 aY8UT36e8w+SVT4lyWSr2nHfpQmRXZ0+rIaNPbqR4QErJNapTDs79D5yHtp8AW0kPgW76sbRx
 oS6G5WREuXAgzc0HlEgfTcSXaOerfp25fcjfENJg+CiQGkm8izB7IU3awIfxS7db3MBE6gxxV
 y98mMp2NOY9DSXyPjMwJHDODkS1KIsGDqj9eq0BB+hn0A2RWlUCnJbm5botReD/Qa1yqG9O7+
 yB+ndbMOMgpvKwC2nB24bTUy6tEKyJu45QXj8OWA6xOXhdeTA7ydlDQ76Vqeh8W8DwOkpba0A
 OCt2zV0du8LDYLlqR1IQBk5zGasJ1NxVEKQQJ/e4U+cC48qbQDJhPK1SABCwIznv9WYL8rFdB
 DsFDqmjlR5wkRh5YQhi5Z5y0dqtGbyaTrxmQ5bML0QMEtfwZ/LEcPJOJd4ncvl+lFWnZt7T6X
 CPopI5a3y/nTRWOD5XCt8ohzZx1JuxSBov9Oci4mNTL5PK7iV5zbhV4mrVQRjXI8Ru5yo23QF
 VISCrRrgaNBxWuFAHHizmNIL+XCf3XjC+m5cuCeQkmLEFJlOxVwB1oxp3eBcQGkiBN9ikUgRT
 LpaHxqMFXAmwND32KeJRgHtXhZ0B75JjIde7X+MTJBLGGDX6Ws=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-10 warns about writes to the empty freeSpaceTable[] array, with
many instances like:

fs/udf/balloc.c: In function 'udf_bitmap_new_block':
fs/udf/balloc.c:101:36: error: array subscript 65535 is outside the bounds of an interior zero-length array '__le32[0]' {aka 'unsigned int[0]'} [-Werror=zero-length-bounds]
  101 |  le32_add_cpu(&lvid->freeSpaceTable[partition], cnt);
      |                ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
In file included from fs/udf/udfdecl.h:7,
                 from fs/udf/balloc.c:22:
fs/udf/ecma_167.h:363:11: note: while referencing 'freeSpaceTable'
  363 |  __le32   freeSpaceTable[0];
      |           ^~~~~~~~~~~~~~

These can all be avoided by using a flexible array member instead.

Another warning is a bit more obscure:

fs/udf/super.c: In function 'udf_count_free':
fs/udf/super.c:2521:26: warning: array subscript '(<unknown>) + 4294967295' is outside the bounds of an interior zero-length array '__le32[0]' {aka 'unsigned int[0]'} [-Wzero-length-bounds]
 2521 |      lvid->freeSpaceTable[part]);

Work around this one by changing the array access to equivalent
pointer arithmetic, as there cannot be multiple flexible-array
members in a single struct.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/udf/ecma_167.h | 2 +-
 fs/udf/super.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
index 736ebc5dc441..14ffe27342bc 100644
--- a/fs/udf/ecma_167.h
+++ b/fs/udf/ecma_167.h
@@ -360,9 +360,9 @@ struct logicalVolIntegrityDesc {
 	uint8_t			logicalVolContentsUse[32];
 	__le32			numOfPartitions;
 	__le32			lengthOfImpUse;
-	__le32			freeSpaceTable[0];
 	__le32			sizeTable[0];
 	uint8_t			impUse[0];
+	__le32			freeSpaceTable[];
 } __packed;
 
 /* Integrity Type (ECMA 167r3 3/10.10.3) */
diff --git a/fs/udf/super.c b/fs/udf/super.c
index f747bf72edbe..379867888c36 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -117,7 +117,7 @@ struct logicalVolIntegrityDescImpUse *udf_sb_lvidiu(struct super_block *sb)
 	}
 	/* The offset is to skip freeSpaceTable and sizeTable arrays */
 	offset = partnum * 2 * sizeof(uint32_t);
-	return (struct logicalVolIntegrityDescImpUse *)&(lvid->impUse[offset]);
+	return (struct logicalVolIntegrityDescImpUse *)(lvid->impUse + offset);
 }
 
 /* UDF filesystem type */
-- 
2.26.0

