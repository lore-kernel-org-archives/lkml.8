Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011FBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4E6206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc83TYlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHXSyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgHXSyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:54:32 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B17C061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:54:31 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id z22so9230726oid.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YiVRbmYsSNzi7UqLw/7RR+iZ/H26A983neW9cgoJua4=;
        b=Uc83TYlEMSgaNr4lN21r139pboyrrA5feqZ4D0eYMVXX/lRFTpf/Ja42zDrVPEu36C
         zhNj0kyIvZ1rroST85X/LFc1Lc4K7+kLf1bNlN6aIN47CTBXy+ZHAdhXYBXR9if3OBKN
         5syeY5V0KgsaojNLWXkh8S2aYSxzr1tZse+TidO+L5FP/jTcWdTcBwR8Sk6oKs693tmP
         sdwG4Ao4KuRRzL+ZbI6F5iPpDCnrcsJidoAtCk+iKwvRbaHixevtNeMjZXbpVs+K21Ix
         WTN5VOcz+YRzO7KMFM8EaqpF6dRG/qHlWdC0RyOY/gjbSF5u/22ntWxuX5NiHgspvUza
         Gmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YiVRbmYsSNzi7UqLw/7RR+iZ/H26A983neW9cgoJua4=;
        b=MrvtorYxTIzAVyECkpQ+UzIYE1kuVmg2ZB6kHdp6BTvo0xKLETHkYmPmlB7IaeLQJx
         UPchVeD7iPZ3IZmbchAZuWIqXaJOz57ugzUxflfnyOcuB/sE9hwIaLbHCZhcPYkxfyr/
         Z3AKYNbTKg3xeF+5mqlA6dm1gD6mgwwy4ISIELwBRnYmg5JM+c2NBeSs+6c13+PvcpkW
         hBpB6OqSm3lcxSPBoj+ADY2btMupo5mRm1qgBmH/RoSLKEF3xxlwkWGG8DHuF1QmfCR1
         hYEJhmahr0ng30WtGq1vtjdLPmCU4VdMCM4T7MRpxE9iTwjsg55Ug9hV7bt4KDZTESKJ
         lpCQ==
X-Gm-Message-State: AOAM530VDbBpnDN6ns7ZQDhiHnDLT+JZ6ETDnfbT4bqbS/S6W5xKs9Cs
        CYMo29EjAUcwqQ8oKePe/HsJeJqCbsiKDw==
X-Google-Smtp-Source: ABdhPJx30eTTtDFz53sqMNRISRNygKTOCUotWUOkK+B17/3fSBZejUfmf+a9s7ErWOUq6EpSIVQsuw==
X-Received: by 2002:a05:6808:a90:: with SMTP id q16mr444475oij.165.1598295271289;
        Mon, 24 Aug 2020 11:54:31 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::b30e])
        by smtp.googlemail.com with ESMTPSA id b188sm2112414oif.19.2020.08.24.11.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:54:30 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 3/3] dyndbg: fix problem parsing format="foo bar"
Date:   Mon, 24 Aug 2020 12:54:12 -0600
Message-Id: <20200824185412.1617174-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824185412.1617174-1-jim.cromie@gmail.com>
References: <20200824185412.1617174-1-jim.cromie@gmail.com>
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
index b6ab2c643116..4af686e6ef59 100644
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

