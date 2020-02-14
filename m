Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41029C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0808A24650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op+DJXg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgBNUs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:48:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40174 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgBNUs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id t3so12461575wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XMs68JYJiHMkbWsOWCdmLNyy+CkM2pYNVCHILFKHUV0=;
        b=Op+DJXg4lC65k9HlSNxUOkbig946q6ftrmK2unYcv9BmKB12UBC5HR4/ye5qcFOuHd
         9s8Hr2AJYd39xumi2cpD2iLpDVNiGmyTH+ieorDplcl1Wkqb5A/gx3wCNucBMRj96XD3
         ELd9FpzoZUMWsdTeU43g2JAVMcIbmqXyBf+dEKuOu2gldOiaLaMVMUwTID+ZXg7hQrJ7
         3lLnSc+WqS+7G6wbV+jIsfTgoNQWNvFY5GYNbYA6TeXnJ4Fg7aBJ8NXeNF9c9yqNvu9Z
         akuMeUsfDiOQ11c7ePpjUyOmNS7a2R6UMmn+89DG7ruUMD5Ji5YINF5V8PPpQBkSbTr6
         ekmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMs68JYJiHMkbWsOWCdmLNyy+CkM2pYNVCHILFKHUV0=;
        b=oizSUQ1fRT+ZkB3PRFZ10MMjpX+urZfT6PCS6QuP25YJ5TUpkYXQV1kGQlCCug433L
         WECHx1iYGBHLDvxWpMVmUQwP/SaBHHNRXfuwhcAh3R9G19nGK+mNy0Kl8qEikW91Hw0s
         rt8zlXssmfO7pCwR+/AZGbsNUgqS5XGntlgBM2ytMmxmT5q+0BmpTd6x1yIDilIosDh9
         dEqlo/UQkyJdE19gzGvuat65UALN5mg4OxfgNJiproU+gAp6e/Rz31CZvrRBbaAoBeEA
         ypiBOXVZFnmlKs9Ylj390Lsk4rwtOV+ggesl4LtXTfzCDqyT8LL9VHDyIqrP1dOAoxvL
         WzGw==
X-Gm-Message-State: APjAAAXVBWz+JLQlWWyNWNBO8JkuvcnmFu0u4xq2uJz93ni/cBRn5460
        PDUpxWNvcinWNfU28agUwgMHhcLfjvD8
X-Google-Smtp-Source: APXvYqzHVOSMfNZT1PvsLVgwvfDCsUxZp01eHtSfZcoB9ZoNKtOpJ3uo83hLeOEzge0nbNTWyZ0ZJg==
X-Received: by 2002:adf:ed0c:: with SMTP id a12mr5803444wro.368.1581713304699;
        Fri, 14 Feb 2020 12:48:24 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:24 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Neil Horman <nhorman@tuxdriver.com>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH 01/30] x86/apic/vector: Add missing annotation to lock_vector_lock(void)
Date:   Fri, 14 Feb 2020 20:47:12 +0000
Message-Id: <20200214204741.94112-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at lock_vector_lock(void)

warning: context imbalance in lock_vector_lock() - wrong count at exit

The root cause is the missing annotation at lock_vector_lock(void)
Add the missing  __acquires(&vector_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 arch/x86/kernel/apic/vector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 2c5676b0a6e7..d7556939c6cf 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -47,7 +47,7 @@ static struct irq_matrix *vector_matrix;
 static DEFINE_PER_CPU(struct hlist_head, cleanup_list);
 #endif
 
-void lock_vector_lock(void)
+void lock_vector_lock(void) __acquires(&vector_lock)
 {
 	/* Used to the online set of cpus does not change
 	 * during assign_irq_vector.
-- 
2.24.1

