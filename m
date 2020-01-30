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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31560C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C0620CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLNPfSYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgA3Wpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:45:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37871 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgA3Wpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:45:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so2245837pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h7XqBAsrYIK8FLRIT9H/d4BITTm+9Id5ebdTfElvMn0=;
        b=iLNPfSYtx11W34RpnVI2MTCu+nXOwbO/qPSz9xuxi02xZhKlpnq2xtgv+A8eSZlUPT
         AdBBzZNQjHT8jeCmkjbGpk+QutXQbSP9LJbE13Q7BimRBuQjIkqK3nBoIXVzpMaEMIed
         I77CUqH4DEpfg/Gd1y7ljoizStQ9R3ImHTpbAC+kOD2lfLwctKlvp+cTjkZPvmT0PRXe
         JCOQgeUrnhrPjB/kQmcl7qm0ob/lo2+AwXaHUlpimD8FpQQMFL5+GEQb6Sl2rcRU7cx/
         HN/Tqefo/S2EegMJ9ctVEiYguKmnYf0KXgQoSxYe9iahDAgrSJs8olxhvgWIfCu+6T8S
         ABGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h7XqBAsrYIK8FLRIT9H/d4BITTm+9Id5ebdTfElvMn0=;
        b=Y+umU2r10becv88uT7zcQjtasDDE0wGsArS4dA3G+ICXERsBaIbYUssvWdG/s2JiVS
         8iW7DbTBA4i0znDuVZw6YBPpW+CBrL2DN8f+orqcY+++ajFNshMvJl6ZMY7e4a7byKiI
         booGXXxYEqzGv338KzpOdcnjIm7JVEyLCFwcUnxl9wiJWziS2/crGirMqhfqe15QM9Oh
         EznY2DSE8/08Gn/w9Y9YENr8wkTrsGFcHKSAHREDK4wZxgArom2DttZg9RqA9aI0Vz23
         0EwkyElVjC+NncUPW7hATurnwREPMUokxlrtl9alQzVD4zGln54G6xjnJMqlxF+5bh4U
         IR2A==
X-Gm-Message-State: APjAAAWDKE+rsLw9v3bw9MxrAD3FGZnRalpoE/IP3EbFbCun1chxokrh
        kGAlcJGs3mhDSBc9XPEFzYE=
X-Google-Smtp-Source: APXvYqxMcluY7JT5XLaxgwa3WBBRDX8Oxa9fDzEWTdNI5E6ZrGIjD21R86MA8eik40vbB3xNMFaB7Q==
X-Received: by 2002:a63:5b0e:: with SMTP id p14mr7313672pgb.315.1580424333056;
        Thu, 30 Jan 2020 14:45:33 -0800 (PST)
Received: from gnu-efi-2.localdomain ([2607:fb90:a75c:e5dc:7703:db9b:85b8:a043])
        by smtp.gmail.com with ESMTPSA id d14sm7938731pfq.117.2020.01.30.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 14:45:32 -0800 (PST)
Received: from gnu-efi-2.localdomain (localhost [127.0.0.1])
        by gnu-efi-2.localdomain (Postfix) with ESMTP id C66DC1007FF;
        Thu, 30 Jan 2020 14:43:37 -0800 (PST)
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
Subject: [PATCH] Add RUNTIME_DISCARD_EXIT to generic DISCARDS
Date:   Thu, 30 Jan 2020 14:43:36 -0800
Message-Id: <20200130224337.4150-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In x86 kernel, .exit.text and .exit.data sections are discarded at
runtime, not by linker.  Add RUNTIME_DISCARD_EXIT to generic DISCARDS
and define it in x86 kernel linker script to keep them.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S     |  1 +
 include/asm-generic/vmlinux.lds.h | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e3296aa028fe..7206e1ac23dd 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -21,6 +21,7 @@
 #define LOAD_OFFSET __START_KERNEL_map
 #endif
 
+#define RUNTIME_DISCARD_EXIT
 #define EMITS_PT_NOTE
 #define RO_EXCEPTION_TABLE_ALIGN	16
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e00f41aa8ec4..6b943fb8c5fd 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -894,10 +894,16 @@
  * section definitions so that such archs put those in earlier section
  * definitions.
  */
+#ifdef RUNTIME_DISCARD_EXIT
+#define EXIT_DISCARDS
+#else
+#define EXIT_DISCARDS							\
+	EXIT_TEXT							\
+	EXIT_DATA
+#endif
 #define DISCARDS							\
 	/DISCARD/ : {							\
-	EXIT_TEXT							\
-	EXIT_DATA							\
+	EXIT_DISCARDS							\
 	EXIT_CALL							\
 	*(.discard)							\
 	*(.discard.*)							\
-- 
2.24.1

