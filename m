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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2023C433FC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B118E20738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6WhusBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgGSXLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgGSXLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:30 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530C7C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:30 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 72so10827718otc.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YvqTkcYAAN78pjSZwwNFeimQiSa/Q3KK8WoooVV/y3U=;
        b=e6WhusBd6Ch7Qtj9IV1lz8mlCRxqljXa/TVPblWqQFh8lgjWLE9zydrspX+XboBc7y
         emIdWp4XcFaYNYwdJNZ7JAlYehwsgKojI24R43pUfWZDAWvMXCMU8UEMXjsbfUQ7RrmH
         tu+2rPPgQDZ0Y5DWKQFIfJTCM+XjaOyjTwIRLMPAZSMDaXQ/JFremy2OTog8lAg208Ph
         WQL1kdwA/pDglzVupPS293VRZceZ8Z6IVLSfViKb+XTOlslV+cTCYrgWbH7018djenTe
         D4mIMjFOJSC5m1ESRDYWdaanM7h7hD9s/RJS8tACqpKBfVKJRotoEkt52zVZjEeYvEiz
         3meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YvqTkcYAAN78pjSZwwNFeimQiSa/Q3KK8WoooVV/y3U=;
        b=PsiykRJ8fcHNGJ0G7l4Sl2q5dvxJrZMUfsRrk5jScFj6cxBiCR3WFj9tCsHVpZcNhQ
         AR3m/jaOT+xksQ01I9Wdtlm89YmSCMgvTk7SKpN5ZCuQtszVZ6arPagQFdeM0gmkWDYg
         JBYs+UNbaYhEWV+w6P5/rbTYbImHq39obmqLXLVQqiu1OGbdHrneiPg5CeDk779fp5Ti
         bFF7sWN77b+I8e9Z/TuFGkT0rxCL5JzimZlK4jH3Utgr+Xj8qu7vqZFPrQ41lb4/pDlu
         b7JS/MDuq9LhtcBLnpumknUjRQzZz3FKq0dCi01/H5cfjaj9JsAuUI8slcvVDiECGuBX
         FeVw==
X-Gm-Message-State: AOAM531JnIgNg4JIsJzMycJgb7RvJ+zYiCcyeekirk4iJ5jB9X8bSRY/
        3epm66Gan1W1JLhDyVswnMk=
X-Google-Smtp-Source: ABdhPJxlbnMT1xDphQOvYeQQVui+bnSNTP+7pdMYhywI74gwNZ2ztd5wLfIZjC7vKYm6SHcIvzJTNw==
X-Received: by 2002:a9d:7f06:: with SMTP id j6mr17250728otq.51.1595200289745;
        Sun, 19 Jul 2020 16:11:29 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 06/18] dyndbg: fix overcounting of ram used by dyndbg
Date:   Sun, 19 Jul 2020 17:10:46 -0600
Message-Id: <20200719231058.1586423-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

during dyndbg init, verbose logging prints its ram overhead.  It
counted strlens of struct _ddebug's 4 string members, in all callsite
entries, which would be approximately correct if each had been
mallocd.  But they are pointers into shared .rodata; for example, all
10 kobject callsites have identical filename, module values.

Its best not to count that memory at all, since we cannot know they
were linked in because of CONFIG_DYNAMIC_DEBUG=y, and we want to
report a number that reflects what ram is saved by deconfiguring it.

Also fix wording and size under-reporting of the __dyndbg section.

Heres my overhead, on a virtme-run VM on a fedora-31 laptop:

  dynamic_debug:dynamic_debug_init: 260 modules, 2479 entries \
    and 10400 bytes in ddebug tables, 138824 bytes in __dyndbg section

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 66c0bdf06ce7..9b2445507988 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1017,7 +1017,6 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 	int ret = 0;
 	int n = 0, entries = 0, modct = 0;
-	int verbose_bytes = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1033,9 +1032,6 @@ static int __init dynamic_debug_init(void)
 	iter_start = iter;
 	for (; iter < __stop___dyndbg; iter++) {
 		entries++;
-		verbose_bytes += strlen(iter->modname) + strlen(iter->function)
-			+ strlen(iter->filename) + strlen(iter->format);
-
 		if (strcmp(modname, iter->modname)) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
@@ -1052,9 +1048,9 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",
+	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
+		 (int)(entries * sizeof(struct _ddebug)));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.26.2

