Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D27C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA4F2469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kf+gX5xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbgB1AXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:23:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38186 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbgB1AW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:22:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so732351pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A992AjdJWLXJEjwtDWIJFXaA8r8Mu1S3gNtRzAo3spo=;
        b=Kf+gX5xddQKiKpPCh8bEqjWUqToYjUe3/Z9DWP7hzU0kpjC0HzX02FDHpmOXXOwPyC
         RQr5vgHl1MrkXOGQjyy45mc7XGMezFVZ2pKsfS+w2wtn0sI0CA8B9URb5ueTsQrTkFPO
         zN9DFPXLMUeWvltrwG3QFCbnPtEHU7Jjtr6Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A992AjdJWLXJEjwtDWIJFXaA8r8Mu1S3gNtRzAo3spo=;
        b=FrFqN9PFOhGwZlJCWPfcUVvVSmPO+QecwtCAx037c2C9kK2SRAz0YHCYFlU7Gh0cz4
         YwrnpZqRNXZ1XS1tNCVOlrKOFPv8QuWHeLwbIPukdY8BnaZU9p1tojSmtx9P4UmbdgE5
         M/MoPSRVX7bBg2VEM9hXvzCx88hn+2CgCZUauLAAPstPcneTCpukx4j7o3fFXfmjMJlT
         y7+QulHJqNa99eTQmTqbGa3jPWed0G6uVa6nbUefTFpG/hFdHCjHrUeezJ/qcWoIY0Nd
         BdbtXeQm/ZCbny4mugnJq/Sgx8IZBDOU1giLikDKqsakkdhyEnd2nyhs1VqE7M2qgs4M
         iMwg==
X-Gm-Message-State: APjAAAXmasPJuQJ6sCju2L8P7CnrJND4WZwj20dm4Ii1cxcTNF3eWLkz
        bUcF0u6AqqKLDEVPKGvw392eQA==
X-Google-Smtp-Source: APXvYqxORpz2NBO4YgeiTAddpXfXe3J/AmESIDy/gZRMg/FCrltSGt039dZiZFkPpl/Q4pPd1+W1MA==
X-Received: by 2002:a63:7207:: with SMTP id n7mr1872186pgc.253.1582849375359;
        Thu, 27 Feb 2020 16:22:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b3sm8714061pft.73.2020.02.27.16.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:22:52 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] Add RUNTIME_DISCARD_EXIT to generic DISCARDS
Date:   Thu, 27 Feb 2020 16:22:40 -0800
Message-Id: <20200228002244.15240-6-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228002244.15240-1-keescook@chromium.org>
References: <20200228002244.15240-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H.J. Lu" <hjl.tools@gmail.com>

In x86 kernel, .exit.text and .exit.data sections are discarded at
runtime, not by linker.  Add RUNTIME_DISCARD_EXIT to generic DISCARDS
and define it in x86 kernel linker script to keep them.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Link: https://lore.kernel.org/r/20200130224337.4150-1-hjl.tools@gmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S     |  1 +
 include/asm-generic/vmlinux.lds.h | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1e345f302a46..1e12c097d09b 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -21,6 +21,7 @@
 #define LOAD_OFFSET __START_KERNEL_map
 #endif
 
+#define RUNTIME_DISCARD_EXIT
 #define EMITS_PT_NOTE
 #define RO_EXCEPTION_TABLE_ALIGN	16
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 303597e51396..1797f2c9bb41 100644
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
2.20.1

