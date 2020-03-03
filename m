Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B227BC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962172166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgCCIHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:07:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727594AbgCCIHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:07:23 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 50C3727143BE5F251882;
        Tue,  3 Mar 2020 16:07:19 +0800 (CST)
Received: from localhost (10.173.228.206) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Mar 2020
 16:07:13 +0800
From:   Jay Zhou <jianjay.zhou@huawei.com>
To:     <kvm@vger.kernel.org>
CC:     <pbonzini@redhat.com>, <peterx@redhat.com>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxinxin.wang@huawei.com>, <weidong.huang@huawei.com>,
        <liu.jinsong@huawei.com>, <jianjay.zhou@huawei.com>
Subject: [PATCH] kvm: selftests: Support dirty log initial-all-set test
Date:   Tue, 3 Mar 2020 16:07:10 +0800
Message-ID: <20200303080710.1672-1-jianjay.zhou@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.228.206]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the new capability KVM_DIRTY_LOG_INITIALLY_SET of
KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 has been introduced, tweak the
clear_dirty_log_test to test it.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 tools/testing/selftests/kvm/clear_dirty_log_test.c |  4 ++++
 tools/testing/selftests/kvm/dirty_log_test.c       | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/clear_dirty_log_test.c b/tools/testing/selftests/kvm/clear_dirty_log_test.c
index 7493369..11672ec 100644
--- a/tools/testing/selftests/kvm/clear_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/clear_dirty_log_test.c
@@ -1,2 +1,6 @@
 #define USE_CLEAR_DIRTY_LOG
+#define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE (1 << 0)
+#define KVM_DIRTY_LOG_INITIALLY_SET         (1 << 1)
+#define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
+		KVM_DIRTY_LOG_INITIALLY_SET)
 #include "dirty_log_test.c"
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 5614222..7e21addc4 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -264,6 +264,10 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 #define DIRTY_MEM_BITS 30 /* 1G */
 #define PAGE_SHIFT_4K  12
 
+#ifdef USE_CLEAR_DIRTY_LOG
+static u64 dirty_log_manual_caps;
+#endif
+
 static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 		     unsigned long interval, uint64_t phys_offset)
 {
@@ -320,7 +324,7 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 	struct kvm_enable_cap cap = {};
 
 	cap.cap = KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2;
-	cap.args[0] = 1;
+	cap.args[0] = dirty_log_manual_caps;
 	vm_enable_cap(vm, &cap);
 #endif
 
@@ -438,8 +442,18 @@ int main(int argc, char *argv[])
 #endif
 
 #ifdef USE_CLEAR_DIRTY_LOG
-	if (!kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2)) {
-		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, skipping tests\n");
+	dirty_log_manual_caps =
+		kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
+	if (!dirty_log_manual_caps) {
+		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, "
+				"skipping tests\n");
+		exit(KSFT_SKIP);
+	}
+	if (dirty_log_manual_caps != KVM_DIRTY_LOG_MANUAL_CAPS &&
+		dirty_log_manual_caps != KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE) {
+		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not valid caps "
+				"%"PRIu64", skipping tests\n",
+				dirty_log_manual_caps);
 		exit(KSFT_SKIP);
 	}
 #endif
-- 
1.8.3.1


