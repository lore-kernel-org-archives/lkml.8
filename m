Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F58C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1E12084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgBDM3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 07:29:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbgBDM3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 07:29:03 -0500
Received: from oasis.local.home (unknown [212.187.182.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22E342084E;
        Tue,  4 Feb 2020 12:29:00 +0000 (UTC)
Date:   Tue, 4 Feb 2020 07:28:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] tracing: Changes for 5.6
Message-ID: <20200204072856.0da60613@oasis.local.home>
In-Reply-To: <CAHk-=wjfjO+h6bQzrTf=YCZA53Y3EDyAs3Z4gEsT7icA3u_Psw@mail.gmail.com>
References: <20200204053155.127c3f1e@oasis.local.home>
        <CAHk-=wjfjO+h6bQzrTf=YCZA53Y3EDyAs3Z4gEsT7icA3u_Psw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2020 11:54:09 +0000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Feb 4, 2020 at 10:32 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >  - Added new "bootconfig".
> >    Looks for a file appended to initrd to add boot config options.
> >    This has been discussed thoroughly at Linux Plumbers.
> >    Very useful for adding kprobes at bootup.  
> 
> Is there a way to disable this from the "real" kernel command line?

Currently no.

> 
> If I have problems, I want to boot with a known kernel command line
> (forcing text mode etc). If the bootconfig file always gets parsed,
> there's no way to do that from the bootloader (grub2, whatever)..
> 

I totally agree as I had that exact same issue while testing this. I
wanted to not have it and found it a bit annoying I needed to modify
the initrd to remove it for just a single boot up.

Would this work?

-- Steve

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
