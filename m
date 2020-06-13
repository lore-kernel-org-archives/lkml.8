Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213ABC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08DA20789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqWyAZFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgFMP66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgFMP6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:33 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92EEC03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:32 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 69so9773423otv.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7rFce4RUuKR6hKelORJV5qMjdT0yjRFDtL43viE0JM=;
        b=gqWyAZFfsrSMItTG3/932jSIwKALSa4vRA/xEQ+ZEhBcCY2hy1MYKZRZopnZ+Dbh+O
         tFpcSeUsaS68wXQudYp+zd1QtrH3uiBCjzfSair6LM7VzadyHZqX4yaeAXPfG+uz3SWA
         p6lxkx7UAWvM31Z6JAR/1nXzg7PAsIrpNW8jBvNhyb6t2Wayun3sx74JDhFXZsbppZqb
         zBydI7yxQlb++upwfwSePgGeHPZf93hJkJVSJusxIsqC6pBciWrxEVAK2HwKvawdOF3a
         aytXJ599BptETLwyFXRRz3d8mlhypFPKG5d2886gAPpIyeB51gSbvaNn39khfNv+t6GZ
         WntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7rFce4RUuKR6hKelORJV5qMjdT0yjRFDtL43viE0JM=;
        b=bWWnNe9tzLidYz1S2NkSSnH3iq5OzubGzCBM279aVZmBfQCROAQVeL+i01Chx/y8NP
         FzKcZuaid1c5QWatny1rBGPIYkGN0663Im48QyX6ZYI5mOjwp/EulOhfujR28Ox0GSS1
         D3EF2885OKL0Bfc+CfyWJXhDmKki93kMgD1dBcbWCDfNb3ikUWQOYsw6+N9YWof7ZRkH
         kNzFbb3SEGe6Q4FMSwFCOYcYTKqHvW5gXDtHBDiBK2fydp7g2Qjzpfs41YABvZMedInY
         JNT4G3ZwnFPcPX8zp3lMugBWgGch1C1WaiXcAl8DUP7gqzdgJwQ1WVwXFM/siYc9XfU/
         94cg==
X-Gm-Message-State: AOAM532KA3COOOQPwwNrjkE+qlhwAArqg7DtYWj6r3y5qXma11BQ2ex+
        XpX43+hgfAQenLkL6M85i4M=
X-Google-Smtp-Source: ABdhPJzBU+w1K2gW9Aik2/nXwtbeKvYkkGfY0D2VXUWnRkJg5xy7SAWXEdzcMaY7yiguT21HDgM51w==
X-Received: by 2002:a05:6830:1383:: with SMTP id d3mr14042153otq.353.1592063912090;
        Sat, 13 Jun 2020 08:58:32 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:31 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 19/24] dyndbg: accept query terms like module:foo and file=bar
Date:   Sat, 13 Jun 2020 09:57:33 -0600
Message-Id: <20200613155738.2249399-20-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code expects "keyword" "arg" as 2 space separated words.
Change to also accept "keyword:arg" and "keyword=arg" forms as well,
and drop !(nwords%2) requirement.

Then in rest of function, use new keyword,arg variables instead of
word[i],word[i+1]
---
 lib/dynamic_debug.c | 49 +++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d67fbbc5317f..cb5c7480e026 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -375,22 +375,33 @@ static int ddebug_parse_query(char *words[], int nwords,
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
+		/* accept keyword[:=]arg */
+		vpr_info("%d w:%s\n", i, words[i]);
+
+		keyword = words[i];
+		if ((arg = strpbrk(keyword, ":="))) {
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
@@ -406,18 +417,18 @@ static int ddebug_parse_query(char *words[], int nwords,
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

