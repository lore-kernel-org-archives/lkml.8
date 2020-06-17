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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EACC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913E321556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHFPT+gA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgFQQ0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgFQQ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:26 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9927C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:25 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 97so2103423otg.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3qCE4bmakEgzVeDumh3DEKOn8ICvfB2l2ErcWMgDYXM=;
        b=HHFPT+gAUyYDcwZuvzJoTG4O5ndBukGxX3dxAwQDL+L2Hm1EEltMd/NYHv/U1Xersi
         LOu43r6B9x+p7eOe0uf8kZpC5n67Lw2ApWna7rDlGc9o7wLRKxKIvwgud3D6NUO8RrlN
         1UUNoj8ZP7RYcmGOU1gILdKHdkh0UiioSrUpJXr5WXFYrcyZzDmuU2W9VAw8IxEepf35
         xPWedXtOvgbkwrVv8FsdMy2iNpbl/2L5kaEd2+5pdVN+221E2gmnjV65T2EXaM7WNdCF
         U9Y0TrIMiwaOuUoa0btlTGbPchgEvl1yhcuQe0UGGbLaoEth8KcxT8X+yGfgSu2yB4pZ
         O+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qCE4bmakEgzVeDumh3DEKOn8ICvfB2l2ErcWMgDYXM=;
        b=OJCX/TFLrAtudzwJOVMOijC4rrBgI9Vl05y0xXMTYBnlHOxq9+9SRvquTE0UG9UBSB
         tXrilW0KP47Fej1NEsIeJN8yMVACyvj9GDvUuyHI2tXiLnnFU6yi36nm/Bfb4Yosabhd
         sotnwT31MukC9DeF/x90VcJpAwj3aXpBNdSHN/9kpB9PurGPPl4x06z96g8ItlLsLjbU
         m43GJgAnBZNNzAzrCurB+dgUfQP4wMJhNUIfVGhHuxJbDgKk3RYEEclmpTq6424NfzUH
         vzIFyP0OLFbgw9u0O8YL7fVhN0LQwOULXFLrknBk5d3wUU9UIVudI5eK15FLT1IZYy9Q
         nZLQ==
X-Gm-Message-State: AOAM532VkmpD9/nIpjkx5XWwqjOfx3XkladAi3NMoZWkt2Gs8gSs3Mlb
        15BUen2EmYoN0dwkJRr6rio=
X-Google-Smtp-Source: ABdhPJxBGi5/+UTI7WCbRBdFi7Hep6nNVwtoSHPYMnL7ikg+1tA2cEUwOudTqjOeMd7i5qjnXhzn4Q==
X-Received: by 2002:a05:6830:1df6:: with SMTP id b22mr7478054otj.98.1592411185225;
        Wed, 17 Jun 2020 09:26:25 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:24 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 14/21] dyndbg: accept query terms like module:foo and file=bar
Date:   Wed, 17 Jun 2020 10:25:29 -0600
Message-Id: <20200617162536.611386-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code expects "keyword" "arg" as 2 space separated words.
Change to also accept "keyword=arg" form as well, and drop !(nwords%2)
requirement.

Then in rest of function, use new keyword,arg variables instead of
word[i],word[i+1]

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 51 ++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 7eb963b1bd11..e1dd96178f18 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -351,6 +351,8 @@ static int check_set(const char **dest, char *src, char *name)
  * line <lineno>
  * line <first-lineno>-<last-lineno> // where either may be empty
  *
+ * Also accept combined keyword=value and keyword:value forms
+ *
  * Only 1 of each type is allowed.
  * Returns 0 on success, <0 on error.
  */
@@ -360,22 +362,33 @@ static int ddebug_parse_query(char *words[], int nwords,
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
@@ -391,18 +404,18 @@ static int ddebug_parse_query(char *words[], int nwords,
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

