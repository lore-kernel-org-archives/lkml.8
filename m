Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0232EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19A62087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgBDMnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 07:43:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbgBDMni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 07:43:38 -0500
Received: from oasis.local.home (unknown [212.187.182.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E182A2082E;
        Tue,  4 Feb 2020 12:43:34 +0000 (UTC)
Date:   Tue, 4 Feb 2020 07:43:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] bootconfig: Add "disable_bootconfig" cmdline option to
 disable bootconfig
Message-ID: <20200204074330.1e7cd4db@oasis.local.home>
In-Reply-To: <20200204072856.0da60613@oasis.local.home>
References: <20200204053155.127c3f1e@oasis.local.home>
        <CAHk-=wjfjO+h6bQzrTf=YCZA53Y3EDyAs3Z4gEsT7icA3u_Psw@mail.gmail.com>
        <20200204072856.0da60613@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As the bootconfig is appended to the initrd it is not as easy to modify as
the kernel command line. If there's some issue with the kernel, and the
developer wants to boot a pristine kernel, it should not be needed to modify
the initrd to remove the bootconfig for a single boot.

A "disable_bootconfig" kernel command line option solves this. If
"disable_bootconfig" is found on the kernel command line, then the
bootconfig file that may be attached to the initrd will not be parsed.

Link: https://lore.kernel.org/r/CAHk-=wjfjO+h6bQzrTf=YCZA53Y3EDyAs3Z4gEsT7icA3u_Psw@mail.gmail.com

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 init/main.c                                     | 14 +++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..c4f1417f1934 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -857,6 +857,10 @@
                 on      Perform hardened usercopy checks (default).
                 off     Disable hardened usercopy checks.
 
+	disable_bootconfig
+			Disable reading the bootconfig that may be attached
+			to the initrd.
+
 	disable_radix	[PPC]
 			Disable RADIX MMU mode on POWER9
 
diff --git a/init/main.c b/init/main.c
index dd7da62d99a5..b52636cd9c1d 100644
--- a/init/main.c
+++ b/init/main.c
@@ -336,15 +336,23 @@ u32 boot_config_checksum(unsigned char *p, u32 size)
 	return ret;
 }
 
-static void __init setup_boot_config(void)
+static void __init setup_boot_config(const char *cmdline)
 {
 	u32 size, csum;
 	char *data, *copy;
+	const char *p;
 	u32 *hdr;
 
 	if (!initrd_end)
 		return;
 
+	p = strstr(cmdline, "disable_bootconfig");
+	if (p && (p == cmdline || isspace(*(p-1))) &&
+	    (!p[18] || isspace(p[18]))) {
+		pr_info("Disabling bootconfig because 'disable_bootconfig' found on the command line\n");
+		return;
+	}
+
 	hdr = (u32 *)(initrd_end - 8);
 	size = hdr[0];
 	csum = hdr[1];
@@ -379,7 +387,7 @@ static void __init setup_boot_config(void)
 	}
 }
 #else
-#define setup_boot_config()	do { } while (0)
+#define setup_boot_config(cmdline)	do { } while (0)
 #endif
 
 /* Change NUL term back to "=", to make "param" the whole string. */
@@ -760,7 +768,7 @@ asmlinkage __visible void __init start_kernel(void)
 	pr_notice("%s", linux_banner);
 	early_security_init();
 	setup_arch(&command_line);
-	setup_boot_config();
+	setup_boot_config(command_line);
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
 	setup_per_cpu_areas();
-- 
2.20.1

