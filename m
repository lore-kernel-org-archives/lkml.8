Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73B4C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD85D20848
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PO4wwiU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgAJKqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:46:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41124 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgAJKqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:46:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id w62so949089pfw.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 02:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=42mwvroZn5D/LVSfX44AjqAGuuEshUhGIY/O55rHNeI=;
        b=PO4wwiU3DoR9x0xd9nS7scCQwBINyo5RbwvD3SRClmUO3SKfq/fSWsAwuyGPmv80/b
         aM8/zs2oNzKkM9jcS4mkAuTMQ1aTpzD31KPfeA6zuWC2RAc5/RkZgeVapRI6P4bZEh73
         +eV+0zF2RmMjyrYqjYmwf/izVUxsbndYe1/awn9CupsIqV2udsu1vxPH07+U0m9nLxvs
         LoeL02JKKS2BIg5ILoRshBLp/3WcslYlPnR5e5+CzvpkWMRfXj4luDNupgOVBMGWxTNb
         fQXz8kgwXyQGI+OL7YNIAYHiLTlDNNbbjwYoOLrbx/bPmAsu9tih57gh0ZV/vIskO11v
         i2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=42mwvroZn5D/LVSfX44AjqAGuuEshUhGIY/O55rHNeI=;
        b=VKpg0Cwvs2MEz6BffjpP3HVsXHlVXMzkrn1cBpYIZ3ReXCXfpGoZ6XHB0XlQBx404/
         9zE35w3qJ087Hw51TY0iBnOT0UrQYJVDPYfwjdCIFvKKopk30mD2Z2YXADfzkzRi6ZY4
         9xOdop3l/Gf0lQSmJHgdHRpy18VdfCMWjpQkouS9tIbYVTc0Idn49RNmtPyrfTrf0Gww
         dvQYIL3NATaaHDFqYHKoc6ph2OloF713jwZp5lRxLMIMLWZTptet2z0TX6dEzKZXfYnC
         xMifCNgoh7VogoRa9XEV5yvYUJYj0HEx3dz9C4PWCkVEUUbQ1xiN7YkH9zn5yacI8ERh
         +mGw==
X-Gm-Message-State: APjAAAV0TgukP3zqKJ1QjfV4r8SaYFgtN0shg3gBPIjjx03VwweyaFlH
        0FpZtX5bzywjBx1rL4BRcwPYlQ==
X-Google-Smtp-Source: APXvYqw50CIZl37GWxKuDHsISFVb3VRdnwoPtm+aVoqB9BSxCjsE6idB+ZSXSU3xHCpEwWgiiR0KbA==
X-Received: by 2002:a63:7843:: with SMTP id t64mr3592350pgc.144.1578653203165;
        Fri, 10 Jan 2020 02:46:43 -0800 (PST)
Received: from greentime-VirtualBox.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id e10sm2590901pfj.7.2020.01.10.02.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 02:46:42 -0800 (PST)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, greentime@kernel.org, anup@brainfault.org,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        gkulkarni@marvell.com, will@kernel.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, paul.walmsley@sifive.com, hch@lst.de
Subject: [RFC PATCH v2 3/4] riscv: Use variable this_cpu instead of smp_processor_id()
Date:   Fri, 10 Jan 2020 18:46:26 +0800
Message-Id: <5a30a3a637af05041780214287f46ea576818c99.1577694824.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1577694824.git.greentime.hu@sifive.com>
References: <cover.1577694824.git.greentime.hu@sifive.com>
In-Reply-To: <cover.1577694824.git.greentime.hu@sifive.com>
References: <cover.1577694824.git.greentime.hu@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To clean up codes in smpboot.c by using a variable this_cpu to prevent too
many calls for smp_processor_id()

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/smpboot.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 8bc01f0ca73b..ceef7c579aeb 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -46,6 +46,9 @@ void __init smp_prepare_boot_cpu(void)
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpuid;
+	unsigned int this_cpu;
+
+	this_cpu = smp_processor_id();
 
 	/* This covers non-smp usecase mandated by "nosmp" option */
 	if (max_cpus == 0)
@@ -137,6 +140,9 @@ void __init smp_cpus_done(unsigned int max_cpus)
 asmlinkage __visible void __init smp_callin(void)
 {
 	struct mm_struct *mm = &init_mm;
+	unsigned int this_cpu;
+
+	this_cpu = smp_processor_id();
 
 	if (!IS_ENABLED(CONFIG_RISCV_SBI))
 		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
@@ -146,9 +152,9 @@ asmlinkage __visible void __init smp_callin(void)
 	current->active_mm = mm;
 
 	trap_init();
-	notify_cpu_starting(smp_processor_id());
-	update_siblings_masks(smp_processor_id());
-	set_cpu_online(smp_processor_id(), 1);
+	notify_cpu_starting(this_cpu);
+	update_siblings_masks(this_cpu);
+	set_cpu_online(this_cpu, true);
 	/*
 	 * Remote TLB flushes are ignored while the CPU is offline, so emit
 	 * a local TLB flush right now just in case.
-- 
2.17.1

