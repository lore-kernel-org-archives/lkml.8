Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00123C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 12:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7412072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 12:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAgQwmVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgAKMyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 07:54:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43742 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbgAKMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 07:54:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id k197so2348943pga.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 04:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aRGKGD24XARcqooB6yRW5X2AEG/hCOzoKCAjLuvYNQ=;
        b=uAgQwmVhODKaaZcjw+d37vVpfPujD+R9Lw/PPZ/xe2TlMviSHZD5O/6MW7ASXOMnSI
         19qqmz4efo4FRoJhEpiAabxnN/LjT2VfZLtndJMaYACY2TITXKNwS79dcqvf8l7mz65Q
         58uylkMAxbDWUhicFjLnHyqEb4SD73km2l2lfPyXcKUqu3AlBTLaK0FbJjTpVq2WYG9A
         0CxXcb4FA1VhnFdM5BmaRK7KIJhItLUEJ1kABY6dDv4sTrW7agPrr7GG1ZPwrOg3sfGy
         2T5TNamZSjuqvcwDx6wYibE7WQ5LFGhsmD+/LIss9MUXDEhuhWT3J+VIhkJc38YUGicp
         3GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aRGKGD24XARcqooB6yRW5X2AEG/hCOzoKCAjLuvYNQ=;
        b=isrxl54mN0qtBgadAUGWu5EmKD5cAjRn8VGkt1e3Cmz+uAyGnL80rRLLyjg+ztKys9
         kfiit/azjLs6+z+PW5NEdtuC9bcD6flNHVYHAywCeVXfp2JvxDVsf0OWj3U+59ax56hJ
         ToRg4/P0IwlcDyZazDRyaH4kkXuI1M3u9SdJpyjKjZQZh3sT5+gghz12movKyr5gl9gL
         dS7yExZHeA/Mg9ixO68Z9U+jR6M7ljwbLCjQ4zmxkYMo53M4YY6CkvlNODJIr2lgQgqD
         XHffmaA+RjSdX1W6OR0AG8r3PcaVC/j6PSE/Al6lkL9oI5DE7HEuSlBgtstSogxyYg6g
         zrcw==
X-Gm-Message-State: APjAAAVLwNHfsdo22/a7bfvVnGmZTpmKFErnXsEGcodd1YTHM/wo/P6Z
        b2X4BQQum6CUhOfVuKu7x8c=
X-Google-Smtp-Source: APXvYqx7KThZdN1LWXXFtnR9Ocr1fFbs6l/e+JH4PpVr9uN7dlhd5g6DVghpQMax4x8duNBCCAl6Tw==
X-Received: by 2002:a63:2142:: with SMTP id s2mr10871756pgm.54.1578747282689;
        Sat, 11 Jan 2020 04:54:42 -0800 (PST)
Received: from localhost.localdomain ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id a2sm6375440pgv.64.2020.01.11.04.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 04:54:42 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2] x86/nmi: remove the irqwork from long duration nmi handler
Date:   Sat, 11 Jan 2020 20:54:27 +0800
Message-Id: <20200111125427.15662-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, printk is NMI context safe now since the safe printk has been
implemented. The safe printk already has an irqwork to make NMI context
safe.

Second, the NMI irqwork actually does not work if a NMI handler causes
panic by watchdog timeout. This NMI irqwork have no chance to run in such
case, while the safe printk will flush its per-cpu buffer before panic.

While at it, repurpose the IRQ work callback into a function which
concentrates the NMI duration checking.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2: polish commit message. (Borislav Petkov)

---
 arch/x86/include/asm/nmi.h |  1 -
 arch/x86/kernel/nmi.c      | 20 +++++++++-----------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 75ded1d13d98..9d5d949e662e 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -41,7 +41,6 @@ struct nmiaction {
 	struct list_head	list;
 	nmi_handler_t		handler;
 	u64			max_duration;
-	struct irq_work		irq_work;
 	unsigned long		flags;
 	const char		*name;
 };
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index e676a9916c49..aa15d4f2340f 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -104,18 +104,22 @@ static int __init nmi_warning_debugfs(void)
 }
 fs_initcall(nmi_warning_debugfs);
 
-static void nmi_max_handler(struct irq_work *w)
+static void nmi_check_duration(struct nmiaction *action, u64 duration)
 {
-	struct nmiaction *a = container_of(w, struct nmiaction, irq_work);
 	int remainder_ns, decimal_msecs;
-	u64 whole_msecs = READ_ONCE(a->max_duration);
+	u64 whole_msecs = READ_ONCE(action->max_duration);
+
+	if (duration < nmi_longest_ns || duration < action->max_duration)
+		return;
+
+	action->max_duration = duration;
 
 	remainder_ns = do_div(whole_msecs, (1000 * 1000));
 	decimal_msecs = remainder_ns / 1000;
 
 	printk_ratelimited(KERN_INFO
 		"INFO: NMI handler (%ps) took too long to run: %lld.%03d msecs\n",
-		a->handler, whole_msecs, decimal_msecs);
+		action->handler, whole_msecs, decimal_msecs);
 }
 
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
@@ -142,11 +146,7 @@ static int nmi_handle(unsigned int type, struct pt_regs *regs)
 		delta = sched_clock() - delta;
 		trace_nmi_handler(a->handler, (int)delta, thishandled);
 
-		if (delta < nmi_longest_ns || delta < a->max_duration)
-			continue;
-
-		a->max_duration = delta;
-		irq_work_queue(&a->irq_work);
+		nmi_check_duration(a, delta);
 	}
 
 	rcu_read_unlock();
@@ -164,8 +164,6 @@ int __register_nmi_handler(unsigned int type, struct nmiaction *action)
 	if (!action->handler)
 		return -EINVAL;
 
-	init_irq_work(&action->irq_work, nmi_max_handler);
-
 	raw_spin_lock_irqsave(&desc->lock, flags);
 
 	/*
-- 
2.24.0

