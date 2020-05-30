Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F003C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C9020776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqOFjwRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgE3WL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 18:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbgE3WLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 18:11:51 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA85C008630
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:50 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t8so5407956ilm.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KsYtJJfLF/jVVqg18d3dXBYpXuPmMyrAj2tgLgEg7HI=;
        b=ZqOFjwRcgQNsxJzgnPTj8UaEb1Mcu8MzhFIVYULpvnAYE3iyd4GKe69IErHoKsJfKW
         BUYmwmgHfacxzWGKPI5lI0wCm1ADTHEkogiRXwfJtmq5yUpw2ZQdEdydMoa9w58arUMD
         zy+LFJcUNiZYVzBt9wWVEpxmDjJdQd52h6bRUxA1ixC2DAJdVXBfkYYsta3yscTkfJrO
         LKqJvfG7FjAvJkJCxN2k3Uyv2O89e7/dqRyZ54XRD5wY9R7onDmpjtk3PUMx9Wz1307Q
         VAhbaSQcI9oWwy4hETO3j93O4M8Mvu3ZMKt354KDutO9/k0My5sxOTPFQ7bTNE7uZkHK
         Yotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KsYtJJfLF/jVVqg18d3dXBYpXuPmMyrAj2tgLgEg7HI=;
        b=h5SlocVpdva5whzT2qiiTgbdcQs9QDvE5lQBetXGIiCO4xN+7aHB+SlxnacM+jMudf
         TIOHWteCDVrav5oFnNyPadbCRspiLkseO3WBY5Eil/NkKIVh/bmNqr1iurQ6QE+O+14c
         MVrZhfuDG6wBSUfmttjgHostXAKfRLbP7hHcMZbJtLSf5v4N4gm4iXvLszL5jhVkBqkF
         2KuatqoqYBTM+7D33iGK+JaHi8VH6YUGXGA56Amwz3y723aVgJcHX6U8+31gXz/5ZjFw
         woc0nDyz78IHRJRHN9FKqXsWaRQqiFNpXVj4R1qyw8qpYmZnFu77wz3aoeZEhQ1hhmum
         Q95A==
X-Gm-Message-State: AOAM5338iY92JkaoOQuTkk1kB1VF3wuLs7R20iJMKmwYqyA/zkTLqimG
        ckvqxzdxzyIL7XLP5Qy4NUP7hQL9Wg==
X-Google-Smtp-Source: ABdhPJyrKGzdmonPdVvx7/R7RFPn4yg08tdo0ObQH1NiaJRPaNev/x+BZTX3pMItcbPPVr0UcpSJPw==
X-Received: by 2002:a05:6e02:11a3:: with SMTP id 3mr14353831ilj.84.1590876709416;
        Sat, 30 May 2020 15:11:49 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id w78sm2735698ilk.14.2020.05.30.15.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 15:11:49 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 10/10] x86/percpu: Remove unused PER_CPU() macro
Date:   Sat, 30 May 2020 18:11:27 -0400
Message-Id: <20200530221127.459704-11-brgerst@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200530221127.459704-1-brgerst@gmail.com>
References: <20200530221127.459704-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also remove now unused __percpu_mov_op.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/percpu.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index cf2b9c2a241e..a3c33b79fb86 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -4,33 +4,15 @@
 
 #ifdef CONFIG_X86_64
 #define __percpu_seg		gs
-#define __percpu_mov_op		movq
 #else
 #define __percpu_seg		fs
-#define __percpu_mov_op		movl
 #endif
 
 #ifdef __ASSEMBLY__
 
-/*
- * PER_CPU finds an address of a per-cpu variable.
- *
- * Args:
- *    var - variable name
- *    reg - 32bit register
- *
- * The resulting address is stored in the "reg" argument.
- *
- * Example:
- *    PER_CPU(cpu_gdt_descr, %ebx)
- */
 #ifdef CONFIG_SMP
-#define PER_CPU(var, reg)						\
-	__percpu_mov_op %__percpu_seg:this_cpu_off, reg;		\
-	lea var(reg), reg
 #define PER_CPU_VAR(var)	%__percpu_seg:var
 #else /* ! SMP */
-#define PER_CPU(var, reg)	__percpu_mov_op $var, reg
 #define PER_CPU_VAR(var)	var
 #endif	/* SMP */
 
-- 
2.25.4

