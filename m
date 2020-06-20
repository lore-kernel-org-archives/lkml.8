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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83F9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C852409B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL9eCNJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgFTSIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:11 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:43159 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbgFTSIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:07 -0400
Received: by mail-oo1-f66.google.com with SMTP id i4so2546969ooj.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s3HECr+XRw8l7R9dXLwTey4aQmeyYxab5E3F+GzM5HU=;
        b=bL9eCNJXzH+q2QjcIsJx+TA4VEz7s16wpdVBRMI61wzBGrw1kkyNPWFpaxeHQ58qLZ
         cZKgogwKIWF9aNizV5nt8u/ULX/AzZNKhdPKgcOs0zvYeYwy+p7X66ddsXYTwYbWpZxS
         wynBtuCiMouFboZ2tqWr7Fa2COund51GGZNiMkz7I01lvWIXNDdAJXT8A0RzI/DqlpUN
         MxW8FCnlg502SxuWDEqrtUbKohYAT69GlOWGI4TbEDTcWe1NJVaKooLng8wQC5A27Bb+
         f41Wmzi4Zwp0lIUdpp+bvLAdewIybiKknOeo8e7f0V1y9VDHJzdt2EaJJKAA9SU+WdVz
         pIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s3HECr+XRw8l7R9dXLwTey4aQmeyYxab5E3F+GzM5HU=;
        b=hu3bBjTkAMFJgWb5LrCFHQRPN344OficFV7Cm88NQey51SY1KDBmyFUU8UsK9n2NHe
         Km3a8fHVUSLD+KnVKX8ere/dQtTzx7zpJnvraL8pAdMyRBVsczfGs3y94RjuHDOQvnfr
         pG0DCBIYJW2nvog2TLLwsr5//JKNKwh0UmSgRTX1EPbDGqiSPAU6GQHLXTQGJAlMQkBJ
         lkJA25L6cujiV2JftRMCGhmBXgwmpC2uepwoRkNxXuCZY06iUyv2ueXirAtDMcYNkr9e
         bIIjPSIGEgTb/IgAXYEnwU61kxO3jksMM5Nzin4V+HfoBqJiZCmxkVxvm2U2AqLLuB8k
         dnVg==
X-Gm-Message-State: AOAM530t0+nEurwi6mg3/ce37KPcHG7Y4RCb+m99lxAsI+pwXFtiSsGl
        EjHlLVRfLlKOkKjMISIYwgo=
X-Google-Smtp-Source: ABdhPJwrlaju4AS7vAxXwsaKGN0A3YDMfCJ4FuqCb8JJIGBwE/epwr9/aLpdHBWMTrS6cLRXmmXcNw==
X-Received: by 2002:a4a:de0c:: with SMTP id y12mr8391364oot.53.1592676424996;
        Sat, 20 Jun 2020 11:07:04 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:04 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 04/17] dyndbg: refine debug verbosity; 1 is basic, 2 more chatty
Date:   Sat, 20 Jun 2020 12:06:30 -0600
Message-Id: <20200620180643.887546-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
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
index 2989a590ce9a..c97872cffc8e 100644
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

