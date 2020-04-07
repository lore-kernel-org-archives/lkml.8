Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28294C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26E32072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jNjrdO2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgDGOrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:47:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44972 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgDGOrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:47:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id n13so396311pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOQsL1UwAyeSD7aVc86VJnzoqXGbBrzuC9r/s6opFAQ=;
        b=jNjrdO2jGlUgSUD9yX89DPR2/2/A55WbbxmEk3D0BPwG9P1qqJkWGiOZ6K9PUE6NI4
         ggW+RiFHKkMdsNH4G7JFuLFLB5oFS2LD3ruTt4WslQzsgp4tDE7Cfb8tUftvsBRs3alZ
         cRRTKvMno8t3cQ4xm6nyN5D0ZzW605zJkEX/DPb47MrtJhxxIEYXO48Fi6A2BOsIJkuu
         W4CCEZS9aswddXKsB5i3wPQ+2evp1ZGk6FxrS1iQhRL//uz2e11ktzh4CsfIymvLlXCB
         2IISADHqCpS4TEXjaRGAoEN64Ct+cjeGOUPvrfx5zDlrSRDrt7GYwCwHG4f3SsBRy6sD
         gefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOQsL1UwAyeSD7aVc86VJnzoqXGbBrzuC9r/s6opFAQ=;
        b=rR78N/MJGxNYLGNpNRiUNvNr5tYG5bB7vFe99ckSX+3tlBYNsFDGtLTwvSOOAVHhaJ
         6Z5cfgz6/ughXgv/IsblAkH654Mo8JHUPLXAwowqztuuPRIIXk0UnB9qLNO07/PQOqUO
         B28+ImBc4ntbBGL+hvUJgxDW18gt6GAu5+wBuRcWJ/fOR0cMlcdSAUoC/lK482UoPr/c
         /yWy8tBQ+7ozWLnVSUMZv9SKAMMB1SNk6ypRswTjKfirGMnhkzs+TaLE51XDQCyE7ulm
         1NDTepf9kNzoB1oCS4cAAHTq5Jf6DV6f+FWI8OffCz4uFO7YAPD6wvl+xv3EoyWUleXZ
         TZzQ==
X-Gm-Message-State: AGi0PuapHVI2IjP6giAhOZ4/Hjif+6sA8Z7atI2yvyLb72E2gL12kqs5
        qmAZdOncsPpOFOdTSkoYFJ3fOA==
X-Google-Smtp-Source: APiQypJSbH9Ho0ehuvytIuygjbLMQeR8OPPI6bu3qmrH4iy9fTjQrkoOscBf4NTGkjiU3CFXYbADLA==
X-Received: by 2002:a63:a052:: with SMTP id u18mr2473808pgn.210.1586270820635;
        Tue, 07 Apr 2020 07:47:00 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id y15sm14190093pfc.206.2020.04.07.07.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:47:00 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 1/9] riscv: add macro to get instruction length
Date:   Tue,  7 Apr 2020 22:46:46 +0800
Message-Id: <621303b9cdea215af57329b401b15750c1f683ab.1586265122.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586265122.git.zong.li@sifive.com>
References: <cover.1586265122.git.zong.li@sifive.com>
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

