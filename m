Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF72C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438B320724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nMX2fGiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgHUQbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:31:33 -0400
Received: from crapouillou.net ([89.234.176.41]:35764 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbgHUQaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598027395; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=Uwgv3V1N1hiJyIEswYWuLiViuZ3G70Jm39XJPsfzS7s=;
        b=nMX2fGiyT39mo7k8Y5qYDjTdSxNRkqvTPAq+n4EwCY8R9efEi3TZ0OMNz3Bmh2bWHTzOxz
        tcwidyxOjL77RxTWqSB6yxpzxOlDVItfXkcw2NwrBdmbq6+dIwyXZh1TGnrm8inwMjTS5G
        9vCLEHseJxptgoMcmBrKQPTDStTUVBo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Nick Terrell <terrelln@fb.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] lib: decompress_unzstd: Limit output size
Date:   Fri, 21 Aug 2020 18:29:47 +0200
Message-Id: <20200821162948.146947-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zstd decompression code, as it is right now, will have internal
values overflow on 32-bit systems when the output size is LONG_MAX.

Until someone smarter than me can figure out how to fix the zstd code
properly, limit the destination buffer size to 512 MiB, which should be
enough for everybody, in order to make it usable on 32-bit systems.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 lib/decompress_unzstd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/decompress_unzstd.c b/lib/decompress_unzstd.c
index 0ad2c15479ed..e1c03b1eaa6e 100644
--- a/lib/decompress_unzstd.c
+++ b/lib/decompress_unzstd.c
@@ -77,6 +77,7 @@
 
 #include <linux/decompress/mm.h>
 #include <linux/kernel.h>
+#include <linux/sizes.h>
 #include <linux/zstd.h>
 
 /* 128MB is the maximum window size supported by zstd. */
@@ -179,7 +180,7 @@ static int INIT __unzstd(unsigned char *in_buf, long in_len,
 	size_t ret;
 
 	if (out_len == 0)
-		out_len = LONG_MAX; /* no limit */
+		out_len = SZ_512M; /* should be big enough, right? */
 
 	if (fill == NULL && flush == NULL)
 		/*
-- 
2.28.0

