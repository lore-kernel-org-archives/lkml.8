Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84258C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB13208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgDUDZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 23:25:22 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:63335 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgDUDZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 23:25:22 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id D7A90665164;
        Tue, 21 Apr 2020 11:25:07 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH V2] kmalloc_index optimization(code size & runtime stable)
Date:   Mon, 20 Apr 2020 20:25:01 -0700
Message-Id: <20200421032501.127370-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
Reply-To: 1587089010-110083-1-git-send-email-bernard@vivo.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VPSEhCQkJOSENPSUpNSFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oj46HQw*HjgyKAMZEDMfIxo#
        LRIKCUNVSlVKTkNMT0hCTkpKSkNKVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBTUlOSDcG
X-HM-Tid: 0a719ac49a499373kuwsd7a90665164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc_index inline function code size optimization and runtime
performance stability optimization. After optimization, the function
kmalloc_index is more stable, the size will never affecte the function`s
execution efficiency.
And follow test data shows that the performance of new optimization
exceeds the original algorithm when applying for more than 512 Bytes
(include 512B).And new optimization runtime is more stable than before.
Test platform:install vmware ubuntu 16.04, ram 2G, cpu 1, i5-8500 3.00GHz
Compiler: gcc -O2 optimization, gcc version 5.4.0.
Just test diff code part.
Follow is detailed test data:
            size        time/Per 100 million times
                        old fun		new fun with optimise
		8	203777		241934
		16	245611		409278
		32	236384		408419
		64	275499		447732
		128	354909		416439
		256	360472		406598
		512	431072		409168
		1024	463822		407401
        2 * 1024	548519		407710
        4 * 1024	623378		422326
        8 * 1024	655932		407457
       16 * 1024	744673		417574
       32 * 1024	824889		415316
       64 * 1024	854374		408577
      128 * 1024	968079		433582
      256 * 1024	985527		412080
      512 * 1024	1196877		448199
     1024 * 1024	1310315		448969
2  * 1024 * 1024	1367441		513117
4  * 1024 * 1024	1264623		415019
8  * 1024 * 1024	1255727		417197
16 * 1024 * 1024	1401431		411087
32 * 1024 * 1024	1440415		416616
64 * 1024 * 1024	1428122		417459

Signed-off-by: Bernard Zhao <bernard@vivo.com>

Changes since V1:
*i am not sure wht kbuild being triggered?
*fix kbuild compiler error

Link for V1:
*https://lore.kernel.org/patchwork/patch/1226159/
---
 include/linux/slab.h | 62 +++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 6d454886bcaf..b09785a79465 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -301,6 +301,23 @@ static inline void __check_heap_object(const void *ptr, unsigned long n,
 #define SLAB_OBJ_MIN_SIZE      (KMALLOC_MIN_SIZE < 16 ? \
                                (KMALLOC_MIN_SIZE) : 16)
 
+#ifndef CONFIG_SLOB
+/*
+ * This used to show the relation between size`s last (most-significant)
+ * bit set & index of kmalloc_info[]
+ * If size%2 ==0, then fls - 1, else fls(round up)
+ * size  8(b 1000)-(b 1xxx)-16(b 10000)-(b 1xxxx)-32(b 100000)-(b 1xxxxx)
+ *       |            |          |           |            |           |
+ * index 3            4          4           5            5           6
+ *       64(b 1000000)-(b 1xxxxxx)-128(b 10000000)-(b 1xxxxxxx)-256....
+ *          |           |              |            |            |
+ *          6           7              7            8            8...
+ */
+#define KMALLOC_SIZE_POW_2_SHIFT_BIT (2)
+#define KMALLOC_SIZE_POW_2_INDEX_BIT (1)
+#endif
+
+
 /*
  * Whenever changing this, take care of that kmalloc_type() and
  * create_kmalloc_caches() still work as intended.
@@ -348,6 +365,7 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
  */
 static __always_inline unsigned int kmalloc_index(size_t size)
 {
+	unsigned char high_bit = 0;
 	if (!size)
 		return 0;
 
@@ -358,30 +376,26 @@ static __always_inline unsigned int kmalloc_index(size_t size)
 		return 1;
 	if (KMALLOC_MIN_SIZE <= 64 && size > 128 && size <= 192)
 		return 2;
-	if (size <=          8) return 3;
-	if (size <=         16) return 4;
-	if (size <=         32) return 5;
-	if (size <=         64) return 6;
-	if (size <=        128) return 7;
-	if (size <=        256) return 8;
-	if (size <=        512) return 9;
-	if (size <=       1024) return 10;
-	if (size <=   2 * 1024) return 11;
-	if (size <=   4 * 1024) return 12;
-	if (size <=   8 * 1024) return 13;
-	if (size <=  16 * 1024) return 14;
-	if (size <=  32 * 1024) return 15;
-	if (size <=  64 * 1024) return 16;
-	if (size <= 128 * 1024) return 17;
-	if (size <= 256 * 1024) return 18;
-	if (size <= 512 * 1024) return 19;
-	if (size <= 1024 * 1024) return 20;
-	if (size <=  2 * 1024 * 1024) return 21;
-	if (size <=  4 * 1024 * 1024) return 22;
-	if (size <=  8 * 1024 * 1024) return 23;
-	if (size <=  16 * 1024 * 1024) return 24;
-	if (size <=  32 * 1024 * 1024) return 25;
-	if (size <=  64 * 1024 * 1024) return 26;
+	if (size <= 8)
+		return 3;
+
+	/* size over KMALLOC_MAX_SIZE should trigger BUG */
+	if (size <= KMALLOC_MAX_SIZE) {
+		/*
+		 * kmalloc_info[index]
+		 * size  8----16----32----64----128---256---512---1024---2048.
+		 *       |  |  |  |  |  |  |  |  |  |  |  |  |  |   |  |   |
+		 * index 3  4  4  5  5  6  6  7  7  8  8  9  9  10  10 11  11
+		 */
+
+		high_bit = fls((int)size);
+
+		if (size == (2 << (high_bit - KMALLOC_SIZE_POW_2_SHIFT_BIT)))
+			return (high_bit - KMALLOC_SIZE_POW_2_INDEX_BIT);
+
+		return high_bit;
+	}
+
 	BUG();
 
 	/* Will never be reached. Needed because the compiler may complain */
-- 
2.26.2

