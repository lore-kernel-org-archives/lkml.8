Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084A4C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D623221744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga7E/kx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgDSQ3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgDSQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:29:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F153C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 09:29:49 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 131so5836567lfh.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=72Y11+mpHoh419u3dSJ7tsB2T9ditl1n5X2d39CwR8Y=;
        b=Ga7E/kx4gS8BiUHTzCPHaIc6f85SUOGPGG1czNDeVpIS16jpDhnO7JDN/MJb62f09Y
         hMp1wCo1/w/W5Qjfb1CJUxejAGJD1PKUEgDwFqG9YTCrD2KDMzOQG57HVovyXMytr3sd
         tZhlO7G/6072h5LT/DS8gGyxM7x1kqonlCKbMD48UFR6EmNog8+8t80e+GrhM66r0xAz
         7wxbuXWayKNWpi8NXFzcvZthnR6xQ+i1pKHgLmgeGjOloyOnyA+VcZ8Z8EvJM9rfPwY7
         8NOB0ySeRyBPI97kQ6d5tCwlY/LHNn9453GiIwj+fJLxyD1mg3pJWVksn2OrKMPbBff1
         X+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=72Y11+mpHoh419u3dSJ7tsB2T9ditl1n5X2d39CwR8Y=;
        b=A8BQiGQrLWNU811Y66oginaVtQ1eQ2jItAAiCNYkJ/uBd5C65/48OXNEfIUUUO8nrq
         IhP/NcZ9c4WA2900GEP1yzT2rzBIIPsNXJ77pUxPevw0eYwTUJObYTISdfzi0IyPnpZS
         OLS1VCg736Qx23fKCiaedCJ+7TULYmCyDC8JcLM1N4EkeWwBUityUw2S1r6+601iX/Lq
         50YzPsPgwo7xMk7AG9OmrzkRguYNtJcftXX1xzAj0C6aT0bgLJO35muMXxgFF0p2LJ/b
         eFHBjvcK4kXDAf6hnF05S2QgWtiOqHt2QiZdMv1+DCFCpltPdujRft/VlZBH1IL92Axr
         5TCg==
X-Gm-Message-State: AGi0PuZkEILR+Cjj8t9W6rP+avi71MBmg7tTA9bx33dGFdnmo/yyWOn9
        LfaE6+FkRDhAZW1D+56WninOuS6nBeI=
X-Google-Smtp-Source: APiQypIb4k1rLEBNprVGxcv5wz7KDP1s+PLU2Gb5BuI2L3JLZ0LgQTAjpr6PQxdOmhgxPotWUh/bOA==
X-Received: by 2002:a19:c7d8:: with SMTP id x207mr7701194lff.190.1587313787305;
        Sun, 19 Apr 2020 09:29:47 -0700 (PDT)
Received: from test.lan ([91.105.39.216])
        by smtp.gmail.com with ESMTPSA id w16sm6146170ljd.101.2020.04.19.09.29.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 09:29:46 -0700 (PDT)
From:   Evalds Iodzevics <evalds.iodzevics@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        Evalds Iodzevics <evalds.iodzevics@gmail.com>
Subject: [PATCH 2/2] Fixed broken microcode early loading on 32 bit platforms because it always jumps past cpuid in sync_core() as data structure boot_cpu_data are not populated so early in boot. This is for 4.4. Should be done for 4.9 too
Date:   Sun, 19 Apr 2020 19:29:43 +0300
Message-Id: <20200419162943.3704-2-evalds.iodzevics@gmail.com>
X-Mailer: git-send-email 2.17.4
In-Reply-To: <20200419162943.3704-1-evalds.iodzevics@gmail.com>
References: <20200419162943.3704-1-evalds.iodzevics@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

