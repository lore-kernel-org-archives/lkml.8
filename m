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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26889C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055C82074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD9fhqXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgFEQ1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgFEQ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:27:38 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B72C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:27:38 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g5so8050531otg.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DRaJ4ESWzscurVoCq7VxWjqZVP7aRxjA4yVd5yVmLPo=;
        b=dD9fhqXhAonC3UcJ/8JDXkYel5lYv7bbFRjgAgpFJTkYks+2MnByaCva0UCR4B6Uh7
         V/pv3QukUgzXF57BmFiRFCxLFOAW3YOV0qAC2+yvlwIvEX/efLK3rQe+tEzQ+Wq+HSC6
         1prL6sQAyldGDLtHTZuO0ZmyUSzW3iDJFs2BR0Q8BRbQezWr2Z59fFHnGqEWyqvPJwqZ
         LlRz7zypXf7LOU06RNP9XbRgsbedihUPNIy66x2xEHdoen//Wh3hlA2IaHiZ84i5z/uJ
         2pAN5whWdPD9sdjTfa8dTeCZu61NtsESdwaYZu8B1EFlTw/NzvCXwfpP6rwaIc8Idotf
         iExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DRaJ4ESWzscurVoCq7VxWjqZVP7aRxjA4yVd5yVmLPo=;
        b=lIyN97qV/O44HNO5PFV6OIRcC46rglpSRVBoHlXWaIxaDESs0hO6Qo0+gZ82ReaaIW
         DIFmkwnk/mA6f01MtFmwpWqG1Nb2eLyWlzwS+1QERAiG4YWfDVb51+thrW6wU3G6vW7e
         ZmhhO6PhqTE1l/j+2SjG7nGEf/YclBYamL1apPFJoK7wzW8x7VMEIZ5Q62C914KPzNUq
         7USu0zT8jXLqovGzYluB+XFM+KlhuHGZmtMO1sAZCSjgvOF/3TlB084puLJbpYior+lB
         t8jaQu+98QSOez4YSseJgIBTqY+TzjbuptyB0RoUtYje+9pwbIz4w8ZVcs/NkaQpTHW4
         PhtA==
X-Gm-Message-State: AOAM5317wEc9GoD0Jgy97qK5gAfxxDRQFVIBdMbyW6FIpt12LAWMhiRt
        cbTO7+GTefney2E03PA9Ukg=
X-Google-Smtp-Source: ABdhPJzvVE85ZKZfGXUQcwb4T67v+Ak3iK5knQgeO/nJJkJis5XHUn9zX9ZEtP4TUtNmKR+QWSk0Ow==
X-Received: by 2002:a9d:4917:: with SMTP id e23mr8592069otf.29.1591374458111;
        Fri, 05 Jun 2020 09:27:38 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:27:37 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 03/16] dyndbg: refine debug verbosity; 1 is basic, 2 more chatty
Date:   Fri,  5 Jun 2020 10:26:32 -0600
Message-Id: <20200605162645.289174-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The verbose/debug logging done for `cat $MNT/dynamic_debug/control` is
voluminous (2 per control file entry + 2 per PAGE).  Moreover, it just
prints pointer and sequence, which is not useful to a dyndbg user.
So just drop them.

Also require verbose>=2 for several other debug printks that are a bit
too chatty for typical needs;

ddebug_change() prints changes, once per modified callsite.  Since
queries like "+p" will enable ~2300 callsites in a typical laptop, a
user probably doesnt need to see them often.  ddebug_exec_queries()
still summarizes with verbose=1.

ddebug_(add|remove)_module() also print 1 line per action on a module,
not needed by typical modprobe user.

This leaves verbose=1 better focussed on the >control parsing process.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b877774dba96..5900c043e979 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -105,12 +105,15 @@ static char *ddebug_describe_flags(struct _ddebug *dp, char *buf,
 	return buf;
 }
 
-#define vpr_info(fmt, ...)					\
+#define vnpr_info(lvl, fmt, ...)				\
 do {								\
-	if (verbose)						\
+	if (verbose >= lvl)					\
 		pr_info(fmt, ##__VA_ARGS__);			\
 } while (0)
 
+#define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
+#define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
+
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
 	/* trim any trailing newlines */
@@ -198,7 +201,7 @@ static int ddebug_change(const struct ddebug_query *query,
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
-			vpr_info("changed %s:%d [%s]%s =%s\n",
+			v2pr_info("changed %s:%d [%s]%s =%s\n",
 				 trim_prefix(dp->filename), dp->lineno,
 				 dt->mod_name, dp->function,
 				 ddebug_describe_flags(dp, flagbuf,
@@ -771,8 +774,6 @@ static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
 	struct _ddebug *dp;
 	int n = *pos;
 
-	vpr_info("called m=%p *pos=%lld\n", m, (unsigned long long)*pos);
-
 	mutex_lock(&ddebug_lock);
 
 	if (!n)
@@ -795,9 +796,6 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp;
 
-	vpr_info("called m=%p p=%p *pos=%lld\n",
-		 m, p, (unsigned long long)*pos);
-
 	if (p == SEQ_START_TOKEN)
 		dp = ddebug_iter_first(iter);
 	else
@@ -818,8 +816,6 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	struct _ddebug *dp = p;
 	char flagsbuf[10];
 
-	vpr_info("called m=%p p=%p\n", m, p);
-
 	if (p == SEQ_START_TOKEN) {
 		seq_puts(m,
 			 "# filename:lineno [module]function flags format\n");
@@ -842,7 +838,6 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
  */
 static void ddebug_proc_stop(struct seq_file *m, void *p)
 {
-	vpr_info("called m=%p p=%p\n", m, p);
 	mutex_unlock(&ddebug_lock);
 }
 
@@ -905,7 +900,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	vpr_info("%u debug prints in module %s\n", n, dt->mod_name);
+	v2pr_info("%u debug prints in module %s\n", n, dt->mod_name);
 	return 0;
 }
 
@@ -964,7 +959,7 @@ int ddebug_remove_module(const char *mod_name)
 	struct ddebug_table *dt, *nextdt;
 	int ret = -ENOENT;
 
-	vpr_info("removing module \"%s\"\n", mod_name);
+	v2pr_info("removing module \"%s\"\n", mod_name);
 
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
-- 
2.26.2

