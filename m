Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DIET_1,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606E8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4092B2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWyWAQSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgHGUKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGUKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:10:16 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D968C061A27
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 13:10:16 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id h3so2997220oie.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a3UDDzhIvH1/+i0FRX7y0haqHObyC/cYDe6aFvS0mIE=;
        b=pWyWAQSEcaR5o2q23Lhj1hu5lev1ZwJsUOkJXSUGisvh8psV3p4AGEAQlE40xUXjuQ
         1QL7C4CD6k+gRx4jbCTmYkttkqB89JCrocEDvyf1Y4B0MWbxzYXVdVppKAWIok+HhKoy
         uLhpuJSBMLTZ4Nl6z1OWsv9o7KsC7kaXsm85M82sIHP+p9Q6c+rgiS3DgApVZc08OHTO
         xgACYE4y1O2FH9e1qhQT95wZ1piqaAPn6k6AobOWCH/4EpHqFhKmONrJM5cp2qGnsyMH
         jluNNox6zn9wIW72y1C67kc3KiC+EG+4FsF38dtDaPnJAWkkIGIeORHFhEzduoOM/7MP
         S2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3UDDzhIvH1/+i0FRX7y0haqHObyC/cYDe6aFvS0mIE=;
        b=O54zjnvsaLO7p+Jy/X3tEtx0ne8i21J/lD+6kyCvwj5tY1gndgR89KnUkc2IIhQBHb
         VkZf0+l/gsL77HKsPCTONv7wwKL1dis6Mn9Tr5BR9klwxg3p1AEOHjxpuJy44CMi0Ktp
         UsSkihO8FOfjaTqpJt2hqvyN8w5nMyjim4hBh3aQtD82qOQgkWttab4MaTBmg4Wwq3fB
         SldUeIuWYtFQsZv/G0Y7kvd6sj16w49hIZAwD/U0W/e8fg3QZ+Gicu6+UqQKkyDiQyl4
         zL7M21cjuvhSf34EwNJI2RxOVpOBefopQ7E7zGVzPCrWH7o/HqY6ZFTyBUaEmEP7x23a
         QnLg==
X-Gm-Message-State: AOAM5326oMPHxBqMfd28MyO+5qhVsCRk825TR8837ge20C8JaLJbY3My
        Yt49IibE4EnnIq707pn6+jVbqPstAyM=
X-Google-Smtp-Source: ABdhPJyYp3S8ZK9pimNGa3qu49dKYz8bRXMdIpcthP4MVM49ILkpPPii1y+VD7YRmE3LplUtwrnw0A==
X-Received: by 2002:aca:1b03:: with SMTP id b3mr12735675oib.26.1596831015848;
        Fri, 07 Aug 2020 13:10:15 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::af38])
        by smtp.googlemail.com with ESMTPSA id s6sm1835794otq.75.2020.08.07.13.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:10:14 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/7] dyndbg: motivate a diet plan
Date:   Fri,  7 Aug 2020 14:09:49 -0600
Message-Id: <20200807200957.1269454-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807200957.1269454-1-jim.cromie@gmail.com>
References: <20200807200957.1269454-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this throwaway patch demonstrates the extra weight:

 dyndbg: 2605 entries. repeated entries: 2369 module 2231 file 1147 func

Thats (91%, 86%, 44%) repeated values in those pointers/columns.

This simple test also shows that a similarly simple run-length encoder
on those 3 columns would compress this table dramatically.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 01b7d0210412..691e79826fc2 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1059,11 +1059,12 @@ static int __init dynamic_debug_init_control(void)
 
 static int __init dynamic_debug_init(void)
 {
-	struct _ddebug *iter, *iter_start;
+	struct _ddebug *iter, *iter_start, *prev = 0;
 	const char *modname = NULL;
 	char *cmdline;
 	int ret = 0;
 	int n = 0, entries = 0, modct = 0;
+	int modreps = 0, funcreps = 0, filereps = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1077,7 +1078,16 @@ static int __init dynamic_debug_init(void)
 	iter = __start___dyndbg;
 	modname = iter->modname;
 	iter_start = iter;
-	for (; iter < __stop___dyndbg; iter++) {
+	for (prev = iter; iter < __stop___dyndbg; iter++) {
+		if (entries) {
+			if (prev->site->modname == iter->site->modname)
+				modreps++;
+			if (prev->site->function == iter->site->function)
+				funcreps++;
+			if (prev->site->filename == iter->site->filename)
+				filereps++;
+			prev++; /* one behind iter */
+		}
 		entries++;
 		if (strcmp(modname, iter->modname)) {
 			modct++;
@@ -1099,6 +1109,9 @@ static int __init dynamic_debug_init(void)
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
 		 (int)(entries * sizeof(struct _ddebug)));
 
+	vpr_info("%d entries. repeated entries: %d module %d file %d func\n",
+		 entries, modreps, filereps, funcreps);
+
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
 		pr_warn("ddebug_query param name is deprecated, change it to dyndbg\n");
-- 
2.26.2

