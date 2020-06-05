Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B6AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5F32074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj/801q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgFEQ2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbgFEQ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:27:49 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75235C08C5C4
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:27:49 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 69so8072887otv.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0TqppIn6BuRHaNOgh5AvgWTO95AAjy++fKL00K6NjM=;
        b=hj/801q0vd3JtRrTWASWK3loeGEI8BUp1dBrQehyCTrhSYQcY3OzL76dvXzSdtWMQm
         msFFu96s0A+bvbe+LYAffWzoJiuWZTTo8LT2IZ1dYtAX5FvF6oa9z1w9qHuUms5Ju0Zl
         fSsM3V58iGiIq6T16raITGmJcaPW/I8kpPAwr2zXWH52sHW6MIQ7p1jHT34I8+nU275u
         OpHnxpHJ9YI92dokvEUfUaXAIUJyl0QDmFp3YO+7qnqq+aerMYLth0XCuTHUGjcHNBZ7
         z9ujlwKpmbjgMmbgKVFVTO/4qshgUrNM7SLG6+NAITvijGXqwwcWkhO1NW072K+utfm1
         qZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0TqppIn6BuRHaNOgh5AvgWTO95AAjy++fKL00K6NjM=;
        b=kAmQb/1ga7sP53pgBCjKRpcG5GUfNEMglazvsLdi/dUGY2HV0RIFk+CPeLgVy2K+7m
         ajGIACfn+qzKrSiPpQ3wYvFbKeDYU3se+OxIqRECIzTkrB2FlxB0jcX3DjSqrdozvs2f
         nFIImfHmlN7DDti4mf6iDUCs4xSXcM/i3+1Fq51oAkaPIDQIlg26dCX0+I3GcFmpZUFV
         7Gq3c8rxWG8PuaZ6apSKXYvwFzKODch1yowmDZjiFfB5BlLHBFaJuCfAHmpM4qkHztto
         MkGRVV9MiAZ8l36nuNegeUm2ahQ1q/4R2sRQZHy+RKrIbeyNkXrx3zPlfcMiwc5Nk/nm
         4k+Q==
X-Gm-Message-State: AOAM531iKJg7UnXdY/GLh9uRD4QVFrCmmqZqrAtUyU/2ekDoPkmnKQ7Z
        GTftgzxyV3V3fPp4WKO5OH4=
X-Google-Smtp-Source: ABdhPJxfNudU4C2BMwt48tt/YYP60TrFleXRpo8vJ0Y1bU2FDNvw+zYiWf7QMZMdVncQbcsN9AxfJA==
X-Received: by 2002:a9d:2253:: with SMTP id o77mr8129433ota.236.1591374468821;
        Fri, 05 Jun 2020 09:27:48 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:27:47 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 08/16] dyndbg: refactor parse_linerange out of ddebug_parse_query
Date:   Fri,  5 Jun 2020 10:26:37 -0600
Message-Id: <20200605162645.289174-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make the code-block reusable to later handle "file foo.c:101-200" etc.
This should be a 90%+ code-move, with minimal adaptations; reindent,
and scafolding.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 61 +++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 494856c04fa7..d43bc3547d3a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -291,6 +291,39 @@ static inline int parse_lineno(const char *str, unsigned int *val)
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
+	return 0;
+}
+
 static int check_set(const char **dest, char *src, char *name)
 {
 	int rc = 0;
@@ -349,34 +382,8 @@ static int ddebug_parse_query(char *words[], int nwords,
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

