Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CB6C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC53206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6urJF7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgEEUuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:50:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33046 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729265AbgEEUuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588711811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+i51Ha4bs/4ULVhajuG3RkAMPQ+kdK19W/W0g9ijW3E=;
        b=J6urJF7mk42PbRR7PP2iJmOnyfrhYD6413KqBzl5MOE/3TBuwFqsrwuecTSbWv8AEgnj4K
        vZQCmwqvjy5CD2+WSbNRGsIgWaBh3/U/ULh70kDmrUmMldtY/ZPAgrSsx1KDQPw2UkeHrM
        2WIC+xQQzdI3dgbPCwSCxDf6Gn6zAts=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-3U--1eUONTKzesoAIu0pLQ-1; Tue, 05 May 2020 16:50:08 -0400
X-MC-Unique: 3U--1eUONTKzesoAIu0pLQ-1
Received: by mail-qt1-f200.google.com with SMTP id g23so184369qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 13:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+i51Ha4bs/4ULVhajuG3RkAMPQ+kdK19W/W0g9ijW3E=;
        b=kvVXgJZKLYBpCmRPfx1hqqL3FJyv812OrJ8hvsZFcTsH62PhEjQzSy1b7aVSnGJo/F
         wAKFS6hGGC0BV1KWwyInteo30X3mLLR3OUPILCnLvUnw5XmuHbDnS5LQXJ8F2thPpTZg
         Vs8/zbJDO0pSQbQaJhtg0BSa5AwJPg17UV8DSs8ab6CxzwNkBGjVm0hrlo98ZjSkgwjw
         8JYpw+GS9mPs80E/RcpNZi7NdCp5/Nd1BrJjBvgFya2e9+flg09jQ2nSoq0WZR/Yh5NG
         Tq/EchKNG7nog4IcXggqTwmunnqUay0kEF/7PpmhheEMRHqicCDslAjpIJahJrvsFzuo
         oclQ==
X-Gm-Message-State: AGi0Pubjr67kimsJwXBdL7aVpVbXgXG7mA3txuICWDZc0/gLzItGDVfs
        3sOePD29F1FJOjl0h9cmGLmRrc7GY2TYaX0uOiWHATEc4q3r7bmm3YF5QfZHb9VjxKoWRb+3Ozo
        qU6bb2yCuWMJ7gO1UjrF6l1Mg
X-Received: by 2002:ac8:7b81:: with SMTP id p1mr4831927qtu.134.1588711807308;
        Tue, 05 May 2020 13:50:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypJb4XLD+Q9VUbIqkJDMJBxJkduRO5B1EdzMJarCykc9lbFGWccVRQzjM9LTaStil0KNFb63Sg==
X-Received: by 2002:ac8:7b81:: with SMTP id p1mr4831897qtu.134.1588711806925;
        Tue, 05 May 2020 13:50:06 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 193sm19380qkl.42.2020.05.05.13.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:50:06 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/3] KVM: selftests: Add KVM_SET_GUEST_DEBUG test
Date:   Tue,  5 May 2020 16:50:00 -0400
Message-Id: <20200505205000.188252-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505205000.188252-1-peterx@redhat.com>
References: <20200505205000.188252-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Covers fundamental tests for KVM_SET_GUEST_DEBUG. It is very close to the debug
test in kvm-unit-test, but doing it from outside the guest.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |   9 +
 .../testing/selftests/kvm/x86_64/debug_regs.c | 180 ++++++++++++++++++
 4 files changed, 192 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/debug_regs.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 712a2ddd2a27..44b6ef513164 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -28,6 +28,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/vmx_dirty_log_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_set_nested_state_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_tsc_adjust_test
 TEST_GEN_PROGS_x86_64 += x86_64/xss_msr_test
+TEST_GEN_PROGS_x86_64 += x86_64/debug_regs
 TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index a99b875f50d2..92e184a422ee 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -143,6 +143,8 @@ struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
 int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid);
+void vcpu_set_guest_debug(struct kvm_vm *vm, uint32_t vcpuid,
+			  struct kvm_guest_debug *debug);
 void vcpu_set_mp_state(struct kvm_vm *vm, uint32_t vcpuid,
 		       struct kvm_mp_state *mp_state);
 void vcpu_regs_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_regs *regs);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 8a3523d4434f..9622431069bc 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1201,6 +1201,15 @@ void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid)
 		    ret, errno);
 }
 
+void vcpu_set_guest_debug(struct kvm_vm *vm, uint32_t vcpuid,
+			  struct kvm_guest_debug *debug)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret = ioctl(vcpu->fd, KVM_SET_GUEST_DEBUG, debug);
+
+	TEST_ASSERT(ret == 0, "KVM_SET_GUEST_DEBUG failed: %d", ret);
+}
+
 /*
  * VM VCPU Set MP State
  *
diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
new file mode 100644
index 000000000000..2b7187db061d
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KVM guest debug register tests
+ *
+ * Copyright (C) 2020, Red Hat, Inc.
+ */
+#include <stdio.h>
+#include <string.h>
+#include "kvm_util.h"
+#include "processor.h"
+
+#define VCPU_ID 0
+
+/* For testing data access debug BP */
+uint32_t guest_value;
+
+extern unsigned char sw_bp, hw_bp, write_data, ss_start;
+
+static void guest_code(void)
+{
+	/*
+	 * Software BP tests.
+	 *
+	 * NOTE: sw_bp need to be before the cmd here, because int3 is an
+	 * exception rather than a normal trap for KVM_SET_GUEST_DEBUG (we
+	 * capture it using the vcpu exception bitmap).
+	 */
+	asm volatile("sw_bp: int3");
+
+	/* Hardware instruction BP test */
+	asm volatile("hw_bp: nop");
+
+	/* Hardware data BP test */
+	asm volatile("mov $1234,%%rax;\n\t"
+		     "mov %%rax,%0;\n\t write_data:"
+		     : "=m" (guest_value) : : "rax");
+
+	/* Single step test, covers 2 basic commands and 2 emulated */
+	asm volatile("ss_start: "
+		     "xor %%rax,%%rax\n\t"
+		     "cpuid\n\t"
+		     "movl $0x1a0,%%ecx\n\t"
+		     "rdmsr\n\t"
+		     : : : "rax", "ecx");
+
+	GUEST_DONE();
+}
+
+#define  CLEAR_DEBUG()  memset(&debug, 0, sizeof(debug))
+#define  APPLY_DEBUG()  vcpu_set_guest_debug(vm, VCPU_ID, &debug)
+#define  CAST_TO_RIP(v)  ((unsigned long long)&(v))
+#define  SET_RIP(v)  do {				\
+		vcpu_regs_get(vm, VCPU_ID, &regs);	\
+		regs.rip = (v);				\
+		vcpu_regs_set(vm, VCPU_ID, &regs);	\
+	} while (0)
+#define  MOVE_RIP(v)  SET_RIP(regs.rip + (v));
+
+int main(void)
+{
+	struct kvm_guest_debug debug;
+	unsigned long long target_dr6, target_rip;
+	struct kvm_regs regs;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	uint64_t cmd;
+	int i;
+	/* Corresponds to commands starts with ss_start */
+	int ss_size[4] = {
+		3,		/* xor */
+		2,		/* cpuid */
+		5,		/* mov */
+		2,		/* rdmsr */
+	};
+
+	if (!kvm_check_cap(KVM_CAP_SET_GUEST_DEBUG)) {
+		print_skip("KVM_CAP_SET_GUEST_DEBUG not supported");
+		return 0;
+	}
+
+	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
+	run = vcpu_state(vm, VCPU_ID);
+
+	/* Test software BPs - int3 */
+	CLEAR_DEBUG();
+	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
+	APPLY_DEBUG();
+	vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
+		    run->debug.arch.exception == BP_VECTOR &&
+		    run->debug.arch.pc == CAST_TO_RIP(sw_bp),
+		    "INT3: exit %d exception %d rip 0x%llx (should be 0x%llx)",
+		    run->exit_reason, run->debug.arch.exception,
+		    run->debug.arch.pc, CAST_TO_RIP(sw_bp));
+	MOVE_RIP(1);
+
+	/* Test instruction HW BP over DR[0-3] */
+	for (i = 0; i < 4; i++) {
+		CLEAR_DEBUG();
+		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW_BP;
+		debug.arch.debugreg[i] = CAST_TO_RIP(hw_bp);
+		debug.arch.debugreg[7] = 0x400 | (1UL << (2*i+1));
+		APPLY_DEBUG();
+		vcpu_run(vm, VCPU_ID);
+		target_dr6 = 0xffff0ff0 | (1UL << i);
+		TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
+			    run->debug.arch.exception == DB_VECTOR &&
+			    run->debug.arch.pc == CAST_TO_RIP(hw_bp) &&
+			    run->debug.arch.dr6 == target_dr6,
+			    "INS_HW_BP (DR%d): exit %d exception %d rip 0x%llx "
+			    "(should be 0x%llx) dr6 0x%llx (should be 0x%llx)",
+			    i, run->exit_reason, run->debug.arch.exception,
+			    run->debug.arch.pc, CAST_TO_RIP(hw_bp),
+			    run->debug.arch.dr6, target_dr6);
+	}
+	/* Skip "nop" */
+	MOVE_RIP(1);
+
+	/* Test data access HW BP over DR[0-3] */
+	for (i = 0; i < 4; i++) {
+		CLEAR_DEBUG();
+		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW_BP;
+		debug.arch.debugreg[i] = CAST_TO_RIP(guest_value);
+		debug.arch.debugreg[7] = 0x00000400 | (1UL << (2*i+1)) |
+		    (0x000d0000UL << (4*i));
+		APPLY_DEBUG();
+		vcpu_run(vm, VCPU_ID);
+		target_dr6 = 0xffff0ff0 | (1UL << i);
+		TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
+			    run->debug.arch.exception == DB_VECTOR &&
+			    run->debug.arch.pc == CAST_TO_RIP(write_data) &&
+			    run->debug.arch.dr6 == target_dr6,
+			    "DATA_HW_BP (DR%d): exit %d exception %d rip 0x%llx "
+			    "(should be 0x%llx) dr6 0x%llx (should be 0x%llx)",
+			    i, run->exit_reason, run->debug.arch.exception,
+			    run->debug.arch.pc, CAST_TO_RIP(write_data),
+			    run->debug.arch.dr6, target_dr6);
+		/* Rollback the 4-bytes "mov" */
+		MOVE_RIP(-7);
+	}
+	/* Skip the 4-bytes "mov" */
+	MOVE_RIP(7);
+
+	/* Test single step */
+	target_rip = CAST_TO_RIP(ss_start);
+	target_dr6 = 0xffff4ff0ULL;
+	vcpu_regs_get(vm, VCPU_ID, &regs);
+	for (i = 0; i < (sizeof(ss_size) / sizeof(ss_size[0])); i++) {
+		target_rip += ss_size[i];
+		CLEAR_DEBUG();
+		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
+		debug.arch.debugreg[7] = 0x00000400;
+		APPLY_DEBUG();
+		vcpu_run(vm, VCPU_ID);
+		TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
+			    run->debug.arch.exception == DB_VECTOR &&
+			    run->debug.arch.pc == target_rip &&
+			    run->debug.arch.dr6 == target_dr6,
+			    "SINGLE_STEP[%d]: exit %d exception %d rip 0x%llx "
+			    "(should be 0x%llx) dr6 0x%llx (should be 0x%llx)",
+			    i, run->exit_reason, run->debug.arch.exception,
+			    run->debug.arch.pc, target_rip, run->debug.arch.dr6,
+			    target_dr6);
+	}
+
+	/* Disable all debug controls, run to the end */
+	CLEAR_DEBUG();
+	APPLY_DEBUG();
+
+	vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO, "KVM_EXIT_IO");
+	cmd = get_ucall(vm, VCPU_ID, &uc);
+	TEST_ASSERT(cmd == UCALL_DONE, "UCALL_DONE");
+
+	kvm_vm_free(vm);
+
+	return 0;
+}
-- 
2.26.2

