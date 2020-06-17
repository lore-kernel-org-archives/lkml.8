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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1864FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D5621556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMsK/ch1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgFQQ0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgFQQ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:32 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E405BC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:31 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k15so2090014otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMISypJy5HssmY7ZOHD++0rXBYTP+eiNwEA2VO5Y7fo=;
        b=DMsK/ch1ZVFLSVaVqEe8saDhSxQGphh7kCvpt4pHA7jr5VHD3USoHwSfkYqcyNvYEC
         JL24Rpx94JXU0ZL+H16UqKShCXvc5zljcp9S0N8b2U6ZYoBPd/JJ7LN91b9HiY8XZ/1A
         ZhVl8eyTrmXnP2FhVC2+JVxW54BfPDpK8UncRSs784yW+8R5H6N/dw0XAdUBKISw/f4X
         uQoiDksVLh5Bw+ui4mIMzgp2rYzytFqh+7gmfuJxzgp/pMhZFpKF5ijgGZMQ4ldzolKY
         hY1Mn9PA+4dR+ZMSxWZR7xi+65pwSWRtROCgBzZhG69XOhNuksywVyekuzrzJAId6Yeq
         vh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMISypJy5HssmY7ZOHD++0rXBYTP+eiNwEA2VO5Y7fo=;
        b=DrEWj098TLeUfotERYlBMetCVtEGNLoAe9scqC5Lna7yJNs7BRCpuuuqS2MY8DlYWR
         0rGWJij+tKYiTnLaD2aEmzqtUinUep0di3K0dR9mRSThwAhjVgfnbAiR3ncmaRR4MStQ
         Eqyjcqp2BRPHum5eKmOlYt3d40yWtvDdfDcFbyYwZezhes0yv/q92jGM8mt3iLlXn6wS
         zKaf3CIlb+X+40OpkTlvRrV4rr2x02t9XJ8pAeOFnC+RdvYaBrhueaUp+obTyMDCiI5y
         aednwYvh+z+ZohAu0zxT+4X1604g8D4cAfJDwm43PfTZ5COYe4QvfJM9uteiWLMg1suW
         UtbQ==
X-Gm-Message-State: AOAM530JpxNyoPppsPFu2+kvbrdL9NDFq41vpL1OOizmlLBq6vuah/gQ
        qoYNgNXAHbJNuI8u2X8aysjUTlQfxWA=
X-Google-Smtp-Source: ABdhPJx1FK6LDfNFTimwSOF+3L4oo/oOEwjS5v8+Bmm8IBqc6oaVuLC3QPSoqGPLNgnmhtxuKThyxQ==
X-Received: by 2002:a9d:d24:: with SMTP id 33mr7237069oti.26.1592411191292;
        Wed, 17 Jun 2020 09:26:31 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:30 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 18/21] dyndbg: add filter channel to the internals
Date:   Wed, 17 Jun 2020 10:25:33 -0600
Message-Id: <20200617162536.611386-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once again, adjust the interface between 3 static functions:

 - ddebug_exec_query calls ..
   - ddebug_parse_query - unchanged here, mentioned for context
   - ddebug_parse_flags, to read the modifying flags
   - ddebug_change, to apply mods to callsites that match the query

This time, add a 2nd flag_settings variable int ddebug_exec_query(),
to specify a secondary constraint on callsites which match the query,
and which are therefore about to be modified.

Here, we only add the channel; ddebug_parse_flags doesnt fill the
filter, and ddebug_change doesnt act upon it.

Also, ddebug_change doesn't alter any of its arguments, including its 2
new ones; mods, filter.  Say so by adding const modifier to them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8400e4f90b67..0fcc688789f4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -146,7 +146,8 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
  * logs the changes.  Takes ddebug_lock.
  */
 static int ddebug_change(const struct ddebug_query *query,
-			 struct flag_settings *modifiers)
+			 const struct flag_settings *modifiers,
+			 const struct flag_settings *filter)
 {
 	int i;
 	struct ddebug_table *dt;
@@ -456,7 +457,9 @@ static int ddebug_read_flags(const char *str, struct flag_settings *modifiers)
  * flags fields of matched _ddebug's.  Returns 0 on success
  * or <0 on error.
  */
-static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
+static int ddebug_parse_flags(const char *str,
+			      struct flag_settings *modifiers,
+			      struct flag_settings *filter)
 {
 	int op;
 
@@ -489,7 +492,8 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	vpr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	vpr_info("mods:flags=0x%x,mask=0x%x filter:flags=0x%x,mask=0x%x\n",
+		 modifiers->flags, modifiers->mask, filter->flags, filter->mask);
 
 	return 0;
 }
@@ -498,6 +502,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
+	struct flag_settings filter = {};
 #define MAXWORDS 9
 	int nwords, nfound;
 	char *words[MAXWORDS];
@@ -508,7 +513,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* check flags 1st (last arg) so query is pairs of spec,val */
-	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
+	if (ddebug_parse_flags(words[nwords-1], &modifiers, &filter)) {
 		pr_err("flags parse failed\n");
 		return -EINVAL;
 	}
@@ -517,7 +522,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &modifiers);
+	nfound = ddebug_change(&query, &modifiers, &filter);
 	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
-- 
2.26.2

