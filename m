Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F58C47247
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2A0214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgEILOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 07:14:48 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:34579 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgEILOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:14:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436316|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0620642-0.00271633-0.935219;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16367;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.HVopGr-_1589022874;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.HVopGr-_1589022874)
          by smtp.aliyun-inc.com(10.147.44.129);
          Sat, 09 May 2020 19:14:40 +0800
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH v5 01/12] printk: pstore: Introduce kmsg_dump_reason_str()
Date:   Sat,  9 May 2020 19:14:03 +0800
Message-Id: <1589022854-19821-2-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589022854-19821-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1589022854-19821-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

The pstore subsystem already had a private version of this function.
With the coming addition of the pstore/zone driver, this needs to be
shared. As it really should live with printk, move it there instead.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/platform.c      | 22 +---------------------
 include/linux/kmsg_dump.h |  7 +++++++
 kernel/printk/printk.c    | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index b882919b8784..4fb8ec9f3a1c 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -130,26 +130,6 @@ enum pstore_type_id pstore_name_to_type(const char *name)
 }
 EXPORT_SYMBOL_GPL(pstore_name_to_type);
 
-static const char *get_reason_str(enum kmsg_dump_reason reason)
-{
-	switch (reason) {
-	case KMSG_DUMP_PANIC:
-		return "Panic";
-	case KMSG_DUMP_OOPS:
-		return "Oops";
-	case KMSG_DUMP_EMERG:
-		return "Emergency";
-	case KMSG_DUMP_RESTART:
-		return "Restart";
-	case KMSG_DUMP_HALT:
-		return "Halt";
-	case KMSG_DUMP_POWEROFF:
-		return "Poweroff";
-	default:
-		return "Unknown";
-	}
-}
-
 static void pstore_timer_kick(void)
 {
 	if (pstore_update_ms < 0)
@@ -402,7 +382,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 	unsigned int	part = 1;
 	int		ret;
 
-	why = get_reason_str(reason);
+	why = kmsg_dump_reason_str(reason);
 
 	if (down_trylock(&psinfo->buf_lock)) {
 		/* Failed to acquire lock: give up if we cannot wait. */
diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index cfc042066be7..b3ddb0b2ee40 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -72,6 +72,8 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 int kmsg_dump_register(struct kmsg_dumper *dumper);
 
 int kmsg_dump_unregister(struct kmsg_dumper *dumper);
+
+const char *kmsg_dump_reason_str(enum kmsg_dump_reason reason);
 #else
 static inline void kmsg_dump(enum kmsg_dump_reason reason)
 {
@@ -113,6 +115,11 @@ static inline int kmsg_dump_unregister(struct kmsg_dumper *dumper)
 {
 	return -EINVAL;
 }
+
+static inline const char *kmsg_dump_reason_str(enum kmsg_dump_reason reason)
+{
+	return "Disabled";
+}
 #endif
 
 #endif /* _LINUX_KMSG_DUMP_H */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1aab69a8a2bf..67a284830d74 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3144,6 +3144,27 @@ int kmsg_dump_unregister(struct kmsg_dumper *dumper)
 static bool always_kmsg_dump;
 module_param_named(always_kmsg_dump, always_kmsg_dump, bool, S_IRUGO | S_IWUSR);
 
+const char *kmsg_dump_reason_str(enum kmsg_dump_reason reason)
+{
+	switch (reason) {
+	case KMSG_DUMP_PANIC:
+		return "Panic";
+	case KMSG_DUMP_OOPS:
+		return "Oops";
+	case KMSG_DUMP_EMERG:
+		return "Emergency";
+	case KMSG_DUMP_RESTART:
+		return "Restart";
+	case KMSG_DUMP_HALT:
+		return "Halt";
+	case KMSG_DUMP_POWEROFF:
+		return "Poweroff";
+	default:
+		return "Unknown";
+	}
+}
+EXPORT_SYMBOL_GPL(kmsg_dump_reason_str);
+
 /**
  * kmsg_dump - dump kernel log to kernel message dumpers.
  * @reason: the reason (oops, panic etc) for dumping
-- 
1.9.1

