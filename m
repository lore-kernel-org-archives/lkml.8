Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33989C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1074420897
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgEaJxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 05:53:07 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:41939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaJxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 05:53:06 -0400
Received: from toerring.de ([94.223.5.94]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MLR5h-1jMq1m1UJv-00IYZa; Sun, 31 May 2020 11:53:01 +0200
Received: by toerring.de (Postfix, from userid 1000)
        id A36AF27207BB; Sun, 31 May 2020 11:53:00 +0200 (CEST)
Date:   Sun, 31 May 2020 11:53:00 +0200
From:   Jens Thoms Toerring <jt@toerring.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4] regmap: fix alignment issue
Message-ID: <20200531095300.GA27570@toerring.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K1:wlLx/fRruH8XAoNiU/GIALJLOg/6QAn/PeQdLurSfnaH/B4qAZn
 E0MIbC7I4fHBiTDc1UncNPDExEpcPoB1jiGBNfkj0jGt7LSBCWIvqI/r4RC/F7F9RzQlJab
 FcD4FdnbcRibYRScX1TDHS7aPFs9v50hStfDczIMxoglzqb9wERwqd1vrNeFHN0he2JYRQM
 ltn4UEOJck8uFmMlOB9CQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ND4hAmKuzAI=:hC1WiqoLndUsTF4K93LECa
 UBgpGoIYjkRWWZYk4Ptughjpdh/IP01PpGeCXmq86P20OQJ9rMe/NAZzUywNiaWHhltAn4JxP
 yqAfaI6jkQNcVzfjHiDbkzfmEtw0Fi+1jrIWi12sFzOlz9H5TcCt76maniojdxDDVx9+XKx1q
 qEt5+br7BxLzaTVozsnUmUEVIMz+OsXKC31VFXoqk73nGvYKUbTZifEbuLeJ7pa/L0eM1pWuJ
 9Z/t05upIDqypEaco52AKe/hzS0QCfX/Ef6oRtSpQ739j3NIlBzYgIOeEXxFVboaWE6QXxuZL
 ufud8ecELMTR6IeiHOwjxVhebKrFx0nT5ZILUYNO9i4dw1v0f2ngcdcWHEnlgFpqbY/jbsmia
 qMSFG29VtLvkes6UeMqatY8OOUec3iXpXQ/owdHntqtpzz54gCFP+O/lExadMyeC+v17c0rTw
 +U59U+3UZLXO1xHSZCv1JOlz0OFusTr6uvEqF+t4XRSD6o/6YoXwOLPvrrLP5LUsYrFTjecdK
 rC4qKqn0JspxNzvOPg/UdnlYXcOIZKMClsNUqSe/y58+pcNb9KM1JFSiQNQ/dcfQzZFN6fXw7
 eXn2yYnCd+TyTdgo2QbOg88hIMrl9M/8kJW1Dp1CE7JpM3HDbMaLwuSJ2tnJ06mSiPOUeRWG/
 9R/V/uiSXOaQbjntZBMe0L2c8AuIHBIyA95/EbQFyw+a0+4KoV2Y2NcdQWM5sklUZ492k80yi
 IbL63G52WTTtxJK4YVwAtOLJn4YUObW9jL0Tx7ukGYRLQGkY84fOYGLImaNQ6C5tpvMfcXgU3
 v5++/nYka2DOeLxDYJ1uuwISqew5XFqblfPpAZMo4CBR/cwPh8Q7EkTHhabQVJMXWdzTvl/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assembly and disassembly of data to be sent to or received from
a device invoke functions regmap_format_XX() and regmap_parse_XX()
that extract or insert data items from or into a buffer, using
assignments. In some cases the functions are called with a buffer
pointer with an odd address. On architectures with strict alignment
requirements this can result in a kernel crash. The assignments
have been replaced by functions that take alignment into account.

Signed-off-by: Jens Thoms Toerring <jt@toerring.de>
---
 drivers/base/regmap/regmap.c | 104 ++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 56 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index c472f62..4cde237 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/log2.h>
 #include <linux/hwspinlock.h>
+#include <asm/unaligned.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -249,22 +250,20 @@ static void regmap_format_8(void *buf, unsigned int val, unsigned int shift)
 
 static void regmap_format_16_be(void *buf, unsigned int val, unsigned int shift)
 {
-	__be16 *b = buf;
-
-	b[0] = cpu_to_be16(val << shift);
+	put_unaligned_be16(val << shift, buf);
 }
 
 static void regmap_format_16_le(void *buf, unsigned int val, unsigned int shift)
 {
-	__le16 *b = buf;
-
-	b[0] = cpu_to_le16(val << shift);
+	put_unaligned_le16(val << shift, buf);
 }
 
 static void regmap_format_16_native(void *buf, unsigned int val,
 				    unsigned int shift)
 {
-	*(u16 *)buf = val << shift;
+	u16 v = val << shift;
+
+	memcpy(buf, &v, sizeof(v));
 }
 
 static void regmap_format_24(void *buf, unsigned int val, unsigned int shift)
@@ -280,43 +279,39 @@ static void regmap_format_24(void *buf, unsigned int val, unsigned int shift)
 
 static void regmap_format_32_be(void *buf, unsigned int val, unsigned int shift)
 {
-	__be32 *b = buf;
-
-	b[0] = cpu_to_be32(val << shift);
+	put_unaligned_be32(val << shift, buf);
 }
 
 static void regmap_format_32_le(void *buf, unsigned int val, unsigned int shift)
 {
-	__le32 *b = buf;
-
-	b[0] = cpu_to_le32(val << shift);
+	put_unaligned_le32(val << shift, buf);
 }
 
 static void regmap_format_32_native(void *buf, unsigned int val,
 				    unsigned int shift)
 {
-	*(u32 *)buf = val << shift;
+	u32 v = val << shift;
+
+	memcpy(buf, &v, sizeof(v));
 }
 
 #ifdef CONFIG_64BIT
 static void regmap_format_64_be(void *buf, unsigned int val, unsigned int shift)
 {
-	__be64 *b = buf;
-
-	b[0] = cpu_to_be64((u64)val << shift);
+	put_unaligned_be64((u64) val << shift, buf);
 }
 
 static void regmap_format_64_le(void *buf, unsigned int val, unsigned int shift)
 {
-	__le64 *b = buf;
-
-	b[0] = cpu_to_le64((u64)val << shift);
+	put_unaligned_le64((u64) val << shift, buf);
 }
 
 static void regmap_format_64_native(void *buf, unsigned int val,
 				    unsigned int shift)
 {
-	*(u64 *)buf = (u64)val << shift;
+	u64 v = (u64) val << shift;
+
+	memcpy(buf, &v, sizeof(v));
 }
 #endif
 
@@ -333,35 +328,34 @@ static unsigned int regmap_parse_8(const void *buf)
 
 static unsigned int regmap_parse_16_be(const void *buf)
 {
-	const __be16 *b = buf;
-
-	return be16_to_cpu(b[0]);
+	return get_unaligned_be16(buf);
 }
 
 static unsigned int regmap_parse_16_le(const void *buf)
 {
-	const __le16 *b = buf;
-
-	return le16_to_cpu(b[0]);
+	return get_unaligned_le16(buf);
 }
 
 static void regmap_parse_16_be_inplace(void *buf)
 {
-	__be16 *b = buf;
-
-	b[0] = be16_to_cpu(b[0]);
+	u16 v = get_unaligned_be16(buf);
+
+	memcpy(buf, &v, sizeof(v));
 }
 
 static void regmap_parse_16_le_inplace(void *buf)
 {
-	__le16 *b = buf;
-
-	b[0] = le16_to_cpu(b[0]);
+	u16 v = get_unaligned_le16(buf);
+
+	memcpy(buf, &v, sizeof(v));
 }
 
 static unsigned int regmap_parse_16_native(const void *buf)
 {
-	return *(u16 *)buf;
+	u16 v;
+
+	memcpy(&v, buf, sizeof(v));
+	return v;
 }
 
 static unsigned int regmap_parse_24(const void *buf)
@@ -376,69 +370,67 @@ static unsigned int regmap_parse_24(const void *buf)
 
 static unsigned int regmap_parse_32_be(const void *buf)
 {
-	const __be32 *b = buf;
-
-	return be32_to_cpu(b[0]);
+	return get_unaligned_be32(buf);
 }
 
 static unsigned int regmap_parse_32_le(const void *buf)
 {
-	const __le32 *b = buf;
-
-	return le32_to_cpu(b[0]);
+	return get_unaligned_le32(buf);
 }
 
 static void regmap_parse_32_be_inplace(void *buf)
 {
-	__be32 *b = buf;
+	u32 v = get_unaligned_be32(buf);
 
-	b[0] = be32_to_cpu(b[0]);
+	memcpy(buf, &v, sizeof(v));
 }
 
 static void regmap_parse_32_le_inplace(void *buf)
 {
-	__le32 *b = buf;
+	u32 v = get_unaligned_le32(buf);
 
-	b[0] = le32_to_cpu(b[0]);
+	memcpy(buf, &v, sizeof(v));
 }
 
 static unsigned int regmap_parse_32_native(const void *buf)
 {
-	return *(u32 *)buf;
+	u32 v;
+
+	memcpy(&v, buf, sizeof(v));
+	return v;
 }
 
 #ifdef CONFIG_64BIT
 static unsigned int regmap_parse_64_be(const void *buf)
 {
-	const __be64 *b = buf;
-
-	return be64_to_cpu(b[0]);
+	return get_unaligned_be64(buf);
 }
 
 static unsigned int regmap_parse_64_le(const void *buf)
 {
-	const __le64 *b = buf;
-
-	return le64_to_cpu(b[0]);
+	return get_unaligned_le64(buf);
 }
 
 static void regmap_parse_64_be_inplace(void *buf)
 {
-	__be64 *b = buf;
+	u64 v =  get_unaligned_be64(buf);
 
-	b[0] = be64_to_cpu(b[0]);
+	memcpy(buf, &v, sizeof(v));
 }
 
 static void regmap_parse_64_le_inplace(void *buf)
 {
-	__le64 *b = buf;
+	u64 v = get_unaligned_le64(buf);
 
-	b[0] = le64_to_cpu(b[0]);
+	memcpy(buf, &v, sizeof(v));
 }
 
 static unsigned int regmap_parse_64_native(const void *buf)
 {
-	return *(u64 *)buf;
+	u64 v;
+
+	memcpy(&v, buf, sizeof(v));
+	return v;
 }
 #endif
 
-- 
1.9.1

