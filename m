Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877AAC352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679E521D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HIlEqOgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgDRUVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728707AbgDRUUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AAFC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u127so5679033wmg.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UewK9hpbawAl/WYk+ND4T8F/xnhDTg+TNkaDS8X7FAg=;
        b=HIlEqOgj2cmtL9KqmWgeEy0gQuJtaVHQ2cHd9TL6LYzeq+/b7CNH9O2AnMvfqwUwvf
         S0mJeEnt1BlrQs0E0jAyHh3xwJPUVthydthFhyyLPd2/4tMYJ1vbJHerC/BEGfJO2JY5
         4XeD++gDBfQv6KfCOl7yU/+ba1E4AkcJxGseQXm0FxDpKK4eqrQswBW2yHMFYEVgv+nO
         sq/nkqxzhK5qUg+90RWPI5o04/AX1DzPH0WeMv6kvdQBBiy6f4p07p/638a9lOfAGSpI
         hq3vSlwGfXw67qjsKksztz3PNazbwK+d5zaZdxUWpYfXqzcNDenfCUfNvGd95r0VenNR
         +Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UewK9hpbawAl/WYk+ND4T8F/xnhDTg+TNkaDS8X7FAg=;
        b=EIumcojva6uAmG1TeaPIsnuhqT1PwJiTEoikVF3RlT2NTzgz8BYWiLVSnvDGzWSKby
         AC2dVADHgaDEAg8jiqFYy2Y8m8D0bbHWC5kZ40olUCR1h0SyEGdINWBAARelU5xVsvlJ
         mQGPLDE+XzCHlAZIfEZEJEW7bfjTSOgHd3EKlVvk43vSUqdLsikL1UvP2Ulv3U/ZDYSM
         XFob/R049XwpSInGaZmtzZbwXbRekBwuSTM7HwuKu11S04evyl1xL4qMNzPnrs4tGyRw
         nUQIHy3aq8mF7lHgccT13QNEs2z26xza1/GWg9685UW2rBxE4KSoZM8R2R3MxRXU0xjx
         H1Ig==
X-Gm-Message-State: AGi0PuZneS3Qtl2E0/lwFjoxAcmlAxBg9lZYnlhT3IgYb9v/lofViilR
        yHye1p9+2rZms3gUuygK4KQFLdniI5g=
X-Google-Smtp-Source: APiQypKR5Y1qOUmKwsHhnH8t7/xEWQdJ92qlq/z6zpVNikpJ4d3OGf+F5GDVmWR8X/evMGIV0sK2CA==
X-Received: by 2002:a1c:7d90:: with SMTP id y138mr10245638wmc.121.1587241254076;
        Sat, 18 Apr 2020 13:20:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:53 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCHv3 47/50] kdb: Don't play with console_loglevel
Date:   Sat, 18 Apr 2020 21:19:41 +0100
Message-Id: <20200418201944.482088-48-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the stack trace with KERN_EMERG - it should be always visible.

Playing with console_loglevel is a bad idea as there may be more
messages printed than wanted. Also the stack trace might be not printed
at all if printk() was deferred and console_loglevel was raised back
before the trace got flushed.

Unfortunately, after rebasing on commit 2277b492582d ("kdb: Fix stack
crawling on 'running' CPUs that aren't the master"), kdb_show_stack()
uses now kdb_dump_stack_on_cpu(), which for now won't be converted as it
uses dump_stack() instead of show_stack().

Convert for now the branch that uses show_stack() and remove
console_loglevel exercise from that case.

Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: kgdb-bugreport@lists.sourceforge.net
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/debug/kdb/kdb_bt.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 3de0cc780c16..43f5dcd2b9ac 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -21,17 +21,18 @@
 
 static void kdb_show_stack(struct task_struct *p, void *addr)
 {
-	int old_lvl = console_loglevel;
-
-	console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
 	kdb_trap_printk++;
 
-	if (!addr && kdb_task_has_cpu(p))
+	if (!addr && kdb_task_has_cpu(p)) {
+		int old_lvl = console_loglevel;
+
+		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
 		kdb_dump_stack_on_cpu(kdb_process_cpu(p));
-	else
-		show_stack(p, addr);
+		console_loglevel = old_lvl;
+	} else {
+		show_stack_loglvl(p, addr, KERN_EMERG);
+	}
 
-	console_loglevel = old_lvl;
 	kdb_trap_printk--;
 }
 
-- 
2.26.0

