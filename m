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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43D8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E9F208B8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkrF+vaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGBXL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgGBXLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:14 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561F3C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:11:14 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so24565958edy.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHCTMmbjnxLnBVTnwczuP/hIItaJS+A9i2ZXuCEHkYs=;
        b=jkrF+vawtQkDtMYq+PHc5/+8EtghPoxY+NzFDSdKTw6VzTd3xeTEnGmI3r+pKnS1MO
         bycVqbHQgdQE6F9H61UQJSD/zp9FqBjMUcsjBtD9NwQ9OY9NDEJcZPVM7PZ11dqcTbpx
         lftfYOCRfdxVSrj5LU4xLGpk/ioO8A1t6MwaJgVfA0ujOpSq2WLHwX0afJ2BlyXG6DcV
         WitIXN0Ma7A3seNwnBXDKeCT50j5vMcXcHcosO1pgvB+PIuQJ6rJdFfEFteM58thBWUC
         SiVzFhhgdBFZZr9D7t42XpjQY8eKwkME0X7dQknvs12XaVzYCizQU+7iOdtOiDePoQuj
         dO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHCTMmbjnxLnBVTnwczuP/hIItaJS+A9i2ZXuCEHkYs=;
        b=gaiZ8Vyuf08Lcwd1WBmUk3hRtMaPDM8EoRzJShsPhhhQX10JFUnah0K6Kad/TH226b
         DB+bC3BJUjQsBoFO/ADUBGHGfCQ+7aeyxvPR0lqYXtoiL8KeocdwkFb6mdyEeJrzAQnF
         6j7ABXJLTmjd6SxkhwkCy5oFjU4O5oHTg9ZjqzfFtn03DeiU6QfvyJRKuTvSW7HLRV/2
         aUE6C+Ly4e74RgmZWgazRYqQSCliI1RZgW1nfu21fcyfMqwt+PLct+zBHXGYwwJWKJPD
         ePhPFimbIKjKg2oylhyLuvg38bx+IeAfmeItwPBaj5PmTStTBXQIAYb2W04l/nWs3ZnT
         bVcA==
X-Gm-Message-State: AOAM532DieQeewl3IfX6wsy+1ATiXt17C4NKnZ3aJUmPrFL2FtvpWz80
        sW/OqkqN6Uzobeu8dpJmBstZzSWB
X-Google-Smtp-Source: ABdhPJz0hK+lxbP4CVlVgJFElP6toDtLAsp0lVAE7n6Rch24fGUi/roA0vp5/FNK+laJ5TAZw0yVsg==
X-Received: by 2002:aa7:c883:: with SMTP id p3mr38425083eds.128.1593731472826;
        Thu, 02 Jul 2020 16:11:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id x9sm8214031ejw.28.2020.07.02.16.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:11:12 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/15] options: avoid spaces between function name and arguments list
Date:   Fri,  3 Jul 2020 01:10:32 +0200
Message-Id: <20200702231039.55015-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
References: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a stylistic detail but a lot of the strcmp() calls used for
the processing of the options are written 'strcmp (...)'. Two
other functions calls are also in the case.

Reformat them to the usual style for function calls: without
the space between the function name and the arguments.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib.c b/lib.c
index 5f4e6b2d76c8..b3bacb180cac 100644
--- a/lib.c
+++ b/lib.c
@@ -570,7 +570,7 @@ OPT_NUMERIC(uint, unsigned int, strtoul)
 
 static char **handle_switch_a(char *arg, char **next)
 {
-	if (!strcmp (arg, "ansi"))
+	if (!strcmp(arg, "ansi"))
 		standard = STANDARD_C89;
 
 	return next;
@@ -759,7 +759,7 @@ static char **handle_switch_f(char *arg, char **next)
 
 static char **handle_switch_G(char *arg, char **next)
 {
-	if (!strcmp (arg, "G") && *next)
+	if (!strcmp(arg, "G") && *next)
 		return next + 1; // "-G 0"
 	else
 		return next;     // "-G0" or (bogus) terminal "-G"
@@ -775,7 +775,7 @@ static char **handle_base_dir(char *arg, char **next)
 
 static char **handle_switch_g(char *arg, char **next)
 {
-	if (!strcmp (arg, "gcc-base-dir"))
+	if (!strcmp(arg, "gcc-base-dir"))
 		return handle_base_dir(arg, next);
 
 	return next;
@@ -907,7 +907,7 @@ static char **handle_nostdinc(char *arg, char **next)
 
 static char **handle_switch_n(char *arg, char **next)
 {
-	if (!strcmp (arg, "nostdinc"))
+	if (!strcmp(arg, "nostdinc"))
 		return handle_nostdinc(arg, next);
 
 	return next;
@@ -925,7 +925,7 @@ static char **handle_switch_O(char *arg, char **next)
 
 static char **handle_switch_o(char *arg, char **next)
 {
-	if (!strcmp (arg, "o")) {       // "-o foo"
+	if (!strcmp(arg, "o")) {	// "-o foo"
 		if (!*++next)
 			die("argument to '-o' is missing");
 		outfile = *next;
@@ -949,23 +949,23 @@ static char **handle_switch_p(char *arg, char **next)
 static char **handle_switch_s(const char *arg, char **next)
 {
 	if ((arg = match_option(arg, "std="))) {
-		if (!strcmp (arg, "c89") ||
-		    !strcmp (arg, "iso9899:1990"))
+		if (!strcmp(arg, "c89") ||
+		    !strcmp(arg, "iso9899:1990"))
 			standard = STANDARD_C89;
 
-		else if (!strcmp (arg, "iso9899:199409"))
+		else if (!strcmp(arg, "iso9899:199409"))
 			standard = STANDARD_C94;
 
-		else if (!strcmp (arg, "c99") ||
-			 !strcmp (arg, "c9x") ||
-			 !strcmp (arg, "iso9899:1999") ||
-			 !strcmp (arg, "iso9899:199x"))
+		else if (!strcmp(arg, "c99") ||
+			 !strcmp(arg, "c9x") ||
+			 !strcmp(arg, "iso9899:1999") ||
+			 !strcmp(arg, "iso9899:199x"))
 			standard = STANDARD_C99;
 
-		else if (!strcmp (arg, "gnu89"))
+		else if (!strcmp(arg, "gnu89"))
 			standard = STANDARD_GNU89;
 
-		else if (!strcmp (arg, "gnu99") || !strcmp (arg, "gnu9x"))
+		else if (!strcmp(arg, "gnu99") || !strcmp(arg, "gnu9x"))
 			standard = STANDARD_GNU99;
 
 		else if (!strcmp(arg, "c11") ||
@@ -986,7 +986,7 @@ static char **handle_switch_s(const char *arg, char **next)
 			standard = STANDARD_GNU17;
 
 		else
-			die ("Unsupported C dialect");
+			die("Unsupported C dialect");
 	}
 
 	return next;
@@ -995,7 +995,7 @@ static char **handle_switch_s(const char *arg, char **next)
 static char **handle_switch_U(char *arg, char **next)
 {
 	const char *name = arg + 1;
-	add_pre_buffer ("#undef %s\n", name);
+	add_pre_buffer("#undef %s\n", name);
 	return next;
 }
 
@@ -1516,7 +1516,7 @@ static struct symbol_list *sparse_file(const char *filename)
 	int fd;
 	struct token *token;
 
-	if (strcmp (filename, "-") == 0) {
+	if (strcmp(filename, "-") == 0) {
 		fd = 0;
 	} else {
 		fd = open(filename, O_RDONLY);
-- 
2.27.0

