Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E13BC18E5B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB620206BE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vh68/Vu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgCORJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 13:09:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36417 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgCORJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 13:09:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id s5so18339062wrg.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V44A2I37Drhfg/qPIvr3ypiS3ycesuCf9thvM+4L9ms=;
        b=vh68/Vu7YuC3asq+YRBLjvxbYWvRSiMivpCnhv/UWPWPRN5ixYdzX5iGTyJvHFBaKJ
         Po1mifghFJqN0FHCcfMlDCOCmPENkWOxSj09Zht0xltPw6LagEVjWlS2xYKHnr/HvZ97
         QQ2i0jgXoMxpd5wz61UI+kbvC+fb0JchUgiKGJ4c2x7HbI58i3l4opnJsUAncw3dabF+
         qIyaz/OS/5cpTDd9/ZgkcEJzYkV+ApCXnQPsg5ISKsdqcJIxTn22UGsho5BLjxGX3M3P
         14KiaCmyI6eZjSj+IjAvRVhIZkVQRU77izWfEPJdDArepnKyNV+rP5Ey8PClFX8S1trj
         Pvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V44A2I37Drhfg/qPIvr3ypiS3ycesuCf9thvM+4L9ms=;
        b=dMfFG1c1MlT31fdBZpprP1nnqInoEQEcUZ9XVGWqcJbL/dyd8KTSnnh0pqSVi7hws7
         wW4PLfM9TYs4G5W5fakJpZurrSWMoTuSYT+cEVrKfamn9IYys6tlBGBH+qhfbBAvhoP6
         PG2ZSFYozrIy02uPZu79nwSFHT+bj2+U6me1pm1Bs0L+gqcTQYSUmhP4jXzkrZut73m+
         3Vw2VS0/iFHDGfA7kbGrNuemAFGGVP8yZ3nRvlWBEfk9sIUzUekDRxcaC3OzNZVDpFUF
         ZbG2x6dicjBzOOauXC8afwXzrEN9bK1cbFsiavmY7dfdNNDAGA+wl7QxYmbK8m268BEv
         N5Gw==
X-Gm-Message-State: ANhLgQ2kIetyM3BePgJ6KnB390eWF3oulLPrDxDCfvia1kFnfv/uoCV9
        WLvmlAbTN0P+p/tEadW5LQnrEavcZksbij0l
X-Google-Smtp-Source: ADFU+vstEFm2oZNugogbuZ084f28nDsxxuWEl0XXVOvQdLV23qz55Y3UxFO8C387Ln7A+j76TGvq3g==
X-Received: by 2002:adf:cf08:: with SMTP id o8mr29256448wrj.192.1584292182444;
        Sun, 15 Mar 2020 10:09:42 -0700 (PDT)
Received: from localhost.localdomain (ipb218f56a.dynamic.kabel-deutschland.de. [178.24.245.106])
        by smtp.gmail.com with ESMTPSA id u25sm25874774wml.17.2020.03.15.10.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 10:09:41 -0700 (PDT)
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [RFC PATCH 1/3] printk: convert ignore_loglevel to atomic_t
Date:   Sun, 15 Mar 2020 18:09:01 +0100
Message-Id: <20200315170903.17393-2-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200315170903.17393-1-erosca@de.adit-jv.com>
References: <20200315170903.17393-1-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for using the 'ignore_loglevel' variable as a lockless and SMP
safe vehicle to turn console verbosity on and off in error paths which
usually (but not necessarily) end up with panic (configurable via
user-selectable knobs).

No functional change intended. Tested on R-Car H3ULCB.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 kernel/printk/printk.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fada22dc4ab6..d2c75955a0d7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1181,24 +1181,46 @@ void __init setup_log_buf(int early)
 		free, (free * 100) / __LOG_BUF_LEN);
 }
 
-static bool __read_mostly ignore_loglevel;
+atomic_t __read_mostly ignore_loglevel = ATOMIC_INIT(0);
 
 static int __init ignore_loglevel_setup(char *str)
 {
-	ignore_loglevel = true;
+	atomic_set(&ignore_loglevel, 1);
 	pr_info("debug: ignoring loglevel setting.\n");
 
 	return 0;
 }
 
+static int kparam_set_atomic(const char *val, const struct kernel_param *kp)
+{
+	if (param_set_bool(val, kp))
+		return -EINVAL;
+
+	atomic_set(&ignore_loglevel, *(bool *)kp->arg ? 1 : 0);
+
+	return 0;
+}
+
+static int kparam_get_atomic(char *val, const struct kernel_param *kp)
+{
+	return sprintf(val, "%c\n", atomic_read(&ignore_loglevel) ? 'Y' : 'N');
+}
+
+static const struct kernel_param_ops kparam_ops = {
+	.set = kparam_set_atomic,
+	.get = kparam_get_atomic,
+};
+
+static int kparam_buf;
+
 early_param("ignore_loglevel", ignore_loglevel_setup);
-module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);
+module_param_cb(ignore_loglevel, &kparam_ops, &kparam_buf, 0644);
 MODULE_PARM_DESC(ignore_loglevel,
 		 "ignore loglevel setting (prints all kernel messages to the console)");
 
 static bool suppress_message_printing(int level)
 {
-	return (level >= console_loglevel && !ignore_loglevel);
+	return (level >= console_loglevel && !atomic_read(&ignore_loglevel));
 }
 
 #ifdef CONFIG_BOOT_PRINTK_DELAY
-- 
2.25.0

