Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F493C433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7AC21744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdUflFDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgGSXLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgGSXL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:26 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B00C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:26 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 5so10772734oty.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2q+BLtegxNZWgyGkqvNTZ0wgeYCQgXTjExxafj5VA6o=;
        b=BdUflFDtaMX2IHkiYmgS5wTB5F6WIhvQdwhb4pkt+kUJhp8jJ1TlJwnkbEPeL6t9aO
         ma4LjIv3K7RlRaKbRDqYG/Dtj4UbJjhPCy7EjB3UJcgN1kqOHIo1eQ6NAZmjFtuAE6r1
         XhANBuM0sB3+bgh3hHIXvalWMSPGq2CBY43uQronNrKH5GzRmKlONKGue9JaYvBlm36X
         4/AUi2GgBiFHuY3RsJQSa38rI9w9LxXn9AOsBqEJUllNHeiq9mCa+zkwho222WSfrzaY
         FjXVcAqUFkv0z9rKfE7Yx1Mujcy4WMPegqswol24fvoVRYnXDztZyajXBeCnx5OSeudB
         6h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2q+BLtegxNZWgyGkqvNTZ0wgeYCQgXTjExxafj5VA6o=;
        b=E5cPw6Mqyuvzc9jS+45SkWE4EqsDYF5uQwTe+bDYfPHcKvgsOqimeE34J3Tuh8MYc6
         r1MOWMra/uDY0KNQ/jXLhjxoPDRNsM9riotGAalCTa9S2vLkw4muw6hu4A2HxfKTUMFf
         2UYeZepxvCaqGQ+yozE5fqG2GjRnZDQQtRLEgVnuPewgSROXV9CdfHuG+KOOdYzvALQz
         HweSpm8C1cFgNODw/OKOnsZ70cLxpykRBxeJMotnszuNgQtzNLIblmbWiu8ApS8R9/kh
         WjqZ29t2kofng6L3YeF/049eJ8YbebuRREUgFjRkgsJOoxwUqpSnF9LWTCnA+1cmiUVH
         3CNQ==
X-Gm-Message-State: AOAM5321W92v6ErbfuSSGuk/kTW4VvCgeComizjyWoy1Sgew/vLIJBc1
        7oiXnWKw1+NwYYnoSbrTJOAAR8JOBfM=
X-Google-Smtp-Source: ABdhPJzmOIL3RWtsJKGKv8HyS4FOGypfV1Nm1SPTPDqc7TvdGzMYISD5Md3or0fR9SAZ/CIcM/bugQ==
X-Received: by 2002:a05:6830:1f22:: with SMTP id e2mr16916653oth.62.1595200285893;
        Sun, 19 Jul 2020 16:11:25 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 04/18] dyndbg: refine debug verbosity; 1 is basic, 2 more chatty
Date:   Sun, 19 Jul 2020 17:10:44 -0600
Message-Id: <20200719231058.1586423-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
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
user probably doesn't need to see them often.  ddebug_exec_queries()
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

