Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794D6C2BB58
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5268C20828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="REj3KT9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgCIQ4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:56:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45395 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgCIQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:56:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id 2so5063067pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DKBW8Eyy8NVtYJgHutHlswaK8NeRD9IAyJm/+12aBBY=;
        b=REj3KT9KCk7pmUAzQenlRZ2UdxDM55l7D4o43L3PCGSAW2igoKTdhOdGSHha/5ZV0k
         PWnirmLcaBYdBy+ACtOq048Ky2eKNeoaSFswZk4gUbnNj2EpUH3DERiyVDErdUcN5bL4
         f7rGeupxtqCtvj2wmTCxeWyv/EgbYZAPatwSOsy69GjDytGquusfnE5lStT5PC2n+LB0
         +deFikDuHSYPI2k3e8zYswywhoFtwypPlee3loaubnkMY59DP6jyRznBAFNfCb2Z4d3x
         94ITFyNP6J5LaBX+WtURnXC0csngUwZMMW6VnLjRJqEnlG9otg0Wqxcm4esJikPDD970
         cB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DKBW8Eyy8NVtYJgHutHlswaK8NeRD9IAyJm/+12aBBY=;
        b=cSecfLF/TEkoCi+yjbvgaaLeA8bIl4EpLAE9wshZKD98a0lRGFbiVFQmxLo9uMHBpL
         XERRPDlvCTVAVeNhQ0uYKgiwgPc8cMI1feKoy5JWQ4rg3/CA6lED+9X4KPLzavEeSPE1
         pMrrwx1LLYP3rJzFVUEoCGFsKVnMFPg/oO9VdQWMthKFSE0VYAuAmDJMjrEF/IEGErKA
         HKjlYutmkaHoR6mkWEP7bdp6knZOPjHJ7uYXiLQ1buZw7Cpy/Uhop8zQ7vMb4SNBq1l7
         9Epyz3q/l6XKRIlR7aFJbov+FXxYVyyUYqSRezquVWRMODNdR4BUKpEl78f6cViQq2aV
         AB/g==
X-Gm-Message-State: ANhLgQ1sRYtN2I/916cLGtlP9e8OZF0vw4WwFQmo0yxyz7CYSl4bKNwB
        hf7cNEm/VS4AeZ+eD9lFt+sLag==
X-Google-Smtp-Source: ADFU+vuSU8d2YJr+UbuHwypGjfeETIP0OFkmwem67CPnKwSBb/4lKf72zr3M4nrZ00SVq1HLPFHWlQ==
X-Received: by 2002:a63:348b:: with SMTP id b133mr17387820pga.372.1583772964283;
        Mon, 09 Mar 2020 09:56:04 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id cm2sm104013pjb.23.2020.03.09.09.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 09:56:03 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 7/9] riscv: add macro to get instruction length
Date:   Tue, 10 Mar 2020 00:55:42 +0800
Message-Id: <8f933bed0478a1b4029447e1f8eef2ce0aefed4b.1583772574.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583772574.git.zong.li@sifive.com>
References: <cover.1583772574.git.zong.li@sifive.com>
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

