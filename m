Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9496C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8148C2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByrdoxdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgDTJAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbgDTJAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:00:46 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF8EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 02:00:45 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j14so7247763lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nTQpJWUWQ93iroLJ8scwaFThtF56RAkbRbfhbcddVxU=;
        b=ByrdoxdRSedshbDkTvNNuW3kRwDyHEtraaBRDp0altYpjDQLJ87IF878hg0JeKxOLK
         gh/0FgNRKCeFzpGF9X6D68xApM/OdlOGofJzZdcQxHo1j0ApgSoXt4/i1pS0QcooSVtS
         QjzMX1Vr/O0VOM/pB/ZZ4Ntwpf2YPHracFs0GFIC0Res3tcqgNLTcBUq/RjWlQ/JALoS
         689eqITKpCJWX0qJL1rz9PmrN0xUJvAjRIJhCEaUKqa5gD1efkLhc9BebMccAU8MzCXi
         l5IoSrOZe5gnxg2CizJH/PY9Or1xXEXr/AxhQDraGOVXpPEA/XhtNjo54t3SrQqcNs+S
         99gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nTQpJWUWQ93iroLJ8scwaFThtF56RAkbRbfhbcddVxU=;
        b=eVQLqBYupE2OJzfloMnnKv2qORb1ZUiSVWMivQB2bG+52fFOghe87I5rEiBArInrJ1
         nnaCck1Pu4tUHpMP5vIZXqL4xPJVUInnggnZffWrJ0Qwp/2CwxFar87NsZ9KbQKp9VnR
         dr+KftIRFJMn+dYUWNKXeeEiCpTybUBPfZ62SsFtwT2vyD9eLZmvqBMLuENbAHRKeZUS
         os7H4+9kRojAE6cYtsOp6+31z5BYHALi8N5A4UXSb5svbtW7OU53AJtfVkEXPKDLiJYT
         MT/+vSFjE0DesCXxzH9G9kERdiQvFsqNq9Ai3WbhJQ1cE8keXDJYuHuI4//CqBgFgZVQ
         nQng==
X-Gm-Message-State: AGi0PuZ3Czufrnr93j0RuBj5wtS8sK2Ym7CEZ0toNZl91a18fn7hW3+y
        j8RXXPlCEOo54xv5KXbIk5bm9AEo0s8=
X-Google-Smtp-Source: APiQypKaRx4T1YYgQJs9FI9HnSW9pFyz217037TzKw6EybxzgTXgdB6y6jD6tg9XtGOMgscp4LhAag==
X-Received: by 2002:ac2:522e:: with SMTP id i14mr9634048lfl.140.1587373244195;
        Mon, 20 Apr 2020 02:00:44 -0700 (PDT)
Received: from test.lan ([91.105.39.216])
        by smtp.gmail.com with ESMTPSA id g3sm442737ljj.13.2020.04.20.02.00.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 02:00:43 -0700 (PDT)
From:   Evalds Iodzevics <evalds.iodzevics@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de,
        Evalds Iodzevics <evalds.iodzevics@gmail.com>
Subject: [PATCH] x86/microcode/intel: replace sync_core() with native_cpuid_reg(eax)
Date:   Mon, 20 Apr 2020 15:00:37 +0300
Message-Id: <20200420120037.1537-1-evalds.iodzevics@gmail.com>
X-Mailer: git-send-email 2.17.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sync_core() always jums past cpuid instruction on 32 bit machines
because data structure boot_cpu_data are not populated so early in boot.

It depends on commit 5dedade6dfa243c130b85d1e4daba6f027805033 for
native_cpuid_reg(eax) definitions

This patch is for 4.4 but also should apply to 4.9

Signed-off-by: Evalds Iodzevics <evalds.iodzevics@gmail.com>
---
 arch/x86/include/asm/microcode_intel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 90343ba50485..92ce9c8a508b 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -60,7 +60,7 @@ static inline u32 intel_get_microcode_revision(void)
 	native_wrmsrl(MSR_IA32_UCODE_REV, 0);
 
 	/* As documented in the SDM: Do a CPUID 1 here */
-	sync_core();
+	native_cpuid_eax(1);
 
 	/* get the current revision from MSR 0x8B */
 	native_rdmsr(MSR_IA32_UCODE_REV, dummy, rev);
-- 
2.17.4

