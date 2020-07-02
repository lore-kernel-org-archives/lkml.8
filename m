Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8001C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F63B208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuFKcEEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGBXLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgGBXLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:21 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAE1C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:11:21 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id by13so15890474edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgtvhZLfdp9O3gftKqMBNkndvT7e8+IujNOk46Vo20Q=;
        b=EuFKcEEIAwfc+2XGtQbcgo9h2Y0W+5HOUpZ2phmxvet9ddeCeDx+HNYvTJEYJoXSe9
         v+VBEWsuhH94XMwurpQpXtrqH2fIToDxj6w18Yp/rQyqsR9Y1C2sFMetG2U3zfJepHVv
         MHYjf4wwnyVONwLWkUFGIXb/Dyj9O8p6LYM/Thimgf+Dm4d3w1x9W7dsNLCbCs/Zwx8a
         dko46RJ36/qeDkq12VRR6FHOIHVV8H1LEWpnL3nCYqtozacr8XJvK6lS9OypwE9ouyLe
         RHF7vhmvBz7fC9VY6lAmjtBCrIR1Px1qatmuyTF94nIkfksnB1NEi9kFkKXZsRzzCRK2
         RtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgtvhZLfdp9O3gftKqMBNkndvT7e8+IujNOk46Vo20Q=;
        b=mBEw8bjSEXQTK8nvImh3lDBYNqeDCbDI+wWQzanvWncVmlXDK+wEoulMDnsUg3rLAb
         /DJs+lLpUJ7IwH3OT4hjKKlgBU9nuPzoQya5WAv4edkuSTA6AwKPBkZzBW7PJ/3oBfce
         iwLxBFcc7p5gL+Gc2Z/m+GZP8BZiHBnbmUP8JLG2Li28Sg2gnzW6PgnuJeKk9rHjGDrF
         HrWqZBqkX9cnuHNxQT2XMnbg3cMDaqRj/R4vhDIMZTVWsnk4hdJp+dh4yPrnDTKdt9nq
         SF8ZIMPtyqQqqTIlkV/is3Q4YHLSFX5T7wE1YZPOHa83YTh3AKL7Q6PtM1kFHiUXiIcW
         aiFg==
X-Gm-Message-State: AOAM532Qz2JJNYWbcmwkGJHj4ibCOZyGHVS2AHAybgT26ByoMJTgAiYG
        W/B3DqHFxE7HmWZlhvDtqEASic/8
X-Google-Smtp-Source: ABdhPJzC3j8T6SI1HIOwjx4ZdlMkG6TwTrsQgIkxp4vEA485iAUEdt6NmjbzkdSlKWL3fleS9EDU1Q==
X-Received: by 2002:a05:6402:13d0:: with SMTP id a16mr37351450edx.269.1593731479679;
        Thu, 02 Jul 2020 16:11:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id x9sm8214031ejw.28.2020.07.02.16.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:11:19 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 15/15] cleanup: move hexval() to utils.c
Date:   Fri,  3 Jul 2020 01:10:39 +0200
Message-Id: <20200702231039.55015-16-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
References: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now lib.c contains almost nothing else than library entrypoints.

Move a small utility, hexval(), to utils.c to complete this cleanup.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c   | 17 -----------------
 lib.h   |  2 --
 utils.c | 17 +++++++++++++++++
 utils.h |  4 ++++
 4 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/lib.c b/lib.c
index f512be2e1a43..57c89a16448e 100644
--- a/lib.c
+++ b/lib.c
@@ -50,23 +50,6 @@
 #include "bits.h"
 
 
-unsigned int hexval(unsigned int c)
-{
-	int retval = 256;
-	switch (c) {
-	case '0'...'9':
-		retval = c - '0';
-		break;
-	case 'a'...'f':
-		retval = c - 'a' + 10;
-		break;
-	case 'A'...'F':
-		retval = c - 'A' + 10;
-		break;
-	}
-	return retval;
-}
-
 static void do_warn(const char *type, struct position pos, const char * fmt, va_list args)
 {
 	static char buffer[512];
diff --git a/lib.h b/lib.h
index 81253a3e7ee5..46483f2bed5c 100644
--- a/lib.h
+++ b/lib.h
@@ -45,8 +45,6 @@
 #endif
 
 
-extern unsigned int hexval(unsigned int c);
-
 struct position {
 	unsigned int type:6,
 		     stream:14,
diff --git a/utils.c b/utils.c
index 094df3f9bf1c..72fff00ff91b 100644
--- a/utils.c
+++ b/utils.c
@@ -8,6 +8,23 @@
 #include <stdio.h>
 
 
+unsigned int hexval(unsigned int c)
+{
+	int retval = 256;
+	switch (c) {
+	case '0'...'9':
+		retval = c - '0';
+		break;
+	case 'a'...'f':
+		retval = c - 'a' + 10;
+		break;
+	case 'A'...'F':
+		retval = c - 'A' + 10;
+		break;
+	}
+	return retval;
+}
+
 void *xmemdup(const void *src, size_t len)
 {
 	return memcpy(__alloc_bytes(len), src, len);
diff --git a/utils.h b/utils.h
index 7bd14f467799..079fb02a3e94 100644
--- a/utils.h
+++ b/utils.h
@@ -8,6 +8,10 @@
 #include <stddef.h>
 #include <stdarg.h>
 
+///
+// return the value coresponding to an hexadecimal digit
+unsigned int hexval(unsigned int c);
+
 ///
 // duplicate a memory buffer in a newly allocated buffer.
 // @src: a pointer to the memory buffer to be duplicated
-- 
2.27.0

