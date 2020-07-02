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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26C9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87562088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksBpfHsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgGBXMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgGBXLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:13 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFB2C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:11:12 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dm19so19499381edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhOexs42tN8O73J1HULhVDqy4cxDIEcuMkt/q9iXBcE=;
        b=ksBpfHsUCGAkAzG8mIlf5e+na6UtfScPDcMjkqjZ/E6rb3sRN5JOADZI69IwAUfqPp
         MDN67RcGt39iQysfHNVsEEPiaX016Y17dlqV/zdLCNO5t8I8TvtMooT+m1VrJ5bXgZ0f
         0MAItLbXfqriWQv4rS2gN33AusX/vrER/pu11t9AZC0yx3O3+lJoSSEBL/7TuRajseay
         lCVz3pkfHdJY5vt1Zw+q0lvR+6goit01hUTyqiDTzOUNshBjALh03WiEg1QsT1t/wHeP
         oP11vtfO4GhO4FhoilpmUjM1YYUNTx4QMdW6tKHMiBSpovdlkCNXa3MMesSBjeOKq2Nw
         aaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhOexs42tN8O73J1HULhVDqy4cxDIEcuMkt/q9iXBcE=;
        b=MP6uk45t7xRlwG/o+XMMveZSbusDr+L9EIMcnFTDTqqpmzI5wO7olF523T2EXz92vc
         nqs88Wp62qhkfdfLUKSVEbw5b2KFcRXrE3+iieWS9RihGmEwHgDcihyXEPLzBBpnZ23l
         2HG+sYJd6/4/We05zfWCjI4F3TLtA5zwu2Zun7guPp/iJpoYKeSkAB/AXZ23oDoRXFPw
         +Zlkaoh342WCL9jablSwJKC8EjNCJ4OkUhZO+bp8QIzl70KGqWXydCtJq6WigdLfhGa/
         /Ku0EVttPGJ7uRMFbhN3smYKjHagHV6Yh0NmZE150c5hxC3CnuHCZKjbHlYzT/qdmbB1
         xFvw==
X-Gm-Message-State: AOAM531TO/Je5K5XI5dlauCf7ErRVY4g06sg9EfzFIvHD1YLdTd1iJCg
        IGO2T+qeDaT4YkIeab2kSrVU8XQv
X-Google-Smtp-Source: ABdhPJzf53uiAz24zfbMjRTm5Avq+yRlSpDi7p8xu2OFYbeRDFOO2FPizxUOQ5VxKJ7F6J4DPWdHfQ==
X-Received: by 2002:a50:f702:: with SMTP id g2mr37791761edn.348.1593731471238;
        Thu, 02 Jul 2020 16:11:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id x9sm8214031ejw.28.2020.07.02.16.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:11:10 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/15] options: move helpers up
Date:   Fri,  3 Jul 2020 01:10:30 +0200
Message-Id: <20200702231039.55015-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
References: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helpers for parsing the options are often situated just above the
first function using them. As result, these helpers can be found a bit
everywhere in the code, it's messy and doesn't help to reuse these helpers.

So, move all these helpers to the top.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 87 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/lib.c b/lib.c
index c27773097127..4868154fa3de 100644
--- a/lib.c
+++ b/lib.c
@@ -364,6 +364,15 @@ void add_pre_buffer(const char *fmt, ...)
 ////////////////////////////////////////////////////////////////////////////////
 // Helpers for option parsing
 
+static const char *match_option(const char *arg, const char *prefix)
+{
+	unsigned int n = strlen(prefix);
+	if (strncmp(arg, prefix, n) == 0)
+		return arg + n;
+	return NULL;
+}
+
+
 struct val_map {
 	const char *name;
 	int val;
@@ -438,14 +447,6 @@ end:
 }
 
 
-static const char *match_option(const char *arg, const char *prefix)
-{
-	unsigned int n = strlen(prefix);
-	if (strncmp(arg, prefix, n) == 0)
-		return arg + n;
-	return NULL;
-}
-
 #define OPT_INVERSE	1
 #define OPT_VAL		2
 struct flag {
@@ -497,6 +498,41 @@ static int handle_switches(const char *ori, const char *opt, const struct flag *
 	return 0;
 }
 
+static char **handle_onoff_switch(char *arg, char **next, const struct flag flags[])
+{
+	int flag = FLAG_ON;
+	char *p = arg + 1;
+	unsigned i;
+
+	// Prefixes "no" and "no-" mean to turn warning off.
+	if (p[0] == 'n' && p[1] == 'o') {
+		p += 2;
+		if (p[0] == '-')
+			p++;
+		flag = FLAG_FORCE_OFF;
+	}
+
+	for (i = 0; flags[i].name; i++) {
+		if (!strcmp(p,flags[i].name)) {
+			*flags[i].flag = flag;
+			return next;
+		}
+	}
+
+	// Unknown.
+	return NULL;
+}
+
+static void handle_onoff_switch_finalize(const struct flag flags[])
+{
+	unsigned i;
+
+	for (i = 0; flags[i].name; i++) {
+		if (*flags[i].flag == FLAG_FORCE_OFF)
+			*flags[i].flag = FLAG_OFF;
+	}
+}
+
 static int handle_switch_setval(const char *arg, const char *opt, const struct flag *flag, int options)
 {
 	*(flag->flag) = flag->mask;
@@ -529,31 +565,6 @@ static int opt_##NAME(const char *arg, const char *opt, TYPE *ptr, int flag)	\
 OPT_NUMERIC(ullong, unsigned long long, strtoull)
 OPT_NUMERIC(uint, unsigned int, strtoul)
 
-static char **handle_onoff_switch(char *arg, char **next, const struct flag flags[])
-{
-	int flag = FLAG_ON;
-	char *p = arg + 1;
-	unsigned i;
-
-	// Prefixes "no" and "no-" mean to turn warning off.
-	if (p[0] == 'n' && p[1] == 'o') {
-		p += 2;
-		if (p[0] == '-')
-			p++;
-		flag = FLAG_FORCE_OFF;
-	}
-
-	for (i = 0; flags[i].name; i++) {
-		if (!strcmp(p,flags[i].name)) {
-			*flags[i].flag = flag;
-			return next;
-		}
-	}
-
-	// Unknown.
-	return NULL;
-}
-
 ////////////////////////////////////////////////////////////////////////////////
 // Option parsing
 
@@ -858,16 +869,6 @@ static char **handle_switch_d(char *arg, char **next)
 }
 
 
-static void handle_onoff_switch_finalize(const struct flag flags[])
-{
-	unsigned i;
-
-	for (i = 0; flags[i].name; i++) {
-		if (*flags[i].flag == FLAG_FORCE_OFF)
-			*flags[i].flag = FLAG_OFF;
-	}
-}
-
 static void handle_switch_W_finalize(void)
 {
 	handle_onoff_switch_finalize(warnings);
-- 
2.27.0

