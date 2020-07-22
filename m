Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E325C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFD2206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8EUVZgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgGVQpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgGVQpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:45:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ABFC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:45:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so2619124wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6iEzS/K7FKWZpD3ua8htStuWzJAGtakSYjlBsBpxZ/4=;
        b=l8EUVZgCpIRU1QL7F3sHnMulBx+ndcr+hiyAH/9TDLEfZ3e4nRnvYcMRlw8pJ1RZDD
         usP3/tJ/orr9olI8t2Qx+Sj/5tEnhSWSaxwGyGsDcxf+AzwpzLvAQgo1GARi5BT9Pose
         fSVvL492qfWaMefMcn5RNZm4KMBSxUa2R4mITHBHTG4G42tVvAyz5XC8X1EHjDPKKVTC
         gnO+1g9xzqhkqboMF9feb+jULlJjKVO8BTsdu5IB3Jql+dhjkP+s/fUtYQxamWeUqX3k
         YELPwGsw80aBmerABn4F7VHRlZuY5XWbtJqzVum5e1OoTgXIAeaBwQQFl2H3zHD4YBs6
         8Exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6iEzS/K7FKWZpD3ua8htStuWzJAGtakSYjlBsBpxZ/4=;
        b=ZJSvXm6kk+/kZmhzJbFY8sk3Ulmfkjy6OkltK/ngsNlLbHTFuzqR9ucqERITw8WxWp
         26J+c6E7t3xIR14ZJKH5/YxapA40QAL9ITYMKwDhjG4PdsfcTITnHnnFJQyrHzNo2iv3
         8F5t1RfSjbvh0uW8FxAAspT85gja6E9+B4QPPCck1WbMz23bOTFXlx3CRK2HmW/inOqn
         NMdj0guugZ55k7TrAknb4VhgpQsLVa+vc7pmVdqKyjVoo28xB/Z/rL+JlaAwNTFQiRKU
         1da9WQhniKQyNhKpJaEnay0iEtPuD3WODLRbo2u5ONUz1VPdlJEgUMtg3TsYop+yp3nf
         eZIQ==
X-Gm-Message-State: AOAM531wdwXV95ZYXonkRGgBwmYsWgXGU64RjdgMmEmR4iHu4J1bdn/w
        +xIKujEG7PEu0BLuHm7u5SpgrQ==
X-Google-Smtp-Source: ABdhPJyvvcrdUvKbE/hxCmWbSibjaaJ7nEtZ3HDL894GJKBpxshjcuwx5vl2E/hVxnCbvqkXRidabQ==
X-Received: by 2002:a1c:a756:: with SMTP id q83mr457233wme.168.1595436300851;
        Wed, 22 Jul 2020 09:45:00 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
        by smtp.gmail.com with ESMTPSA id u20sm265826wmm.15.2020.07.22.09.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:45:00 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@google.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 1/9] Macros to override naming of percpu symbols and sections
Date:   Wed, 22 Jul 2020 17:44:16 +0100
Message-Id: <20200722164424.42225-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify generic linker script macros to generate section/symbol names for
percpu area using overridable macros. No functional changes.

This will allow arm64 linker script to define a second KVM-specific percpu
data section using the generic PERCPU_SECTION macro.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 include/asm-generic/vmlinux.lds.h | 40 +++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef218d7..1bfc002ecfce 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -892,6 +892,20 @@
 #define INIT_RAM_FS
 #endif
 
+/*
+ * Macros to override the naming of percpu symbols and sections.
+ * Used by arm64 linker script to define a separate percpu area for KVM.
+ */
+#define PERCPU_SECTION_BASE_NAME .data..percpu
+
+#ifndef PERCPU_SECTION_NAME
+#define PERCPU_SECTION_NAME(suffix) PERCPU_SECTION_BASE_NAME ## suffix
+#endif
+
+#ifndef PERCPU_SYMBOL_NAME
+#define PERCPU_SYMBOL_NAME(name) name
+#endif
+
 /*
  * Memory encryption operates on a page basis. Since we need to clear
  * the memory encryption mask for this section, it needs to be aligned
@@ -903,7 +917,7 @@
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 #define PERCPU_DECRYPTED_SECTION					\
 	. = ALIGN(PAGE_SIZE);						\
-	*(.data..percpu..decrypted)					\
+	*(PERCPU_SECTION_NAME(..decrypted))				\
 	. = ALIGN(PAGE_SIZE);
 #else
 #define PERCPU_DECRYPTED_SECTION
@@ -947,17 +961,17 @@
  * sharing between subsections for different purposes.
  */
 #define PERCPU_INPUT(cacheline)						\
-	__per_cpu_start = .;						\
-	*(.data..percpu..first)						\
+	PERCPU_SYMBOL_NAME(__per_cpu_start) = .;			\
+	*(PERCPU_SECTION_NAME(..first))					\
 	. = ALIGN(PAGE_SIZE);						\
-	*(.data..percpu..page_aligned)					\
+	*(PERCPU_SECTION_NAME(..page_aligned))				\
 	. = ALIGN(cacheline);						\
-	*(.data..percpu..read_mostly)					\
+	*(PERCPU_SECTION_NAME(..read_mostly))				\
 	. = ALIGN(cacheline);						\
-	*(.data..percpu)						\
-	*(.data..percpu..shared_aligned)				\
+	*(PERCPU_SECTION_NAME())					\
+	*(PERCPU_SECTION_NAME(..shared_aligned))			\
 	PERCPU_DECRYPTED_SECTION					\
-	__per_cpu_end = .;
+	PERCPU_SYMBOL_NAME(__per_cpu_end) = .;
 
 /**
  * PERCPU_VADDR - define output section for percpu area
@@ -984,11 +998,11 @@
  * address, use PERCPU_SECTION.
  */
 #define PERCPU_VADDR(cacheline, vaddr, phdr)				\
-	__per_cpu_load = .;						\
-	.data..percpu vaddr : AT(__per_cpu_load - LOAD_OFFSET) {	\
+	PERCPU_SYMBOL_NAME(__per_cpu_load) = .;				\
+	PERCPU_SECTION_NAME() vaddr : AT(PERCPU_SYMBOL_NAME(__per_cpu_load) - LOAD_OFFSET) { \
 		PERCPU_INPUT(cacheline)					\
 	} phdr								\
-	. = __per_cpu_load + SIZEOF(.data..percpu);
+	. = PERCPU_SYMBOL_NAME(__per_cpu_load) + SIZEOF(PERCPU_SECTION_NAME());
 
 /**
  * PERCPU_SECTION - define output section for percpu area, simple version
@@ -1004,8 +1018,8 @@
  */
 #define PERCPU_SECTION(cacheline)					\
 	. = ALIGN(PAGE_SIZE);						\
-	.data..percpu	: AT(ADDR(.data..percpu) - LOAD_OFFSET) {	\
-		__per_cpu_load = .;					\
+	PERCPU_SECTION_NAME() : AT(ADDR(PERCPU_SECTION_NAME()) - LOAD_OFFSET) { \
+		PERCPU_SYMBOL_NAME(__per_cpu_load) = .;			\
 		PERCPU_INPUT(cacheline)					\
 	}
 
-- 
2.27.0

