Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFF6C2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C422075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Kn66xOjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgDHH5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:57:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34290 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDHH5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:57:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id v23so2702157pfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 00:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOQsL1UwAyeSD7aVc86VJnzoqXGbBrzuC9r/s6opFAQ=;
        b=Kn66xOjs81SGng0oCT/+Z7hx0FVYo/eEbSiAPSkG9YVazysZSGW4dQ90RJVw3fhxTU
         LjJTuf3qNq70mPiPOSxgd3h57DEvXCZ4aaKn8N0CWCciCzKED0k7HF0Tu2fNtAMQ4T0k
         4c6XsSZEpyV80iSmIYTvIqO9MXT32jyPMkSRuqmIC1LEYBF6OB3BZ+ajDJ4YboAcW1DI
         7NKm61fnwUrEFJkjyStI7+n8KexOl+3V3WwgZQYS/GQpoeqSunEHf249g+eF8J4tP0PX
         cJCST86Qnj/SwsTN+DWIWo6oRiD/mhGFKz4rr2flD9ipTpcUO41ef2MS2ymx9Vevq3uT
         D9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOQsL1UwAyeSD7aVc86VJnzoqXGbBrzuC9r/s6opFAQ=;
        b=ahQPOAKKzuAoTNfMP30epdPGxTxZa6BFfYb1WRCPD4yPPBuUgsyJp902Pub1IUQnbR
         ukP2sqcxGOw+zQSVHj/LM1L3V9d8JYXG/cRtRIr77Mukpv7cca564A9njrxe7Ar/2TX2
         qaxfzCKZVfNeFkHEzwH+s5iEF2UhUDfN+X8VI9MF5ns7ytGeZVIlpMtUH5PP/2fyEcdV
         X8MbCrSRvJgMDWBHrJGCDU0lflBEkMUXtEbB42qmsA/lSQiNKHgiFF7uTXAiDJ1x2LP4
         LYVZudR4gsQjiqJs8LNEGh83XL+meO3ZNiEAExTjQlAphy6gntxnhcHDo4+flZcIda76
         p30g==
X-Gm-Message-State: AGi0PuZ6lmaQ3gHnQVTbbgQlLSWLTqz7p83hgP60rIjM3OV55c04n0vt
        ufZJWc2ljHEhAu8gi2+lbb+ELw==
X-Google-Smtp-Source: APiQypKDfW2TB8LOB4CYBluerKzQ+zb+Jp1k53ujx1q7dkVM3x7cUFvX9tSZRYulxwzoPAbZJn1KxQ==
X-Received: by 2002:a05:6a00:2cf:: with SMTP id b15mr6388378pft.174.1586332631240;
        Wed, 08 Apr 2020 00:57:11 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d85sm485599pfd.157.2020.04.08.00.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 00:57:10 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 1/9] riscv: add macro to get instruction length
Date:   Wed,  8 Apr 2020 15:56:56 +0800
Message-Id: <621303b9cdea215af57329b401b15750c1f683ab.1586332296.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586332296.git.zong.li@sifive.com>
References: <cover.1586332296.git.zong.li@sifive.com>
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
2.26.0

