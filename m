Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C53C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07182077C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="EyV02xAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAWOBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:01:20 -0500
Received: from mout02.posteo.de ([185.67.36.66]:48747 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgAWOBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:01:19 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 07B9D2400FC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 15:01:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1579788077; bh=ZVtVWPk2nLjF6dSYv8YBCQyVws1d8uWihyfKP1Ac6VI=;
        h=From:To:Cc:Subject:Date:From;
        b=EyV02xAnENVfXhyv4Lhbtdbc/olaRO5FYvIkqCnWKpl/4uChQbKdPJwpQ986uX9m0
         6wLwTgXbJp+dpo5ZyG6OBhZW7yklu4U5ynvToY0PCa/zPyBvzJYzCrGJ4hTEjX64yL
         gn6d8680yoI0EVTEVK8hmVy7APo/RHLI5ohdMyuAbxtHrnggAdncYlHT3MkSXtUex4
         YRkSjTz9DeaGpVQJbs9AQMF894DtHWn93BXa1WMWlwq/9jGJvL4QoQgJb9+EHGomA4
         3zoHSly76K9sb9zpvHwD/CUGGW903PJZHgRMCqapLpFvI7S0nGvYx/so/1/x4fbt4Q
         A0qr4x0ZcMgKw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 483P7w5D0gz9rxS;
        Thu, 23 Jan 2020 15:01:16 +0100 (CET)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     X86 ML <x86@kernel.org>
Cc:     kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH] x86/cpu: Move prototype for get_umwait_control_msr() to global location
Date:   Thu, 23 Jan 2020 15:01:13 +0100
Message-Id: <20200123140113.8447-1-b.thiel@posteo.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.. in order to fix a -Wmissing-prototype warning.

No functional change.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
---
 arch/x86/include/asm/mwait.h | 2 ++
 arch/x86/kernel/cpu/umwait.c | 1 +
 arch/x86/kvm/vmx/vmx.c       | 1 +
 arch/x86/kvm/vmx/vmx.h       | 2 --
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 9d5252c9685c..83b296ffc85a 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -23,6 +23,8 @@
 #define MWAITX_MAX_LOOPS		((u32)-1)
 #define MWAITX_DISABLE_CSTATES		0xf0
 
+extern u32 get_umwait_control_msr(void);
+
 static inline void __monitor(const void *eax, unsigned long ecx,
 			     unsigned long edx)
 {
diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index c222f283b456..300e3fd5ade3 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -4,6 +4,7 @@
 #include <linux/cpu.h>
 
 #include <asm/msr.h>
+#include <asm/mwait.h>
 
 #define UMWAIT_C02_ENABLE	0
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e3394c839dea..25ddfd3d6bb0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -44,6 +44,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/virtext.h>
 #include <asm/vmx.h>
+#include <asm/mwait.h>
 
 #include "capabilities.h"
 #include "cpuid.h"
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index a4f7f737c5d4..db947076bf68 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -14,8 +14,6 @@
 extern const u32 vmx_msr_index[];
 extern u64 host_efer;
 
-extern u32 get_umwait_control_msr(void);
-
 #define MSR_TYPE_R	1
 #define MSR_TYPE_W	2
 #define MSR_TYPE_RW	3
-- 
2.17.1

