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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A706FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832602088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUfgFFw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgGBXMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgGBXLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:12 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C695EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:11:11 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e22so25745381edq.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26ZiewEHNxWX5EAuv9sa51RYGJG4O6qcJfTfVaArce0=;
        b=iUfgFFw3mmZu0Oh9wOKE8Hvo/QYkt1zOcd7Z+9mAmho/NNHjUPdbQAtE117AwFaL99
         dqHa7RJvu3L2gUOX6avLBtAgXAXbLZpZh+tqkOZQ66wcvmB2aS3mfPenwTy/rUQRA8rc
         pxFhO/B9xoU5VCfz2EvqoHFwYOG+uiNfy4al+ZynLzzkiycMKaPgEpxyTJmL5hZg1SFH
         gUEj7oUgrEOY63xTRKiTL+KchQ05EtHqVPyJ2bf6kgmJ/H+o5aHCz4yoAiBJO+qvxptp
         XY8AoSrcij4P9miFS6CLPaSUCdU2Xv6nqQAy8d3ZoMQCB3bnj80VadAxFpim17wE8q2s
         f4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26ZiewEHNxWX5EAuv9sa51RYGJG4O6qcJfTfVaArce0=;
        b=chyybyh0ZODYolZbeHGA5u3BH9dps8UGGoPBSLgbQN1Qb345GnyYRbXEem4LC4VZ4+
         axyPnBzEugBNS5jIWKmCWTsAHddlZoDZ9JnP1wYN4euPrE7D0mEa2SqkuH9Gvkzns0u0
         765em2NvyzIwacB5jisWh6kNH/zaiXepRylQ/q6G/91R+3s1XQTPJwLy+mQQubxy2gcB
         P1nxM/D6pbnp1oQOtpIvggwtvuL2JvPc7rnX48DFwNWAP0GiqJ8mYm8AKSG52LsJwlKh
         mG5e1L9NuTNmLK5pHn96TvGcw3anMO8mU7NVOk2qXoa2xD/WO9qTYFT7sw8m3M+xaRbj
         yk8g==
X-Gm-Message-State: AOAM533BkTRWN/9KBxvaMWnGluJvp1Sx7sB0vATMEReVR25jw0JHAVMQ
        QWOWb6xmypUEpCyKKPeKdxGRjRCs
X-Google-Smtp-Source: ABdhPJzzDlf1sbMBRdlpW+FTsKwCqeGLxqT2y5BGSJ+uwFUETVi2riOspmcrQJaezxvioX7sUiteRA==
X-Received: by 2002:a05:6402:228d:: with SMTP id cw13mr37891086edb.343.1593731470281;
        Thu, 02 Jul 2020 16:11:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id x9sm8214031ejw.28.2020.07.02.16.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:11:09 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/15] options: handle_onoff_switch() can handle any flags, not only warnings
Date:   Fri,  3 Jul 2020 01:10:29 +0200
Message-Id: <20200702231039.55015-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
References: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, use 'flag' instead of 'warning' for variable and function names.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/lib.c b/lib.c
index 9acdc60fc416..c27773097127 100644
--- a/lib.c
+++ b/lib.c
@@ -250,10 +250,10 @@ void die(const char *fmt, ...)
 static struct token *pre_buffer_begin = NULL;
 static struct token *pre_buffer_end = NULL;
 
-enum warning_type {
-	WARNING_OFF,
-	WARNING_ON,
-	WARNING_FORCE_OFF
+enum flag_type {
+	FLAG_OFF,
+	FLAG_ON,
+	FLAG_FORCE_OFF
 };
 
 int Waddress = 0;
@@ -295,7 +295,7 @@ int Wshadow = 0;
 int Wshift_count_negative = 1;
 int Wshift_count_overflow = 1;
 int Wsizeof_bool = 0;
-int Wsparse_error = WARNING_FORCE_OFF;
+int Wsparse_error = FLAG_FORCE_OFF;
 int Wstrict_prototypes = 1;
 int Wtautological_compare = 0;
 int Wtransparent_union = 0;
@@ -529,9 +529,9 @@ static int opt_##NAME(const char *arg, const char *opt, TYPE *ptr, int flag)	\
 OPT_NUMERIC(ullong, unsigned long long, strtoull)
 OPT_NUMERIC(uint, unsigned int, strtoul)
 
-static char **handle_onoff_switch(char *arg, char **next, const struct flag warnings[])
+static char **handle_onoff_switch(char *arg, char **next, const struct flag flags[])
 {
-	int flag = WARNING_ON;
+	int flag = FLAG_ON;
 	char *p = arg + 1;
 	unsigned i;
 
@@ -540,12 +540,12 @@ static char **handle_onoff_switch(char *arg, char **next, const struct flag warn
 		p += 2;
 		if (p[0] == '-')
 			p++;
-		flag = WARNING_FORCE_OFF;
+		flag = FLAG_FORCE_OFF;
 	}
 
-	for (i = 0; warnings[i].name; i++) {
-		if (!strcmp(p,warnings[i].name)) {
-			*warnings[i].flag = flag;
+	for (i = 0; flags[i].name; i++) {
+		if (!strcmp(p,flags[i].name)) {
+			*flags[i].flag = flag;
 			return next;
 		}
 	}
@@ -722,7 +722,7 @@ static char **handle_switch_o(char *arg, char **next)
 }
 
 static const struct flag pflags[] = {
-	{ "pedantic", &Wpedantic, NULL, OPT_VAL, WARNING_ON },
+	{ "pedantic", &Wpedantic, NULL, OPT_VAL, FLAG_ON },
 	{ }
 };
 
@@ -793,8 +793,8 @@ static char **handle_switch_W(char *arg, char **next)
 	if (!strcmp(arg, "Wsparse-all")) {
 		int i;
 		for (i = 0; warnings[i].name; i++) {
-			if (*warnings[i].flag != WARNING_FORCE_OFF)
-				*warnings[i].flag = WARNING_ON;
+			if (*warnings[i].flag != FLAG_FORCE_OFF)
+				*warnings[i].flag = FLAG_ON;
 		}
 	}
 
@@ -858,13 +858,13 @@ static char **handle_switch_d(char *arg, char **next)
 }
 
 
-static void handle_onoff_switch_finalize(const struct flag warnings[])
+static void handle_onoff_switch_finalize(const struct flag flags[])
 {
 	unsigned i;
 
-	for (i = 0; warnings[i].name; i++) {
-		if (*warnings[i].flag == WARNING_FORCE_OFF)
-			*warnings[i].flag = WARNING_OFF;
+	for (i = 0; flags[i].name; i++) {
+		if (*flags[i].flag == FLAG_FORCE_OFF)
+			*flags[i].flag = FLAG_OFF;
 	}
 }
 
-- 
2.27.0

