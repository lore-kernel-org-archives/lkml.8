Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AFDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34C28204EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgESD3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 23:29:50 -0400
Received: from mail-m1271.qiye.163.com ([115.236.127.1]:15308 "EHLO
        mail-m1271.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgESD3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 23:29:50 -0400
Received: from SZ11061793 (unknown [58.251.74.226])
        by mail-m1271.qiye.163.com (Hmail) with ESMTPA id 0048E582472;
        Tue, 19 May 2020 11:29:46 +0800 (CST)
From:   =?gb2312?B?zfWzzLjV?= <wangchenggang@vivo.com>
To:     "'Masami Hiramatsu'" <mhiramat@kernel.org>,
        "'Steven Rostedt \(VMware'" <rostedt@goodmis.org>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Kees Cook'" <keescook@chromium.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Dominik Brodowski'" <linux@dominikbrodowski.net>,
        "'Arvind Sankar'" <nivedita@alum.mit.edu>,
        "'Mike Rapoport'" <rppt@linux.ibm.com>,
        "'Alexander Potapenko'" <glider@google.com>,
        <linux-kernel@vger.kernel.org>
Cc:     <kernel@vivo.com>
Subject: [PATCH] init/main.c: Print all command line when boot
Date:   Tue, 19 May 2020 11:29:46 +0800
Message-ID: <010201d62d8d$bf7605f0$3e6211d0$@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdYtjIsiN79CRE3nQBWNrTxxhAKwaQ==
Content-Language: zh-cn
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VPTU9LS0tJSU5LTUxKT1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSI6DCo6Dzg3ESsMPTYJCEIz
        AwsaFA5VSlVKTkNCQ05DQkNMQk1NVTMWGhIXVQwaFRwYEx4VHBwaFRw7DRINFFUYFBZFWVdZEgtZ
        QVlOQ1VJTkpVTE9VSUlNWVdZCAFZQUlDTkM3Bg++
X-HM-Tid: 0a722afaef3798b6kuuu0048e582472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function pr_notice print max length maybe less than the command line length,
need more times to print all.
For example, arm64 has 2048 bytes command line length, but printk maximum
length is only 1024 bytes.

Signed-off-by: Chenggang Wang <wangchenggang@vivo.com>
---
 init/main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 03371976d387..4cf676cc3305 100644
--- a/init/main.c
+++ b/init/main.c
@@ -825,6 +825,16 @@ void __init __weak arch_call_rest_init(void)
 	rest_init();
 }
 
+static void __init print_cmdline(void)
+{
+	const char *prefix = "Kernel command line: ";
+	int len = -strlen(prefix);
+
+	len += pr_notice("%s%s\n", prefix, boot_command_line);
+	while (boot_command_line[len])
+		len += pr_notice("%s\n", &boot_command_line[len]);
+}
+
 asmlinkage __visible void __init start_kernel(void)
 {
 	char *command_line;
@@ -858,7 +868,7 @@ asmlinkage __visible void __init start_kernel(void)
 	build_all_zonelists(NULL);
 	page_alloc_init();
 
-	pr_notice("Kernel command line: %s\n", saved_command_line);
+	print_cmdline();
 	/* parameters may set static keys */
 	jump_label_init();
 	parse_early_param();
-- 
2.20.1

