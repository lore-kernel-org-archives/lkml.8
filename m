Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5FEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167BF208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTDopd5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgFQQ1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgFQQ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:17 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA269C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:16 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id q188so527472ooq.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GmKiR2gu/wiGa6gUvyZ+gseeA9528zgy4FBcqF+x5zM=;
        b=WTDopd5sgbf5DkNU/F1blgWE6j49uaBqPWN7l7HStN8JEMS4EZsiUQvvf5WHdMezAD
         L1dHSFIkCdcFaaj1TlzJ8c165IjfRz5Dj7wt2EPJ74j0P2bfhrqxQ6C2ufbPhDnZ7R7r
         bgA2PYHjYMsgej/HgX4w93spoFAJT1zvKIFZThkdmtdXkqljOpd3Hb0lure2yuuK12V8
         841ZqqL9D12xVwm7U2tuMnaJwyFYxgJbF1LGl6OTCXPjzXdqoPqrdbkM+8bzlr5qZ0Ay
         7xeRQ0O/uZcVw+62RnQX3UiymRuT+EfWudeKr3xKpNk8Ex1r8ja8iO2VqvktdeRDUUE1
         Zb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GmKiR2gu/wiGa6gUvyZ+gseeA9528zgy4FBcqF+x5zM=;
        b=MccGTAp8g2bO5fSR6Osi9+uos/JjkO179t9LJFGfa5A6MRNSChkGajUMdXgIgOe0TJ
         O6wciKqRAQ8NXSzumQQfxM9XaY7QjDqMxvZFpnCzH5u5dC8OBMn5qp6lTD2LPLKQfbF3
         VJv+gHi0MXE+BXYLc5B47CSY/6inISJdqrdX7PeswcAg7IpaYa0mi6b2Sm2Pch/nxgan
         bdN2+eQh1pMASQr3m7IFi4tS7Mzgh2BVY6ko3+gwS8mmaRvhmSy0sE6s8FX8W8K/JMjk
         yEsnczA64lvRAV2Ztb6RtRYVoqr7hnaVZaBB/NzsXgYuNGjyZX9j8ENNVQoJcATWrBwc
         X8Bw==
X-Gm-Message-State: AOAM532xqy0Z8YZ/14Feh9fgomn9kzTOV57dDUMPuN2k5/GLqWIqtyTk
        nERLyUN8OHJQzOHY3Fg9ezw=
X-Google-Smtp-Source: ABdhPJy0eiiD/ErcoWIu3Wu5tzt5pIrlUMY1i9ZkQKwVFtK+AZCTcNQJCLwSrQumNrPkB4olGOzFwQ==
X-Received: by 2002:a4a:e9b4:: with SMTP id t20mr168451ood.3.1592411176064;
        Wed, 17 Jun 2020 09:26:16 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:15 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 12/21] dyndbg: refactor parse_linerange out of ddebug_parse_query
Date:   Wed, 17 Jun 2020 10:25:25 -0600
Message-Id: <20200617162536.611386-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code-block reusable to later handle "file foo.c:101-200" etc.
This is a 99% code move, with reindent, function wrap & call, etc.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 61 +++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6d0159075308..ae6e523fdecd 100644
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
@@ -348,34 +381,8 @@ static int ddebug_parse_query(char *words[], int nwords,
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

