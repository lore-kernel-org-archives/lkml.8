Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872DDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EBC9214F1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ0FrLtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgHGUKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHGUKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:10:24 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1856C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 13:10:23 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id a24so3028733oia.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t/o1QHf6JfaGQyqOjwwBkMrAL/MmcPSgiGCF5pDCiu0=;
        b=KZ0FrLtYnui5+HPhclS0wMfwN6zztWEk/d7bJa9Yn1JhEbL0JzA9NBw3Up4cnXtfXU
         PPaCpWkQAjecVAZhm+WXu9h5xbyNcLVlnnBn+P+HAVhj5z2EFvdbKti3rdkBN9QgjCBX
         tqJoWYbW5HUaiUBRsn+2HJtBRlFaWWPn9yckD80ZTMDbhKa5r0f6gWfduZc0SheqG/ry
         TS4tIUo/1caaiOz/bvhvbqjx6fCbOrDlPgQiFaRU+6E5ZznUd5CfN+euyr5Tj1lm4ejH
         pgN7amEANaFXV+qXSDI01aeG77K8sN9A5r1fvZSEQzMzFQOrzQuABx8mC3bJLZ/RV+PQ
         mG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t/o1QHf6JfaGQyqOjwwBkMrAL/MmcPSgiGCF5pDCiu0=;
        b=HKWbyMepIVk6HcD+41kllQwWMunDKsa8ey4nH/0JLeiwu17HbZDt/Uph7SW6VAnohW
         OS617iy0lKarXG3S6zI7+WCe5Yn2E0BBnsJWVrEks6Ef6/vCdaHg0NgBMDbkkSof1Z0W
         Mk0m5/erypL82LkmmhEKusy7ho/1Vgu0VPFh74fCNkNtJCzL32LTHeWfWjyugYAFyk3F
         SiBrfGjh6/mHGh04zzcbBZZCabIAk198dmnYel56WFNwdK+xEu2XNq13ZtPO10/0iEEK
         ZV67jlnfEx0kh0/zw/YfAzbYvMML1BNIScxfxBUffxMtVvgDh1qStpyC50/3SlQpKhHE
         XLSg==
X-Gm-Message-State: AOAM531mMvAdOwpOyTfizzBMRMnRIXMmpkTmZR8fDd9WrvukWM2mpnIL
        ytL4wp0pW0B3bztR5UrUWjw=
X-Google-Smtp-Source: ABdhPJwEVye0QTxyXENNT1LKnQxUfzGJYQMScAiVPpaDhZ+LxpeWLXlAQsgOIlNVnGFIFD20liGnTw==
X-Received: by 2002:a54:4e8b:: with SMTP id c11mr13027873oiy.3.1596831023185;
        Fri, 07 Aug 2020 13:10:23 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::af38])
        by smtp.googlemail.com with ESMTPSA id s6sm1835794otq.75.2020.08.07.13.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:10:22 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 5/7] dyndbg: WIP replace __dyndbg_callsite section with a zs-pool copy.
Date:   Fri,  7 Aug 2020 14:09:52 -0600
Message-Id: <20200807200957.1269454-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807200957.1269454-1-jim.cromie@gmail.com>
References: <20200807200957.1269454-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HEAD~1 split struct _ddebugs into heads & bodies, linked accross 2 ELF
sections.  Lets now store copies of the bodies into a zs_pool, and
relink head to the new body.  This should allow recycling the section
soon.

The strategy is to let a compression algo handle the repetition, and
map individual records in when needed.  If that works, we only need
one record at a time, so the 3:1 zram compression applys to 99.9% of
callsites, ie to 98120 bytes below:

 dyndbg: 259 modules, 2453 entries and 10360 bytes in ddebug tables, \
  98120 bytes in __dyndbg section, 98120 bytes in __dyndbg_callsites section
 dyndbg: 2453 entries. repeated entries: 2193 module 2058 file 981 func

Since dynamic_debug is nice to have but rarely used, paying more for
active logging to save in-kernel memory might be a worthwhile tradeoff.

This is how:

ddebug_zpool_init(), at late_initcall time, creates the zpool.
Per dmesg, this is immediately after zswap is ready.

Existing ddebug_add_module() now also calls ddebug_zpool_add(in a loop), which
copies the _ddebug_callsite record into the zpool, once it is ready.
For builtins, added early, the pool is not ready yet.

So ddebug_zpool_init() also calls ddebug_zpool_add() for all those
builtin modules already _add()ed.

ddebug_zpool_add() does, foreach _ddebug:
 - zs_mallocs and saves callsite to .zhandle,
 - zs_maps and saves .site to it
 - zs_unmaps it, triggering write to zram
 - .site=0, detaching __dyndbg_callsites[item]
   which later triggers zs_map (of the copy)

ddebug_zpool_remove() undoes ddebug_zpool_add().
We call it from ddebug_remove_module().

So we leave late-init with a full zram copy,
and __dyndbg_callsites ready to reclaim.

run-time access for the 3 existing users of struct _ddebug is entirely
via 2 helpers; ddebug_callsite_get(), ddebug_callsite_put().  These 3
uses are all with ddebug_lock held.

_get() returns .site 1st, or maps zrec to it and returns it.
_put() always unmaps, minimizing online ram (see 1 below)

ddebug_change() also gets s/continue/goto skipsite/g to cleanly unmap
the record at the bottom of the loop.

This much works.

Next steps:

1. dont always unmap in _put(), leave enabled pr_debugs mapped.

this is sticking point atm.

This would make the set of zs_mapped recs work like a cache, reducing
zs_mappings to a trickle, and only for <>control.

2. adapt struct _ddebug to unionize .site and .zhandle

We currently use !!.site and !!.zhandle tests to keep state, we have
bits available in flags to replace these tests, making union possible.

A crazy alt is to create a "restricted" zpool, which limits pool size
to 2**N handles, and returned handles to an (N+crc)-bit number, which
would fit beside our 8-bit flags, inside an 8-byte pointer.  This
would be cool, but isnt necessary, since union looks practical.

3. move key from struct _ddebug into _ddebug_callsite

key doesnt exactly fit semantically (and its not RO), but its use is
super rare, and is never needed without also needing all the other
callsite data.  Getting it out of head saves on-line ram.  But it
broke in HEAD~1 when I tried it, with asm goto errors.

4. linker question

DECLARE_DYNAMIC_DEBUG_METADATA macro fills 2 sections simultaneously.
If we can rely on the linker to keep those records in identical order,
we can 'index' both _dyndbg & _callsites (& keys) with [N-opaque] and
drop the .site pointer.

5. improve compression ?

Im seeing 3:1 pages_per_zspage:

 # cut -c1-12,40-77,85-90 $SKD/zsmalloc/dyndbg_callsites/classes | head -n3
 class  sizebj_allocated   obj_used pages_used pagzspage
     0    32           0          0          0         1
     1    48        2816       2605         33         3

Since the __dyndbg_callsite section is well sorted, a simple
run-length encoding on 3 RO members (modname, file, function) could
reclaim most of the (90%, 84%, 45%) repeated values.  That said, a
standard compressor should be able to compete, and there are several
to try.

Lastly, this whole zram block is RO after late-init (maybe, if we
split into 2 zpools, for builtins and loadable modules).  So
compression can be biased towards costly but excellent compression
(esp for RO zpool) and good small block decompression for random-ish
access.

6. we could add a ram_reclaim(), to walk the dt-list, check each
_ddebug, and unmap the mapped ones.  This presumes 1. is done, and
there are sometimes memory pressures to respond to.

Potential benefits:
- convert in-kernel mem to zram/etc
- zram compression
- eventually swap it out entirely
- map in the enabled callsites only

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |   1 +
 lib/dynamic_debug.c           | 156 +++++++++++++++++++++++++++++++---
 2 files changed, 145 insertions(+), 12 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index bbb06a44c0cf..cae82e046685 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -28,6 +28,7 @@ struct _ddebug_callsite {
 
 struct _ddebug {
 	struct _ddebug_callsite *site;
+	long unsigned int zhandle;
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9161f345e3c9..fdf52a26a504 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/netdevice.h>
+#include <linux/zsmalloc.h>
 
 #include <rdma/ib_verbs.h>
 
@@ -72,6 +73,8 @@ static LIST_HEAD(ddebug_tables);
 static int verbose;
 module_param(verbose, int, 0644);
 
+static struct zs_pool *dd_callsite_zpool;
+
 /* Return the path relative to source root */
 static inline const char *trim_prefix(const char *path)
 {
@@ -139,6 +142,41 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		 query->first_lineno, query->last_lineno);
 }
 
+/*
+ * Lifecycle of struct _ddebug's .site and .zhandle:
+ *
+ * At early-init, .site points into __dyndbg_callsite[], .zhandle=0
+ *
+ * At late-init, zpool_add(callsite)s copies into zram, saves ref in
+ * .zhandle, and forgets .site, allowing __dyndbg_callsite[] to be
+ * reclaimed.  After this, we restore .site from .zhandle when needed.
+ * We default to minimal mapping, load on demand.
+ *
+ * _get() returns .site preferentially, and updates it when needed.
+ * this works for early-prints and minimal mapped records strategy.
+ */
+static struct _ddebug_callsite* ddebug_callsite_get(struct _ddebug *dp)
+{
+	if (dp->site)
+		return dp->site;
+
+	dp->site = (struct _ddebug_callsite*)
+		zs_map_object(dd_callsite_zpool, dp->zhandle, ZS_MM_RO);
+
+	return dp->site;
+}
+
+static void ddebug_callsite_put(struct _ddebug *dp)
+{
+	if (!dp->site || !dp->zhandle)
+		/* no site to unmap, or no means to restore */
+		return;
+
+	/* always unmap for now. if !pr-debug was too hard */
+	zs_unmap_object(dd_callsite_zpool, dp->zhandle);
+	dp->site = NULL;
+}
+
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -165,7 +203,8 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
-			struct _ddebug_callsite *dc = dp->site;
+			struct _ddebug_callsite *dc;
+			dc = ddebug_callsite_get(dp);
 
 			/* match against the source filename */
 			if (query->filename &&
@@ -174,12 +213,12 @@ static int ddebug_change(const struct ddebug_query *query,
 					   kbasename(dc->filename)) &&
 			    !match_wildcard(query->filename,
 					   trim_prefix(dc->filename)))
-				continue;
+				goto skipsite;
 
 			/* match against the function */
 			if (query->function &&
 			    !match_wildcard(query->function, dc->function))
-				continue;
+				goto skipsite;
 
 			/* match against the format */
 			if (query->format) {
@@ -188,24 +227,24 @@ static int ddebug_change(const struct ddebug_query *query,
 					/* anchored search. match must be at beginning */
 					p = strstr(dc->format, query->format+1);
 					if (p != dc->format)
-						continue;
+						goto skipsite;
 				} else if (!strstr(dc->format, query->format))
-					continue;
+					goto skipsite;
 			}
 
 			/* match against the line number range */
 			if (query->first_lineno &&
 			    dc->lineno < query->first_lineno)
-				continue;
+				goto skipsite;
 			if (query->last_lineno &&
 			    dc->lineno > query->last_lineno)
-				continue;
+				goto skipsite;
 
 			nfound++;
 
 			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
 			if (newflags == dp->flags)
-				continue;
+				goto skipsite;
 #ifdef CONFIG_JUMP_LABEL
 			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
 				if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
@@ -218,6 +257,9 @@ static int ddebug_change(const struct ddebug_query *query,
 				 trim_prefix(dc->filename), dc->lineno,
 				 dt->mod_name, dc->function,
 				 ddebug_describe_flags(dp->flags, &fbuf));
+
+		skipsite:
+			ddebug_callsite_put(dp);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
@@ -569,14 +611,16 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
+static char *dynamic_emit_prefix(struct _ddebug *dp, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
-	const struct _ddebug_callsite *desc = dp->site;
+	const struct _ddebug_callsite *desc;
 
 	*buf = '\0';
 
+	desc = ddebug_callsite_get(dp);
+
 	if (dp->flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
@@ -599,6 +643,8 @@ static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 	if (pos >= PREFIX_SIZE)
 		buf[PREFIX_SIZE - 1] = '\0';
 
+	ddebug_callsite_put(dp);
+
 	return buf;
 }
 
@@ -863,7 +909,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
-	struct _ddebug_callsite *dc = dp->site;
+	struct _ddebug_callsite *dc;
 	struct flagsbuf flags;
 
 	if (p == SEQ_START_TOKEN) {
@@ -872,6 +918,8 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		return 0;
 	}
 
+	dc = ddebug_callsite_get(dp);
+
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dc->filename), dc->lineno,
 		   iter->table->mod_name, dc->function,
@@ -879,6 +927,8 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_escape(m, dc->format, "\t\r\n\"");
 	seq_puts(m, "\"\n");
 
+	ddebug_callsite_put(dp);
+
 	return 0;
 }
 
@@ -922,6 +972,50 @@ static const struct proc_ops proc_fops = {
 	.proc_write = ddebug_proc_write
 };
 
+/*
+ * copy struct _ddebug records into the zpool, and remember zhandle in
+ * the struct.  This is close to what we'll want to unionize the
+ * handle and the struct
+ */
+static void ddebug_zpool_add(struct _ddebug *dp)
+{
+	unsigned long handle;
+	struct _ddebug_callsite *cursor;
+
+	handle = zs_malloc(dd_callsite_zpool, sizeof(struct _ddebug_callsite),
+			   GFP_KERNEL);
+	if (!handle) {
+		pr_err("pool malloc failed on %s\n", dp->site->function);
+		return;
+	}
+	dp->zhandle = handle;
+
+	cursor = (struct _ddebug_callsite *)
+		zs_map_object(dd_callsite_zpool, handle, ZS_MM_WO);
+
+	if (!cursor) {
+		pr_err("zs-map failed\n");
+		return;
+	}
+	memcpy(cursor, dp->site, sizeof(struct _ddebug_callsite));
+
+	/* forget __dyndbg_callsites[] so we can reclaim it */
+	dp->site = NULL;
+	zs_unmap_object(dd_callsite_zpool, handle);
+}
+
+static void ddebug_zpool_remove(struct _ddebug *dp)
+{
+	if (dp->site) {
+		pr_warn("zhandle shouldnt be mapped now\n");
+		zs_unmap_object(dd_callsite_zpool, dp->zhandle);
+	}
+	if (!dp->zhandle)
+		pr_err("zhandle already cleared !\n");
+	else
+		zs_free(dd_callsite_zpool, dp->zhandle);
+}
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -947,10 +1041,15 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	dt->ddebugs = tab;
 
 	mutex_lock(&ddebug_lock);
+	if (dd_callsite_zpool)
+		/* zpool is ready for filling late */
+		for (; n; n--, tab++)
+			ddebug_zpool_add(tab);
+
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	v2pr_info("%3u debug prints in module %s\n", n, dt->mod_name);
+	v2pr_info("%3u debug prints in module %s\n", dt->num_ddebugs, dt->mod_name);
 	return 0;
 }
 
@@ -1014,6 +1113,13 @@ int ddebug_remove_module(const char *mod_name)
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
 		if (dt->mod_name == mod_name) {
+
+			unsigned int n = dt->num_ddebugs;
+			struct _ddebug *dp = dt->ddebugs;
+
+			for (; n; n--, dp++)
+				ddebug_zpool_remove(dp);
+
 			ddebug_table_free(dt);
 			ret = 0;
 			break;
@@ -1060,6 +1166,31 @@ static int __init dynamic_debug_init_control(void)
 	return 0;
 }
 
+/*
+ * initialize the zpool, and fill it with copies of struct _ddebug
+ * records in the __verbose/__dyndbg section.
+ */
+static void __init ddebug_zpool_init(void)
+{
+	struct _ddebug *iter;
+
+	/* tbd- no corresponding destroy */
+	dd_callsite_zpool = zs_create_pool("dyndbg_callsites");
+	if (!dd_callsite_zpool) {
+		pr_err("create pool failed\n");
+		return;
+	}
+
+	/* add-module normally does this, but not in time for builtins */
+	for (iter = __start___dyndbg; iter < __stop___dyndbg; iter++)
+		ddebug_zpool_add(iter);
+
+	v2pr_info("total pages: %lu compaction: %lu\n",
+		  zs_get_total_pages(dd_callsite_zpool),
+		  zs_compact(dd_callsite_zpool));
+}
+late_initcall(ddebug_zpool_init);
+
 static int __init dynamic_debug_init(void)
 {
 	struct _ddebug *iter, *iter_start, *prev = 0;
@@ -1149,3 +1280,4 @@ early_initcall(dynamic_debug_init);
 
 /* Debugfs setup must be done later */
 fs_initcall(dynamic_debug_init_control);
+
-- 
2.26.2

