Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4660C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EC52051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UffnQYQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgCPOkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:40:16 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39697 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731551AbgCPOkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:40:15 -0400
Received: by mail-pj1-f67.google.com with SMTP id d8so8807475pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/gCbAp+H9Fc7JriqMdSSF6E8ktWavqK5+A0swN3ZDc=;
        b=UffnQYQrX4Gsz0le1JAUkNrEskhQYyMx9aVo6pv/sYzRbgsZ9Ie846Y+l+3ziU4DdR
         3CjCVS5kj+n3OdYgO4/HMMJIpRVeB/J8l1u+khYQcffFkGJy+FMZwW2yEjCJN/L84LiA
         MHrkzGrtCj9mIrHJAhMGwtJnD1aZyQb1Bi6etSTY258uU/ugk25xkkG/W29Dq+iTh6Dl
         VkFSfrGBRRzkn4HEBoD5ktZJd0jABrCLp0yAD7j0Ig19xr+bvMve/rE6NL+0AxPQmxOc
         PBKBcOfuC3RhsqLSe5kwzjpZQnGXTfzxONLW634aqtTK/ZGy2gcwaaEYFOcQz/zw4MVL
         6LOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/gCbAp+H9Fc7JriqMdSSF6E8ktWavqK5+A0swN3ZDc=;
        b=oIeCgiN0ABA+PZjIq3+OaunbFmmODC7wyAYIU0v8LG4qXejKtmgoP0vIYUg7buzYCQ
         0bFUvb+rZg3wmVN9DDl58i19jW+KrM7CvXTrjNRgpxcRhCDuZwwXS8kD0smOlEtYAs47
         bkI78qYOS6hjJx1qlnaUS4Fx3KtwZSGSpDZnlf07cG75fowew3XvXTcCrGi/BkwN5DF5
         4fCgyGvuwVNJB2mCiwZhTL3oqs/6QHmfwdqnUOoAK0q1sYEvbRC5/7Nh/QaOoHaAC3hS
         6IlM+nZDdTKhoA135LMP0NVy+zO0DY84lGNERjHwtEMg64mnbEtdqZ93XKC2tbtRVinK
         awPA==
X-Gm-Message-State: ANhLgQ1fjcMLjLFgrrxipKtLFVVo1WM+cKIMbhLSxf1UEqa52mugwOk0
        L0/31us2HmcMqQe+do4DRkUpYS7EnurwkA==
X-Google-Smtp-Source: ADFU+vuP+9D4s7GPz8or+QCMJaQtRjQgHTDwkRUFWwBShfCJpkUaUxI2cOrbtLoyolvwdTEEMYe9tA==
X-Received: by 2002:a17:90a:36c7:: with SMTP id t65mr25183358pjb.182.1584369614252;
        Mon, 16 Mar 2020 07:40:14 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:40:13 -0700 (PDT)
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
Subject: [PATCHv2 07/50] arm: Wire up dump_backtrace_{entry,stm}
Date:   Mon, 16 Mar 2020 14:38:33 +0000
Message-Id: <20200316143916.195608-8-dima@arista.com>
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

Now that c_backtrace() always emits correct loglvl, use it for printing.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: clang-built-linux@googlegroups.com
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/kernel/traps.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 0f09ace18e6c..e1be6c85327c 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -68,13 +68,15 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
 	unsigned long end = frame + 4 + sizeof(struct pt_regs);
 
 #ifdef CONFIG_KALLSYMS
-	printk("[<%08lx>] (%ps) from [<%08lx>] (%pS)\n", where, (void *)where, from, (void *)from);
+	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
+		loglvl, where, (void *)where, from, (void *)from);
 #else
-	printk("Function entered at [<%08lx>] from [<%08lx>]\n", where, from);
+	printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
+		loglvl, where, from);
 #endif
 
 	if (in_entry_text(from) && end <= ALIGN(frame, THREAD_SIZE))
-		dump_mem("", "Exception stack", frame + 4, end);
+		dump_mem(loglvl, "Exception stack", frame + 4, end);
 }
 
 void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
@@ -89,12 +91,12 @@ void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
 			if (++x == 6) {
 				x = 0;
 				p = str;
-				printk("%s\n", str);
+				printk("%s%s\n", loglvl, str);
 			}
 		}
 	}
 	if (p != str)
-		printk("%s\n", str);
+		printk("%s%s\n", loglvl, str);
 }
 
 #ifndef CONFIG_ARM_UNWIND
-- 
2.25.1

