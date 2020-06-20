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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B346C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CF52415C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMWXebqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgFTSId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:33 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:33379 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbgFTSI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:27 -0400
Received: by mail-oo1-f67.google.com with SMTP id v1so2555341ooh.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RZbyQxlPPlj+C7W88GsV5u7gIrqOuboIqILXGq1cy2Q=;
        b=tMWXebqAWjrdZLG79HY5DmkUXSwJNJ3bTvr/2vz2mEjIAbm/GZzuoG0LIVAXnWR7xq
         khS/7Lid18WkeVSpsMEIT5eeDbPlqdmXoNBG1isleqFYBACVmDjIFqJWnjbwuTtczJbK
         DFuC/NOjA0I8oiMsiL5d6Mv1bGegc8bgFcHws99k/wP/TyG1vs+mVSeIqm3A5AS/eF3F
         IrbucJuksXk8ly7peEtJAaPi62jjscixui+Hu/HCeO1atnE6MD4BlOjAbEQH5iWdurBi
         i/Xb3RMg/0ZKELch9PkHsSjGiVjvYdLnH/x2MOaw3RXCM5JB9lqLFhalumAxmrV4T5Nk
         mR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RZbyQxlPPlj+C7W88GsV5u7gIrqOuboIqILXGq1cy2Q=;
        b=b/epeKELtP5kQxIJzIRZgjqTpvVSI0i3dcpS+q3xGM0PLKbLiOo1zuAEKymnFF9C7Q
         4FZEQHOViGUEfvZQzT1xyEV6Tqe+Uo4QFPyZHH5Edlyh/5QXOEjt3ShPn6Od8jnCX1Hk
         kXXsLQtKwz/cPiZ1EmAfpPXv8XmsPlRV159aF6XARpPv2Fwgq+LlynycyREZ1VyO41+Z
         RUjBpL2sgRoGHSvoMx5jwCqe6g0mTbROra4jgMHXPbTNb0YqDljnggwr4QhfikwwDwHI
         CkZqO2iP2Mjw070O9NGTdsB0gayvwLPRBoeeWSvn/wgghUY7/Eup17cY3wzHHlzFCBF1
         H4xQ==
X-Gm-Message-State: AOAM532319XacT6TBUDaKjIzi27tzstBDnSgvjNYb5cEsnD5ZPWuoLQY
        MtI23iywABZjHiqfCkc3nno=
X-Google-Smtp-Source: ABdhPJwriTdACm85KeoPV/cP36XV2Rmp7EtTqHWTs3e/L+nR6mJQnPsBojze/11JRlSiFF4DdsfKAQ==
X-Received: by 2002:a05:6820:54c:: with SMTP id n12mr2357343ooj.73.1592676445842;
        Sat, 20 Jun 2020 11:07:25 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 17/17] dyndbg: combine flags & mask into a struct, simplify with it
Date:   Sat, 20 Jun 2020 12:06:43 -0600
Message-Id: <20200620180643.887546-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
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
 - ddebug_exec_query - declares query and flag-settings,
   		     calls other 2, passing flags
 - ddebug_parse_flags - fills flag_settings and returns
 - ddebug_change - test all callsites against query,
   		   modify passing sites.

benefits:
 - bit-banging always needs flags & mask, best together.
 - simpler function signatures
 - 1 less parameter, less stack overhead

no functional changes

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d737c733967a..c0bc78d67b36 100644
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
@@ -196,14 +201,14 @@ static int ddebug_change(const struct ddebug_query *query,
 
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
@@ -436,11 +441,9 @@ static int ddebug_parse_query(char *words[], int nwords,
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
@@ -457,7 +460,7 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
 			if (*str == opt_array[i].opt_char) {
-				flags |= opt_array[i].flag;
+				modifiers->flags |= opt_array[i].flag;
 				break;
 			}
 		}
@@ -466,30 +469,30 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
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
@@ -501,7 +504,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* check flags 1st (last arg) so query is pairs of spec,val */
-	if (ddebug_parse_flags(words[nwords-1], &flags, &mask)) {
+	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
 		pr_err("flags parse failed\n");
 		return -EINVAL;
 	}
@@ -510,7 +513,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, flags, mask);
+	nfound = ddebug_change(&query, &modifiers);
 	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
-- 
2.26.2

