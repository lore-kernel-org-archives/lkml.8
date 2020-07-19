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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE7EC433F7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D898220738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcXDVwy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGSXMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgGSXLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:46 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2807C0619D2;
        Sun, 19 Jul 2020 16:11:45 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r8so12999144oij.5;
        Sun, 19 Jul 2020 16:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRXB+JS42nffvxMyjWW2qiYBpadQLCn8VyzG3U8X8TA=;
        b=pcXDVwy9RftphiIDcWquMAKxmUKx4I1iGGUBYh+MFy5v6w9JzewC45GD+nE2vtbKAh
         +slRGlBtr+UFAd0ug9zzZW3YcwLbSS8+9SYTDI6NFJwjv1WNRYF3fVQW6uYFc8BuXWMV
         SmnKM2BVt7BrryTS2PpmjGJB97q54XCOxA+O0iftMoy0VR99myhJaQIZfN/206+zFhsz
         VfAlpTi2WDOSk4l+1GUcr7crPvAYh542UpJKbRinouAk5D/Ww7FHX0lSo5lDbbXPAX65
         l+RXG/MfTNmNLJ7oabIwkHTncd8HSu02zhJDtyMEUlcIpKUv4YzzWnNw17DJgGr/Q7ZD
         4H0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRXB+JS42nffvxMyjWW2qiYBpadQLCn8VyzG3U8X8TA=;
        b=D65wNxNu4MVwLJbChuLGPVUb7eokdX2CpgWA6xa6gGiW6bca1Sn8OwkDpSo23N5Nsa
         xt6CSDoLoyE5+BzDO7yfaKFI0gxeCuSUer599gSHBvJTCRYwtEGWOHNFQk9cyts5K96R
         IeyJ16eqmuavtPKOmDshPMMQq5aYYoyljbipUB4CBYT9FAC5lSzHLVs4Upe7BRDtC7jE
         o0RJyqXSXqUOvSnukZg/H1zS7Nc0rjqEVNjkZo01UafuXb0/bM3va5Y9zy4k3qrdU+7q
         gmFUtaDPztXyvNGkwPxf0QdI/MkmzUCDnbr801pMgBio6ojHKKtgBrdlTa8SV/nGeVMJ
         gdzQ==
X-Gm-Message-State: AOAM531GtNaS63shw/F8/p94TAq/bSQjIT7PW9ahgpfdX6qTHOGjlQXc
        K9bjAu9aFtx35XfR1NQIrh3gxClS9O+ZgA==
X-Google-Smtp-Source: ABdhPJwJNAh4wd8+kPvUDNTW1no5MEq+Y+AyQo23eJosmFvfDTGJAQeeRrMMD93ks1U2pxRzLWL5jQ==
X-Received: by 2002:aca:edc1:: with SMTP id l184mr16733658oih.99.1595200304774;
        Sun, 19 Jul 2020 16:11:44 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:44 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org
Subject: [PATCH v5 14/18] dyndbg: accept query terms like file=bar and module=foo
Date:   Sun, 19 Jul 2020 17:10:54 -0600
Message-Id: <20200719231058.1586423-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code expects "keyword" "arg" as 2 words, space separated.
Change to also accept "keyword=arg" form as well, and drop !(nwords%2)
requirement.  Then in rest of function, use new keyword, arg variables
instead of word[i], word[i+1]

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       |  1 +
 lib/dynamic_debug.c                           | 53 ++++++++++++-------
 2 files changed, 34 insertions(+), 20 deletions(-)

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
index 7eb963b1bd11..fad6c34c930d 100644
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
@@ -360,22 +361,34 @@ static int ddebug_parse_query(char *words[], int nwords,
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
+		arg = strchr(keyword, '=');
+		if (arg) {
+			*arg++ = '\0';
+		} else {
+			i++; /* next word is arg */
+			if (!(i < nwords)) {
+				pr_err("missing arg to keyword: %s\n", keyword);
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

