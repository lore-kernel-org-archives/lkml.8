Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDA9C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 23:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C5E2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 23:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgDJXRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 19:17:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:20816 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgDJXRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 19:17:13 -0400
IronPort-SDR: 29D+sTUQ3xyntsLL/V83JwwcMd8Lj1FJAamtzpTaPWr2bdMuIZqbwt0qNPCZAEEwfHlBq4TwEO
 Tl8JT+eAg7Sw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 16:17:12 -0700
IronPort-SDR: 1z1Is419uA7ZWd1ZZMMa72LoAPlHer1krhvVdwX4j8FVpnJU6vKkymUaDFgJz4CRlpv2qDcgtk
 g6g7QWUYYx/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; 
   d="scan'208";a="452542247"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2020 16:17:12 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 08/10] KVM: selftests: Add "zero" testcase to set_memory_region_test
Date:   Fri, 10 Apr 2020 16:17:05 -0700
Message-Id: <20200410231707.7128-9-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200410231707.7128-1-sean.j.christopherson@intel.com>
References: <20200410231707.7128-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a testcase for running a guest with no memslots to the memory region
test.  The expected result on x86_64 is that the guest will trigger an
internal KVM error due to the initial code fetch encountering a
non-existent memslot and resulting in an emulation failure.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 .../kvm/x86_64/set_memory_region_test.c       | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/set_memory_region_test.c b/tools/testing/selftests/kvm/x86_64/set_memory_region_test.c
index b556024af683..c274ce6b4ba2 100644
--- a/tools/testing/selftests/kvm/x86_64/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/x86_64/set_memory_region_test.c
@@ -289,6 +289,28 @@ static void test_delete_memory_region(void)
 	kvm_vm_free(vm);
 }
 
+static void test_zero_memory_regions(void)
+{
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+
+	pr_info("Testing KVM_RUN with zero added memory regions\n");
+
+	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
+	vm_vcpu_add(vm, VCPU_ID);
+
+	TEST_ASSERT(!ioctl(vm_get_fd(vm), KVM_SET_NR_MMU_PAGES, 64),
+		    "KVM_SET_NR_MMU_PAGES failed, errno = %d\n", errno);
+
+	vcpu_run(vm, VCPU_ID);
+
+	run = vcpu_state(vm, VCPU_ID);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_INTERNAL_ERROR,
+		    "Unexpected exit_reason = %u\n", run->exit_reason);
+
+	kvm_vm_free(vm);
+}
+
 int main(int argc, char *argv[])
 {
 	int i, loops;
@@ -296,6 +318,8 @@ int main(int argc, char *argv[])
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
 
+	test_zero_memory_regions();
+
 	if (argc > 1)
 		loops = atoi(argv[1]);
 	else
-- 
2.26.0

