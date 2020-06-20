Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A99C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDE924140
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBjwb6fl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgFTSIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36172 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgFTSIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id 97so9857413otg.3;
        Sat, 20 Jun 2020 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vxv6MffVeswoJgrFkqFvX1d7qFMjlLZElugxJP8tfQU=;
        b=OBjwb6flZxKZSdDmGhHd44kMwy+85CMdNTAGy9iIzNxJkk5M7TRah+s5OG4H0rfjK+
         KqYfZMiD9ksdjOTDUS+rRB/NEFIWlK6P5SAutvcRku7x8rY/+9+BSy7ggfhh0UUFczQj
         DlbOXWMmYsyOSU9Ku5QDx1Ce97N8rfrDKSU8Bwh5C3FSQR1kGDIX8pxsXPw2AYQ/U9Hs
         BY1MY8sPtJ9GUvJh0OkZ8Vnh++w95w+PzyaKZqPxf35G9ArVCIj0xPhWSxQRTXS132LU
         ylH3AEIKimJ61mA3yBojbngXvB5B5D9fOA28Xj3ReCWLLEWCfDccxTjfPcOmjtSEbrxU
         hoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vxv6MffVeswoJgrFkqFvX1d7qFMjlLZElugxJP8tfQU=;
        b=iNDzw9lvn/myVw45xwvRwEssmyDlkJfsoqbNBxaqXyRwmgrD77wvm2e52i69ZejeSs
         xXOnCPZH6qL69otsov3hRokEBQ+6qOr5kyCGYeVTZCWv8BrB6K5SyAm20iKcsE5cQtGj
         dxXKNAMn6dO8RxMBSxZoodQwRLMIylpWVIMNe2YtHHdhDlxtBeb3xyA9vWGUcmk9tjvn
         FphCoQoaKCl9AbMvt4kwM5/4OK7AqUEfLaj+jj8RqoRSGDL0O0TvjMzzEAavCh/9PCrF
         /JlucWJABf/V+g4r//TFtwAkod+z1Uij2UsPUs6JelakTs55UPXCrHOiT2FDYuUGQEej
         SXWA==
X-Gm-Message-State: AOAM533nJwruZneiqNyxzI5HumjSDe4VfZl80szWWSNXAM0cU1odA6S4
        KFMSjsnKcZQvbjJNqRDPFp4=
X-Google-Smtp-Source: ABdhPJyfJAjyzBuRnL9VZ1bz2vnlsrR3p8JWdc/kqzueEceGz+MjpJlMBTSBICrtqIhX6LuK8CNnhg==
X-Received: by 2002:a9d:2ca:: with SMTP id 68mr7589048otl.298.1592676442060;
        Sat, 20 Jun 2020 11:07:22 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:21 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Petr Mladek <pmladek@suse.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 14/17] dyndbg: accept query terms like file=bar and module=foo
Date:   Sat, 20 Jun 2020 12:06:40 -0600
Message-Id: <20200620180643.887546-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code expects "keyword" "arg" as 2 space separated words.
Change to also accept "keyword=arg" form as well, and drop !(nwords%2)
requirement.  Then in rest of function, use new keyword, arg variables
instead of word[i], word[i+1]

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       |  1 +
 lib/dynamic_debug.c                           | 52 ++++++++++++-------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 6c04aea8f4cd..e5a8def45f3f 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -156,6 +156,7 @@ against.  Possible keywords are:::
   ``line-range`` cannot contain space, e.g.
   "1-30" is valid range but "1 - 30" is not.
 
+  ``module=foo`` combined keyword=value form is interchangably accepted
 
 The meanings of each keyword are:
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 7eb963b1bd11..65c224301509 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -341,7 +341,8 @@ static int check_set(const char **dest, char *src, char *name)
 
 /*
  * Parse words[] as a ddebug query specification, which is a series
- * of (keyword, value) pairs chosen from these possibilities:
+ * of (keyword, value) pairs or combined keyword=value terms, 
+ * chosen from these possibilities:
  *
  * func <function-name>
  * file <full-pathname>
@@ -360,22 +361,33 @@ static int ddebug_parse_query(char *words[], int nwords,
 	unsigned int i;
 	int rc = 0;
 	char *fline;
-
-	/* check we have an even number of words */
-	if (nwords % 2 != 0) {
-		pr_err("expecting pairs of match-spec <value>\n");
-		return -EINVAL;
-	}
+	char *keyword, *arg;
 
 	if (modname)
 		/* support $modname.dyndbg=<multiple queries> */
 		query->module = modname;
 
-	for (i = 0; i < nwords; i += 2) {
-		if (!strcmp(words[i], "func")) {
-			rc = check_set(&query->function, words[i+1], "func");
-		} else if (!strcmp(words[i], "file")) {
-			if (check_set(&query->filename, words[i+1], "file"))
+	for (i = 0; i < nwords; i++) {
+		/* accept keyword=arg */
+		vpr_info("%d w:%s\n", i, words[i]);
+
+		keyword = words[i];
+		if ((arg = strchr(keyword, '='))) {
+			*arg++ = '\0';
+		} else {
+			i++; /* next word is arg */
+			if (!(i < nwords)) {
+				pr_err("missing arg to keyword:%s\n", keyword);
+				return -EINVAL;
+			}
+			arg = words[i];
+		}
+		vpr_info("%d key:%s arg:%s\n", i, keyword, arg);
+
+		if (!strcmp(keyword, "func")) {
+			rc = check_set(&query->function, arg, "func");
+		} else if (!strcmp(keyword, "file")) {
+			if (check_set(&query->filename, arg, "file"))
 				return -EINVAL;
 
 			/* tail :$info is function or line-range */
@@ -391,18 +403,18 @@ static int ddebug_parse_query(char *words[], int nwords,
 				if (parse_linerange(query, fline))
 					return -EINVAL;
 			}
-		} else if (!strcmp(words[i], "module")) {
-			rc = check_set(&query->module, words[i+1], "module");
-		} else if (!strcmp(words[i], "format")) {
-			string_unescape_inplace(words[i+1], UNESCAPE_SPACE |
+		} else if (!strcmp(keyword, "module")) {
+			rc = check_set(&query->module, arg, "module");
+		} else if (!strcmp(keyword, "format")) {
+			string_unescape_inplace(arg, UNESCAPE_SPACE |
 							    UNESCAPE_OCTAL |
 							    UNESCAPE_SPECIAL);
-			rc = check_set(&query->format, words[i+1], "format");
-		} else if (!strcmp(words[i], "line")) {
-			if (parse_linerange(query, words[i+1]))
+			rc = check_set(&query->format, arg, "format");
+		} else if (!strcmp(keyword, "line")) {
+			if (parse_linerange(query, arg))
 				return -EINVAL;
 		} else {
-			pr_err("unknown keyword \"%s\"\n", words[i]);
+			pr_err("unknown keyword \"%s\"\n", keyword);
 			return -EINVAL;
 		}
 		if (rc)
-- 
2.26.2

