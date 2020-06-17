Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4615BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220EB21534
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgXTbxLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgFQQ0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgFQQ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:28 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8E3C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:28 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a3so2300553oid.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpKisUIrNDP4b7Le3VGwmmpBHcbUC4mhjuxLi316v8I=;
        b=jgXTbxLw7ienGk2MzFo5c0wKoSn2H8CttyP3ZPskJYPeIeP1PPl70Le0PY4aN2EiEQ
         iEDGqQJiiSq/Xq/eoEM3TsIkuZkKpdCNIPwS5QjaI8UH5QrxB27IddmRnrYl+EJz4VrH
         d/vhhH7iR3tox52A37syuTUMeDqCSj0bodLOjh6OVketiv7/R6x+HIC5gRFZ6TN5xHO6
         RpPcoovEohIVWTMIWqnWmW5zGXiKX3TUuBZTlo/rK/eu/gkrnkJkcbDF9zFKkLPYgsJY
         4pvEhfCsG3BeO9nOzbqcLPRs7lzWb56nzn0jtAnBxZRHV8JH7u+LwWygbahWc11THy9R
         tf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OpKisUIrNDP4b7Le3VGwmmpBHcbUC4mhjuxLi316v8I=;
        b=s/vBBm+bhEAxHbRQW6dWx+0Fc1mrUzvcBuf1viaxDX8Cl6X7IrbI3wF3ygXGNAwowk
         VPqWiKL+NbEsBtw4pdJ49qBj1dmsV4G8BUZfMEC9aRi2EGad75pn86IYM8zud0Vj2yVT
         ZTHRjyuDYuHn36b7gzLZyZ+EP+MTnjsAAMW2s+9gk3oA4NZGbCxquOXCPJxfYcoWrh+5
         mFdFLXFhPdkqJk8fr6hbXiPCumD7Zkf2bvYdbgUoLdTbrAY5RzMrXDXckzQeGFPzSeDq
         DCdy9aVMD13s2d66cvpiQOOUryvv7eFhI1V1L3pCpedLa+4E3pvcAyXCNMESZ+Q+Vmja
         5b7Q==
X-Gm-Message-State: AOAM5300mHRrfC1lXq0GOmfdTI4C4t8FVCkjbykHhhJ8MX0tB8IDlPOz
        QbZNKzVl0vdQrpyYb29Zxiw=
X-Google-Smtp-Source: ABdhPJyktbEeQ4lzo1ybzJxvOPN38vMwOJif3TWdAdUj+7nvB113kmYKbE4fme5DITZSwsfIpFMTRg==
X-Received: by 2002:a05:6808:8ce:: with SMTP id k14mr5690052oij.141.1592411187727;
        Wed, 17 Jun 2020 09:26:27 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:27 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 16/21] dyndbg: combine flags & mask into a struct, simplify with it
Date:   Wed, 17 Jun 2020 10:25:31 -0600
Message-Id: <20200617162536.611386-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flags & mask are used together everywhere, and are passed around
together between multiple functions; they belong together in a struct,
call that struct flag_settings.

Use struct flag_settings to rework 3 functions:
 - ddebug_exec_query - calls other 2
 - ddebug_parse_flags - fills flag_settings and returns
 - ddebug_change - test all callsites against query,
   		   modify passing sites.

benefits:
 - bit-banging always needs flags & mask, best together.
 - simpler function signatures
 - 1 less parameter, less stack overhead
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ff97938b5849..22335f7dbac1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -62,6 +62,11 @@ struct ddebug_iter {
 	unsigned int idx;
 };
 
+struct flag_settings {
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
-			unsigned int flags, unsigned int mask)
+			 struct flag_settings *modifiers)
 {
 	int i;
 	struct ddebug_table *dt;
@@ -190,14 +195,14 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			nfound++;
 
-			newflags = (dp->flags & mask) | flags;
+			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
 			if (newflags == dp->flags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(flags & _DPRINTK_FLAGS_PRINT))
+				if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (flags & _DPRINTK_FLAGS_PRINT)
+			} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
@@ -431,11 +436,9 @@ static int ddebug_parse_query(char *words[], int nwords,
  * flags fields of matched _ddebug's.  Returns 0 on success
  * or <0 on error.
  */
-static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
-			       unsigned int *maskp)
+static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 {
-	unsigned flags = 0;
-	int op = '=', i;
+	int op, i;
 
 	switch (*str) {
 	case '+':
@@ -452,7 +455,7 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
 			if (*str == opt_array[i].opt_char) {
-				flags |= opt_array[i].flag;
+				modifiers->flags |= opt_array[i].flag;
 				break;
 			}
 		}
@@ -461,30 +464,30 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 			return -EINVAL;
 		}
 	}
-	vpr_info("flags=0x%x\n", flags);
+	vpr_info("flags=0x%x\n", modifiers->flags);
 
-	/* calculate final *flagsp, *maskp according to mask and op */
+	/* calculate final flags, mask based upon op */
 	switch (op) {
 	case '=':
-		*maskp = 0;
-		*flagsp = flags;
+		/* modifiers->flags already set */
+		modifiers->mask = 0;
 		break;
 	case '+':
-		*maskp = ~0U;
-		*flagsp = flags;
+		modifiers->mask = ~0U;
 		break;
 	case '-':
-		*maskp = ~flags;
-		*flagsp = 0;
+		modifiers->mask = ~modifiers->flags;
+		modifiers->flags = 0;
 		break;
 	}
-	vpr_info("*flagsp=0x%x *maskp=0x%x\n", *flagsp, *maskp);
+	vpr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+
 	return 0;
 }
 
 static int ddebug_exec_query(char *query_string, const char *modname)
 {
-	unsigned int flags = 0, mask = 0;
+	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
 #define MAXWORDS 9
 	int nwords, nfound;
@@ -496,7 +499,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* check flags 1st (last arg) so query is pairs of spec,val */
-	if (ddebug_parse_flags(words[nwords-1], &flags, &mask)) {
+	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
 		pr_err("flags parse failed\n");
 		return -EINVAL;
 	}
@@ -505,7 +508,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, flags, mask);
+	nfound = ddebug_change(&query, &modifiers);
 	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
-- 
2.26.2

