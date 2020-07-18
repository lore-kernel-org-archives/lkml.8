Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A160EC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC832076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 14:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG5qqxEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGROiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 10:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgGROis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 10:38:48 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFFCC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 07:38:47 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v8so13312107iox.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 07:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bE7ryY5bmKmNgC6eIa/UyE6X2gMyGEMpAXbppuSg5s=;
        b=SG5qqxEv/bGbPPNqoo7521htEX4rcqNPDp07njON8/cMZx0JcU2vERb7Kd2mvsmF/q
         f3R7uqwVmMM5+Gna/QHkGOKjc9JJP5XZoiyaOzM0YxgpMw2EBBrrRvSfBi/T/Kj2WY1D
         4525U0FQutq7jlRpU/+0wFF2OJ8SeT63omQAdAhR79QqXcT48yi6vm3PFHO285HL2k5q
         IxkcvFWpmeFWBnqIfJ/c7ExHhM3rI9Y1J7xlDFyl3JcBTuLgTS2r80leHkvhM4vGuefr
         AaBQFXkD/GRjTK7lB/wsACxRXQ/geRxys8RzwnzFyTl3FzJcWJVoQo8pMbTL/dlZvNwS
         3ChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bE7ryY5bmKmNgC6eIa/UyE6X2gMyGEMpAXbppuSg5s=;
        b=UZiik9YMpDyRUGvJmgL6Us+qcOezkec3xRwRm4na4llmHxnkqcPHNs9zQuymCQlw4X
         STlDEE1DdYYEXlcA+v2kRbv+djYzB/ft/RePQysmCwePQI9gktlUNah1SjS1dYBpkZ0m
         t8A25drvHA6luzaJ4EbOgTtPMWNa3uyAYTNZVWyf7nmgZ9Aq1vpBlC9OO60lMLSDhkzi
         xp8rHnM1wGStqHwAE5cRATAk2jZatvcDUcV9dIyfOu677tkrk7jHc+i1i+QcSIgeFqbZ
         s0W/l6Ofxmvp3ttHPVRzhQNqlkWd6f5K+hNaMVnW9BsyNkQwGMxhM5SsAeUsR3qhd5EY
         BKlg==
X-Gm-Message-State: AOAM530ZT4GlumI0mqMoWdnULeQkNW7zxJdrlW8mpji7lcQZ0laW5Eom
        udXM/6C1Asjvhn6Hqih/vJKLhpE=
X-Google-Smtp-Source: ABdhPJyG7ikvEwxq1esi7aQLgsQDtfVaQXlzfytabaXHyjZ7SgEi/aVpBv46vIbg3G8ZAWhOAHoeGg==
X-Received: by 2002:a02:70d6:: with SMTP id f205mr16344131jac.5.1595083127172;
        Sat, 18 Jul 2020 07:38:47 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id 5sm5888610ion.7.2020.07.18.07.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 07:38:46 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 2/3] x86-32: Remove SEP test for SYSEXIT
Date:   Sat, 18 Jul 2020 10:38:38 -0400
Message-Id: <20200718143839.194960-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718143839.194960-1-brgerst@gmail.com>
References: <20200718143839.194960-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEP must be present in order for do_fast_syscall_32() to be called on native
32-bit.  Therefore the check here is redundant.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 9e01445f6679c..bdb4c15b8610e 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -587,8 +587,7 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 	 * We don't allow syscalls at all from VM86 mode, but we still
 	 * need to check VM, because we might be returning from sys_vm86.
 	 */
-	return static_cpu_has(X86_FEATURE_SEP) &&
-		regs->cs == __USER_CS && regs->ss == __USER_DS &&
+	return regs->cs == __USER_CS && regs->ss == __USER_DS &&
 		regs->ip == landing_pad &&
 		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)) == 0;
 #endif
-- 
2.26.2

