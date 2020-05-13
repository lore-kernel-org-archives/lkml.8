Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67013C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1327720671
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DG0DErJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbgEMSwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:52:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28488 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732990AbgEMSww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589395970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=izj75eA8qUg9h4nL2GwzYuH/rvKXm4fOWTZ49lsEjYs=;
        b=DG0DErJTc7eJtloCX1FQ6hoym3Av6B5NizNNYs6BvJ5B5gmrQzONZ0FnEXEfMETGnLYH9C
        9MyiIb9Et6rhMZLVXYdMVb2OaW2kZJlnlAptOT2I0+pAnzJJ6zbAOf9Y0eLCDQIqC32ZIs
        HsU+iu2tSXMtZ1kdUkiYOUhg4Yldzjs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-7sMQR_M-PWSRQs2pZsIJDQ-1; Wed, 13 May 2020 14:52:49 -0400
X-MC-Unique: 7sMQR_M-PWSRQs2pZsIJDQ-1
Received: by mail-pg1-f199.google.com with SMTP id s188so299670pgc.17
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=izj75eA8qUg9h4nL2GwzYuH/rvKXm4fOWTZ49lsEjYs=;
        b=F+In5MG11yjk0HGPfmr28CBvozuoNCJluMIHKy87jSX+j9+5yMudRBrPwWYCK778YE
         nhevRcEduthwJpr5mk1CB+DONyYe7AxXezNmXFXA97cnqw9pW+SQNtatxpYrXXGlYJN5
         mXyD06YTiHtWQkTTuTWl9ZGZx+yduvgLCsjke5nlJ6A5JIHcGb+2/RE7O6IgeAdkZq5D
         jW2p+9BzM1frsfNx2DwZE8sZalJZY+jyCranEbTwnKGH67hzD7H//ubIRB0Qw2Y8MriP
         K4aUgHYD6VwLbhsNRk4z2+F9LvLM6603VuMOVBbp2eftAortbEfefIglg0cSfQ4unrqP
         7ilQ==
X-Gm-Message-State: AGi0PuYQIcjEtSk30SJ7+13ZtpNyM7yCnKp5Zb96YsO2H7WY+6fWjf8v
        gJYRrZzJFIeV3BWFU1vr0/3xch4NEfooEqr2sBYxH69fjtbGXgMrfddMDxBTBuX6jbU8uPC5Iqn
        BDavY9Sbib3eWfTl/VUZlleye
X-Received: by 2002:a17:90b:957:: with SMTP id dw23mr36890003pjb.101.1589395967883;
        Wed, 13 May 2020 11:52:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypIUoH47tRnLfSqut0ZmslcTFLWt4zJqrM5AJrrszLhn3W9AzXL/43kjytAFi2CPzyIbgMCYKQ==
X-Received: by 2002:a17:90b:957:: with SMTP id dw23mr36889975pjb.101.1589395967645;
        Wed, 13 May 2020 11:52:47 -0700 (PDT)
Received: from localhost ([122.177.166.225])
        by smtp.gmail.com with ESMTPSA id h5sm15945895pjv.4.2020.05.13.11.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 11:52:47 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: [PATCH v6 2/2] arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
Date:   Thu, 14 May 2020 00:22:37 +0530
Message-Id: <1589395957-24628-3-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vabits_actual variable on arm64 indicates the actual VA space size,
and allows a single binary to support both 48-bit and 52-bit VA
spaces.

If the ARMv8.2-LVA optional feature is present, and we are running
with a 64KB page size; then it is possible to use 52-bits of address
space for both userspace and kernel addresses. However, any kernel
binary that supports 52-bit must also be able to fall back to 48-bit
at early boot time if the hardware feature is not present.

Since TCR_EL1.T1SZ indicates the size offset of the memory region
addressed by TTBR1_EL1 (and hence can be used for determining the
vabits_actual value) it makes more sense to export the same in
vmcoreinfo rather than vabits_actual variable, as the name of the
variable can change in future kernel versions, but the architectural
constructs like TCR_EL1.T1SZ can be used better to indicate intended
specific fields to user-space.

User-space utilities like makedumpfile and crash-utility, need to
read this value from vmcoreinfo for determining if a virtual
address lies in the linear map range.

While at it also add documentation for TCR_EL1.T1SZ variable being
added to vmcoreinfo.

It indicates the size offset of the memory region addressed by TTBR1_EL1

Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Tested-by: John Donnelly <john.p.donnelly@oracle.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 11 +++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h         |  1 +
 arch/arm64/kernel/crash_core.c                 | 10 ++++++++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 2a632020f809..2baad0bfb09d 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -404,6 +404,17 @@ KERNELPACMASK
 The mask to extract the Pointer Authentication Code from a kernel virtual
 address.
 
+TCR_EL1.T1SZ
+------------
+
+Indicates the size offset of the memory region addressed by TTBR1_EL1.
+The region size is 2^(64-T1SZ) bytes.
+
+TTBR1_EL1 is the table base address register specified by ARMv8-A
+architecture which is used to lookup the page-tables for the Virtual
+addresses in the higher VA range (refer to ARMv8 ARM document for
+more details).
+
 arm
 ===
 
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 6bf5e650da78..a1861af97ac9 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -216,6 +216,7 @@
 #define TCR_TxSZ(x)		(TCR_T0SZ(x) | TCR_T1SZ(x))
 #define TCR_TxSZ_WIDTH		6
 #define TCR_T0SZ_MASK		(((UL(1) << TCR_TxSZ_WIDTH) - 1) << TCR_T0SZ_OFFSET)
+#define TCR_T1SZ_MASK		(((UL(1) << TCR_TxSZ_WIDTH) - 1) << TCR_T1SZ_OFFSET)
 
 #define TCR_EPD0_SHIFT		7
 #define TCR_EPD0_MASK		(UL(1) << TCR_EPD0_SHIFT)
diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
index 1f646b07e3e9..314391a156ee 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -7,6 +7,14 @@
 #include <linux/crash_core.h>
 #include <asm/cpufeature.h>
 #include <asm/memory.h>
+#include <asm/pgtable-hwdef.h>
+
+static inline u64 get_tcr_el1_t1sz(void);
+
+static inline u64 get_tcr_el1_t1sz(void)
+{
+	return (read_sysreg(tcr_el1) & TCR_T1SZ_MASK) >> TCR_T1SZ_OFFSET;
+}
 
 void arch_crash_save_vmcoreinfo(void)
 {
@@ -16,6 +24,8 @@ void arch_crash_save_vmcoreinfo(void)
 						kimage_voffset);
 	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
 						PHYS_OFFSET);
+	vmcoreinfo_append_str("NUMBER(TCR_EL1_T1SZ)=0x%llx\n",
+						get_tcr_el1_t1sz());
 	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
 	vmcoreinfo_append_str("NUMBER(KERNELPACMASK)=0x%llx\n",
 						system_supports_address_auth() ?
-- 
2.7.4

