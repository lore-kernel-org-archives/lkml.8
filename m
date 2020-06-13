Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487A5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2556C20789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5X5yT12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgFMP6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgFMP6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:10 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDE0C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:08 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v13so9756967otp.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGK4Co7NDboyjza4qRh2rluizajI/4ObcvQZ/gCqlA4=;
        b=l5X5yT12ssNv2xKvw8g3JqKWwmPysYm7vAtMWsJG4UumwH8R2g1fappn53oAHdz95e
         R8iGsuiaXz3tnAVMHM3ntaifzEaOyEYtWF70MAW8wj3X3eC1Zj2DFbHfq+TOT9slN7iO
         mJd1wZpl4xS7jSeGVi7LI0T/Cw0GkPUtuaYSx53dpEspilUiUiGYob6UiKHucKs+rzIS
         9m6PPgkHfck1eijWsK+1qiMB0n6ADOkh2FIz77w7CJnVJx8z70dl4Tu9sATuTvgN90iz
         7dM6jYfaxd/5qf7zeqHSEDTVxpgXDRZGfgiZLCvdxU2tbLDTqBdk4+NDrxLYJdY62bcv
         CFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGK4Co7NDboyjza4qRh2rluizajI/4ObcvQZ/gCqlA4=;
        b=WS0CTNUPUizbHswG/o9K3oRkRW0q4NflgHjk9DRzgpKTI+HVKEgPCkTnEDyD+A/ne8
         rndQfC1rIwkaat3T6jabTnU7Yj8lBRzffa5+Co4hrIdfNPt59HYHcFZmcZARUN8jLZsV
         5Z7fIBpUYxdeWPaA9FBOM2s7VMgCG/jA4ENc+QceoJ+YTRiVwunkpzeL+i62xEwyG/wu
         dtAq9SMTFGD3OZ6irQzBJQ2N7WmX7mlwZczPfbeVt245tZXn5/M9mRlnpS3V49YjRKkr
         uXO41p9RQHsirm9B3j2j5KZXcvUp5OdD7v7ZahlTD+sgQ/amenx92fDmAAJ6Y2p036QS
         YNSg==
X-Gm-Message-State: AOAM531nKPbh5wylrDPY8TDMlAtnOKpJvZ+G0GS1GdP0SI6aa7pPfXMC
        VkOjOV/KmY66t5Rm/rXEiQs=
X-Google-Smtp-Source: ABdhPJwTgAq76eJRmdksQgH/+D7eHxhoFXN31VaLR7x99kGjXWQasEaqg9r1u22tiuxZkr00TtP1GA==
X-Received: by 2002:a05:6830:1bca:: with SMTP id v10mr14419789ota.109.1592063886536;
        Sat, 13 Jun 2020 08:58:06 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:05 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 07/24] dyndbg: fix a BUG_ON in ddebug_describe_flags
Date:   Sat, 13 Jun 2020 09:57:21 -0600
Message-Id: <20200613155738.2249399-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ddebug_describe_flags currently fills a caller provided string buffer,
after testing its size (also passed) in a BUG_ON.  Fix this by
replacing them with a known-big-enough string buffer wrapped in a
struct, and passing that instead.

Also simplify the flags parameter, and instead de-ref the flags struct
in the caller; this makes the function reusable (soon) where flags are
unpacked.
---
 lib/dynamic_debug.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9b2445507988..aaace13d7536 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -87,22 +87,22 @@ static struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_NONE, '_' },
 };
 
+struct flagsbuf { char buf[ARRAY_SIZE(opt_array)+1]; };
+
 /* format a string into buf[] which describes the _ddebug's flags */
-static char *ddebug_describe_flags(struct _ddebug *dp, char *buf,
-				    size_t maxlen)
+static char *ddebug_describe_flags(unsigned int flags, struct flagsbuf *fb)
 {
-	char *p = buf;
+	char *p = fb->buf;
 	int i;
 
-	BUG_ON(maxlen < 6);
 	for (i = 0; i < ARRAY_SIZE(opt_array); ++i)
-		if (dp->flags & opt_array[i].flag)
+		if (flags & opt_array[i].flag)
 			*p++ = opt_array[i].opt_char;
-	if (p == buf)
+	if (p == fb->buf)
 		*p++ = '_';
 	*p = '\0';
 
-	return buf;
+	return fb->buf;
 }
 
 #define vnpr_info(lvl, fmt, ...)				\
@@ -141,13 +141,13 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
  * logs the changes.  Takes ddebug_lock.
  */
 static int ddebug_change(const struct ddebug_query *query,
-			unsigned int flags, unsigned int mask)
+			unsigned int pflags, unsigned int mask)
 {
 	int i;
 	struct ddebug_table *dt;
 	unsigned int newflags;
 	unsigned int nfound = 0;
-	char flagbuf[10];
+	struct flagsbuf flags;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -190,22 +190,21 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			nfound++;
 
-			newflags = (dp->flags & mask) | flags;
+			newflags = (dp->flags & mask) | pflags;
 			if (newflags == dp->flags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(flags & _DPRINTK_FLAGS_PRINT))
+				if (!(pflags & _DPRINTK_FLAGS_PRINT))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (flags & _DPRINTK_FLAGS_PRINT)
+			} else if (pflags & _DPRINTK_FLAGS_PRINT)
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
 			v2pr_info("changed %s:%d [%s]%s =%s\n",
 				 trim_prefix(dp->filename), dp->lineno,
 				 dt->mod_name, dp->function,
-				 ddebug_describe_flags(dp, flagbuf,
-						       sizeof(flagbuf)));
+				 ddebug_describe_flags(dp->flags, &flags));
 		}
 	}
 	mutex_unlock(&ddebug_lock);
@@ -814,7 +813,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
-	char flagsbuf[10];
+	struct flagsbuf flags;
 
 	if (p == SEQ_START_TOKEN) {
 		seq_puts(m,
@@ -825,7 +824,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
 		   iter->table->mod_name, dp->function,
-		   ddebug_describe_flags(dp, flagsbuf, sizeof(flagsbuf)));
+		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape(m, dp->format, "\t\r\n\"");
 	seq_puts(m, "\"\n");
 
-- 
2.26.2

