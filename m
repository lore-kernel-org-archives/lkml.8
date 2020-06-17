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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A3EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C1C21532
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI4pqwh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgFQQ0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFQQ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:08 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E60C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:08 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id v1so529835ooh.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V4vaC8jH1uAkf0e4xv8Z3CqlZMc6lIX3fCOrUzVEUYI=;
        b=KI4pqwh+XCkyNnXG1j38RmHM9YUoW1IzdAMc9ZsD7Sh3MbbRYftqNC978juv0E5lfG
         ydZzMa0Pbiy4JOwnzQAEPbFUQaQe0kiWDb7hzZSyWYkNvGKrXZ2NnJpsPL4cHyoa046+
         WYvxCWzMaNc3h6uQpesOXBseXWURfndQ7IEbwlav/HEp/MTmj8x+G01+SaDeJqBnPtNC
         CbYnB3woElpXnzT8LeQ4xuu2t7/KcuPmsJbZ1b53oxL0hoRxoSCcjkR6EJfHtFkyVJKO
         +KPA//vQFPwH4UcBTtvgUKLnOyqOz5P6Xa5eU51059I6H4yiopSc2pyK8IKO9MDGOqrL
         W2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V4vaC8jH1uAkf0e4xv8Z3CqlZMc6lIX3fCOrUzVEUYI=;
        b=ZFyUbi0j078+IsD1FhzjboGsTu6lRpks1DLe+6T+c4u8/Clwau8wHPGDrEiU1XmYOx
         I0b/rTYI1fWbRLdW/NRrvBZRwyKWgmJpB0vqoiwwaFFUSoBLBt2wAx5xV+aP/Vn1gm9N
         ld5J+HCo48kuz8IhztF3skzH7TsXnsETfUXP+Lb3AIio1BP2x6hkacUYuDE17oUGJGof
         +0EFuzIbpDCR6I7gi/DKhwGiA+XCwIyCEkaTW2p7e8Me5ne4vGHThjubneN0JNXPtcDW
         +27ivnAyKtcLYGyL66ERWYcoAEH1fuVljQb8HvSGOt6uVWf0KHuAQ+1BpG9n1Bo2dIu0
         9kuA==
X-Gm-Message-State: AOAM5312dRU8jTTXTQ73THQ+QXq3vUtoy6dwLne9PWjuPnSqViHWbX/j
        CNUN0vmX3gPxAsTlhWyMF4MspXqLByM=
X-Google-Smtp-Source: ABdhPJwulPf8PAjGI11HpznAlFwPhOoBNltmelbjqWtLXNOnVoMi600gz5AHyu3YRVLxGET91eqzsg==
X-Received: by 2002:a4a:4c8e:: with SMTP id a136mr159067oob.23.1592411168149;
        Wed, 17 Jun 2020 09:26:08 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:07 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 07/21] dyndbg: fix a BUG_ON in ddebug_describe_flags
Date:   Wed, 17 Jun 2020 10:25:20 -0600
Message-Id: <20200617162536.611386-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
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

