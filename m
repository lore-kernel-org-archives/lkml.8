Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADC1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F4924125
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cml31sO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgFTSI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45935 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgFTSIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id m2so9823305otr.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GmKiR2gu/wiGa6gUvyZ+gseeA9528zgy4FBcqF+x5zM=;
        b=Cml31sO2iTQweHSZ0kWit25Wa2OGvwQU4JxGikW+aiQHQVicGINv9GWHRvlPcRkY5Q
         VDCbE/mYOQWqOTfkb4qO/nbuc+6wxMbNBFid60zaKfTaWdO1uUeOw4rPt/6H8lw1+ouo
         6rjgHCIas4X8jPMi+oyqXA1GhQ7cckPGgvJzBMPkagyRiS2BLrs/4NoJ/ydxgkGPGQyU
         93BqM0P/tyavNED1AzVzZNkSvk/aBKtirmbNDtHeTYFktb5VQryk5yVU+v0n0c0Pbg2o
         uO0IDBaupBeFtlvlvcpOgFKk/shBUc551w1aqI6K4tGw+ts8nPneuci0mIXQ9jdM4hzF
         kCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GmKiR2gu/wiGa6gUvyZ+gseeA9528zgy4FBcqF+x5zM=;
        b=A1CEtUPVdA8RSXX9HU+9R0K1vCE03qKx4RW8DJGluBGZnUEpoiJUR+svu0DMF/O+AX
         OeRUAd1VB0UtuONTF8V56Y9EabkbkWAgbkXb0poN44pWiScWvr6JTjFcS5Xu7z+Wxl+K
         vZv9b2/8rY6zUCNmEXOYgZnkkRTO6A5fb4DDCbOR3YffFDp4EIRP7fAvH03qN9+YJL5s
         iPbYremi2j+fFjgO89McaDNiTjDJ02jGgVDtOnpiHyYjSnNCoqK5r3d9JBqBwTtR9PCx
         MYH5c1/9XCUnxknJ1f7G4eFRMDT/wTLDELMU0coKvY2L7sA5Atte5PUGZTP8qtTG8xG9
         j59w==
X-Gm-Message-State: AOAM532QvUQ3YhhVtCX2r/w6LPNzs2ypXkaGyX9chRR6H0SmsEzEDpoW
        5U5OypzV5e/XcK/Nm8titjKP16iz
X-Google-Smtp-Source: ABdhPJxUTsgNoAaq1ANGr+sc1dqnW7jo0b0JYc6Lr+p58ebLdZBGJOJTKRtCOH4cPyPT9FQ7y1zhuQ==
X-Received: by 2002:a9d:170c:: with SMTP id i12mr8147518ota.321.1592676436024;
        Sat, 20 Jun 2020 11:07:16 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:15 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 12/17] dyndbg: refactor parse_linerange out of ddebug_parse_query
Date:   Sat, 20 Jun 2020 12:06:38 -0600
Message-Id: <20200620180643.887546-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code-block reusable to later handle "file foo.c:101-200" etc.
This is a 99% code move, with reindent, function wrap & call, etc.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 61 +++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6d0159075308..ae6e523fdecd 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -291,6 +291,39 @@ static inline int parse_lineno(const char *str, unsigned int *val)
 	return 0;
 }
 
+static int parse_linerange(struct ddebug_query *query, const char *first)
+{
+	char *last = strchr(first, '-');
+
+	if (query->first_lineno || query->last_lineno) {
+		pr_err("match-spec: line used 2x\n");
+		return -EINVAL;
+	}
+	if (last)
+		*last++ = '\0';
+	if (parse_lineno(first, &query->first_lineno) < 0)
+		return -EINVAL;
+	if (last) {
+		/* range <first>-<last> */
+		if (parse_lineno(last, &query->last_lineno) < 0)
+			return -EINVAL;
+
+		/* special case for last lineno not specified */
+		if (query->last_lineno == 0)
+			query->last_lineno = UINT_MAX;
+
+		if (query->last_lineno < query->first_lineno) {
+			pr_err("last-line:%d < 1st-line:%d\n",
+			       query->last_lineno,
+			       query->first_lineno);
+			return -EINVAL;
+		}
+	} else {
+		query->last_lineno = query->first_lineno;
+	}
+	return 0;
+}
+
 static int check_set(const char **dest, char *src, char *name)
 {
 	int rc = 0;
@@ -348,34 +381,8 @@ static int ddebug_parse_query(char *words[], int nwords,
 							    UNESCAPE_SPECIAL);
 			rc = check_set(&query->format, words[i+1], "format");
 		} else if (!strcmp(words[i], "line")) {
-			char *first = words[i+1];
-			char *last = strchr(first, '-');
-			if (query->first_lineno || query->last_lineno) {
-				pr_err("match-spec: line used 2x\n");
-				return -EINVAL;
-			}
-			if (last)
-				*last++ = '\0';
-			if (parse_lineno(first, &query->first_lineno) < 0)
+			if (parse_linerange(query, words[i+1]))
 				return -EINVAL;
-			if (last) {
-				/* range <first>-<last> */
-				if (parse_lineno(last, &query->last_lineno) < 0)
-					return -EINVAL;
-
-				/* special case for last lineno not specified */
-				if (query->last_lineno == 0)
-					query->last_lineno = UINT_MAX;
-
-				if (query->last_lineno < query->first_lineno) {
-					pr_err("last-line:%d < 1st-line:%d\n",
-						query->last_lineno,
-						query->first_lineno);
-					return -EINVAL;
-				}
-			} else {
-				query->last_lineno = query->first_lineno;
-			}
 		} else {
 			pr_err("unknown keyword \"%s\"\n", words[i]);
 			return -EINVAL;
-- 
2.26.2

