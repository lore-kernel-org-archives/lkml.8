Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F7EC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C422051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LVJn6OFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbgCPOmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:42:03 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54932 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731623AbgCPOmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:42:03 -0400
Received: by mail-pj1-f68.google.com with SMTP id np9so1809217pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oWxFx/406yUtg30SmusrySPoRRB+gbnvcdB7/TuVNY4=;
        b=LVJn6OFWIwdfSJqraQpbC9t2GFVTP2yTPPGTuFDD9Rg9bV5pgOEjCrw67icPccDEqu
         NRz439tlTw0uYeHqV0x2EM1uSIcQytLoGUck82lenO2Cs7rxaQUtmpuQJAnla/OkCeEJ
         dGA8b+JEreuY+MoEdic5vN6eb/xQIaQATJ+FJ2Wz7pnGE0rj+BYf4a3vIEKNYsGwlGhl
         wzxsha5smMLBTUY4Faj2+VziE2O6HX9HmUoaQGntfUJZg5uXYpY4QTvjEsjDUhuPs+8e
         rbLOHE+687dNky3pO9sYxIF1u8m1p+CIpSvlW0fUg4OdnTdpnlqd2iIb5UH96EDno/Qp
         foug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oWxFx/406yUtg30SmusrySPoRRB+gbnvcdB7/TuVNY4=;
        b=W79SlRJK2rgCld0eMiS89qNE4udHC126n2qFuHTuvMsCG2JZbnkIxf9n9BvQoG4q18
         WNefzVzZaIbMFD+UlPKmM0raP6SnuU3epU/JfUAG5AtfqXPdcFnpnKJmQgig7PlptrhG
         LnOcie6FhZdLOIGFF/sbBKym5CxU3LaM0VSLjcawovQX/4upRffetcICDah5B4ModApX
         h6ZQfDK1SHs70UZQzBBCsC6NGR84mVvBW83QvRGMNm914rvvHLmxKMfyJRXi3ZCePksD
         zpI8vbSqXtAIRJNwVS2pmLsX0r/voo7ihfgw6hvpm+wb59UIRyD2jZsic59eIfmS5eNQ
         68Qg==
X-Gm-Message-State: ANhLgQ3oSyHDM7b0HL6HnuQH6M9CoATioZflfL32UWueJ5rtDfh5VuR5
        whWwjnVUW9hLpDOqEry/LnAK9SpgiALlcg==
X-Google-Smtp-Source: ADFU+vs5Sq1T1bEl12/cwahVNmRAdQ5sYMKn0UKTwB2nu8sLgr8lgSz5w+gh4TdVyTiwcbYHnluLLg==
X-Received: by 2002:a17:902:7248:: with SMTP id c8mr27417817pll.282.1584369721428;
        Mon, 16 Mar 2020 07:42:01 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:42:00 -0700 (PDT)
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
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCHv2 31/50] sh: Add loglvl to printk_address()
Date:   Mon, 16 Mar 2020 14:38:57 +0000
Message-Id: <20200316143916.195608-32-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Add log level argument to printk_address() as a preparation to introduce
show_stack_loglvl().

As a good side-effect show_fault_oops() now prints the address with
KERN_EMREG as the rest of output, making sure there won't be situation
where "PC: " is printed without actual address.

Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sh/include/asm/kdebug.h | 3 ++-
 arch/sh/kernel/dumpstack.c   | 6 +++---
 arch/sh/mm/fault.c           | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/sh/include/asm/kdebug.h b/arch/sh/include/asm/kdebug.h
index de8693fabb1d..960545306afa 100644
--- a/arch/sh/include/asm/kdebug.h
+++ b/arch/sh/include/asm/kdebug.h
@@ -12,7 +12,8 @@ enum die_val {
 };
 
 /* arch/sh/kernel/dumpstack.c */
-extern void printk_address(unsigned long address, int reliable);
+extern void printk_address(unsigned long address, int reliable,
+			   const char *loglvl);
 extern void dump_mem(const char *str, const char *loglvl,
 		     unsigned long bottom, unsigned long top);
 
diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index 2c1a78e5776b..959064b90055 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -44,9 +44,9 @@ void dump_mem(const char *str, const char *loglvl,
 	}
 }
 
-void printk_address(unsigned long address, int reliable)
+void printk_address(unsigned long address, int reliable, const char *loglvl)
 {
-	printk(" [<%p>] %s%pS\n", (void *) address,
+	printk("%s [<%p>] %s%pS\n", loglvl, (void *) address,
 			reliable ? "" : "? ", (void *) address);
 }
 
@@ -118,7 +118,7 @@ static int print_trace_stack(void *data, char *name)
  */
 static void print_trace_address(void *data, unsigned long addr, int reliable)
 {
-	printk_address(addr, reliable);
+	printk_address(addr, reliable, (char *)data);
 }
 
 static const struct stacktrace_ops print_trace_ops = {
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 5f51456f4fc7..b11f0c5e65b6 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -196,7 +196,7 @@ show_fault_oops(struct pt_regs *regs, unsigned long address)
 
 	printk(KERN_CONT " at %08lx\n", address);
 	printk(KERN_ALERT "PC:");
-	printk_address(regs->pc, 1);
+	printk_address(regs->pc, 1, KERN_ALERT);
 
 	show_pte(NULL, address);
 }
-- 
2.25.1

