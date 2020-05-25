Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D05C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 21:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7EC320776
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 21:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbgEYVrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 17:47:32 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41057 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgEYVrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 17:47:31 -0400
Received: from toerring.de ([88.75.114.2]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MdeOl-1j4YHu181h-00ZgDB; Mon, 25 May 2020 23:47:27 +0200
Received: by toerring.de (Postfix, from userid 1000)
        id 8C1912720F62; Mon, 25 May 2020 23:47:26 +0200 (CEST)
Date:   Mon, 25 May 2020 23:47:26 +0200
From:   Jens Thoms Toerring <jt@toerring.de>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] regmap: fix alignment issues
Message-ID: <20200525214726.GA19717@toerring.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K1:8DrhEQqJqGab7nLMzuwATLHjrJ1IYFxVWz7Q/CM03+c6FnI4pha
 Z99SW8YTd9CepotBOUWUh2ZXONUOkBn1mxmJ24AYWfTS7GJjemgOCh+Q6ewLoP3Za32W/4N
 gx8ILCN+d6i3vVBr+o7n5eCRTLrSEWNjbTvpUJHjZRF+97jn8diy5j5eyWkUdtIzg3nlJTd
 YhLIxz5VJrDrHlWM7/MFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OQKjGJ0fsP4=:NVrj6Vi9IunRKtSInWo+uu
 rNjU0qVXTzQqloYUs+tC9H2eH6OqfcTGqpZXLs+f0XgjK19Ng7UcWt+TtGMbmGF7CQQrC6ugD
 hei2gRfbR0e5PIbtRe34rz91Jd6eUYvd6OGIXzqNWWcMxpuEZ98apc1KF5R0pcwJ14bWseUPz
 P5avn7UPZ5r4FJYHohMuIir/2Fny9fkxLI2Y/bkw9MZvU00gQYtadyAmvl2dUe2jHavBVrqI0
 HmLSH2nAUj5dLCEKFNyVvU1xml7kyq65GtoKFzv3Xa42Qcd3UkAsnSXFKrDNGcM1atdeFhFqi
 1yQYQ9FpPXUPtcI7nB3/6Vj0VZZEnsg05za+lvyWoKoGDii3Xb9/wdVhLvql7zFaaOHPffqjX
 zSdqnMBiVP2Nn3YKVwGPUUDrNrcS+Jz8V/ur4/NPUvMsbohHgPR8hvPIMteu/HF/dWSJsXCme
 kna5efzx7sqcAXAevUpNAO3/f6Lj5ugxVb4kojQi3Sdrj9uLMbHHdljRdle5rjvJd0uMQ13lp
 Bbf39Sw7ttYlOpz7qatcvOUQrF20ed7fTVebO3/x3mkWBFJSlDewUrT9EbD3ueOJqS3aaypu9
 4GZV8U6Hy+qXz7rbL5y19voC9Z2riMpmezKuyRAQD6yO7mrieC+P9tkMK6sYG4iSJicWiKna+
 CifXtUJ3iQlJncjuFYd/QLgIEKN8SncQREEPqFGIkPdA781abCPJ3tPVSnn/VmIySIAe+d7Yn
 8DC2i268uXzSE38UgDo2WAFwfuHXIrbzVhTCqlgsDFIsOlodDnuQvdanC3ah3uFZRagRb5vk+
 TaOUZgM5clxBFgrOa3H/CT9yTes9NdKS+iKS/d8a83WZ4W6of2wfjZQeD+Ae+pJc0/C5kZ3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assembly and disassembly of data to be sent to or received from a
device invoke functions (regmap_format_XXX() and regmap_parse_XXX())
that extract or insert data items into a buffer. In some cases these
functions are invoked with buffer pointers with odd addresses but try
to directly assign from or to those address. On architectures with
strict alignment requirements this leads to kernel crashes for u16 and
u32 values. The assignments have are replaced by memcpy() calls.

Signed-off-by: Jens Thoms Toerring <jt@toerring.de>
---
 drivers/base/regmap/regmap.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 58cfb32..d495ce1 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -193,15 +193,17 @@ static void regmap_format_8(void *buf, unsigned int val, unsigned int shift)
 
 static void regmap_format_16_be(void *buf, unsigned int val, unsigned int shift)
 {
-	__be16 *b = buf;
+	__be16 v = cpu_to_be16(val << shift);
 
-	b[0] = cpu_to_be16(val << shift);
+	memcpy(buf, &v, sizeof(v));
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
@@ -217,15 +219,17 @@ static void regmap_format_24(void *buf, unsigned int val, unsigned int shift)
 
 static void regmap_format_32_be(void *buf, unsigned int val, unsigned int shift)
 {
-	__be32 *b = buf;
+	__be32 v = cpu_to_be32(val << shift);
 
-	b[0] = cpu_to_be32(val << shift);
+	memcpy(buf, &v, sizeof(v));
 }
 
 static void regmap_format_32_native(void *buf, unsigned int val,
 				    unsigned int shift)
 {
-	*(u32 *)buf = val << shift;
+	u32 v = val << shift;
+
+	memcpy(buf, &v, sizeof(v));
 }
 
 static unsigned int regmap_parse_8(void *buf)
@@ -237,16 +241,18 @@ static unsigned int regmap_parse_8(void *buf)
 
 static unsigned int regmap_parse_16_be(void *buf)
 {
-	__be16 *b = buf;
+	__be16 v;
 
-	b[0] = be16_to_cpu(b[0]);
-
-	return b[0];
+	memcpy(&v, buf, sizeof(v));
+	return be16_to_cpu(v);
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
@@ -261,16 +267,18 @@ static unsigned int regmap_parse_24(void *buf)
 
 static unsigned int regmap_parse_32_be(void *buf)
 {
-	__be32 *b = buf;
-
-	b[0] = be32_to_cpu(b[0]);
+	__be32 v;
 
-	return b[0];
+	memcpy(&v, buf, sizeof(v));
+	return be32_to_cpu(v);
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

