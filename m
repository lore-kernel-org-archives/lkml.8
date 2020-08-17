Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50EFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63DA20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNryhj5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHQFX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHQFX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:23:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0AC061388
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 22:23:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f9so7139559pju.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 22:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TzuuMH1reS4hX1WqfpGoXCtEwIjilw/y6DFPlUvP7Fo=;
        b=lNryhj5tlH5i84BH6yKM3e5KuqlbpAL/F6wq+bwpNLXYgOUxEHykALDmwlzCOUqxG5
         h0jsInhr1tcGAcuPx2X7Lvq0vGnHM+Pa/ifIgpgKxADVkxgja+98mwSWDixNVdEGrIO7
         VV7c3CatxQhjzj+wG8tJ12UBpjivVsm1Cp897nJVPkCKX0NUrmqwYXZjRGc9hwr39eWA
         H1G5fvd8l1tYbfEZL9bOgm3JL2GUzV0ToFru5nkub/AzF5H2PZlhBxCzUnNL0DMFobj5
         rLkr/fwcdy4s0s7qayB5mMs8HMAmaD7yvQZeNB05CZkhbftzn46Z/W4b4n42CcrUVWHq
         n7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TzuuMH1reS4hX1WqfpGoXCtEwIjilw/y6DFPlUvP7Fo=;
        b=ZfFdjpLbTW/BQvKINBjv2ehrCnK3jPUjYNjuGWK7cZNo5HBPCQ5p6DLtzjiiy9yZ1Y
         blcz1b8FnNwjkib9wsasQ0C0LSsZ7NOn5UvEI6hz7IxR7wys8aMTKLGc2sGPcGl/Rohl
         /fJpMqtYn2v8Lm4lFofb+Z8m66jelmUxvdIE/G0wHHKKfguBAJl7r913tQr9L1Wc6bvR
         oCj95LHegCjmZ0ANOaCT81BVLm1jHz3vN2we8Y8DMlsuXKXSdOAVokZGidko9MVUnJdA
         mkIszxLz7hke+IVXZgEfRB5ll6c0Y5F5pXt3+sR0AKpco4FzasxqK5t5IsGRfIs9k3H5
         2L1A==
X-Gm-Message-State: AOAM532nCfqiFkE5aOSV4YiQ/efl0t385giR+2ihqRkMrY/1PY/2r0xB
        7JxNtCtG3QFqokqQ0dajy+I=
X-Google-Smtp-Source: ABdhPJwImP1PIQioiWYHAhyjpXe8DXg7vbcPr9+aIKIFO6rFk/nGecE9w9l5OJZfTa4nGkDhZXnEPg==
X-Received: by 2002:a17:90a:748:: with SMTP id s8mr10950467pje.112.1597641836520;
        Sun, 16 Aug 2020 22:23:56 -0700 (PDT)
Received: from localhost ([121.0.29.56])
        by smtp.gmail.com with ESMTPSA id r77sm17889148pfc.193.2020.08.16.22.23.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Aug 2020 22:23:56 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/3] x86/entry: remove unused sync_regs()
Date:   Mon, 17 Aug 2020 14:23:55 +0800
Message-Id: <20200817062355.2884-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20200817062355.2884-1-jiangshanlai@gmail.com>
References: <CALCETrWx66qLc-NiwKS_Zu=BP8JDTzfeUO7A2vDd01kXNmiNiA@mail.gmail.com>
 <20200817062355.2884-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

No more users.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/traps.h |  1 -
 arch/x86/kernel/traps.c      | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 714b1a30e7b0..52cd29bde1d0 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -10,7 +10,6 @@
 #include <asm/siginfo.h>			/* TRAP_TRACE, ... */
 
 #ifdef CONFIG_X86_64
-asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
 asmlinkage __visible notrace
 struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
 void __init trap_init(void);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 852de6f1bf88..ebea1c3e473b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -660,19 +660,6 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 }
 
 #ifdef CONFIG_X86_64
-/*
- * Help handler running on a per-cpu (IST or entry trampoline) stack
- * to switch to the normal thread stack if the interrupted code was in
- * user mode. The actual stack switch is done in entry_64.S
- */
-asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
-{
-	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
-	if (regs != eregs)
-		*regs = *eregs;
-	return regs;
-}
-
 struct bad_iret_stack {
 	void *error_entry_ret;
 	struct pt_regs regs;
-- 
2.19.1.6.gb485710b

