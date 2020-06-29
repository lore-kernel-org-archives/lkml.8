Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791EDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD4D206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Jal2PwFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbgF2TjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387437AbgF2Thn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:37:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D06C02F00B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:48:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so15657828wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U9kIWLeBNmIRQf5BoQCoOxHjEb/diR5405BJuiyer9U=;
        b=Jal2PwFX9BEL/CwslELaOFzJQot+F9t/UtDEnmU710ULO3x0tcGIOQuZENZEVbt53F
         KDY9jOc02pX6Uc5vORmAvShIJOCfuSwL1GXV2+w8xopav15DoaejsmhUVQfe9x284fsH
         fyPKXcKGjeBjme/K64XCdjqQa1YXMmnb2p9pCbYg7wvEu19PilS+sg1LL3IcxuWT+aH4
         KWFaLDc6/MOGeZwrI/eD4dguPNr5e5/KXC0MaIOdjj8LUrHYX2pv5bkK7w9Luhj+YbEs
         JpOS5KaLeDcKfRLM7q2fetLj3cmX86xmXFgWiHhK31XiQPeC7z4EK4xWDKv9WcEiJghW
         0StQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U9kIWLeBNmIRQf5BoQCoOxHjEb/diR5405BJuiyer9U=;
        b=c+6fSR9G8Z6N986RQ23BWOQt7/LKauM7POBTgKP9n0lSZf/abq51KCxVhx0JlcNCaY
         SzVDF7eK/Ghe0AFV8FcvwxmV1N2JXltUs/YAqIgCH3coV02hFK70O/hVWe/SLvPmf7Ya
         lo9A3Zmc+TYsjtPIH9QR2TqGkxnlQC7K5pglynVGo6qovpLa+w3UyEzM/jow6Rcww/8+
         Kk3SC+pIvb9PSNVGe/LKrx6f/afZWdFo9zHsVDnCIQLBTL7V7WjefmZgXyP3C/rvEkVd
         R42nN5giTRS9atHQPlG5s1tKfhwEmp6Px0cG6KfiCBw2QFkSuHqffje6Cv99UQCptCMO
         WoAQ==
X-Gm-Message-State: AOAM533iXtWJs2V4ZldoDgG+2RGG+xTYdFfnxDJ83hyWMvyclAqhT6MB
        Q2mFP501i6TfEF6mo3XSgcnhLhqf2XMMQg==
X-Google-Smtp-Source: ABdhPJwUDLoF2+28/SV+ieEvc+RCmASXJsFxt+k+4wktO1E5xs2buwarU4w9RN6KgSfnfvYRZhtXMA==
X-Received: by 2002:a1c:345:: with SMTP id 66mr2055548wmd.31.1593442133291;
        Mon, 29 Jun 2020 07:48:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id s8sm42786336wru.38.2020.06.29.07.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:48:52 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH v2 3/3] x86/dumpstack: Show registers dump with trace's log level
Date:   Mon, 29 Jun 2020 15:48:47 +0100
Message-Id: <20200629144847.492794-4-dima@arista.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629144847.492794-1-dima@arista.com>
References: <20200629144847.492794-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show_trace_log_lvl() provides x86 platform-specific way to unwind
backtrace with a given log level. Unfortunately, registers dump(s) are
not printed with the same log level - instead, KERN_DEFAULT is always
used.

Arista's switches uses quite common setup with rsyslog, where only
urgent messages goes to console (console_log_level=KERN_ERR), everything
else goes into /var/log/ as the console baud-rate often is indecently
slow (9600 bps).

Backtrace dumps without registers printed have proven to be as useful as
morning standups. Furthermore, in order to introduce KERN_UNSUPPRESSED
(which I believe is still the most elegant way to fix raciness of sysrq[1])
the log level should be passed down the stack to register dumping
functions. Besides, I have a potential use-case for printing traces
with KERN_DEBUG level [2] (where registers dump shouldn't appear with
higher log level).

After all preparations are done, provide log_lvl parameter for
show_regs_if_on_stack() and wire up to actual log level used as
an argument for show_trace_log_lvl().

[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/
[2]: https://lore.kernel.org/linux-doc/20190724170249.9644-1-dima@arista.com/
Acked-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/kernel/dumpstack.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 4954d6678cef..f9a3526af15d 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -134,7 +134,7 @@ void show_iret_regs(struct pt_regs *regs, const char *log_lvl)
 }
 
 static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
-				  bool partial)
+				  bool partial, const char *log_lvl)
 {
 	/*
 	 * These on_stack() checks aren't strictly necessary: the unwind code
@@ -146,7 +146,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 	 * they can be printed in the right context.
 	 */
 	if (!partial && on_stack(info, regs, sizeof(*regs))) {
-		__show_regs(regs, SHOW_REGS_SHORT, KERN_DEFAULT);
+		__show_regs(regs, SHOW_REGS_SHORT, log_lvl);
 
 	} else if (partial && on_stack(info, (void *)regs + IRET_FRAME_OFFSET,
 				       IRET_FRAME_SIZE)) {
@@ -155,7 +155,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 		 * full pt_regs might not have been saved yet.  In that case
 		 * just print the iret frame.
 		 */
-		show_iret_regs(regs, KERN_DEFAULT);
+		show_iret_regs(regs, log_lvl);
 	}
 }
 
@@ -210,7 +210,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			printk("%s <%s>\n", log_lvl, stack_name);
 
 		if (regs)
-			show_regs_if_on_stack(&stack_info, regs, partial);
+			show_regs_if_on_stack(&stack_info, regs, partial, log_lvl);
 
 		/*
 		 * Scan the stack, printing any text addresses we find.  At the
@@ -271,7 +271,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			/* if the frame has entry regs, print them */
 			regs = unwind_get_entry_regs(&state, &partial);
 			if (regs)
-				show_regs_if_on_stack(&stack_info, regs, partial);
+				show_regs_if_on_stack(&stack_info, regs, partial, log_lvl);
 		}
 
 		if (stack_name)
-- 
2.27.0

