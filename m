Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C419C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 18:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666BA2071A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 18:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFIQTNYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgFNSP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgFNSP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 14:15:27 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19CFC05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 11:15:26 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c12so13650991qkk.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 11:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=I/OxNFBNI4Z0/4pbK+Rclrhkip1ykrGdgqyLL3oDo3g=;
        b=QFIQTNYQbYKGKFgSTGTt3NMd0JlIjvHA/7qautJQsZnXsWryTU7lXcIQGAme1PTJXH
         4ECYhxzqoeKJQ2BFKEi57iI+pEMiwUKZHsv1AU7TWd5j7g03V32OMKLa0POmV27r7Nns
         gIstIhwvXqAFNNnCWWehhe8GdcRqRyGLRZh4vksXNHu2jJKpSZ4vnDJ4oc6L/O5lIehx
         ZlbDFCQMPgxDallkE58IjFlAyet7zPO89nKcWYDlsue3VoCkKcT2LyzNuegRRzDczc4T
         LdqKkBxUivZnBpFNsyo/PxSFeDRt44KpKrp961x6SpDP9CfKqs+eMJUtoe8H3L+N8NLR
         parw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=I/OxNFBNI4Z0/4pbK+Rclrhkip1ykrGdgqyLL3oDo3g=;
        b=i9oq3VO27zi1Fu9qAkeB9F1qWUAW81y7gHtA3P3HH5fA+E3MGV3JDOrdCBM/aCv5dL
         bx6n3RFaOxRWDhg5BXUcjW1B4kSubcsLRbS40Gw8zT5xrJ2oo6HbccU1eEoXC5OrWD3k
         0gnnV+SOIUKDQr+uT4o/PbilwdDZzYr7TdvY330syuds6yVhzixBTefhVm2mgeYyZOur
         E2nE505AN4SV9Uva7Mp1mZadHKKEKkR0kzpTGSYmB7bwMYNLtKBWYJVqHr6s4CICGsvs
         WVqKEXYY54ugRE9XCrc8YwNo4pkcZVndYSwXus/AXbO/MPlIhyxYaA+FhtENpl+c9qqp
         wGvA==
X-Gm-Message-State: AOAM531eRqS8WU1UbG+PjdxKNu0zZpKPysW2Hox5pN0ccYktPep4Ug4C
        vipTWgbgPd5ICyCNub7yxhjKrgsOsej2CQ==
X-Google-Smtp-Source: ABdhPJwjhS+2wt5RRczPmJRYe2+BCO3E9RmkmR8iOv/r0PS94FiMwmWvOgR63rzkA6oNWrr27OnD5w==
X-Received: by 2002:a37:ecc:: with SMTP id 195mr11285440qko.469.1592158525987;
        Sun, 14 Jun 2020 11:15:25 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:b556:165b:f409:9052])
        by smtp.googlemail.com with ESMTPSA id c2sm9044733qkl.58.2020.06.14.11.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 11:15:25 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] [traceevent] add_new_comm(): Fix memory leak
Date:   Sun, 14 Jun 2020 14:14:53 -0400
Message-Id: <20200614181517.30187-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer cmdlines need to be explicity freed in case the
realloc() fails. Fix it by adding a free() if realloc()
returns a NULL pointer.

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 tools/lib/traceevent/event-parse.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index e1bd2a93c6db..7f0133420931 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -284,12 +284,13 @@ static int add_new_comm(struct tep_handle *tep,
 		return 0;
 	}
 
-	cmdlines = realloc(cmdlines, sizeof(*cmdlines) * (tep->cmdline_count + 1));
-	if (!cmdlines) {
+	struct tep_cmdline *new_cmdlines = realloc(cmdlines, sizeof(*cmdlines) * (tep->cmdline_count + 1));
+	if (!new_cmdlines) {
+		free(cmdlines);
 		errno = ENOMEM;
 		return -1;
 	}
-	tep->cmdlines = cmdlines;
+	tep->cmdlines = new_cmdlines;
 
 	key.comm = strdup(comm);
 	if (!key.comm) {
-- 
2.17.1

