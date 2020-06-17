Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A442C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6085C21534
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO2Jywzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgFQQ0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgFQQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:22 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DB8C06174E;
        Wed, 17 Jun 2020 09:26:22 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id e8so519021ooi.11;
        Wed, 17 Jun 2020 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6W/W/8iMgyKSSCNjDIAMf5k7Ck/OYV5ckFmptQp2ydo=;
        b=SO2JywzrwXv4GNIXn+00sBgyqL1118djI9ahQ1RbuDjnyvlsLdpPmIyHfFKR5qHjEv
         36n9IoVyVGXXk0FpezkeKPSoe3GvpZdLIBGItCO88tkC81FxDJ2WcDv+2ErDuPu7Xaye
         oPSERMipc7u1sM1Cyv2wsxjrZlKQY0iiOTnc78konDQrr3/T4HOUEmFJN2Nlc8FLtqs+
         6LHj1E1GBLRXY5gsL2eF604HQuTWeq8vHoFKQkq/GV2HF1X4cBnDT1Mtn8RBPOYxo4td
         wSmEbrojRFNHzxUtc/jorQhmAUd6LJy/OZqgbtJhVXg87/P+AuA0KSSrLEk3S80R5YwV
         UCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6W/W/8iMgyKSSCNjDIAMf5k7Ck/OYV5ckFmptQp2ydo=;
        b=PWW6AfU2A3JbqZIA1H88imTEC+kD+jtDp/gFZMc/l8wXIhMA7/uDajN1ITs2uJIbdg
         +HMqMKd/MDI+eZb95ebYOgB2/ATpsMCkE2zG4tVZT8aeyXHtOZYgBO7q7FRpxYOwiWDF
         LomzLkaNJS1OWkmh+HF63IerkK85k43rvPQraZvJ6o1ixN0IX4U9mRwlI8/vlNfoMhdd
         f/8QV6Oep4H4O83/PPvB1w+H2onBzp1KNLgyQ1if7/77Pee5+d+93BtiAWGtZco9BQZP
         M76XvMhH49SIuHEv3JDG850qxB2ywUGWLesuhj8XcN9TqNKXQZQmM5nB+eSz9H3oTQ+Q
         ijXg==
X-Gm-Message-State: AOAM532top7wDBp1uYlR/z1vYclOutCFOaImL/a4uEp1Y3Lvk8tlaIsA
        azBlDzfHueeQOPZ71vYfiRg=
X-Google-Smtp-Source: ABdhPJzGNolf97KQxjF9nsqYYW7HJfwm5X3hTHPmEJtL22DVcbb0b0PCYnmzWAexgGE6fcCGSigSOg==
X-Received: by 2002:a4a:dcc4:: with SMTP id h4mr213583oou.0.1592411181740;
        Wed, 17 Jun 2020 09:26:21 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:21 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org
Subject: [PATCH v3 14/21] dyndbg: accept query terms like file=bar and module=foo
Date:   Wed, 17 Jun 2020 10:25:27 -0600
Message-Id: <20200617162536.611386-15-jim.cromie@gmail.com>
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

Then in rest of function, use new keyword, arg variables instead of
word[i], word[i+1]

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       |  1 +
 lib/dynamic_debug.c                           | 51 ++++++++++++-------
 2 files changed, 33 insertions(+), 19 deletions(-)

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

