Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FB8C5321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE39F21744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gldqVV0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgDSQ3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDSQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:29:49 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E242C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 09:29:48 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b2so1789397ljp.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4iy7veB7VgIUBk675FYilXrEOwVsWoEtapBVxC4CVXk=;
        b=gldqVV0WwzdGlLC7qGAdPEfhrpGHP5eXNu6Iupu905mA6pbIhkQytbKTjdlN9sdoWd
         LvIyWpy9XF8MG7s9QEvP77Wc8qwu5nTMfytox9PAKld4RCxERfvwz/8dQ/0ybovlhF9J
         4E76UCBCdv/RbtlFLAjLMuPPnapMR4Boqb0zv8Pjw5GxiZmdvqRdvDqKS6pWoOmMtBoq
         MqkMSHmCXcvU8O5zrs5GQOaSe8XBxc+eR1iXX+jW+KpRHxzs6C88U2PbA/9Q9glmIlMA
         eitVpJ2OasStedxS2U7PX9YqDSQb4MQTJN50n4+8enez7PeTSfZMvvWti5gnKnQKnAT0
         8fMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4iy7veB7VgIUBk675FYilXrEOwVsWoEtapBVxC4CVXk=;
        b=kew50vJBnQ8PaeX9LEXU0tKvKDZvLaJZ5SRM7jb+YfKI75NXE+n9D5uABOJw8Jk8V+
         LrS5wvRQ+78E5sxnQFfT0lT28RXQGIqlVdfstFj5ugUZ0tGPYZ7gVbvMMDKyASgCaJ32
         MGpDhDwdSO2ZoK8sPaWxEgN88DbVRYzVmP0LtI/zuKx/UTshLGDqhm3BDmBPe+wN742z
         JxhZhf3YyFvSyNBxqJ6yloGUaNDGHES/EwaLQWer61IrP08dT/CUDbGe5fT9n/dpVtPl
         q8CY0ISE4hvJWFL2WFdGaDEg0xA9191BNo6jnRMUBO8mTOE00vgNz8fI/P6wfBk91VVn
         xzZw==
X-Gm-Message-State: AGi0PuanWl5lV3PwEkO9YpyfcQzL1qy7oHQCwhbeAZaa+vWDgDANvP3o
        f5xB1m5FVGvP+KyVwitnvX1tDqtN1/4=
X-Google-Smtp-Source: APiQypKtynYEbIlFEoQFibpa5XKcbsk6c9A0PwO56du/9If9b/gz866hODfJJ7OkpbXzch+tluphNg==
X-Received: by 2002:a05:651c:2002:: with SMTP id s2mr5516250ljo.285.1587313786569;
        Sun, 19 Apr 2020 09:29:46 -0700 (PDT)
Received: from test.lan ([91.105.39.216])
        by smtp.gmail.com with ESMTPSA id w16sm6146170ljd.101.2020.04.19.09.29.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 09:29:46 -0700 (PDT)
From:   Evalds Iodzevics <evalds.iodzevics@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/2] x86/CPU: Add native CPUID variants returning a single datum
Date:   Sun, 19 Apr 2020 19:29:42 +0300
Message-Id: <20200419162943.3704-1-evalds.iodzevics@gmail.com>
X-Mailer: git-send-email 2.17.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... similarly to the cpuid_<reg>() variants.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: http://lkml.kernel.org/r/20170109114147.5082-2-bp@alien8.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cac54e61c299..048942d53988 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -212,6 +212,24 @@ static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 	    : "memory");
 }
 
+#define native_cpuid_reg(reg)					\
+static inline unsigned int native_cpuid_##reg(unsigned int op)	\
+{								\
+	unsigned int eax = op, ebx, ecx = 0, edx;		\
+								\
+	native_cpuid(&eax, &ebx, &ecx, &edx);			\
+								\
+	return reg;						\
+}
+
+/*
+ * Native CPUID functions returning a single datum.
+ */
+native_cpuid_reg(eax)
+native_cpuid_reg(ebx)
+native_cpuid_reg(ecx)
+native_cpuid_reg(edx)
+
 static inline void load_cr3(pgd_t *pgdir)
 {
 	write_cr3(__pa(pgdir));
-- 
2.17.4

