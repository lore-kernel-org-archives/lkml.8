Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D876CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D26207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLo2RoPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgFMP6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgFMP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:02 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE89C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:02 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id s13so9755821otd.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x1cBwRcx92OfHjO+CcvlZ6ERQaBwIoGIXhstM4+3lAM=;
        b=qLo2RoPjhjyKe93JF77exgGSwgprYeKXM1wQvPakrlUs5iv/JMCqtQFPHyLDt1Xs4w
         d9W6122KBLqz1poQ1brkwvCeBoLgEZkrD5YYo5+5toQL4+fJe57/03abZPwvqwebVBqU
         7ZMOxtLS0dY+seeQT+3hFg7QU04KUTnsU0Fb5LOkwNds9j8SEi2XulxYDmUyhLLnfZWL
         SjdN30Aj4wY9ZDr7agpqPGjijQG3IZB+NGKKGuCs4uABcpiNzXCqVEKEO1V6M90B0XZ6
         9Y47Yp9taoI0iFOjEM91wvOQ/BL2TC/d9nvrC1IVXAzcPSO0j59CyVETlaRIKRtJmgyM
         ostQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1cBwRcx92OfHjO+CcvlZ6ERQaBwIoGIXhstM4+3lAM=;
        b=TsVOJCeUqQHIweLEcoOhJJCatouGN4GiXNAXsLkcVLOEermVmoP1qYSQ+j2p9CKPpf
         83wm0Raytadku/yPCW1Yx5bdNNozRbqApUhmeob4N6XapLhXOHiZqKqVBHp+Go8/Gypt
         9AETJdY4r5TZrO1eLdV2ta/PXFbgvwIGtmGPm/Q/iHHugI7Ej0hJqNFiAETVFP8lW7dS
         imnZVLnH5MnpjJPI9r7W6Ey5E6Evk6m2YigIcKBytkNXzvmDckO3jwGVi6Z1HBD5B6Mv
         xxghtkYL7AFhmGh9zjapHGfpRXNkwNvORUAIwKWjOchPRGhqTpnI0liVRHsTNNtzRaEd
         bteA==
X-Gm-Message-State: AOAM532hhjFrh1DpeEp82HYnsO4kSAvcJeAARhG74/xSAnT7yRxViCGH
        vVkRceXsAIl7QUOKSkgR6hc=
X-Google-Smtp-Source: ABdhPJxVL/TNFdpWwiXRCqAnV3GSvbdqNbWqxBNX51JKSQCgJO7cHG5aL7zWNH8WqszBl0uA9Van2Q==
X-Received: by 2002:a05:6830:115:: with SMTP id i21mr14903514otp.222.1592063882026;
        Sat, 13 Jun 2020 08:58:02 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:01 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 04/24] dyndbg: refine debug verbosity; 1 is basic, 2 more chatty
Date:   Sat, 13 Jun 2020 09:57:18 -0600
Message-Id: <20200613155738.2249399-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
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

