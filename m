Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07B5C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D9320866
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PLP0zU9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgCIIXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:23:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38943 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCIIWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:22:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id s2so4372770pgv.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DKBW8Eyy8NVtYJgHutHlswaK8NeRD9IAyJm/+12aBBY=;
        b=PLP0zU9h4LODazLocgYTaUlefV0n5miYUkqXeQnR2x+qSMUaUylcFG1Z08ma8BbMpw
         YWNRqxfL2bdhm2EMPL4ti3jf5tyiN7zqHYcUro5PFxsmj+dB/779BE+Vj/tq7Vg1qZ9w
         ZyTk50s8LgxDr0SXz4Z+rUJswzfZMGLKf2oAn/fuRddJNqIU6YbM2KvTnrGsbz4HQ2Q/
         Tt/N35eOUez5OYJDHr1blVvIB1Qatw/SgsHStUqULYs1oyJtl+5YOnTrRMU2auogtEZS
         PZnFCwBnaGIlIbj6rswYaLXFRTp/aKCMeTw5MLJauUquwJ22T6n+F3q7GGaQVx01i/92
         zSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DKBW8Eyy8NVtYJgHutHlswaK8NeRD9IAyJm/+12aBBY=;
        b=hyNnNqJ7Axw6IsKijZmIuo5lpNCi6aKaONctQaU8ZkwaUQX/ykcfnQz/asXYTfTaxa
         Avvo69pJeCpmZzKbHEjuWLdiDzRX9cqNTGO8o2Gu/n8UljMXWxP5dJHCuoug2nEzuIAE
         wbfvgSdcFedxt9yBFXvEdVdXyPfxc7vnoFCFIQ41vSjMgKPyPcd0TKOnFPUWhVEGlcrZ
         c8XecomObdLCGxxVq+gfKUl/MoFYuR/aYBC2YMYWUsGuswXcdVN1iP4ngnWuh8N4bO0f
         ouGNVC3d8IL28MVEryybCVC+gx7NZKY0PeSrv6EYQEZ/PRmB2pWIMvWFJZ2ml7GJsmCY
         jn1w==
X-Gm-Message-State: ANhLgQ0b3aOzF6aNbUwco4eYmzqXhcJ1r49FqqVo4e6D8W20hgJDeZ7W
        p8joiSP27HkxnqEnGK4kF5t9qw==
X-Google-Smtp-Source: ADFU+vtA5aTtQ+0ugZHTUipprmgbLl0y+udRb/LyBPppXvEMK9X7hatVSm8bayWX4VgWOrvI1xzZog==
X-Received: by 2002:a63:e053:: with SMTP id n19mr15845329pgj.64.1583742171399;
        Mon, 09 Mar 2020 01:22:51 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id v5sm18364779pfn.64.2020.03.09.01.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 01:22:51 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 7/9] riscv: add macro to get instruction length
Date:   Mon,  9 Mar 2020 16:22:27 +0800
Message-Id: <59d5cd2e5325893f3cff9420e7e94d5c0f503da1.1583741997.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583741997.git.zong.li@sifive.com>
References: <cover.1583741997.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the calculation of instruction length for common use.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/include/asm/bug.h | 8 ++++++++
 arch/riscv/kernel/traps.c    | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 75604fec1b1b..d6f1ec08d97b 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -19,6 +19,14 @@
 #define __BUG_INSN_32	_UL(0x00100073) /* ebreak */
 #define __BUG_INSN_16	_UL(0x9002) /* c.ebreak */
 
+#define GET_INSN_LENGTH(insn)						\
+({									\
+	unsigned long __len;						\
+	__len = ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) ?	\
+		4UL : 2UL;						\
+	__len;								\
+})
+
 typedef u32 bug_insn_t;
 
 #ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index ffb3d94bf0cc..a4d136355f78 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -118,7 +118,8 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 
 	if (probe_kernel_address((bug_insn_t *)pc, insn))
 		return 0;
-	return (((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) ? 4UL : 2UL);
+
+	return GET_INSN_LENGTH(insn);
 }
 
 asmlinkage __visible void do_trap_break(struct pt_regs *regs)
-- 
2.25.1

