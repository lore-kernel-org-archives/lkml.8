Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD18AC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B8C2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzsxBwf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbgCaVkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:40:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38599 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaVkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:40:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id c7so2008983wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 14:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ky/1n1np4qIlShwrBAH1ymqTQEq+G2GKa8d4EMnc3Nk=;
        b=QzsxBwf0RBD2KHV+c1sUngkyU1Wfq6tZ3US5ybGgmBWwaZzGuBY4/XHS3jC+7of27k
         Vk/xcWhNpkgUw7Vv3BeK+EX1dP7h3Ma+k+cHHbOEcxKe815g8ZSleOD2lyDDe0267WlD
         C/ZcVncUhfNvwC1794Lvwbrid72iHH02v2xSG3nKtn5qOiL6EnJm5sav3g+ViVD3hUa1
         iDbR638bqPbOOGTOFf/jdTN7rx7ddBmAc3NIg3Nd69PRufIdi4c2pmYhEgXcIBV7LIV3
         McWZW8ZXSlRkBdyvyuRHzt3Ogj+YUt6P0lADvteo2T5u2XeH15y/ynbSwtp2/ycuZJqA
         Ogog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ky/1n1np4qIlShwrBAH1ymqTQEq+G2GKa8d4EMnc3Nk=;
        b=M3jU8KW1rMVuhYwEU/7WyENxwImq9qq/tQH33dNobF8rrE+Buz0nkn0k/TT0hFY09f
         6VoPoGm120GgCM6QqzWghCjsVvkFVJqlkiZdsryGEUZDsbVX2iLl3pbSNuBxIc70VgL2
         HlkRSW+R/5VFwyrQ2EDhIJ91QsZj9uTIYvzHYGdfQajT8c+rgZ8e01Dkah03zmrPKqxw
         UrTUcDww9kw3Y7YG64Gjx29lSrUvz1uEb6rleUPoT0PubdCKx4TnLaJ5JxEZhK7KzclK
         fgferXep4oyDtTyXHcbmzVT8Vn0y55dHFJF2NzbLLr0WA9WEXvD4r22Fkj2t/k8IqR+w
         823g==
X-Gm-Message-State: ANhLgQ264lFvQlgPg3sU/H06pWdjPYsN8iSgn/Vam2M34mBVdVYGz+Cu
        d3njZFzoEk1+yRlPSWLDwm+nTUnL
X-Google-Smtp-Source: ADFU+vvrnjxtq6u7MX4X161OB9PrZlEz52rMXkmBzUPLpVLAZOCWKHxFvIs31ap7cUFpgQvn75/NMg==
X-Received: by 2002:adf:bc04:: with SMTP id s4mr22177890wrg.244.1585690850193;
        Tue, 31 Mar 2020 14:40:50 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id y11sm5190580wmi.13.2020.03.31.14.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:40:49 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: Add debugfs support
Date:   Tue, 31 Mar 2020 23:40:45 +0200
Message-Id: <20200331214045.2957710-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Add a top-level "clocksource" directory to debugfs. For each clocksource
registered with the system, a subdirectory will be added with attributes
that can be queried to obtain information about the clocksource.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/linux/clocksource.h |  3 ++
 kernel/time/clocksource.c   | 60 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 86d143db6523..89424da76244 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -118,6 +118,9 @@ struct clocksource {
 	u64			wd_last;
 #endif
 	struct module		*owner;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs;
+#endif
 };
 
 /*
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 7cb09c4cf21c..51266f53df83 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -911,6 +911,63 @@ void __clocksource_update_freq_scale(struct clocksource *cs, u32 scale, u32 freq
 }
 EXPORT_SYMBOL_GPL(__clocksource_update_freq_scale);
 
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+static struct dentry *debugfs_root;
+
+static int clocksource_debugfs_counter_show(struct seq_file *s, void *data)
+{
+	struct clocksource *cs = s->private;
+
+	seq_printf(s, "%llu\n", cs->read(cs));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(clocksource_debugfs_counter);
+
+static void clocksource_debugfs_add(struct clocksource *cs)
+{
+	if (!debugfs_root)
+		return;
+
+	cs->debugfs = debugfs_create_dir(cs->name, debugfs_root);
+
+	debugfs_create_file("counter", 0444, cs->debugfs, cs,
+			    &clocksource_debugfs_counter_fops);
+}
+
+static void clocksource_debugfs_remove(struct clocksource *cs)
+{
+	debugfs_remove_recursive(cs->debugfs);
+}
+
+static int __init init_clocksource_debugfs(void)
+{
+	struct clocksource *cs;
+
+	debugfs_root = debugfs_create_dir("clocksource", NULL);
+
+	mutex_lock(&clocksource_mutex);
+
+	list_for_each_entry(cs, &clocksource_list, list)
+		clocksource_debugfs_add(cs);
+
+	mutex_unlock(&clocksource_mutex);
+
+	return 0;
+}
+late_initcall(init_clocksource_debugfs);
+#else
+static inline void clocksource_debugfs_add(struct clocksource *cs)
+{
+}
+
+static inline void clocksource_debugfs_remove(struct clocksource *cs)
+{
+}
+#endif
+
 /**
  * __clocksource_register_scale - Used to install new clocksources
  * @cs:		clocksource to be registered
@@ -951,6 +1008,7 @@ int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
 	clocksource_select();
 	clocksource_select_watchdog(false);
 	__clocksource_suspend_select(cs);
+	clocksource_debugfs_add(cs);
 	mutex_unlock(&clocksource_mutex);
 	return 0;
 }
@@ -991,6 +1049,8 @@ static int clocksource_unbind(struct clocksource *cs)
 {
 	unsigned long flags;
 
+	clocksource_debugfs_remove(cs);
+
 	if (clocksource_is_watchdog(cs)) {
 		/* Select and try to install a replacement watchdog. */
 		clocksource_select_watchdog(true);
-- 
2.24.1

