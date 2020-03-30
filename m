Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8ABC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EE520757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkP96MsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgC3Un4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:43:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:23807 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728471AbgC3Unz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585601034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=hH/iO6FDRZxlFvpDCLckIcIJQzohrbkDKXNiBqkh6qA=;
        b=FkP96MsV9VIOBTlCAV7bmeWVM5YtjXVGWRs8K4vst4ZLNWQ50NNxII3Mtfi8Z+ManHeBfY
        kAfD9bsjDA4yo8oPogWpL+KuSqAZkxdx8BTe/bwYWuye60XCkWXIkUIIOfh1X5YqBmh8KC
        0ZAHCKW//hPuZttwZjX011n0/epp8RM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-WVIWNsR0MXWxq5PiSYhXpQ-1; Mon, 30 Mar 2020 16:43:51 -0400
X-MC-Unique: WVIWNsR0MXWxq5PiSYhXpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09AD3DB62;
        Mon, 30 Mar 2020 20:43:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9B2C19C58;
        Mon, 30 Mar 2020 20:43:43 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        david@redhat.com, drjones@redhat.com
Subject: [PATCH 2/2] selftests: kvm: Add mem_slot_test test
Date:   Mon, 30 Mar 2020 17:43:10 -0300
Message-Id: <20200330204310.21736-3-wainersm@redhat.com>
In-Reply-To: <20200330204310.21736-1-wainersm@redhat.com>
References: <20200330204310.21736-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the mem_slot_test test which checks
an VM can have added memory slots up to the limit defined in
KVM_CAP_NR_MEMSLOTS. Then attempt to add one more slot to
verify it fails as expected.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tools/testing/selftests/kvm/.gitignore      |  1 +
 tools/testing/selftests/kvm/Makefile        |  3 +
 tools/testing/selftests/kvm/mem_slot_test.c | 92 +++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/mem_slot_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 30072c3f52fb..b1b94d50f6a2 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -17,3 +17,4 @@
 /clear_dirty_log_test
 /dirty_log_test
 /kvm_create_max_vcpus
+/mem_slot_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index d91c53b726e6..070133349403 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -30,16 +30,19 @@ TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
 TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
+TEST_GEN_PROGS_x86_64 += mem_slot_test
 
 TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
+TEST_GEN_PROGS_aarch64 += mem_slot_test
 
 TEST_GEN_PROGS_s390x = s390x/memop
 TEST_GEN_PROGS_s390x += s390x/sync_regs_test
 TEST_GEN_PROGS_s390x += s390x/resets
 TEST_GEN_PROGS_s390x += dirty_log_test
 TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
+TEST_GEN_PROGS_s390x += mem_slot_test
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
diff --git a/tools/testing/selftests/kvm/mem_slot_test.c b/tools/testing/selftests/kvm/mem_slot_test.c
new file mode 100644
index 000000000000..75d2bbd71642
--- /dev/null
+++ b/tools/testing/selftests/kvm/mem_slot_test.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * mem_slot_test
+ *
+ * Copyright (C) 2020, Red Hat, Inc.
+ *
+ * Test it can be added memory slots up to KVM_CAP_NR_MEMSLOTS, then any
+ * tentative to add further slots should fail.
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <linux/kvm.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+
+/* Memory region flags */
+#define MEM_REG_FLAGS KVM_MEM_LOG_DIRTY_PAGES
+
+/* Guest VM mode */
+#define GUEST_VM_MODE VM_MODE_DEFAULT
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	/* Maximum allowed number of memory slots */
+	uint32_t max_mem_slots;
+	/* Slot number */
+	uint32_t slot;
+	/* Number of pages in a memory region */
+	uint64_t mem_reg_npages;
+	/* Memory region size */
+	uint64_t mem_reg_size;
+	/* Guest physical memory guest_address */
+	uint64_t guest_addr;
+	/* VM page size */
+	uint64_t vm_page_size;
+	int ret;
+
+	max_mem_slots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS);
+	TEST_ASSERT(max_mem_slots > 0,
+		    "KVM_CAP_NR_MEMSLOTS should be greater than 0");
+	DEBUG("Allowed number of memory slots: %i\n", max_mem_slots);
+
+	vm = vm_create(GUEST_VM_MODE, 0, O_RDWR);
+
+	/* Determine the minimal number of pages as possible per region. */
+	vm_page_size = vm_get_page_size(vm);
+#ifdef __s390x__
+	mem_reg_size = 0x100000;
+#else
+	uint64_t host_page_size = sysconf(_SC_PAGESIZE);
+
+	mem_reg_size = (host_page_size > vm_page_size) ? host_page_size :
+							 vm_page_size;
+#endif
+	mem_reg_npages = mem_reg_size / vm_page_size;
+	guest_addr = 0x0;
+
+	/* Check it can be added memory slots up to the maximum allowed */
+	DEBUG("Adding slots 0..%i, each memory region with %ldK size\n",
+	      (max_mem_slots - 1), mem_reg_size >> 10);
+	for (slot = 0; slot < max_mem_slots; slot++) {
+		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+					    guest_addr, slot, mem_reg_npages,
+					    MEM_REG_FLAGS);
+		guest_addr += mem_reg_size;
+	}
+
+	/* Check it cannot be added memory slots beyond the limit */
+	guest_addr += mem_reg_size;
+	void *mem = mmap(NULL, mem_reg_size, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	TEST_ASSERT(mem != NULL, "Failed to mmap() host");
+
+	struct kvm_userspace_memory_region kvm_region = {
+		.slot = slot,
+		.flags = MEM_REG_FLAGS,
+		.guest_phys_addr = guest_addr,
+		.memory_size = mem_reg_size,
+		.userspace_addr = (uint64_t) mem,
+	};
+
+	ret = ioctl(vm_get_fd(vm), KVM_SET_USER_MEMORY_REGION, &kvm_region);
+	TEST_ASSERT(ret == -1, "Adding one more memory slot should fail");
+
+	munmap(mem, mem_reg_size);
+	kvm_vm_free(vm);
+
+	return 0;
+}
-- 
2.17.2

