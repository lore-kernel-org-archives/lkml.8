Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F0DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6788420789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM/jBwRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgFMP63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgFMP6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:17 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF634C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:16 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g5so9763243otg.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pb0hYDbseIYTJoZnZgDtyPYNtoDJhNYiuYLBezVk0+U=;
        b=RM/jBwRf8Bg7HRJfBIqpBvZHS1fOs87oIiDbw5dXNL/4nkM9q1MS3hmcJL5CpBNPUh
         dfjZvSxFJiE13OGTrqVbyPJU6+dAh4gC2x5U+r88aVG/uP/1yntfS0MdTSKq0gdpaVVe
         Okj7mG7hl48CimVUrn5cc/gCJ+4GR/TUAkNl8GkD6ZDx5wdjxrG8tPxYP0YoP6ZNN+fH
         Sacrubo/HxI5S1BnobXTvUS4hn8kBiYg93FfVwSR1lvvOvk24m+Jqj7Pe6Zm1EPtwCY9
         w3CYfgvwR/qg03yp9gNwKOirLnPPIBdKEIuXKvhKmL7PkOyPDJFq9tZAySEcVgmvhiCI
         H2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pb0hYDbseIYTJoZnZgDtyPYNtoDJhNYiuYLBezVk0+U=;
        b=cjNaiBc7g3HZW9Dug0x5jkE4yb/ajfN9mQmf1QifSxlxpWe1sm1oFRnwwnCMFg0PbS
         TbayRl23WIPK0xrw8e6n/eNa8KXrDZERx8ogA+fO0OHoG1yIxYIIgSoD8qR5W882uMTq
         vPTS8z3X5aD6I/8pYkgIcRlfBc7FBgMIHE6fhyk/1d5sMJq+MAkUaePOgw9CVQNscw69
         cnGEWAMPQFjVdoG/URhHrfjoMA7N8JDkuj1T0lmE5N4gBzI6QUdkUKi3gSccU4MKTzvu
         x5B21Dub8OW/pcNO4UxMY6fvJKcEx6OGxPbwJ+T/gWaAxLvH7pz4H3RrhFmWOYLGLeB7
         qx1A==
X-Gm-Message-State: AOAM5300/iloGaehx7mGDBQ0GGtA7sblN9zPtoXSInQ6MHv5DZpOzgF2
        c43rYRo81PIYccCHWC30awc=
X-Google-Smtp-Source: ABdhPJwTzoLoQATNw2Fr3/0rX3DTwI+2Jyo5+04C69djI1qXf5QxrzdA/ss533z5P1ETRlRTIqSZbw==
X-Received: by 2002:a9d:631a:: with SMTP id q26mr15019315otk.220.1592063896291;
        Sat, 13 Jun 2020 08:58:16 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:15 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 13/24] dyndbg: combine flags & mask into a struct, use that
Date:   Sat, 13 Jun 2020 09:57:27 -0600
Message-Id: <20200613155738.2249399-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
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
---
 lib/dynamic_debug.c | 46 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 93c627e9c094..8dc073a6e8a4 100644
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
@@ -142,7 +147,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
  * logs the changes.  Takes ddebug_lock.
  */
 static int ddebug_change(const struct ddebug_query *query,
-			unsigned int pflags, unsigned int mask)
+			 struct flagsettings *mods)
 {
 	int i;
 	struct ddebug_table *dt;
@@ -191,14 +196,14 @@ static int ddebug_change(const struct ddebug_query *query,
 
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
@@ -414,14 +419,14 @@ static int ddebug_parse_query(char *words[], int nwords,
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
@@ -430,7 +435,7 @@ static int ddebug_read_flags(const char *str, unsigned int *flags)
 			return -EINVAL;
 		}
 	}
-	vpr_info("flags=0x%x\n", *flags);
+	vpr_info("flags=0x%x mask=0x%x\n", f->flags, f->mask);
 	return 0;
 }
 
@@ -440,10 +445,8 @@ static int ddebug_read_flags(const char *str, unsigned int *flags)
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
@@ -458,31 +461,30 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
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
@@ -494,7 +496,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* check flags 1st (last arg) so query is pairs of spec,val */
-	if (ddebug_parse_flags(words[nwords-1], &flags, &mask)) {
+	if (ddebug_parse_flags(words[nwords-1], &mods)) {
 		pr_err("flags parse failed\n");
 		return -EINVAL;
 	}
@@ -503,7 +505,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, flags, mask);
+	nfound = ddebug_change(&query, &mods);
 	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
-- 
2.26.2

