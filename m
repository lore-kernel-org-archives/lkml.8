Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7A7C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36F62068E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linux-org-tw.20150623.gappssmtp.com header.i=@linux-org-tw.20150623.gappssmtp.com header.b="VG5toFuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgEGDMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 23:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727967AbgEGDMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:12:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E67C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 20:12:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o18so1842989pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 20:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-org-tw.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ovatWTT2IkfeCN2gxUv+nyGPUFRj4YSKgWlcEr5L7I4=;
        b=VG5toFufhGCTMPP6ZxTZyCQD6W5mfLNWbOdFbl93egQ7hHDMGsN7YV6fAcl5sjsixG
         JfD+T7nU7uTXtK6WONMl/8YeR2ZjGaep9ZbWAYTP/DfZ6P58X/7Q03M9Nytn1dNF1gNf
         uWeQB2GtsvcO6Ali2G2YIl23Z6+X0Xfm9pduhu+DsCB7tnFim6LR/2ZyX04Vx5sISmN0
         VFxotFqATPRp4y3bPvYsNHj2zJK0Yf5M5M3j5REvP87X8DU9jDnSmZmLlCSmFS7NB9Y0
         IekeFloyBhDuk8GfPAcvTq2rtBfQsGFZxM4dOgjdRkd5r5tclok4/rOvwMAwiWkibskG
         wU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ovatWTT2IkfeCN2gxUv+nyGPUFRj4YSKgWlcEr5L7I4=;
        b=LjTctqQj7gaAdesWS4Lzl/flvKVlOQ8O9WwwgvzBELJMWe6HfjdatbRrDET5GNKcrE
         a/LZ2eygb4KMN6oJaClSLChIFcfkyuM4LFwQyluX9yJYoFJ3r3JBBUlZU+yCKaLmS6et
         OLsS8nEnBbM9IaCwvle9cZyYIVy+y7sj9jBwDhQ9WCe5YMmyqtWyhTH8bc1GZcmwpJ3D
         XFOjPnELhKFhHoA9zASnLQJYthG2bOjImilIln8xSxVyrtmgb6H+i9jH/CtxRdk4rY82
         zLliL2Qg/nIes4GzI+NMwmoCH6GgngwAY7AWaTX/lO1IHz67JoCM4BMLv0g2j7X17+Mj
         I4Dw==
X-Gm-Message-State: AGi0PubrehwiNV3NeQ5USYzX8+ZcoUYbw9OX+zhBxT64Vfem3YOmbvOz
        cKTdCylYozLbaG5GgfPECWKcSg==
X-Google-Smtp-Source: APiQypLs4kCydRSxIeN2W2YVGDn5j3r5vbVuUKqEmVMNTDvaExJjsTb6QQ+rRhvWelNvZ/rfLZMjpw==
X-Received: by 2002:aa7:9ac9:: with SMTP id x9mr11147730pfp.304.1588821131588;
        Wed, 06 May 2020 20:12:11 -0700 (PDT)
Received: from ws.cwhuang.info (114-34-107-28.HINET-IP.hinet.net. [114.34.107.28])
        by smtp.gmail.com with ESMTPSA id c15sm123724pfp.34.2020.05.06.20.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 20:12:11 -0700 (PDT)
From:   Chih-Wei Huang <cwhuang@linux.org.tw>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        =?UTF-8?q?Peter=20K=C3=A4stle?= <peter@piie.net>
Subject: [PATCH] platform/x86: acerhdf: replace space by * in modalias
Date:   Thu,  7 May 2020 11:12:01 +0800
Message-Id: <20200507031201.20460-1-cwhuang@linux.org.tw>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using space in module alias makes it harder to parse modules.alias.
Replace it by a star(*).

Reviewed-by: Peter Kästle <peter@piie.net>
Signed-off-by: Chih-Wei Huang <cwhuang@linux.org.tw>
---
 drivers/platform/x86/acerhdf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 505224225378..306ea92d5b10 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -837,7 +837,7 @@ MODULE_ALIAS("dmi:*:*Packard*Bell*:pnDOTMU*:");
 MODULE_ALIAS("dmi:*:*Packard*Bell*:pnENBFT*:");
 MODULE_ALIAS("dmi:*:*Packard*Bell*:pnDOTMA*:");
 MODULE_ALIAS("dmi:*:*Packard*Bell*:pnDOTVR46*:");
-MODULE_ALIAS("dmi:*:*Acer*:pnExtensa 5420*:");
+MODULE_ALIAS("dmi:*:*Acer*:pnExtensa*5420*:");
 
 module_init(acerhdf_init);
 module_exit(acerhdf_exit);
-- 
2.21.1

