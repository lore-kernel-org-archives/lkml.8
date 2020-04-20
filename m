Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4713C55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E538206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVYB1Rus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgDTU6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgDTU6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C11DC061A0E;
        Mon, 20 Apr 2020 13:58:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so13962033wrx.4;
        Mon, 20 Apr 2020 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUn+GLd9ydpqdPTxEVmckTZm3FvpDIuZEv3pyNzEsmI=;
        b=cVYB1Rus+R9pIeYMUG/QWduWz8K0rywd1BdDprPoH5NmUE9TEHIeieWn4I5UtcZXhg
         AyaID9QQKsSgQ8LrOLZJJ1cMhKQqBCDoG+A5U8UQiPjK1TlqC2VnQ2MMy76+0+PHCo4t
         3R2k6HmH/LJgf/BE5Niegz+/axjbBwrLwwBATULZHt64yUlaBLiAVtVavu6wpP+RhUPy
         93WlOtfMRW/1OBOTdnrX2t8Ena89qXM8eHVa1YHLCNgu5FIZI2UQcKl+d97yqLXzOdp5
         +M4+vHMubQbYmAyA4evnQ+XH36tHh+P3fK6WFdgABqCPMrOIkEYATgXHWkSjobU9o3Hm
         8jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUn+GLd9ydpqdPTxEVmckTZm3FvpDIuZEv3pyNzEsmI=;
        b=epLzA4tC37gm2xCxZe9mTRZn+Y8OtONqvZYMUaQvAPp9bTVlak9r47b/VyDH11df2+
         IZZO5QqvfYtoPPTwGR4EgVW0wfhVlSfa1OUK49em3XYaGrmnuv/UYPJROEW70SMzLSzH
         5Eg8/Pc5Ar+muJeTEvvTLrPqYskhHOrAr4a6XKv53aqBT106Wn+Xi4bsSOeLCRNah1dv
         eXaX/EB9GPRPUwNcb9lc+oj4Lltzk2iZ5Jfg3Nw4AGTCziljjJu5xxiH7sBbSiagW9W/
         ozQ/Q8sDd+cOY7x1phbDFi191wjmJj0xUOZNx1In/I/Be6wscdQ4pF60XL/tLzNAJBbT
         f3lg==
X-Gm-Message-State: AGi0PuYSR2cdArMyqnZ6c6G2WLd+0NDHtOwXOok4ru9+f9fnGxYOgWYa
        PAFXiDGsLuP8bf5uyrayLw==
X-Google-Smtp-Source: APiQypIHh1BVDZtCSpJ9pmclsPkF4Pg/cpDbpAhEaeANpfDDu2+ZY+J6Rt7bFehDFKyxtw6S8BjVww==
X-Received: by 2002:adf:fc4f:: with SMTP id e15mr20763529wrs.415.1587416295092;
        Mon, 20 Apr 2020 13:58:15 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:14 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 08/15] print_integer, proc: rewrite /proc/uptime via print_integer()
Date:   Mon, 20 Apr 2020 23:57:36 +0300
Message-Id: <20200420205743.19964-8-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/uptime.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index 5a1b228964fb..a8190078d595 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -8,10 +8,14 @@
 #include <linux/time_namespace.h>
 #include <linux/kernel_stat.h>
 
+#include "../../lib/print-integer.h"
+
 static int uptime_proc_show(struct seq_file *m, void *v)
 {
 	struct timespec64 uptime;
 	struct timespec64 idle;
+	char buf[(LEN_UL + 1 + 2 + 1) * 2];
+	char *p = buf + sizeof(buf);
 	u64 nsec;
 	u32 rem;
 	int i;
@@ -25,11 +29,21 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 
 	idle.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec = rem;
-	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
-			(unsigned long) uptime.tv_sec,
-			(uptime.tv_nsec / (NSEC_PER_SEC / 100)),
-			(unsigned long) idle.tv_sec,
-			(idle.tv_nsec / (NSEC_PER_SEC / 100)));
+
+	*--p = '\n';
+	--p;	/* overwritten */
+	*--p = '0';
+	(void)_print_integer_u32(p + 2, idle.tv_nsec / (NSEC_PER_SEC / 100));
+	*--p = '.';
+	p = _print_integer_ul(p, (unsigned long)idle.tv_sec);
+	*--p = ' ';
+	--p;	/* overwritten */
+	*--p = '0';
+	(void)_print_integer_u32(p + 2, uptime.tv_nsec / (NSEC_PER_SEC / 100));
+	*--p = '.';
+	p = _print_integer_ul(p, (unsigned long)uptime.tv_sec);
+
+	seq_write(m, p, buf + sizeof(buf) - p);
 	return 0;
 }
 
-- 
2.24.1

