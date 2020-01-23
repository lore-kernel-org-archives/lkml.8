Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2356C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4B520718
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLyp6z0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgAWSE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:04:56 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:33192 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbgAWSEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:04:54 -0500
Received: by mail-pj1-f73.google.com with SMTP id u91so1511504pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ii0SHfgzZYUwZb7/pvTlYqckx+NQoa62QNzOVUMGLgE=;
        b=PLyp6z0CAVfybtr5KJdK4BBfI+xCS6iijTEsVuy8dz1EF81cfVUm4jiBXsFCTUknHo
         PQcVYi9HFjlQ5LQF3cJuh3cErtPPBfqEOtl80cfSmYoh6giejP2Xkeq55zSVbOmvAN5c
         8k0WJW1tSCXKy6+3lSxlXbHecJrTCsrfCfi0xHnYWCcovJUUbkNozPqdX0W6PNALccJq
         jIl8iyp/gVfDlvYKWBhGVu7CU958B2XFlDQTIyeGJM1aTQZknxXggjEn6RRpB9A0BTJK
         LfB+OWKCtg9PDadtPS5KLpFsWhsJ7RvAWYpuz5CYl2wZLcS0n/uJcp4haojwUTA5E/Ig
         iH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ii0SHfgzZYUwZb7/pvTlYqckx+NQoa62QNzOVUMGLgE=;
        b=QCZ7GR0xSw0vDWi9uiAe50AePyTTUoW5EouZRDx+B6q7U02+AI4mGMB2Un4F4Alwq5
         ezjfa+Jv/BQ2jNg7JxOzdQfzT2wKEcH98EKviZmBGhrzPLIcQsgOlzVujobuc2So5DlX
         ZZoifj/YF2tIGZy0lFyTe4qV0e+RlZ6pskmdIV/SkxPIaIO4MhVJzdvz8menv6izBEFu
         gGX/IjENIKjO3zecS4GNb+/Sz20itpWNK2/WaR6bUITaTD2x26C+SrqkH1ggV6u1k76p
         ELTP6CT/vsweEGnA5+YpIgr8bM7098VgwEvn36QySsL7ySvCOJqQVhjOS1GOz6WzbdGw
         tPlw==
X-Gm-Message-State: APjAAAU30KbxinaJMH/EpNGgAl9wzS8A2hjZ+J6FwP4IjW6z+Fy0sNNU
        cm+vXsGOu72PhL8zanQ/yQofdbTfrHjoDuh31ArMNAzqL1VTmaq9CESXaJV1T5sp29Ua7nV8Lpv
        eXqM2J6BGmx/qBKE0pKOmyewEUcmQ9IZj2rmSnCuQzJbqWYYcS7uZgwVG+AeMvG3naLlei1QT
X-Google-Smtp-Source: APXvYqzoG885PQKUB+5r9e3ERU5dNsON806PZLYtG3pHCaY+uutcjNNjYcphpDoZq+MA1e7JH20yRhKI/XzA
X-Received: by 2002:a63:5fca:: with SMTP id t193mr33015pgb.28.1579802691847;
 Thu, 23 Jan 2020 10:04:51 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:04:31 -0800
In-Reply-To: <20200123180436.99487-1-bgardon@google.com>
Message-Id: <20200123180436.99487-6-bgardon@google.com>
Mime-Version: 1.0
References: <20200123180436.99487-1-bgardon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v4 05/10] KVM: selftests: Pass args to vCPU in global vCPU
 args struct
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

In preparation for supporting multiple vCPUs in the demand paging test,
pass arguments to the vCPU in a consolidated global struct instead of
syncing multiple globals.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 38 +++++++++++++------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 9d7514e96a639..9e2a5f7dfa140 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -42,7 +42,6 @@
  */
 static uint64_t host_page_size;
 static uint64_t guest_page_size;
-static uint64_t guest_num_pages;
 
 static char *guest_data_prototype;
 
@@ -59,18 +58,30 @@ static uint64_t guest_test_phys_mem;
  */
 static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
 
+struct vcpu_args {
+	uint64_t gva;
+	uint64_t pages;
+
+	/* Only used by the host userspace part of the vCPU thread */
+	int vcpu_id;
+	struct kvm_vm *vm;
+};
+
+static struct vcpu_args vcpu_args;
+
 /*
  * Continuously write to the first 8 bytes of each page in the demand paging
  * memory region.
  */
 static void guest_code(void)
 {
+	uint64_t gva = vcpu_args.gva;
+	uint64_t pages = vcpu_args.pages;
 	int i;
 
-	for (i = 0; i < guest_num_pages; i++) {
-		uint64_t addr = guest_test_virt_mem;
+	for (i = 0; i < pages; i++) {
+		uint64_t addr = gva + (i * guest_page_size);
 
-		addr += i * guest_page_size;
 		addr &= ~(host_page_size - 1);
 		*(uint64_t *)addr = 0x0123456789ABCDEF;
 	}
@@ -85,15 +96,16 @@ static uint64_t host_num_pages;
 static void *vcpu_worker(void *data)
 {
 	int ret;
-	struct kvm_vm *vm = data;
+	struct kvm_vm *vm = vcpu_args.vm;
+	int vcpu_id = vcpu_args.vcpu_id;
 	struct kvm_run *run;
 
-	run = vcpu_state(vm, VCPU_ID);
+	run = vcpu_state(vm, vcpu_id);
 
 	/* Let the guest access its memory */
-	ret = _vcpu_run(vm, VCPU_ID);
+	ret = _vcpu_run(vm, vcpu_id);
 	TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
-	if (get_ucall(vm, VCPU_ID, NULL) != UCALL_SYNC) {
+	if (get_ucall(vm, vcpu_id, NULL) != UCALL_SYNC) {
 		TEST_ASSERT(false,
 			    "Invalid guest sync status: exit_reason=%s\n",
 			    exit_reason_str(run->exit_reason));
@@ -285,6 +297,7 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 	pthread_t uffd_handler_thread;
 	int pipefd[2];
 	struct kvm_vm *vm;
+	uint64_t guest_num_pages;
 	int r;
 
 	/*
@@ -370,10 +383,13 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 	/* Export the shared variables to the guest */
 	sync_global_to_guest(vm, host_page_size);
 	sync_global_to_guest(vm, guest_page_size);
-	sync_global_to_guest(vm, guest_test_virt_mem);
-	sync_global_to_guest(vm, guest_num_pages);
 
-	pthread_create(&vcpu_thread, NULL, vcpu_worker, vm);
+	vcpu_args.vm = vm;
+	vcpu_args.vcpu_id = VCPU_ID;
+	vcpu_args.gva = guest_test_virt_mem;
+	vcpu_args.pages = guest_num_pages;
+	sync_global_to_guest(vm, vcpu_args);
+	pthread_create(&vcpu_thread, NULL, vcpu_worker, &vcpu_args);
 
 	/* Wait for the vcpu thread to quit */
 	pthread_join(vcpu_thread, NULL);
-- 
2.25.0.341.g760bfbb309-goog

