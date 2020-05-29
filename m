Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB2DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9BA20810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgE2TZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:25:44 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51877 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2TZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:25:43 -0400
Received: from toerring.de ([92.78.127.109]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mv2tK-1io1UR0Als-00qw0L; Fri, 29 May 2020 21:25:39 +0200
Received: by toerring.de (Postfix, from userid 1000)
        id 5064A2720D7A; Fri, 29 May 2020 21:25:38 +0200 (CEST)
Date:   Fri, 29 May 2020 21:25:38 +0200
From:   Jens Thoms Toerring <jt@toerring.de>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] regmap: fix alignment issue
Message-ID: <20200529192538.GA28402@toerring.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K1:HKMEX1LhIy4WsFYeeeerOet60CJQIvagZKaUD4bhcAORqGfSY9K
 4icNCtmgrfi2ieVXUa/qnNNZod5kgz8KlBXdWZwuqQIslpBIrG8Wf/ZudnWIj9yyxpOE2Fq
 kNCXPh7sOmMVYVg988X23gVdNT/ZnSjZTlFLHVTVKxgra7a22p4T6HKOTpBtQA1ebFMSr16
 kouEOHbKhTLGyL1GY/m5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bseuBP/cpQQ=:nqcVXGLPpF36nHsDMQSSl7
 pk+DupudJ2EhuqloiBTQF2PxaSE+Anv+imasCkFpvXEPI9bu2zaNiZcpdw8Go1JjWLUbuvAhi
 PcLeCZUabxn8N+bqATrVAi9vfQJCbRFSL+MKbGeYWCB36/zOeXHlRAxuRv23VKlM88FjJ4BKW
 KfYkArUm7AlGUOAbYkRPUca0dm+gUk2bBag3ylZL5D3PimWCsJnEOAndhE/SafEvlyOm7AU0g
 34570LQPI+HxPNSI2JPRG25OUlvYbxhyxr0I/4Iro8FFB7RDZ36fOswA2ZQYBLfxp6RxGepvH
 U3ipjsytSUSv5sRr4OXAKixDjBPS1GAYNvWNAzyerC6MDh2Ey5gWzCGY15PKDtidzSlnF5ALl
 +YYF8XCudFxWVdMTkIMb53oe4nOZcFrFyhzU8SHOi6cjDYRBGF0sboLzCvwsiAa2KyFei3qce
 Ll8cKmlfq4xrZwGnMtITrsaZAOOHjyJDlxJM2RpWy/CgEhZ7C1tG4UQ3j+JLkFi9nr5sfwYJo
 mcVKzuUTaCQ3XxaLxTRbHXc7Z2rjtGa8JVcLKZ2HGHmhZNd9u8Muplg2brEEd48rhqeA738r4
 9TWbaJ5KYZx4ydk6C2NpfP2OgZlmbQ3W8yY9Gfv5HQlyDF7zs5Qq0GQ7uNhxcFLnSLojEbm+D
 tgZ+v7RQd4VZqXHlSZuPnii77gyH5i1mqIv8qrOxEQcET4BGaQbryuMey9FhXEwwLtj+3LXuI
 D8TFJQ1p/X8RiJhXeayGGlblU5OYimzjwwdo9E7ZrCXqL5mFhsuteugBsan/8z2Hh51nsuxGV
 eguSd0odexdkXSVzgIEdVrwI3RD12LSndu+yXZi0lhUJLeg9g7lsC07Su9QYa0pXFsY8pfl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assembly and disassembly of data to be sent to or received from a
device invoke functions (regmap_format_XXX() and regmap_parse_XXX())
that extract or insert data items from or into a buffer, using
assignments. In some cases those functions are called with buffer
pointers with odd addresses. On architectures with strict alignment
requirements this results in a kernel crash for u16 and u32 values.
The assignments have been replaced by methods that take alignment
into consideration.

Signed-off-by: Jens Thoms Toerring <jt@toerring.de>
---
 drivers/base/regmap/regmap.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 58cfb32..70f470e 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -193,15 +193,15 @@ static void regmap_format_8(void *buf, unsigned int val, unsigned int shift)
 
 static void regmap_format_16_be(void *buf, unsigned int val, unsigned int shift)
 {
-	__be16 *b = buf;
-
-	b[0] = cpu_to_be16(val << shift);
+	put_unaligned_be16(val << shift, buf);
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
@@ -217,15 +217,15 @@ static void regmap_format_24(void *buf, unsigned int val, unsigned int shift)
 
 static void regmap_format_32_be(void *buf, unsigned int val, unsigned int shift)
 {
-	__be32 *b = buf;
-
-	b[0] = cpu_to_be32(val << shift);
+	put_unaligned_be32(val << shift, buf);
 }
 
 static void regmap_format_32_native(void *buf, unsigned int val,
 				    unsigned int shift)
 {
-	*(u32 *)buf = val << shift;
+	u32 = val << shift;
+
+	memcpy(buf, &v, sizeof(v));
 }
 
 static unsigned int regmap_parse_8(void *buf)
@@ -237,16 +237,15 @@ static unsigned int regmap_parse_8(void *buf)
 
 static unsigned int regmap_parse_16_be(void *buf)
 {
-	__be16 *b = buf;
-
-	b[0] = be16_to_cpu(b[0]);
-
-	return b[0];
+	return get_unaligned_be16(buf);
 }
 
 static unsigned int regmap_parse_16_native(void *buf)
 {
-	return *(u16 *)buf;
+	u16 v;
+
+	memcpy(&v, buf, sizeof(v));
+	return v;
 }
 
 static unsigned int regmap_parse_24(void *buf)
@@ -261,17 +260,15 @@ static unsigned int regmap_parse_24(void *buf)
 
 static unsigned int regmap_parse_32_be(void *buf)
 {
-	__be32 *b = buf;
-
-	b[0] = be32_to_cpu(b[0]);
-
-	return b[0];
+	return get_unaligned_be32(buf);
 }
 
 static unsigned int regmap_parse_32_native(void *buf)
 {
-	return *(u32 *)buf;
+	u32 v;
+
+	memcpy(&v, buf, sizeof(v));
+	return v;
 }
 
 static void regmap_lock_mutex(void *__map)
-- 
1.9.1

