Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C5FC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 15:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB9F20729
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 15:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIKjoruE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgBPPRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 10:17:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40966 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgBPPRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 10:17:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so16635254wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 07:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=vrwGSkm0zl0fsgDrsdAXuIbVXcayveGtL2hVDCNf5Mw=;
        b=ZIKjoruEpN+8D6zGpxSgUMmhnAtnjWzH+QdDm7B5IIqQseOKWRGuyFf273Pl7hgDtc
         e/wXZjvNCHxj4B7sn/LveYABqwZ3FrArnEw+KUSiAT5cz8CG9AiiEqQ8nEO7n/SsUhIy
         LJCUI51Wup/sxS6mbBbJyfxtRdmyFk3ooMHTmhRCTy2tmOWUQPZ2iLG5D4wpK7jFXTqi
         69mxObd6wb9JGaE0FhzvQri6fhD1lP//gV7b/aRqjkEa2Z4sUxW7hBd4NrvnTlhQHbea
         TZgGWLL6EfXAfXK0NpQTr89x1ecICWFupiQZfjfnClB1WU0pXaOZz1c/PfY64auG/lHZ
         gISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=vrwGSkm0zl0fsgDrsdAXuIbVXcayveGtL2hVDCNf5Mw=;
        b=IZjUv0/+m5qo4LG5h7sCqkRdGTl39eRAX4DOBgCfO9pntvB50C2apaYA9L7NTLDQZU
         QaDkVmX2vj46FirLOZ7+gZQzjpXgB88gsPxQUMrr50AGQyXtX9hr8WoyVL99Iuy6UYme
         Q8MHE9TR4vUVds28SRMpMxrGqUxtl/PHUscuzeXJsQ9dxnsWOLTFGqKzCwsVSb+HkDUt
         3B/mGutHVWrxgAjUXlvGoDI/l/5zTE+d2RDPBS7ZHajNDAVKqDNZPQASyuvxe5Ha9Y0o
         FMS5gTWx8CEvY5EkztrhnoWukQxMg9ul89c4RO1Ir63bx8ryEOqZFoI/XnIjet3CZOsC
         98kw==
X-Gm-Message-State: APjAAAWrRm8OFstR3eDDHSeMWz0/bshzkK3WWlV4TcnY0JbVkI9+/T0p
        /19Us48GheiHGQFmN4RbZ/HeymPC
X-Google-Smtp-Source: APXvYqxFRt3Q8HXiTuGpvRScJFKxmVCK3YBPZ4H//KLmTJMbrsANiddJz1HcSZbXRgPKDMI8Ynmi0g==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr15308859wrv.291.1581866260559;
        Sun, 16 Feb 2020 07:17:40 -0800 (PST)
Received: from [10.0.0.97] (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a9sm15860222wmm.15.2020.02.16.07.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 07:17:39 -0800 (PST)
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
From:   Martin Molnar <martin.molnar.programming@gmail.com>
Subject: x86: Fix a handful of typos
Message-ID: <0819a044-c360-44a4-f0b6-3f5bafe2d35c@gmail.com>
Date:   Sun, 16 Feb 2020 16:17:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please find a couple of typos fixed in the patch below. Let me know if I should do anything else.

     Martin Molnar

Signed-off-by: Martin Molnar <martin.molnar.programming@gmail.com>
---
 arch/x86/kernel/irqinit.c  | 2 +-
 arch/x86/kernel/nmi.c      | 4 ++--
 arch/x86/kernel/reboot.c   | 2 +-
 arch/x86/kernel/smpboot.c  | 2 +-
 arch/x86/kernel/tsc.c      | 2 +-
 arch/x86/kernel/tsc_sync.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index 16919a9671fa..e08d46171cf4 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -84,7 +84,7 @@ void __init init_IRQ(void)
 	 * On cpu 0, Assign ISA_IRQ_VECTOR(irq) to IRQ 0..15.
 	 * If these IRQ's are handled by legacy interrupt-controllers like PIC,
 	 * then this configuration will likely be static after the boot. If
-	 * these IRQ's are handled by more mordern controllers like IO-APIC,
+	 * these IRQ's are handled by more modern controllers like IO-APIC,
 	 * then this vector space can be freed and re-used dynamically as the
 	 * irq's migrate etc.
 	 */
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 54c21d6abd5a..6407ea21fa1b 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -403,9 +403,9 @@ static void default_do_nmi(struct pt_regs *regs)
 	 * a 'real' unknown NMI.  For example, while processing
 	 * a perf NMI another perf NMI comes in along with a
 	 * 'real' unknown NMI.  These two NMIs get combined into
-	 * one (as descibed above).  When the next NMI gets
+	 * one (as described above).  When the next NMI gets
 	 * processed, it will be flagged by perf as handled, but
-	 * noone will know that there was a 'real' unknown NMI sent
+	 * no one will know that there was a 'real' unknown NMI sent
 	 * also.  As a result it gets swallowed.  Or if the first
 	 * perf NMI returns two events handled then the second
 	 * NMI will get eaten by the logic below, again losing a
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0cc7c0b106bb..3ca43be4f9cf 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -531,7 +531,7 @@ static void emergency_vmx_disable_all(void)
 
 	/*
 	 * We need to disable VMX on all CPUs before rebooting, otherwise
-	 * we risk hanging up the machine, because the CPU ignore INIT
+	 * we risk hanging up the machine, because the CPU ignores INIT
 	 * signals when VMX is enabled.
 	 *
 	 * We can't take any locks and we may be on an inconsistent
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 69881b2d446c..3feaeee8a926 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1434,7 +1434,7 @@ early_param("possible_cpus", _setup_possible_cpus);
 /*
  * cpu_possible_mask should be static, it cannot change as cpu's
  * are onlined, or offlined. The reason is per-cpu data-structures
- * are allocated by some modules at init time, and dont expect to
+ * are allocated by some modules at init time, and don't expect to
  * do this dynamically on cpu arrival/departure.
  * cpu_present_mask on the other hand can change dynamically.
  * In case when cpu_hotplug is not compiled, then we resort to current
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7e322e2daaf5..0109b9d485c6 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -477,7 +477,7 @@ static unsigned long pit_calibrate_tsc(u32 latch, unsigned long ms, int loopmin)
  * transition from one expected value to another with a fairly
  * high accuracy, and we didn't miss any events. We can thus
  * use the TSC value at the transitions to calculate a pretty
- * good value for the TSC frequencty.
+ * good value for the TSC frequency.
  */
 static inline int pit_verify_msb(unsigned char val)
 {
diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 32a818764e03..3d3c761eb74a 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -295,7 +295,7 @@ static cycles_t check_tsc_warp(unsigned int timeout)
  * But as the TSC is per-logical CPU and can potentially be modified wrongly
  * by the bios, TSC sync test for smaller duration should be able
  * to catch such errors. Also this will catch the condition where all the
- * cores in the socket doesn't get reset at the same time.
+ * cores in the socket don't get reset at the same time.
  */
 static inline unsigned int loop_timeout(int cpu)
 {
-- 
2.20.1


