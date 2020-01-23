Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC54C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BE420718
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rswnlLqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgAWSEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:04:51 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43875 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgAWSEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:04:46 -0500
Received: by mail-pg1-f201.google.com with SMTP id d9so2230886pgd.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cQGsf25lgBgmgowyMdPpkSI0OuBqPxdwaRG5rlH9TOU=;
        b=rswnlLqJs/N1oZ4FNZqHbpYcIuJcQYsbmECvlEebHuZ55/jIHXM5X3BBmd+Q9TPDjO
         RgO5d7U9XPgGYwUIF0IXAfvuH14l0cWO1VI08ZXxIHUPO+4sUgz4Eg3luV6gpjTWNgPr
         mty2L4wiRXu07cFnPtwBOKGOWiu/068Op2nmNmAoeG0hbvBVJv9x4aayMxpiQGBEQuhh
         fKarS5kA6j920y23By7hydU90vCEYFUL/7C/dwJF+RvoWsAkuTi8ks+bXpN9i3lJLE0z
         +iz+P//gyeWtvV8E7dUuaxwW/oJjnq+jdsLDBrrXE3VUkJ0tAnjU3baWuWfyMFLGjsTT
         8vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cQGsf25lgBgmgowyMdPpkSI0OuBqPxdwaRG5rlH9TOU=;
        b=YkJ3apVFGLu9BDb48IRdJkBeVKKwOv82UE3ShjkfLwbRLCiZmdl4KUXFcwgxu0Zwr1
         tCfxz8XbRUH+S93xgiBYQAoG2LlgZUq6OMfI8rdaB7fUrf2ceIMV8NLAZUKLO5TZFXJo
         Ku0xhpLS/lr3Uta0nunpdkGqOoyxEraa0e1MJWwDoBlE6U5UkUjRCBN2FMMb8nVHryWy
         nrbaEu7ZShAT4XianJpsnsNDlTha6UlzYxEbg0UL5SUO0rzRCpJ60viSHEo3sk8lIXF4
         IFN2pEqGUcfqfv4i0KI9n1W3SB/wT+IVYcBbkpQm5HU84Buh5JgFHKvcx7SZxcaV4FVZ
         Wqmw==
X-Gm-Message-State: APjAAAVuH4m2kIlBNrlGyPauHoY8UCY68eKnrQWZeldM4aEOzE5sOe3E
        Pjh4aiCZQemK2GysTFLxVsTGaGB3cAHuURSKH42X6GzTqpiQBDoq5ibW+KLea+wSjRCTy3YEti4
        LNy40EFPD67gynaF0N+7+zlOvXjRwV1wdTxlNC34UGwgv7Xy7Pew4l/SVh/d7n1bWzLWr6kaT
X-Google-Smtp-Source: APXvYqxuGC8Dx7jeTN0VJLhlrXVvqKWPjVviG9Lm8j5L1hEdkhn3GjC9uldIJqgx+Pkw06HCeMxsgx/oLXnc
X-Received: by 2002:a63:ce4b:: with SMTP id r11mr5432103pgi.419.1579802685421;
 Thu, 23 Jan 2020 10:04:45 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:04:28 -0800
In-Reply-To: <20200123180436.99487-1-bgardon@google.com>
Message-Id: <20200123180436.99487-3-bgardon@google.com>
Mime-Version: 1.0
References: <20200123180436.99487-1-bgardon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v4 02/10] KVM: selftests: Add demand paging content to the
 demand paging test
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The demand paging test is currently a simple page access test which, while
potentially useful, doesn't add much versus the existing dirty logging
test. To improve the demand paging test, add a basic userfaultfd demand
paging implementation.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 196 +++++++++++++++++-
 1 file changed, 192 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 5f214517ba1de..6fab4468f97f6 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -11,11 +11,14 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/syscall.h>
 #include <unistd.h>
 #include <time.h>
+#include <poll.h>
 #include <pthread.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/userfaultfd.h>
 
 #include "test_util.h"
 #include "kvm_util.h"
@@ -39,6 +42,8 @@ static uint64_t host_page_size;
 static uint64_t guest_page_size;
 static uint64_t guest_num_pages;
 
+static char *guest_data_prototype;
+
 /*
  * Guest physical memory offset of the testing memory slot.
  * This will be set to the topmost valid physical address minus
@@ -110,13 +115,169 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 	return vm;
 }
 
+static int handle_uffd_page_request(int uffd, uint64_t addr)
+{
+	pid_t tid;
+	struct uffdio_copy copy;
+	int r;
+
+	tid = syscall(__NR_gettid);
+
+	copy.src = (uint64_t)guest_data_prototype;
+	copy.dst = addr;
+	copy.len = host_page_size;
+	copy.mode = 0;
+
+	r = ioctl(uffd, UFFDIO_COPY, &copy);
+	if (r == -1) {
+		DEBUG("Failed Paged in 0x%lx from thread %d with errno: %d\n",
+		      addr, tid, errno);
+		return r;
+	}
+
+	return 0;
+}
+
+bool quit_uffd_thread;
+
+struct uffd_handler_args {
+	int uffd;
+	int pipefd;
+};
+
+static void *uffd_handler_thread_fn(void *arg)
+{
+	struct uffd_handler_args *uffd_args = (struct uffd_handler_args *)arg;
+	int uffd = uffd_args->uffd;
+	int pipefd = uffd_args->pipefd;
+	int64_t pages = 0;
+
+	while (!quit_uffd_thread) {
+		struct uffd_msg msg;
+		struct pollfd pollfd[2];
+		char tmp_chr;
+		int r;
+		uint64_t addr;
+
+		pollfd[0].fd = uffd;
+		pollfd[0].events = POLLIN;
+		pollfd[1].fd = pipefd;
+		pollfd[1].events = POLLIN;
+
+		r = poll(pollfd, 2, -1);
+		switch (r) {
+		case -1:
+			DEBUG("poll err");
+			continue;
+		case 0:
+			continue;
+		case 1:
+			break;
+		default:
+			DEBUG("Polling uffd returned %d", r);
+			return NULL;
+		}
+
+		if (pollfd[0].revents & POLLERR) {
+			DEBUG("uffd revents has POLLERR");
+			return NULL;
+		}
+
+		if (pollfd[1].revents & POLLIN) {
+			r = read(pollfd[1].fd, &tmp_chr, 1);
+			TEST_ASSERT(r == 1,
+				    "Error reading pipefd in UFFD thread\n");
+			return NULL;
+		}
+
+		if (!pollfd[0].revents & POLLIN)
+			continue;
+
+		r = read(uffd, &msg, sizeof(msg));
+		if (r == -1) {
+			if (errno == EAGAIN)
+				continue;
+			DEBUG("Read of uffd gor errno %d", errno);
+			return NULL;
+		}
+
+		if (r != sizeof(msg)) {
+			DEBUG("Read on uffd returned unexpected size: %d bytes",
+			      r);
+			return NULL;
+		}
+
+		if (!(msg.event & UFFD_EVENT_PAGEFAULT))
+			continue;
+
+		addr =  msg.arg.pagefault.address;
+		r = handle_uffd_page_request(uffd, addr);
+		if (r < 0)
+			return NULL;
+		pages++;
+	}
+
+	return NULL;
+}
+
+static int setup_demand_paging(struct kvm_vm *vm,
+			       pthread_t *uffd_handler_thread, int pipefd)
+{
+	int uffd;
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
+	struct uffd_handler_args uffd_args;
+
+	guest_data_prototype = malloc(host_page_size);
+	TEST_ASSERT(guest_data_prototype,
+		    "Failed to allocate buffer for guest data pattern");
+	memset(guest_data_prototype, 0xAB, host_page_size);
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd == -1) {
+		DEBUG("uffd creation failed\n");
+		return -1;
+	}
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1) {
+		DEBUG("ioctl uffdio_api failed\n");
+		return -1;
+	}
+
+	uffdio_register.range.start = (uint64_t)host_test_mem;
+	uffdio_register.range.len = host_num_pages * host_page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
+		DEBUG("ioctl uffdio_register failed\n");
+		return -1;
+	}
+
+	if ((uffdio_register.ioctls & UFFD_API_RANGE_IOCTLS) !=
+			UFFD_API_RANGE_IOCTLS) {
+		DEBUG("unexpected userfaultfd ioctl set\n");
+		return -1;
+	}
+
+	uffd_args.uffd = uffd;
+	uffd_args.pipefd = pipefd;
+	pthread_create(uffd_handler_thread, NULL, uffd_handler_thread_fn,
+		       &uffd_args);
+
+	return 0;
+}
+
 #define GUEST_MEM_SHIFT 30 /* 1G */
 #define PAGE_SHIFT_4K  12
 
-static void run_test(enum vm_guest_mode mode)
+static void run_test(enum vm_guest_mode mode, bool use_uffd)
 {
 	pthread_t vcpu_thread;
+	pthread_t uffd_handler_thread;
+	int pipefd[2];
 	struct kvm_vm *vm;
+	int r;
 
 	/*
 	 * We reserve page table for 2 times of extra dirty mem which
@@ -173,6 +334,16 @@ static void run_test(enum vm_guest_mode mode)
 	/* Cache the HVA pointer of the region */
 	host_test_mem = addr_gpa2hva(vm, (vm_paddr_t)guest_test_phys_mem);
 
+	if (use_uffd) {
+		/* Set up user fault fd to handle demand paging requests. */
+		r = pipe2(pipefd, O_CLOEXEC | O_NONBLOCK);
+		TEST_ASSERT(!r, "Failed to set up pipefd");
+
+		r = setup_demand_paging(vm, &uffd_handler_thread, pipefd[0]);
+		if (r < 0)
+			exit(-r);
+	}
+
 #ifdef __x86_64__
 	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 #endif
@@ -191,8 +362,20 @@ static void run_test(enum vm_guest_mode mode)
 	/* Wait for the vcpu thread to quit */
 	pthread_join(vcpu_thread, NULL);
 
+	if (use_uffd) {
+		char c;
+
+		/* Tell the user fault fd handler thread to quit */
+		r = write(pipefd[1], &c, 1);
+		TEST_ASSERT(r == 1, "Unable to write to pipefd");
+
+		pthread_join(uffd_handler_thread, NULL);
+	}
+
 	ucall_uninit(vm);
 	kvm_vm_free(vm);
+
+	free(guest_data_prototype);
 }
 
 struct vm_guest_mode_params {
@@ -212,7 +395,7 @@ static void help(char *name)
 	int i;
 
 	puts("");
-	printf("usage: %s [-h] [-m mode]\n", name);
+	printf("usage: %s [-h] [-m mode] [-u]\n", name);
 	printf(" -m: specify the guest mode ID to test\n"
 	       "     (default: test all supported modes)\n"
 	       "     This option may be used multiple times.\n"
@@ -221,6 +404,7 @@ static void help(char *name)
 		printf("         %d:    %s%s\n", i, vm_guest_mode_string(i),
 		       vm_guest_mode_params[i].supported ? " (supported)" : "");
 	}
+	printf(" -u: Use User Fault FD to handle vCPU page faults.\n");
 	puts("");
 	exit(0);
 }
@@ -230,6 +414,7 @@ int main(int argc, char *argv[])
 	bool mode_selected = false;
 	unsigned int mode;
 	int opt, i;
+	bool use_uffd = false;
 #ifdef __aarch64__
 	unsigned int host_ipa_limit;
 #endif
@@ -253,7 +438,7 @@ int main(int argc, char *argv[])
 	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
 #endif
 
-	while ((opt = getopt(argc, argv, "hm:")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:u")) != -1) {
 		switch (opt) {
 		case 'm':
 			if (!mode_selected) {
@@ -266,6 +451,9 @@ int main(int argc, char *argv[])
 				    "Guest mode ID %d too big", mode);
 			vm_guest_mode_params[mode].enabled = true;
 			break;
+		case 'u':
+			use_uffd = true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -279,7 +467,7 @@ int main(int argc, char *argv[])
 		TEST_ASSERT(vm_guest_mode_params[i].supported,
 			    "Guest mode ID %d (%s) not supported.",
 			    i, vm_guest_mode_string(i));
-		run_test(i);
+		run_test(i, use_uffd);
 	}
 
 	return 0;
-- 
2.25.0.341.g760bfbb309-goog

