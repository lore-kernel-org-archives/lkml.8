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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598B2C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DF320738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4a8oCg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgGSXMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgGSXLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:32 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD906C0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:31 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id e4so13008600oib.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V4vaC8jH1uAkf0e4xv8Z3CqlZMc6lIX3fCOrUzVEUYI=;
        b=e4a8oCg0tDD6Nuw9h4YbPUXrHklYipvy+bV6bYBaVbbZd8OtBTlunOOCadl6UFwOWK
         eaE1tSSFAEkNVx4Xr+PReriJx7iYlnFXSwAekB+fyeX8alS2KOTUgp+2FB887Fiq5S4+
         XMVEruCUV3uhlxxeUPAgyZnMA4ooW0JSzusdRImFGShE7spF6u7d3YFxSrwO8eTswAlr
         GUABdWt07yhhAXwZqjEckoNf7EkUpLF9fN0GV04LPBASjSMXCtEfDLXAMgiBk15Rhd+N
         +MHes1hhRnWUAqydupzZ/cOXygzU/gzzNbfNk0vqLoPm9D5ZcvHiTuwEWCb1vakUGALm
         TFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V4vaC8jH1uAkf0e4xv8Z3CqlZMc6lIX3fCOrUzVEUYI=;
        b=DxbIjpLiNxF2mhstELrbi46KU/hi9do5gIHE36uy/8XpiBEJRDHkWVHNEp8xKdARag
         FFYLkQK6JwzwYpaV2+wpYWx8XArIJXickswcJpnaOeEs4vSN1twSPHdDOcB329BsY6JI
         vA8n7OANXa2QnctSzshcgBqPiXu0sHnSFhYKQoaUOMU0o38ZFNOqG3kXDdYWzgenbZ9V
         VdvblevYgNMGtXDJe8Dm/y1tdZsdnCdCQ0jL9MXlWIVAsJCwakWUT5owuQ/vDJU6y3aD
         FGLuKyQicfDQc9zI7Jre8PgeNMN5z6P/Hv3YJ90ChU8/I8djSU2+J2Qekf/XutxpepCN
         9d2Q==
X-Gm-Message-State: AOAM531Vb0xVSVgx8pN24pjUeN5NRfp6yujuIJdx1/B/VMsRyY+xpYN7
        8eTfFiwROcIEtgyU1ykX7kU=
X-Google-Smtp-Source: ABdhPJy1B6kzslbF9MiF787qbfTKWHWy3Kg8E82+C504+GAnfqdnxpu7RQuD7i6po+/Qgwsa71W+yg==
X-Received: by 2002:aca:a98f:: with SMTP id s137mr16396033oie.120.1595200291197;
        Sun, 19 Jul 2020 16:11:31 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:30 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 07/18] dyndbg: fix a BUG_ON in ddebug_describe_flags
Date:   Sun, 19 Jul 2020 17:10:47 -0600
Message-Id: <20200719231058.1586423-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ddebug_describe_flags() currently fills a caller provided string buffer,
after testing its size (also passed) in a BUG_ON.  Fix this by
replacing them with a known-big-enough string buffer wrapped in a
struct, and passing that instead.

Also simplify ddebug_describe_flags() flags parameter from a struct to
a member in that struct, and hoist the member deref up to the caller.
This makes the function reusable (soon) where flags are unpacked.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9b2445507988..0cb5679f6c54 100644
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
@@ -147,7 +147,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	struct ddebug_table *dt;
 	unsigned int newflags;
 	unsigned int nfound = 0;
-	char flagbuf[10];
+	struct flagsbuf fbuf;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -204,8 +204,7 @@ static int ddebug_change(const struct ddebug_query *query,
 			v2pr_info("changed %s:%d [%s]%s =%s\n",
 				 trim_prefix(dp->filename), dp->lineno,
 				 dt->mod_name, dp->function,
-				 ddebug_describe_flags(dp, flagbuf,
-						       sizeof(flagbuf)));
+				 ddebug_describe_flags(dp->flags, &fbuf));
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

