Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBC2C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9543320674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="CZszvrzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbgCPOkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:40:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39686 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731653AbgCPOkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:40:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id j20so8098103pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QHtnMaoK5O9FegkpkkwNmoxCiRNZGD2z9MaeDc0+/xc=;
        b=CZszvrzmIRvERN2PlRfmNYaxq7wc0KrRfRp+ZUcwArxYqFLQDjiJyKC0N3hjkUHKKz
         HaU/VFm68qpJWzdHlhTZHI5ax7L23gtlENHvgWiRZmTlFvS6VVKkekfJ+OWUot4LKwAz
         V1RTs/vDsTw9ZUxE9K8lwEMCNWIWS7T3Giko+Vvy+YsAAnc4tM5wptSLlXVpIYQLe+zs
         ocnbJoahMUAwCosYsTR1CeARHLJE3nNy26/UAQHvAinQ8kTGLjY/sA6ypsPDk+pshlCi
         YTjCevn2ykVc4DODRIutQNGktScrUEwI/gcH02xw4H7+Nr7swysCIKXWySAPQdJcZWvI
         GhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QHtnMaoK5O9FegkpkkwNmoxCiRNZGD2z9MaeDc0+/xc=;
        b=TbXSmZDkqWEgHogJ76c3zfBURL1iP2XgfOf/8cbxRGCDMBsT7VFUWrZrZlf60NBuS+
         GNffC342AdwpnURGzsHKnOF3x20NOpqf4cjapTYkNelT25/MDUHwDaSZXVxyqHncmKUy
         JW7gsxqyOEN0Aj8TE2PhyyonPYQV8EzK4pVgJICyTUrXZ7b/M521uqXqAk2TeuUEOmMh
         7nVB8u/iKf2q3BiYLcfeWFfIHMf6xAKGmLk+wEZwczC3wik1ZLc2h1ul1iq3TpJbxYDO
         qUIJ6qTavvm9knAm1SXXyeW5crlSijRq8QSqWCHKrJtfPbbH5QK1dZOcaoAl/Mg7n86u
         L8Ng==
X-Gm-Message-State: ANhLgQ0v4+Zb6AknYKUGVu6dg0Hchw2pLd4nQivuZNgEnQ53vKDYyCC6
        T4mwRTUlQtQ6XNASYcEiNqKaqRX38sWR/A==
X-Google-Smtp-Source: ADFU+vuv0p+9CyDCn7sGloFjTFfHxbeMZbOZDt3pRLhru+RDD2KBw7DzGtWo4ZzXWPme/uj8Q70fIQ==
X-Received: by 2002:a17:90a:2a89:: with SMTP id j9mr25550721pjd.64.1584369618925;
        Mon, 16 Mar 2020 07:40:18 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:40:18 -0700 (PDT)
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
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com
Subject: [PATCHv2 08/50] arm: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:34 +0000
Message-Id: <20200316143916.195608-9-dima@arista.com>
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

Introduce show_stack_loglvl(), that eventually will substitute
show_stack().

Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: clang-built-linux@googlegroups.com
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/kernel/traps.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index e1be6c85327c..00455b5bbf8a 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -247,12 +247,18 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 }
 #endif
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
+		       const char *loglvl)
 {
-	dump_backtrace(NULL, tsk, KERN_DEFAULT);
+	dump_backtrace(NULL, tsk, loglvl);
 	barrier();
 }
 
+void show_stack(struct task_struct *tsk, unsigned long *sp)
+{
+	show_stack_loglvl(tsk, sp, KERN_DEFAULT);
+}
+
 #ifdef CONFIG_PREEMPT
 #define S_PREEMPT " PREEMPT"
 #elif defined(CONFIG_PREEMPT_RT)
-- 
2.25.1

