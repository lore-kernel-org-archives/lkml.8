Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9FCC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABD72071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joFCO9aP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgHaSXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbgHaSXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:23:05 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:23:05 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d190so6106175iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xv8rGjKL3AwaVAY3DveNACmKtTJqRUUuSopt9eMG6Sg=;
        b=joFCO9aPkwFdN3+LMX0pw3+AcTzaOnmd3vAoxDSr0miya+xkD5Q3Ww2WoPKJ8zmINc
         8cTGbp4nwt2bPZEj55JmmAkwFKvMRTlGKZ2wi9THLyOAaRucncX4QUmxsJq6CHoavYCr
         ughYYusRskGtr1JJVKa7xJ9rxdQs5X1H2HrmY96C0kogl8G1QyVG3PUxSuJ0C3D1Lxv9
         KcvWSk75PWEPhekhVjcLIc+Xc1bK3OSGLmZuRKq26v0Gbz778mRaz+H37ti700WzGl2p
         YSaMg/3FQP82QGXLiE3Gj4f/QsKJchu+0HJU9NNvgtImqPDI2djCMzHjOUK8vVO7YZGZ
         9UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xv8rGjKL3AwaVAY3DveNACmKtTJqRUUuSopt9eMG6Sg=;
        b=kNU0Vb5ZAeKizByTwX0nnp7O31IDHvDv8YLbiHv2loykisUksm+sXWZ3gNUZ0QxhZa
         Frwd2ttXBGrKfal+IxarZexYTDEenOm0mwepvOdYMCPiRroWhwoW7hLkfBnQhU1Oq42J
         KTHfJR0QxhS6NKTt5N7gRqiWInSdQA9MbqHHUceqeZ5vOQzGPO0wQ2cjJm9fG6HUF/eh
         j9Wd1Cf4k2UzqLxjru3Fo3JZVCYmaRsfRybXBZNS5hTnLjCYzfxONPLeesY0xxV10gq8
         ORaIl1B4tRVCFyb9cfBXFZCCHNTL0C56l8Ih+papEmuWyc5/7eR2kbu5NLrADqNr9eP8
         Xtzw==
X-Gm-Message-State: AOAM530Hh1lFeIWygr+JYTjRTr3NjiSf66POvBpCE+ZtdJ1sZB5cXjqI
        +tw+dBKsO2IVfNo5aZ62FME=
X-Google-Smtp-Source: ABdhPJzBxffsjRS306lzQbjmhFGK2u2q6uduTo/rEalzCIBbICArYTe2nwuVweajJC+vNlOTk08vjg==
X-Received: by 2002:a5e:9e0a:: with SMTP id i10mr2287381ioq.41.1598898184551;
        Mon, 31 Aug 2020 11:23:04 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::dc2e])
        by smtp.googlemail.com with ESMTPSA id p18sm4129017iog.1.2020.08.31.11.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 11:23:04 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 3/3] dyndbg: fix problem parsing format="foo bar"
Date:   Mon, 31 Aug 2020 12:22:10 -0600
Message-Id: <20200831182210.850852-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831182210.850852-1-jim.cromie@gmail.com>
References: <20200831182210.850852-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 14775b049642 ("dyndbg: accept query terms like file=bar and module=foo")

added the combined keyword=value parsing poorly; revert most of it,
keeping the keyword & arg change.

Instead, fix the tokenizer for the new input, by terminating the
keyword (an unquoted word) on '=' as well as space, thus letting the
tokenizer work on the quoted argument, like it would have previously.

Also add a few debug-prints to show more parsing context, into
tokenizer and parse-query, and use "keyword, value" in others.

Fixes: 14775b049642 ("dyndbg: accept query terms like file=bar and module=foo")
---
-v3 commit message, checkpatch fixes

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 08e4b057514c..04f4c80b0d16 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -237,6 +237,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 {
 	int nwords = 0;
 
+	vpr_info("entry, buf:'%s'\n", buf);
 	while (*buf) {
 		char *end;
 
@@ -247,6 +248,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 		if (*buf == '#')
 			break;	/* token starts comment, skip rest of line */
 
+		vpr_info("start-of-word:%d '%s'\n", nwords, buf);
+
 		/* find `end' of word, whitespace separated or quoted */
 		if (*buf == '"' || *buf == '\'') {
 			int quote = *buf++;
@@ -257,7 +260,9 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf;
+			     *end && *end != '=' && !isspace(*end);
+			     end++)
 				;
 			BUG_ON(end == buf);
 		}
@@ -373,30 +378,21 @@ static int ddebug_parse_query(char *words[], int nwords,
 	unsigned int i;
 	int rc = 0;
 	char *fline;
-	char *keyword, *arg;
 
-	if (modname)
+	if (nwords % 2 != 0) {
+		pr_err("expecting pairs of match-spec <value>\n");
+		return -EINVAL;
+	}
+	if (modname) {
 		/* support $modname.dyndbg=<multiple queries> */
+		vpr_info("module:%s queries:'%s'\n", modname);
 		query->module = modname;
+	}
+	for (i = 0; i < nwords; i += 2) {
+		char *keyword = words[i];
+		char *arg = words[i+1];
 
-	for (i = 0; i < nwords; i++) {
-		/* accept keyword=arg */
-		vpr_info("%d w:%s\n", i, words[i]);
-
-		keyword = words[i];
-		arg = strchr(keyword, '=');
-		if (arg) {
-			*arg++ = '\0';
-		} else {
-			i++; /* next word is arg */
-			if (!(i < nwords)) {
-				pr_err("missing arg to keyword: %s\n", keyword);
-				return -EINVAL;
-			}
-			arg = words[i];
-		}
-		vpr_info("%d key:%s arg:%s\n", i, keyword, arg);
-
+		vpr_info("keyword:'%s' value:'%s'\n", keyword, arg);
 		if (!strcmp(keyword, "func")) {
 			rc = check_set(&query->function, arg, "func");
 		} else if (!strcmp(keyword, "file")) {
-- 
2.26.2

