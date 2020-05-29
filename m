Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6444C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A6520810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590738097;
	bh=JPQWPDE/TFDKT6e4ySQoca+im2JdIAEs38ORW23QNdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vPA0OOC0R0bGHe4CApbDqRDKyMnsh+aFrL5YeIa3fuAxvrsB9PE5JQ68Gks6O0IUx
	 cGWG1P53KW95EsCijSzV7d3XzS/Jz6TGGA705KNreybfMwVHeuGDOXBD9SI0FOq3Vq
	 KefmZ4xudSqyfIraQZz8aiqAaH4PSTCzaaxnuujk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgE2Hlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:41:36 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56179 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgE2HlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:41:24 -0400
Received: by mail-pj1-f68.google.com with SMTP id fs4so842147pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OeMaeWf8ySHfvuEzWncwhX9a4D5s1xQoEDO3/r/aYzY=;
        b=bk/TwDkPhUwRTuDo1BiLCTnijOXGO7FgunHfSDR6T9o5XFzCWeA7KTBziazW5M1eJp
         ywCbN4o995uhzy6xHwoky9sMQCjNnW4BpRz2j3vFRg7WXbvp1XHHjHMn6OXRv4Gwyspb
         jC+6vkMka4Vi93FxxOvTPcLP9dyv1I2zoMm/xe2j9gn93T9f82D0Sh2J5wzwwE0q0x+w
         ICAbxI21yvedjSCi6/rNCMOyKbCciWOxUXGCOlXJ0ACcje/M65brUf1XsM/kqjTm0K6N
         AxQboNI6HnvwaRlqoqBQMByDCR7PRD3m5FDjGN3qrhACVriXQt48tTplkrIg2Hkos3/v
         Ga/Q==
X-Gm-Message-State: AOAM531jxU7PlmDSd6rLh2a6+jGMjB1oygKvykeA74I3rnJqo/5D///r
        sS3j2b++kqtYU6eXkcfxyAU=
X-Google-Smtp-Source: ABdhPJyZTqVeXpnC780yNsYcAysPbnmEI2o7s7rzYFo+LKi1oKtcOEgW9W/Zd68h1pyiVT90AxPOjw==
X-Received: by 2002:a17:90a:2807:: with SMTP id e7mr7981405pjd.6.1590738083514;
        Fri, 29 May 2020 00:41:23 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id jx10sm6903511pjb.46.2020.05.29.00.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:41:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DDE9C42376; Fri, 29 May 2020 07:41:10 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, axboe@kernel.dk, clemens@ladisch.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        benh@kernel.crashing.org, rdna@fb.com, viro@zeniv.linux.org.uk,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        vbabka@suse.cz, sfr@canb.auug.org.au, jack@suse.cz,
        amir73il@gmail.com, rafael@kernel.org, tytso@mit.edu
Cc:     julia.lawall@lip6.fr, akpm@linux-foundation.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 09/13] firmware_loader: simplify sysctl declaration with register_sysctl_subdir()
Date:   Fri, 29 May 2020 07:41:04 +0000
Message-Id: <20200529074108.16928-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200529074108.16928-1-mcgrof@kernel.org>
References: <20200529074108.16928-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoming Ni <nixiaoming@huawei.com>

Move the firmware config sysctl table to fallback_table.c and use the
new register_sysctl_subdir() helper. This removes the clutter from
kernel/sysctl.c.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback.c       |  4 ++++
 drivers/base/firmware_loader/fallback.h       | 11 ++++++++++
 drivers/base/firmware_loader/fallback_table.c | 22 +++++++++++++++++--
 include/linux/sysctl.h                        |  1 -
 kernel/sysctl.c                               |  7 ------
 5 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index d9ac7296205e..8190653ae9a3 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -200,12 +200,16 @@ static struct class firmware_class = {
 
 int register_sysfs_loader(void)
 {
+	int ret = register_firmware_config_sysctl();
+	if (ret != 0)
+		return ret;
 	return class_register(&firmware_class);
 }
 
 void unregister_sysfs_loader(void)
 {
 	class_unregister(&firmware_class);
+	unregister_firmware_config_sysctl();
 }
 
 static ssize_t firmware_loading_show(struct device *dev,
diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
index 06f4577733a8..7d2cb5f6ceb8 100644
--- a/drivers/base/firmware_loader/fallback.h
+++ b/drivers/base/firmware_loader/fallback.h
@@ -42,6 +42,17 @@ void fw_fallback_set_default_timeout(void);
 
 int register_sysfs_loader(void);
 void unregister_sysfs_loader(void);
+#ifdef CONFIG_SYSCTL
+extern int register_firmware_config_sysctl(void);
+extern void unregister_firmware_config_sysctl(void);
+#else
+static inline int register_firmware_config_sysctl(void)
+{
+	return 0;
+}
+static inline void unregister_firmware_config_sysctl(void) { }
+#endif /* CONFIG_SYSCTL */
+
 #else /* CONFIG_FW_LOADER_USER_HELPER */
 static inline int firmware_fallback_sysfs(struct firmware *fw, const char *name,
 					  struct device *device,
diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
index 46a731dede6f..4234aa5ee5df 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -24,7 +24,7 @@ struct firmware_fallback_config fw_fallback_config = {
 EXPORT_SYMBOL_NS_GPL(fw_fallback_config, FIRMWARE_LOADER_PRIVATE);
 
 #ifdef CONFIG_SYSCTL
-struct ctl_table firmware_config_table[] = {
+static struct ctl_table firmware_config_table[] = {
 	{
 		.procname	= "force_sysfs_fallback",
 		.data		= &fw_fallback_config.force_sysfs_fallback,
@@ -45,4 +45,22 @@ struct ctl_table firmware_config_table[] = {
 	},
 	{ }
 };
-#endif
+
+static struct ctl_table_header *hdr;
+int register_firmware_config_sysctl(void)
+{
+	if (hdr)
+		return -EEXIST;
+	hdr = register_sysctl_subdir("kernel", "firmware_config",
+				     firmware_config_table);
+	if (!hdr)
+		return -ENOMEM;
+	return 0;
+}
+
+void unregister_firmware_config_sysctl(void)
+{
+	if (hdr)
+		unregister_sysctl_table(hdr);
+}
+#endif /* CONFIG_SYSCTL */
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 58bc978d4f03..aa01f54d0442 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -217,7 +217,6 @@ extern int no_unaligned_warning;
 
 extern struct ctl_table sysctl_mount_point[];
 extern struct ctl_table random_table[];
-extern struct ctl_table firmware_config_table[];
 extern struct ctl_table epoll_table[];
 
 #else /* CONFIG_SYSCTL */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 30c2d521502a..e007375c8a11 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2088,13 +2088,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0555,
 		.child		= usermodehelper_table,
 	},
-#ifdef CONFIG_FW_LOADER_USER_HELPER
-	{
-		.procname	= "firmware_config",
-		.mode		= 0555,
-		.child		= firmware_config_table,
-	},
-#endif
 	{
 		.procname	= "overflowuid",
 		.data		= &overflowuid,
-- 
2.26.2

