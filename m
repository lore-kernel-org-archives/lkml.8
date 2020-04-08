Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5641C2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD83120747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mPZ6G/Dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgDHH5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:57:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40363 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgDHH5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:57:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so2231557plk.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 00:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Quhy5/QZPA8/P4q/9fnjufmjHKuWjkZaQYF9/wabbVw=;
        b=mPZ6G/DvSUkmvJrsHi7YzN51egMqhQiZtrVAWVMnop5ZSHgLEIBO5VaJpn2sJ8xXc5
         ceGghSnnkHeQjGqVbbP2GSy0IaxBEEDD6Uf8jv9x8gIZlTQBljt2bYXg6NVDSFCdlCZu
         8816ZszTSt5DuxQO6UH5wDNaGBBzdvNleauumy+j4WmLKypcrS3dk46ERhxQb0XuNgpI
         ZF9HkUjimJRUSoU1j4w7FGVsVl7LPc7yXlvcMju/o9Dfbc/lTI3GZnewD5hzYZvIjtsT
         F2Kr+fHNYLd4hVK2lKG/xFoBanJbWknoy5vYCfoT2CFkMrgBE5EeLDHzF4N5HwLlEfYh
         7lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Quhy5/QZPA8/P4q/9fnjufmjHKuWjkZaQYF9/wabbVw=;
        b=b+46UimXIn2K2kUhqNrp3qgqV8uDMLbVoifcwGZwvHZSBuJdFQZyErEWwNDBrmDi9m
         yGNZsI62KN9I312MquSMqan72djNPikzATF8OdeARnh3QrLZLEeT3sAHO2htrNLY6XEm
         gPf2KJRQpC43njqNELwXtL4zALdpKl/rJb/Dpfs+PnoWpQjEJScBNoAIXARcdxtRysT/
         xNggeuuvL2itLCKaxPmGJ9G3tqWjIfOzdU1EuzHKU9xHKCCkhnXNha5pZL6w0aCfpiM0
         NvB6h6LU32RPYf+13fL+QaC/1nrQxjH9DbZyh0Mq8Ddj1lXU9nkQem4mco7W7gT+yinu
         jOtw==
X-Gm-Message-State: AGi0PuZnFFdRxAIi/a4S4JAjqCtKq9q2HvIUNmRlHSFWw0KlQkmlMbtq
        gdtluxfDBs6u6aKuwNt/uEzsqQ==
X-Google-Smtp-Source: APiQypJXFX/0Lnb7UwEs543bcGfXQmbM061XO3WoufDW75ChPwGGHilbdAdbTBnLkBOrX4EDrVWkHw==
X-Received: by 2002:a17:90a:65c5:: with SMTP id i5mr2480742pjs.18.1586332642779;
        Wed, 08 Apr 2020 00:57:22 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d85sm485599pfd.157.2020.04.08.00.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 00:57:22 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v5 7/9] riscv: move exception table immediately after RO_DATA
Date:   Wed,  8 Apr 2020 15:57:02 +0800
Message-Id: <6dba29ff224e253bcacc7891caecadb5666d8059.1586332296.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586332296.git.zong.li@sifive.com>
References: <cover.1586332296.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move EXCEPTION_TABLE immediately after RO_DATA. Make it easy to set the
attribution of the sections which should be read-only at a time.
Add _data to specify the start of data section with write permission.
This patch is prepared for STRICT_KERNEL_RWX support.

Signed-off-by: Zong Li <zong.li@sifive.com>
Suggested-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/kernel/vmlinux.lds.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 1e0193ded420..02e948b620af 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -58,6 +58,10 @@ SECTIONS
 		*(.srodata*)
 	}
 
+	EXCEPTION_TABLE(0x10)
+
+	_data = .;
+
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
 	.sdata : {
 		__global_pointer$ = . + 0x800;
@@ -69,8 +73,6 @@ SECTIONS
 
 	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
 
-	EXCEPTION_TABLE(0x10)
-
 	.rel.dyn : {
 		*(.rel.dyn*)
 	}
-- 
2.26.0

