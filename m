Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63358C433EC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD302177B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyZm2z9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGSXLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGSXLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:41 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDC3C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:41 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id p26so2839100oos.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QII4KCJwf9dMBviArk10YJa+Ll/mKwPyRSRRAQ8I9nQ=;
        b=MyZm2z9paEHiEIBVHHceHZNoe6oZKEFY3TWQVCHoTqN0shJPXDdp3E6UkRpvndSnER
         ntIw3e2qzWIEZ1ZdDlwcsVq4bry6GcB/ZS6/6apnTmvNQLLLjLL0lusiTE7nz2cGJlnv
         doyTke7HxhKjkCaivw8oXpS+nici6cVCT1qZf6V57u+vhnRFjGPi0+90a42W9TdioNfR
         0BGLek+AZduzhRB33E55Iognz9bTUgLdFqZmMQ/IXAQlHGcqKoETndtRjUWY/IxoKX/Y
         UYlRmBJ493tWnws1ABP+K7JpQRkLYDQAavOOIaHm6kFo9h877lVEYvrJgG5Ngptd6P2W
         3Inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QII4KCJwf9dMBviArk10YJa+Ll/mKwPyRSRRAQ8I9nQ=;
        b=JKuaTGvMNgpA3jnH2AXgQtAfaczgWD3o8oml2Jdv04tr64f3EPtKBO9ZulfrXu2vLY
         sfY/jbEuz0GxnOZVRo24SBig7QeC2cLiTo5cnHzutGK7ymfeDIdXnsisFzB1IcxOySXA
         IpSooyVx+nErmBLlfrVghVbW14cRET9XaX6nF5E5vk1RkPxGQbJfQHqOQFOHrDVo+Bzl
         IxXSLs+PzJ4k7e/qxztocTTHaICvgYJZqQhKCncP4Lhl+X/RWSmz1JsfRZ/7ZEwNzm8o
         X6d+SjVuVzUFYSmNhAco20gaIFzP5ppNGQlgwSPBn61uTtsHZ1FmYaPELj+RXiIaSPYk
         J0lg==
X-Gm-Message-State: AOAM531YvXob681ZIj0oQuad0N9F9lWFDa0WZCDiGTFQXxnNLOsFgPga
        B8mNmrS7GjkuExhyPJzWOko=
X-Google-Smtp-Source: ABdhPJyQFpjCBq9k/kyNJZl442a01HNqlbdliGw0oaVlkmG2kQVaOIFgzwF14vbfGpnzZJXxmLFMxA==
X-Received: by 2002:a4a:86c3:: with SMTP id y3mr17345911ooh.31.1595200300752;
        Sun, 19 Jul 2020 16:11:40 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:40 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 12/18] dyndbg: refactor parse_linerange out of ddebug_parse_query
Date:   Sun, 19 Jul 2020 17:10:52 -0600
Message-Id: <20200719231058.1586423-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code-block reusable to later handle "file foo.c:101-200" etc.
This is a 99% code move, with reindent, function wrap&call, +pr_debug.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 63 ++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6d0159075308..7a66d5e07f41 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -291,6 +291,41 @@ static inline int parse_lineno(const char *str, unsigned int *val)
 	return 0;
 }
 
+static int parse_linerange(struct ddebug_query *query, const char *first)
+{
+	char *last = strchr(first, '-');
+
+	if (query->first_lineno || query->last_lineno) {
+		pr_err("match-spec: line used 2x\n");
+		return -EINVAL;
+	}
+	if (last)
+		*last++ = '\0';
+	if (parse_lineno(first, &query->first_lineno) < 0)
+		return -EINVAL;
+	if (last) {
+		/* range <first>-<last> */
+		if (parse_lineno(last, &query->last_lineno) < 0)
+			return -EINVAL;
+
+		/* special case for last lineno not specified */
+		if (query->last_lineno == 0)
+			query->last_lineno = UINT_MAX;
+
+		if (query->last_lineno < query->first_lineno) {
+			pr_err("last-line:%d < 1st-line:%d\n",
+			       query->last_lineno,
+			       query->first_lineno);
+			return -EINVAL;
+		}
+	} else {
+		query->last_lineno = query->first_lineno;
+	}
+	vpr_info("parsed line %d-%d\n", query->first_lineno,
+		 query->last_lineno);
+	return 0;
+}
+
 static int check_set(const char **dest, char *src, char *name)
 {
 	int rc = 0;
@@ -348,34 +383,8 @@ static int ddebug_parse_query(char *words[], int nwords,
 							    UNESCAPE_SPECIAL);
 			rc = check_set(&query->format, words[i+1], "format");
 		} else if (!strcmp(words[i], "line")) {
-			char *first = words[i+1];
-			char *last = strchr(first, '-');
-			if (query->first_lineno || query->last_lineno) {
-				pr_err("match-spec: line used 2x\n");
-				return -EINVAL;
-			}
-			if (last)
-				*last++ = '\0';
-			if (parse_lineno(first, &query->first_lineno) < 0)
+			if (parse_linerange(query, words[i+1]))
 				return -EINVAL;
-			if (last) {
-				/* range <first>-<last> */
-				if (parse_lineno(last, &query->last_lineno) < 0)
-					return -EINVAL;
-
-				/* special case for last lineno not specified */
-				if (query->last_lineno == 0)
-					query->last_lineno = UINT_MAX;
-
-				if (query->last_lineno < query->first_lineno) {
-					pr_err("last-line:%d < 1st-line:%d\n",
-						query->last_lineno,
-						query->first_lineno);
-					return -EINVAL;
-				}
-			} else {
-				query->last_lineno = query->first_lineno;
-			}
 		} else {
 			pr_err("unknown keyword \"%s\"\n", words[i]);
 			return -EINVAL;
-- 
2.26.2

