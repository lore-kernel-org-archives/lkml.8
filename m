Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8ACC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6166207D8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFi3luT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgFEQ21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgFEQ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:27:56 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DC9C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:27:56 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id u23so8049680otq.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVn2ZJqvpzUH29M3RomJkg8mujEdnSQL3JazyfpNjV4=;
        b=KFi3luT4gKqZVo4io4NXZKfvbVrdDmtD/Rk9CTMxRvg8IVBYgB/sC81htsJE5WNhed
         8leqy3In6at29qGCyfbBFsDDYU7c9skwCo7+i3s1cXrga44B4FnVxFdpFibv41iOmkob
         SQ4nliLo1/wy72PnOI4YBpTM2iHaiAIWX5q0JHh1XL5RWJrYb8O9vCR4xpMG8+F9xp2M
         pA8MU9ip8VGT1LGvjK7DV1ZNKC0TK9v2N0BGb20g7vz8UbuIb2tarM+QAOxbaSqEAU9i
         PQDtq8ghs6b5uzvn0tw442BO6CxkBd5H4lIUsV4wixjSJoruhwh4+7vm0A3yB6cvTrk5
         +llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVn2ZJqvpzUH29M3RomJkg8mujEdnSQL3JazyfpNjV4=;
        b=jdMSmwushTol/0LBbE0YhoD0E/CZAVwBU3OLzPi6Dts3zRL/yc2RUEcuBMNyefhfqB
         8ypnljqQ9oa7gVilD+icQTvlfac+ebdYQSU3V2LLi2X3gKMf7zQfyyEj5a5P+3PV9Mhj
         u23QK4MBdK08q3z48wMCuKwQShHpVAS4T89Z/T2W+ZApELZ8mtppRrbI+QECLbz9kl/F
         0E3wwa+BvLWM3dTx454pWbDa3WiejpyKgKQu0DpQz0CINCzhm34mYd89aapGdTr/sD16
         nRTDyFn0qUD9amEmaJXlZrg932vqzfCsRqIjiEGA5YnVFuLi4z0Dpir9E9vP/7yQkHDO
         MlaA==
X-Gm-Message-State: AOAM530pYfgAkIYieMCzvzaBgHoZYutzDB9C6DLpaWWwAPMvbn/YIfNq
        u+2OPjSZQN/AxR5WRAU9wEQ=
X-Google-Smtp-Source: ABdhPJy4F1yYfLUug72euVz1fLnYxqa7LaO++CoHvpAS91WDrdESEAVQ6UYjkP4yehzf35IWESPIOA==
X-Received: by 2002:a05:6830:13d3:: with SMTP id e19mr2311030otq.290.1591374476039;
        Fri, 05 Jun 2020 09:27:56 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:27:55 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 11/16] dyndbg: combine flags & mask into a struct, use that
Date:   Fri,  5 Jun 2020 10:26:40 -0600
Message-Id: <20200605162645.289174-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

combine flags & mask into a struct, and replace those 2 parameters in
3 functions: ddebug_change, ddebug_parse_flags, ddebug_read_flags,
altering the derefs in them accordingly.

This simplifies the 3 function sigs, preparing for more changes.
We dont yet need mask from ddebug_read_flags, but will soon.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 46 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 005b8221a9d6..2ecabfd3f432 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -62,6 +62,11 @@ struct ddebug_iter {
 	unsigned int idx;
 };
 
+struct flagsettings {
+	unsigned int flags;
+	unsigned int mask;
+};
+
 static DEFINE_MUTEX(ddebug_lock);
 static LIST_HEAD(ddebug_tables);
 static int verbose;
@@ -141,7 +146,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
  * logs the changes.  Takes ddebug_lock.
  */
 static int ddebug_change(const struct ddebug_query *query,
-			unsigned int pflags, unsigned int mask)
+			 struct flagsettings *mods)
 {
 	int i;
 	struct ddebug_table *dt;
@@ -190,14 +195,14 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			nfound++;
 
-			newflags = (dp->flags & mask) | pflags;
+			newflags = (dp->flags & mods->mask) | mods->flags;
 			if (newflags == dp->flags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(pflags & _DPRINTK_FLAGS_PRINT))
+				if (!(mods->flags & _DPRINTK_FLAGS_PRINT))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (pflags & _DPRINTK_FLAGS_PRINT)
+			} else if (mods->flags & _DPRINTK_FLAGS_PRINT)
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
@@ -413,14 +418,14 @@ static int ddebug_parse_query(char *words[], int nwords,
 	return 0;
 }
 
-static int ddebug_read_flags(const char *str, unsigned int *flags)
+static int ddebug_read_flags(const char *str, struct flagsettings *f)
 {
 	int i;
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
 			if (*str == opt_array[i].opt_char) {
-				*flags |= opt_array[i].flag;
+				f->flags |= opt_array[i].flag;
 				break;
 			}
 		}
@@ -429,7 +434,7 @@ static int ddebug_read_flags(const char *str, unsigned int *flags)
 			return -EINVAL;
 		}
 	}
-	vpr_info("flags=0x%x\n", *flags);
+	vpr_info("flags=0x%x mask=0x%x\n", f->flags, f->mask);
 	return 0;
 }
 
@@ -439,10 +444,8 @@ static int ddebug_read_flags(const char *str, unsigned int *flags)
  * flags fields of matched _ddebug's.  Returns 0 on success
  * or <0 on error.
  */
-static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
-			       unsigned int *maskp)
+static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
 {
-	unsigned flags = 0;
 	int op;
 
 	switch (*str) {
@@ -457,31 +460,30 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 	}
 	vpr_info("op='%c'\n", op);
 
-	if (ddebug_read_flags(str, &flags))
+	if (ddebug_read_flags(str, mods))
 		return -EINVAL;
 
-	/* calculate final *flagsp, *maskp according to mask and op */
+	/* calculate final flags, mask based upon op */
 	switch (op) {
 	case '=':
-		*maskp = 0;
-		*flagsp = flags;
+		mods->mask = 0;
 		break;
 	case '+':
-		*maskp = ~0U;
-		*flagsp = flags;
+		mods->mask = ~0U;
 		break;
 	case '-':
-		*maskp = ~flags;
-		*flagsp = 0;
+		mods->mask = ~mods->flags;
+		mods->flags = 0;
 		break;
 	}
-	vpr_info("*flagsp=0x%x *maskp=0x%x\n", *flagsp, *maskp);
+	vpr_info("*flagsp=0x%x *maskp=0x%x\n", mods->flags, mods->mask);
+
 	return 0;
 }
 
 static int ddebug_exec_query(char *query_string, const char *modname)
 {
-	unsigned int flags = 0, mask = 0;
+	struct flagsettings mods = {};
 	struct ddebug_query query;
 #define MAXWORDS 9
 	int nwords, nfound;
@@ -493,7 +495,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* check flags 1st (last arg) so query is pairs of spec,val */
-	if (ddebug_parse_flags(words[nwords-1], &flags, &mask)) {
+	if (ddebug_parse_flags(words[nwords-1], &mods)) {
 		pr_err("flags parse failed\n");
 		return -EINVAL;
 	}
@@ -502,7 +504,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, flags, mask);
+	nfound = ddebug_change(&query, &mods);
 	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
-- 
2.26.2

