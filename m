Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C8DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06F420899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/dqQBdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgGBXLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgGBXLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:20 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E410C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:11:20 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so31764231ejn.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HeXjftP6OVlCVgUhZlLVsughFp7YymEMeZxEFLqAWi0=;
        b=Y/dqQBdBDP7S4DY8lhxTuOWUmANHiPwCuYnSyCPnnmZJw3bfUSm4Wf8YFXLKt6nNgA
         toySjdKaXPsRsGG8CSHw9ahfuApaYIaLBXQFV7XAN0TCTsLvSMmg+r1z8BLnSrDih6se
         DIPDaG2xIgTPQWlGw2EIHmVRokaXzhHfEX+u7acwkX+IlR3CWAfn7eeC7l+2Jk/WA7BQ
         6wxpa4W82u+8RzD1Ag6Vj0DBWEuhnbutE+1N8wg/vbJ/CypDeJq0tnldaEXFhqUaowd9
         fguTtXOX8XeWhkY76vrMSlsF8T9XJDut5FJGruEiengYwpq0hNUJR5A8ClRB6jVA+36t
         mbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HeXjftP6OVlCVgUhZlLVsughFp7YymEMeZxEFLqAWi0=;
        b=ooEI0Ral7pSuWpMrr5tCN23eY8f421FiGwUBJ8tzNqLZFdvqU047FQGeDsoRcmiUCB
         tBgyOqXAFZmkzzMhsbd/uQtyMapqUswiVxoI1cBauoVsieflGKzVkJ0bCfu8HFGZ3uDi
         LixFz4kb5IOfvwqWmXUzq/VEcpvf0vSIisP3uQ9i7QwplfsFrfuiVE8UCr3USsqsC35e
         K2+T4n/Uyh/DL6d8Y0StkFQtNz8piL0ZmefIJrskuMSZM8iDv4YUIEmITTXiuyUN6fL0
         VDG/9t/IbCRbnDY64RAbsbnWxM0tNJVMnAfYToPmZELM4GQK6GvZgjkldWFegbqI0E7D
         +2Dg==
X-Gm-Message-State: AOAM53399PvIebp1qDapPHen8TqTn3a5yzjMs5YyQtFVRySSo2ZMLiyz
        mLeYCfwCrP1IZhXY26YjYXDJ8p3b
X-Google-Smtp-Source: ABdhPJyLm9rF0URQ3IhsyeFX4NucP/KXkUdzC+qgDGf6iwE3sIQ7HLNzflRvl2iYydXeV3uBkbhZqg==
X-Received: by 2002:a17:906:90c1:: with SMTP id v1mr29184790ejw.481.1593731478785;
        Thu, 02 Jul 2020 16:11:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id x9sm8214031ejw.28.2020.07.02.16.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:11:17 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 14/15] cleanup: move parsing helpers to parse.c
Date:   Fri,  3 Jul 2020 01:10:38 +0200
Message-Id: <20200702231039.55015-15-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
References: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lib.c contains 2-3 helpers fro parsing. Move these to parse.c.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c   | 38 --------------------------------------
 parse.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/lib.c b/lib.c
index fd1fe6cb3ba5..f512be2e1a43 100644
--- a/lib.c
+++ b/lib.c
@@ -50,44 +50,6 @@
 #include "bits.h"
 
 
-struct token *skip_to(struct token *token, int op)
-{
-	while (!match_op(token, op) && !eof_token(token))
-		token = token->next;
-	return token;
-}
-
-static struct token bad_token = { .pos.type = TOKEN_BAD };
-struct token *expect(struct token *token, int op, const char *where)
-{
-	if (!match_op(token, op)) {
-		if (token != &bad_token) {
-			bad_token.next = token;
-			sparse_error(token->pos, "Expected %s %s", show_special(op), where);
-			sparse_error(token->pos, "got %s", show_token(token));
-		}
-		if (op == ';')
-			return skip_to(token, op);
-		return &bad_token;
-	}
-	return token->next;
-}
-
-///
-// issue an error message on new parsing errors
-// @token: the current token
-// @errmsg: the error message
-// If the current token is from a previous error, an error message
-// has already been issued, so nothing more is done.
-// Otherwise, @errmsg is displayed followed by the current token.
-void unexpected(struct token *token, const char *errmsg)
-{
-	if (token == &bad_token)
-		return;
-	sparse_error(token->pos, "%s", errmsg);
-	sparse_error(token->pos, "got %s", show_token(token));
-}
-
 unsigned int hexval(unsigned int c)
 {
 	int retval = 256;
diff --git a/parse.c b/parse.c
index 70d8b237ce5e..cea208395090 100644
--- a/parse.c
+++ b/parse.c
@@ -655,6 +655,44 @@ void init_parser(int stream)
 }
 
 
+struct token *skip_to(struct token *token, int op)
+{
+	while (!match_op(token, op) && !eof_token(token))
+		token = token->next;
+	return token;
+}
+
+static struct token bad_token = { .pos.type = TOKEN_BAD };
+struct token *expect(struct token *token, int op, const char *where)
+{
+	if (!match_op(token, op)) {
+		if (token != &bad_token) {
+			bad_token.next = token;
+			sparse_error(token->pos, "Expected %s %s", show_special(op), where);
+			sparse_error(token->pos, "got %s", show_token(token));
+		}
+		if (op == ';')
+			return skip_to(token, op);
+		return &bad_token;
+	}
+	return token->next;
+}
+
+///
+// issue an error message on new parsing errors
+// @token: the current token
+// @errmsg: the error message
+// If the current token is from a previous error, an error message
+// has already been issued, so nothing more is done.
+// Otherwise, @errmsg is displayed followed by the current token.
+void unexpected(struct token *token, const char *errmsg)
+{
+	if (token == &bad_token)
+		return;
+	sparse_error(token->pos, "%s", errmsg);
+	sparse_error(token->pos, "got %s", show_token(token));
+}
+
 // Add a symbol to the list of function-local symbols
 static void fn_local_symbol(struct symbol *sym)
 {
-- 
2.27.0

