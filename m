Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C715CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9622076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6o50Bxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHYReN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgHYRdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:33:50 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEBCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:33:49 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 5so8226881otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Zb3O25WoLFkngCfCQG+fPmc0tqenZMw1StPfudPSEQ=;
        b=g6o50BxwHog+DdqQpMPOSsEmmzcZL4EmTrGrMO8bNYnEHjeNPoEolgwpY0zAuIIzk6
         uKUDjGHyjfglmrpJu+MyUxvfrbhkEpZ0u9SKab0HqB0lIzrd1+x/tzSB3oT7PlIL/rXy
         YLrZ+XkuduT1lhKAfI0CJWfv2WISTmCSokoAX36MY0BKtI83p4Jpy5TJEc2n4+lekaXu
         xjJTaTIEpOaj1PXnvy94XUE4W6qSsxCITbtZfrgATKTp6PuFzK9Kuu59A70SpcXvOkGS
         BCksbHv9mVvOR6yh2iy6YJg2qT/JdFuAZ959VMqoA/L/bL6ytzVSk+0ZOhkk4irxnh7h
         jFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Zb3O25WoLFkngCfCQG+fPmc0tqenZMw1StPfudPSEQ=;
        b=ZYU3zeRNWbfy891cLA0JYkM/U0sb6cRmrcNggzNtEI4TZ+YtfhZbk8/kwdDhT4Vr46
         ZrL/VlM9KiKSU7919ULjFkIqqyDx+HVDxeyq4AuOsn0CGvZZH5bZ5dcdYtBJRn4oinUo
         r0sCdByp2r1kAU+3fwyxGuTvAmN3gjmRD0QXGYqqlDLgA1oz/nTEiIRwrCSQ2/cGxcMf
         pLAQevhuf9SiqL2FXhqWlYLEKP2AT4a0mclH5PDtHjYT97wh+b7cpgcD94/hNqhdE8Av
         NKZfcn2ZyTs4pNrxzy0ixh4m8hJD2IC53NNmx+U/c3RTie4uvseV5vpzDX3eQziYLCQW
         NOyw==
X-Gm-Message-State: AOAM531cYZPFFpbvdNAyjP27g/gMQWATihtabPKAU7QqAhHNVyw4zqWu
        kgDkHV13yB3fZnodusRWk+U=
X-Google-Smtp-Source: ABdhPJwOco4inGnNluR87Owyjjcrl0Ny0TfSMpySfagQ0eMjxDASCGEIjPSFV4Mwepg1dM6rF+y8DQ==
X-Received: by 2002:a9d:ea5:: with SMTP id 34mr7731340otj.199.1598376829090;
        Tue, 25 Aug 2020 10:33:49 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::c4c])
        by smtp.googlemail.com with ESMTPSA id x11sm3214168oot.0.2020.08.25.10.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:33:48 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 3/3] dyndbg: fix problem parsing format="foo bar"
Date:   Tue, 25 Aug 2020 11:33:39 -0600
Message-Id: <20200825173339.2082585-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825173339.2082585-1-jim.cromie@gmail.com>
References: <20200825173339.2082585-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 14775b049642 dyndbg: accept query terms like file=bar and module=foo

That commit broke on a tokenization modality where a word could start
with a quote, but couldnt continue with one.  So the above would
tokenize as 'format="foo' and 'bar"', and fail hard.

This commit fixes the tokenizer by terminating an unquoted token on
the '=', avoiding that problem.  And since ddebug-parse-query will
never see a combined 'keyword=value', revert those parts of the
previous commit.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a23b5d153153..04b851117eeb 100644
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
@@ -373,30 +378,20 @@ static int ddebug_parse_query(char *words[], int nwords,
 	unsigned int i;
 	int rc = 0;
 	char *fline;
-	char *keyword, *arg;
 
+	if (nwords % 2 != 0) {
+		pr_err("expecting pairs of match-spec <value>\n");
+		return -EINVAL;
+	}
 	if (modname)
 		/* support $modname.dyndbg=<multiple queries> */
 		query->module = modname;
 
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
+	for (i = 0; i < nwords; i+=2) {
+		char *keyword = words[i];
+		char *arg = words[i+1];
 
+		vpr_info("key:'%s' arg:'%s'\n", keyword, arg);
 		if (!strcmp(keyword, "func")) {
 			rc = check_set(&query->function, arg, "func");
 		} else if (!strcmp(keyword, "file")) {
-- 
2.26.2

