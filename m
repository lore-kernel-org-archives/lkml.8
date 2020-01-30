Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADC4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2958206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c62MQ+Mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgA3SAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:00:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46076 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgA3SAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:00:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so2022113pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 10:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bpcbVebQMddVeSOdQYLefZ6gpfj1PnXmD5uZeNqvneY=;
        b=c62MQ+Mr49Lf+AKq6Ooxx01eMlVpwUC94FEWJIf0le/xPYYXPgzNKS70R/EkjXV7n1
         w6A6sDUIRHyVegnrqYo/kqzvig9MswHecET09VQ3Vl298frizQbaIEpskulEFhmQGElY
         RB08UUtBAq/R7uZi0/R0lUg0XZbrDuLebAmKhkihk7fekBM9y+AWP8pfJYCInyFZiPWg
         /s3I8SJvzS3B7tQN9x0tpHotneAPGQXUxBa3mhLqdNi4bKFPnnj59lhuIEd/MPQ9YnrB
         t6r/k5kMbAx815QrHGbeVBuBqcOQl+te2tlJaCgewhlnOI+hk/AY0rNEDWfUmvsokxdA
         ZXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bpcbVebQMddVeSOdQYLefZ6gpfj1PnXmD5uZeNqvneY=;
        b=VQf0rc09XhWTWtfnWHr4qzWvIgIjY2f7QpyMPQ/IhHLqTaJNjrP2mXJtQ+kDSwJYv2
         BRbuBcmWHgJRRjdUxyUEKoY/HLmnHIIDgevpC1LZy9IAjHlyhSQe591QDcLaymkopnjF
         RTdVZS4kkAq0A9DJGBSUe4jH2WPUuSB0FArpslLP4OFffGZTMiMFjJGNCgzWAAzN1Uki
         31cmSJxirB5Y+Edc0cXsCLIUf1Z0kpgC45pHdx6ImWDerVElCdBCPIonl7yPxcf98kl4
         V46+1IEq+3jQQkq6KPOCvoyvvIb1kgUoB6RhFTCSBw4gnzLa7PrTiy1MjGMibTnwQ9Cr
         VC3Q==
X-Gm-Message-State: APjAAAVK6g3xEutk2zN/w7Q7gnWMId93Qu9bsV+nuqOlpuPFBXKBVXGI
        rrh/br+ypliblS5EItIHQ3o=
X-Google-Smtp-Source: APXvYqzGAblEZZfh3pLwJQVKwRaYggWGdw4o1XfZdQq1iCyg6J+swomrVs2SkmbQOO/swbGFvf2vtg==
X-Received: by 2002:a63:696:: with SMTP id 144mr6205330pgg.260.1580407252164;
        Thu, 30 Jan 2020 10:00:52 -0800 (PST)
Received: from gnu-efi-2.localdomain ([2607:fb90:a7b9:27d7:eac5:2229:91f5:d315])
        by smtp.gmail.com with ESMTPSA id k12sm7004764pgm.65.2020.01.30.10.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 10:00:51 -0800 (PST)
Received: from gnu-efi-2.localdomain (localhost [IPv6:::1])
        by gnu-efi-2.localdomain (Postfix) with ESMTP id 170E9100820;
        Thu, 30 Jan 2020 10:00:49 -0800 (PST)
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH] x86: Don't discard .exit.text and .exit.data at link-time
Date:   Thu, 30 Jan 2020 10:00:48 -0800
Message-Id: <20200130180048.2901-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since .exit.text and .exit.data sections are discarded at runtime, we
should undefine EXIT_TEXT and EXIT_DATA to exclude .exit.text and
.exit.data sections from default discarded sections.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 arch/x86/kernel/vmlinux.lds.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index d1b942365d27..fb2c45cb1d1f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -416,6 +416,12 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 
+	/* Sections to be discarded.  EXIT_TEXT and EXIT_DATA discard at runtime.
+	 * not link time.  */
+#undef EXIT_TEXT
+#define EXIT_TEXT
+#undef EXIT_DATA
+#define EXIT_DATA
 	DISCARDS
 	/DISCARD/ : {
 		*(.eh_frame)
-- 
2.24.1

