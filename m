Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC880C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 22:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5181207CB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 22:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nvxzfv95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388298AbgEWW55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 18:57:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42577 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388221AbgEWW5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 18:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590274653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=730Ne0FnxkAmbCOu3JPrFansS1VF8UrEZO+/Jl/FkyQ=;
        b=Nvxzfv958Eq1qn01z+5lVwqnGsq3jOlu6PDDz+9D56iLSkWeTxo35xq78orq60MBV8q8cy
        Kj2Cn0OCXMgE84PcA1WzqzG2mvoBw45wiBYCjU0Vrad+kG2Mtuee4ctpNKzaiNELU2i6e+
        DihPFQcn5hRMdmMXCzZlm7NS7LNyfkE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-V16RyTBpP2azOdfA0e_DDA-1; Sat, 23 May 2020 18:57:32 -0400
X-MC-Unique: V16RyTBpP2azOdfA0e_DDA-1
Received: by mail-qv1-f69.google.com with SMTP id a7so14233628qvl.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 15:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=730Ne0FnxkAmbCOu3JPrFansS1VF8UrEZO+/Jl/FkyQ=;
        b=hDHj4UozUyInAg3L4mV4WoTXht60wCDM0wYy1g74vy3MWbyKPu2u8m40bSlPSUv9+i
         r0xUdUi4bqga7GMJCvf1nSJSWNl/2gr/JeagfaQLjzmhMU2aFtVAnidtmieM0tGj4cPH
         kMc3bGj8/rZtuporGbgIAK2NvA3LURi0K8G+5aoMhlHB7FufZM3XCNJMIHc9CNQkZtGy
         LsEr1AiRWUyNSIDrCVqwNQtamqsJRAazLdQyZGqsRXeJ+pKW8KLRbJ6WRAJ5UvbSkjnH
         uLnGccDhkIqU/INZDssTAVi+N3X9r1VqBpKWLKijeC9igomFC2j6YD8Y2bw65L+m0fwa
         Sstg==
X-Gm-Message-State: AOAM530JkSeCrlvT1Yiq+KPeYje6HqLVEgt41Gr6jqe6sN1MpjhisFKd
        3ty5JBEYzya8UL9U8aUbfVLN///gOIkpcwl7lNIzdpbdTYE34AgVPWqcfqcVYKjkQGbUbi4yqIz
        hD1B6NzUskIJ0oypd8in6KPUW
X-Received: by 2002:a0c:fd24:: with SMTP id i4mr9833768qvs.69.1590274651099;
        Sat, 23 May 2020 15:57:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwEe/JdK2mKUSALUSl7mT0B+CoO7WPPj9RQSdKEmgMIvT8uI2qZQfFCc4nhqP4mb0dn88gFg==
X-Received: by 2002:a0c:fd24:: with SMTP id i4mr9833751qvs.69.1590274650683;
        Sat, 23 May 2020 15:57:30 -0700 (PDT)
Received: from xz-x1.hitronhub.home (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id w14sm11630979qtt.82.2020.05.23.15.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 15:57:30 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>, peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v9 10/14] KVM: selftests: Use a single binary for dirty/clear log test
Date:   Sat, 23 May 2020 18:56:55 -0400
Message-Id: <20200523225659.1027044-11-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523225659.1027044-1-peterx@redhat.com>
References: <20200523225659.1027044-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the clear_dirty_log test, instead merge it into the existing
dirty_log_test.  It should be cleaner to use this single binary to do
both tests, also it's a preparation for the upcoming dirty ring test.

The default behavior will run all the modes in sequence.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/Makefile          |   2 -
 .../selftests/kvm/clear_dirty_log_test.c      |   6 -
 tools/testing/selftests/kvm/dirty_log_test.c  | 187 +++++++++++++++---
 3 files changed, 156 insertions(+), 39 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/clear_dirty_log_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 712a2ddd2a27..fee0393f10da 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -28,13 +28,11 @@ TEST_GEN_PROGS_x86_64 += x86_64/vmx_dirty_log_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_set_nested_state_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_tsc_adjust_test
 TEST_GEN_PROGS_x86_64 += x86_64/xss_msr_test
-TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += steal_time
 
-TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
 TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
diff --git a/tools/testing/selftests/kvm/clear_dirty_log_test.c b/tools/testing/selftests/kvm/clear_dirty_log_test.c
deleted file mode 100644
index 11672ec6f74e..000000000000
--- a/tools/testing/selftests/kvm/clear_dirty_log_test.c
+++ /dev/null
@@ -1,6 +0,0 @@
-#define USE_CLEAR_DIRTY_LOG
-#define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE (1 << 0)
-#define KVM_DIRTY_LOG_INITIALLY_SET         (1 << 1)
-#define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
-		KVM_DIRTY_LOG_INITIALLY_SET)
-#include "dirty_log_test.c"
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 6a8275a22861..139ccb550618 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -128,6 +128,78 @@ static uint64_t host_dirty_count;
 static uint64_t host_clear_count;
 static uint64_t host_track_next_count;
 
+enum log_mode_t {
+	/* Only use KVM_GET_DIRTY_LOG for logging */
+	LOG_MODE_DIRTY_LOG = 0,
+
+	/* Use both KVM_[GET|CLEAR]_DIRTY_LOG for logging */
+	LOG_MODE_CLEAR_LOG = 1,
+
+	LOG_MODE_NUM,
+
+	/* Run all supported modes */
+	LOG_MODE_ALL = LOG_MODE_NUM,
+};
+
+/* Mode of logging to test.  Default is to run all supported modes */
+static enum log_mode_t host_log_mode_option = LOG_MODE_ALL;
+/* Logging mode for current run */
+static enum log_mode_t host_log_mode;
+
+static bool clear_log_supported(void)
+{
+	return kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
+}
+
+static void clear_log_create_vm_done(struct kvm_vm *vm)
+{
+	struct kvm_enable_cap cap = {};
+	u64 manual_caps;
+
+	manual_caps = kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
+	TEST_ASSERT(manual_caps, "MANUAL_CAPS is zero!");
+	manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
+			KVM_DIRTY_LOG_INITIALLY_SET);
+	cap.cap = KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2;
+	cap.args[0] = manual_caps;
+	vm_enable_cap(vm, &cap);
+}
+
+static void dirty_log_collect_dirty_pages(struct kvm_vm *vm, int slot,
+					  void *bitmap, uint32_t num_pages)
+{
+	kvm_vm_get_dirty_log(vm, slot, bitmap);
+}
+
+static void clear_log_collect_dirty_pages(struct kvm_vm *vm, int slot,
+					  void *bitmap, uint32_t num_pages)
+{
+	kvm_vm_get_dirty_log(vm, slot, bitmap);
+	kvm_vm_clear_dirty_log(vm, slot, bitmap, 0, num_pages);
+}
+
+struct log_mode {
+	const char *name;
+	/* Return true if this mode is supported, otherwise false */
+	bool (*supported)(void);
+	/* Hook when the vm creation is done (before vcpu creation) */
+	void (*create_vm_done)(struct kvm_vm *vm);
+	/* Hook to collect the dirty pages into the bitmap provided */
+	void (*collect_dirty_pages) (struct kvm_vm *vm, int slot,
+				     void *bitmap, uint32_t num_pages);
+} log_modes[LOG_MODE_NUM] = {
+	{
+		.name = "dirty-log",
+		.collect_dirty_pages = dirty_log_collect_dirty_pages,
+	},
+	{
+		.name = "clear-log",
+		.supported = clear_log_supported,
+		.create_vm_done = clear_log_create_vm_done,
+		.collect_dirty_pages = clear_log_collect_dirty_pages,
+	},
+};
+
 /*
  * We use this bitmap to track some pages that should have its dirty
  * bit set in the _next_ iteration.  For example, if we detected the
@@ -137,6 +209,44 @@ static uint64_t host_track_next_count;
  */
 static unsigned long *host_bmap_track;
 
+static void log_modes_dump(void)
+{
+	int i;
+
+	printf("all");
+	for (i = 0; i < LOG_MODE_NUM; i++)
+		printf(", %s", log_modes[i].name);
+	printf("\n");
+}
+
+static bool log_mode_supported(void)
+{
+	struct log_mode *mode = &log_modes[host_log_mode];
+
+	if (mode->supported)
+		return mode->supported();
+
+	return true;
+}
+
+static void log_mode_create_vm_done(struct kvm_vm *vm)
+{
+	struct log_mode *mode = &log_modes[host_log_mode];
+
+	if (mode->create_vm_done)
+		mode->create_vm_done(vm);
+}
+
+static void log_mode_collect_dirty_pages(struct kvm_vm *vm, int slot,
+					 void *bitmap, uint32_t num_pages)
+{
+	struct log_mode *mode = &log_modes[host_log_mode];
+
+	TEST_ASSERT(mode->collect_dirty_pages != NULL,
+		    "collect_dirty_pages() is required for any log mode!");
+	mode->collect_dirty_pages(vm, slot, bitmap, num_pages);
+}
+
 static void generate_random_array(uint64_t *guest_array, uint64_t size)
 {
 	uint64_t i;
@@ -257,6 +367,7 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 #ifdef __x86_64__
 	vm_create_irqchip(vm);
 #endif
+	log_mode_create_vm_done(vm);
 	vm_vcpu_add_default(vm, vcpuid, guest_code);
 	return vm;
 }
@@ -264,10 +375,6 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 #define DIRTY_MEM_BITS 30 /* 1G */
 #define PAGE_SHIFT_4K  12
 
-#ifdef USE_CLEAR_DIRTY_LOG
-static u64 dirty_log_manual_caps;
-#endif
-
 static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 		     unsigned long interval, uint64_t phys_offset)
 {
@@ -275,6 +382,12 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 	struct kvm_vm *vm;
 	unsigned long *bmap;
 
+	if (!log_mode_supported()) {
+		print_skip("Log mode '%s' not supported",
+			   log_modes[host_log_mode].name);
+		return;
+	}
+
 	/*
 	 * We reserve page table for 2 times of extra dirty mem which
 	 * will definitely cover the original (1G+) test range.  Here
@@ -317,14 +430,6 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 	bmap = bitmap_alloc(host_num_pages);
 	host_bmap_track = bitmap_alloc(host_num_pages);
 
-#ifdef USE_CLEAR_DIRTY_LOG
-	struct kvm_enable_cap cap = {};
-
-	cap.cap = KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2;
-	cap.args[0] = dirty_log_manual_caps;
-	vm_enable_cap(vm, &cap);
-#endif
-
 	/* Add an extra memory slot for testing dirty logging */
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
 				    guest_test_phys_mem,
@@ -362,11 +467,8 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 	while (iteration < iterations) {
 		/* Give the vcpu thread some time to dirty some pages */
 		usleep(interval * 1000);
-		kvm_vm_get_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap);
-#ifdef USE_CLEAR_DIRTY_LOG
-		kvm_vm_clear_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap, 0,
-				       host_num_pages);
-#endif
+		log_mode_collect_dirty_pages(vm, TEST_MEM_SLOT_INDEX,
+					     bmap, host_num_pages);
 		vm_dirty_log_verify(mode, bmap);
 		iteration++;
 		sync_global_to_guest(vm, iteration);
@@ -410,6 +512,9 @@ static void help(char *name)
 	       TEST_HOST_LOOP_INTERVAL);
 	printf(" -p: specify guest physical test memory offset\n"
 	       "     Warning: a low offset can conflict with the loaded test code.\n");
+	printf(" -M: specify the host logging mode "
+	       "(default: run all log modes).  Supported modes: \n\t");
+	log_modes_dump();
 	printf(" -m: specify the guest mode ID to test "
 	       "(default: test all supported modes)\n"
 	       "     This option may be used multiple times.\n"
@@ -429,18 +534,7 @@ int main(int argc, char *argv[])
 	bool mode_selected = false;
 	uint64_t phys_offset = 0;
 	unsigned int mode;
-	int opt, i;
-
-#ifdef USE_CLEAR_DIRTY_LOG
-	dirty_log_manual_caps =
-		kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
-	if (!dirty_log_manual_caps) {
-		print_skip("KVM_CLEAR_DIRTY_LOG not available");
-		exit(KSFT_SKIP);
-	}
-	dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
-				  KVM_DIRTY_LOG_INITIALLY_SET);
-#endif
+	int opt, i, j;
 
 #ifdef __x86_64__
 	guest_mode_init(VM_MODE_PXXV48_4K, true, true);
@@ -464,7 +558,7 @@ int main(int argc, char *argv[])
 	guest_mode_init(VM_MODE_P40V48_4K, true, true);
 #endif
 
-	while ((opt = getopt(argc, argv, "hi:I:p:m:")) != -1) {
+	while ((opt = getopt(argc, argv, "hi:I:p:m:M:")) != -1) {
 		switch (opt) {
 		case 'i':
 			iterations = strtol(optarg, NULL, 10);
@@ -486,6 +580,26 @@ int main(int argc, char *argv[])
 				    "Guest mode ID %d too big", mode);
 			guest_modes[mode].enabled = true;
 			break;
+		case 'M':
+			if (!strcmp(optarg, "all")) {
+				host_log_mode_option = LOG_MODE_ALL;
+				break;
+			}
+			for (i = 0; i < LOG_MODE_NUM; i++) {
+				if (!strcmp(optarg, log_modes[i].name)) {
+					pr_info("Setting log mode to: '%s'\n",
+						optarg);
+					host_log_mode_option = i;
+					break;
+				}
+			}
+			if (i == LOG_MODE_NUM) {
+				printf("Log mode '%s' invalid. Please choose "
+				       "from: ", optarg);
+				log_modes_dump();
+				exit(1);
+			}
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -507,7 +621,18 @@ int main(int argc, char *argv[])
 		TEST_ASSERT(guest_modes[i].supported,
 			    "Guest mode ID %d (%s) not supported.",
 			    i, vm_guest_mode_string(i));
-		run_test(i, iterations, interval, phys_offset);
+		if (host_log_mode_option == LOG_MODE_ALL) {
+			/* Run each log mode */
+			for (j = 0; j < LOG_MODE_NUM; j++) {
+				pr_info("Testing Log Mode '%s'\n",
+					log_modes[j].name);
+				host_log_mode = j;
+				run_test(i, iterations, interval, phys_offset);
+			}
+		} else {
+			host_log_mode = host_log_mode_option;
+			run_test(i, iterations, interval, phys_offset);
+		}
 	}
 
 	return 0;
-- 
2.26.2

