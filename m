Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90255C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520DE2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKBpupEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgBEC7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:59:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48068 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728065AbgBEC7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580871548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T3MfHN9tfMflA2mtZCLums4Fx20WmuB7Kv75tieeS3Q=;
        b=dKBpupExw/gxjvWh2jttYIOjajep92Tzyup224LBL8gDWa//Vb71kI/zRQ9yxGZxkadYo5
        c736riaqeflPofFavA9Ft9afCNu3R5wFihKwusJhFVbsk1mbBxP2sEwXeu/lBVXEMMtrfs
        fJnKZtcreiYAXuoTK5PGJi/4J6Ye5Ls=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-lQ7jdd6FNM-6OwuDtv85_g-1; Tue, 04 Feb 2020 21:59:07 -0500
X-MC-Unique: lQ7jdd6FNM-6OwuDtv85_g-1
Received: by mail-qt1-f198.google.com with SMTP id h11so414488qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 18:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T3MfHN9tfMflA2mtZCLums4Fx20WmuB7Kv75tieeS3Q=;
        b=ZVRkxHGOEB+ZdMbJNE38wpX+Mwsp9sQHdxmVvzpEuM0NDtrFDdh0snNyYm/UvlVq0Y
         taIi7Ufmo58XABLDWWCMGxQbYtS+qYggvF7yhVo/5NwSd3evj6oYKvA1fbI1vdTVMrOK
         d+j/SoI7pDcOafbzoLIY5k772ppz/gfDp2hESjtAC3o/KsXseVuoYAXaQxUk6/UxvM/Y
         a8pMNM6ycnQTrGrdQn6x8agry6CnhyNYvqbcGpWMzcmFPoX/Ys52UqO2REMR/dFyWdJN
         rkXsPHcy5SRZfhhRYUnXHVmI4arKsluDS2uhuIHL+lSLlieeXQL9Ei9Xcfei2xDKfD4C
         a7jg==
X-Gm-Message-State: APjAAAVpvvUDg5oJfriLEZvsO42Jnrd8OovzMa06zIXSk5NlACeLrlAR
        QtUFASCRXpmHuqiCFWUyXgtReb6szF5TM3Fztlp33qOuVMREbuEHTC9Eiue8gUeBi7lJNO9soit
        s6F+hzgAQPv21hGWep1LwKxYZ
X-Received: by 2002:a37:47c8:: with SMTP id u191mr32340475qka.438.1580871545346;
        Tue, 04 Feb 2020 18:59:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKBLFeUOTbByGjjkxUFAudwxLYcVqrWwN0nXLuxqXpj2ynXuSckzR2GzSHtwiMeb5iakaRWA==
X-Received: by 2002:a37:47c8:: with SMTP id u191mr32340458qka.438.1580871544935;
        Tue, 04 Feb 2020 18:59:04 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id e64sm12961649qtd.45.2020.02.04.18.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 18:59:04 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinechin@redhat.com, sean.j.christopherson@intel.com,
        pbonzini@redhat.com, jasowang@redhat.com, yan.y.zhao@intel.com,
        mst@redhat.com, peterx@redhat.com, kevin.tian@intel.com,
        alex.williamson@redhat.com, dgilbert@redhat.com,
        vkuznets@redhat.com
Subject: [PATCH 13/14] KVM: selftests: Let dirty_log_test async for dirty ring test
Date:   Tue,  4 Feb 2020 21:58:41 -0500
Message-Id: <20200205025842.367575-10-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205025842.367575-1-peterx@redhat.com>
References: <20200205025105.367213-1-peterx@redhat.com>
 <20200205025842.367575-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the dirty ring test was working in synchronous way, because
only with a vmexit (with that it was the ring full event) we'll know
the hardware dirty bits will be flushed to the dirty ring.

With this patch we first introduced the vcpu kick mechanism by using
SIGUSR1, meanwhile we can have a guarantee of vmexit and also the
flushing of hardware dirty bits.  With all these, we can keep the vcpu
dirty work asynchronous of the whole collection procedure now.  Still,
we need to be very careful that we can only do it async if the vcpu is
not reaching soft limit (no KVM_EXIT_DIRTY_RING_FULL).  Otherwise we
must collect the dirty bits before continuing the vcpu.

Further increase the dirty ring size to current maximum to make sure
we torture more on the no-ring-full case, which should be the major
scenario when the hypervisors like QEMU would like to use this feature.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c  | 123 +++++++++++++-----
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |   8 ++
 3 files changed, 103 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index b4c210f33dd7..6c754e91fc50 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -13,6 +13,9 @@
 #include <time.h>
 #include <pthread.h>
 #include <semaphore.h>
+#include <sys/types.h>
+#include <signal.h>
+#include <errno.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <asm/barrier.h>
@@ -59,7 +62,9 @@
 # define test_and_clear_bit_le	test_and_clear_bit
 #endif
 
-#define TEST_DIRTY_RING_COUNT		1024
+#define TEST_DIRTY_RING_COUNT		65536
+
+#define SIG_IPI SIGUSR1
 
 /*
  * Guest/Host shared variables. Ensure addr_gva2hva() and/or
@@ -135,6 +140,12 @@ static uint64_t host_track_next_count;
 /* Whether dirty ring reset is requested, or finished */
 static sem_t dirty_ring_vcpu_stop;
 static sem_t dirty_ring_vcpu_cont;
+/*
+ * This is updated by the vcpu thread to tell the host whether it's a
+ * ring-full event.  It should only be read until a sem_wait() of
+ * dirty_ring_vcpu_stop and before vcpu continues to run.
+ */
+static bool dirty_ring_vcpu_ring_full;
 
 enum log_mode_t {
 	/* Only use KVM_GET_DIRTY_LOG for logging */
@@ -151,6 +162,33 @@ enum log_mode_t {
 
 /* Mode of logging.  Default is LOG_MODE_DIRTY_LOG */
 static enum log_mode_t host_log_mode;
+pthread_t vcpu_thread;
+
+/* Only way to pass this to the signal handler */
+struct kvm_vm *current_vm;
+
+static void vcpu_sig_handler(int sig)
+{
+	TEST_ASSERT(sig == SIG_IPI, "unknown signal: %d", sig);
+}
+
+static void vcpu_kick(void)
+{
+	pthread_kill(vcpu_thread, SIG_IPI);
+}
+
+/*
+ * In our test we do signal tricks, let's use a better version of
+ * sem_wait to avoid signal interrupts
+ */
+static void sem_wait_until(sem_t *sem)
+{
+	int ret;
+
+	do
+		ret = sem_wait(sem);
+	while (ret == -1 && errno == EINTR);
+}
 
 static void clear_log_create_vm_done(struct kvm_vm *vm)
 {
@@ -179,10 +217,13 @@ static void clear_log_collect_dirty_pages(struct kvm_vm *vm, int slot,
 	kvm_vm_clear_dirty_log(vm, slot, bitmap, 0, num_pages);
 }
 
-static void default_after_vcpu_run(struct kvm_vm *vm)
+static void default_after_vcpu_run(struct kvm_vm *vm, int ret, int err)
 {
 	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
 
+	TEST_ASSERT(ret == 0 || (ret == -1 && err == EINTR),
+		    "vcpu run failed: errno=%d", err);
+
 	TEST_ASSERT(get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC,
 		    "Invalid guest sync status: exit_reason=%s\n",
 		    exit_reason_str(run->exit_reason));
@@ -233,27 +274,37 @@ static uint32_t dirty_ring_collect_one(struct kvm_dirty_gfn *dirty_gfns,
 	return count;
 }
 
+static void dirty_ring_wait_vcpu(void)
+{
+	/* This makes sure that hardware PML cache flushed */
+	vcpu_kick();
+	sem_wait_until(&dirty_ring_vcpu_stop);
+}
+
+static void dirty_ring_continue_vcpu(void)
+{
+	DEBUG("Notifying vcpu to continue\n");
+	sem_post(&dirty_ring_vcpu_cont);
+}
+
 static void dirty_ring_collect_dirty_pages(struct kvm_vm *vm, int slot,
 					   void *bitmap, uint32_t num_pages)
 {
 	/* We only have one vcpu */
 	static uint32_t fetch_index = 0;
 	uint32_t count = 0, cleared;
+	bool continued_vcpu = false;
 
-	/*
-	 * Before fetching the dirty pages, we need a vmexit of the
-	 * worker vcpu to make sure the hardware dirty buffers were
-	 * flushed.  This is not needed for dirty-log/clear-log tests
-	 * because get dirty log will natually do so.
-	 *
-	 * For now we do it in the simple way - we simply wait until
-	 * the vcpu uses up the soft dirty ring, then it'll always
-	 * do a vmexit to make sure that PML buffers will be flushed.
-	 * In real hypervisors, we probably need a vcpu kick or to
-	 * stop the vcpus (before the final sync) to make sure we'll
-	 * get all the existing dirty PFNs even cached in hardware.
-	 */
-	sem_wait(&dirty_ring_vcpu_stop);
+	dirty_ring_wait_vcpu();
+
+	if (!dirty_ring_vcpu_ring_full) {
+		/*
+		 * This is not a ring-full event, it's safe to allow
+		 * vcpu to continue
+		 */
+		dirty_ring_continue_vcpu();
+		continued_vcpu = true;
+	}
 
 	/* Only have one vcpu */
 	count = dirty_ring_collect_one(vcpu_map_dirty_ring(vm, VCPU_ID),
@@ -265,13 +316,16 @@ static void dirty_ring_collect_dirty_pages(struct kvm_vm *vm, int slot,
 	TEST_ASSERT(cleared == count, "Reset dirty pages (%u) mismatch "
 		    "with collected (%u)", cleared, count);
 
-	DEBUG("Notifying vcpu to continue\n");
-	sem_post(&dirty_ring_vcpu_cont);
+	if (!continued_vcpu) {
+		TEST_ASSERT(dirty_ring_vcpu_ring_full,
+			    "Didn't continue vcpu even without ring full");
+		dirty_ring_continue_vcpu();
+	}
 
 	DEBUG("Iteration %ld collected %u pages\n", iteration, count);
 }
 
-static void dirty_ring_after_vcpu_run(struct kvm_vm *vm)
+static void dirty_ring_after_vcpu_run(struct kvm_vm *vm, int ret, int err)
 {
 	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
 
@@ -279,10 +333,16 @@ static void dirty_ring_after_vcpu_run(struct kvm_vm *vm)
 	if (get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC) {
 		/* We should allow this to continue */
 		;
-	} else if (run->exit_reason == KVM_EXIT_DIRTY_RING_FULL) {
+	} else if (run->exit_reason == KVM_EXIT_DIRTY_RING_FULL ||
+		   (ret == -1 && err == EINTR)) {
+		/* Update the flag first before pause */
+		WRITE_ONCE(dirty_ring_vcpu_ring_full,
+			   run->exit_reason == KVM_EXIT_DIRTY_RING_FULL);
 		sem_post(&dirty_ring_vcpu_stop);
-		DEBUG("vcpu stops because dirty ring full...\n");
-		sem_wait(&dirty_ring_vcpu_cont);
+		DEBUG("vcpu stops because %s...\n",
+		      dirty_ring_vcpu_ring_full ?
+		      "dirty ring is full" : "vcpu is kicked out");
+		sem_wait_until(&dirty_ring_vcpu_cont);
 		DEBUG("vcpu continues now.\n");
 	} else {
 		TEST_ASSERT(false, "Invalid guest sync status: "
@@ -305,7 +365,7 @@ struct log_mode {
 	void (*collect_dirty_pages) (struct kvm_vm *vm, int slot,
 				     void *bitmap, uint32_t num_pages);
 	/* Hook to call when after each vcpu run */
-	void (*after_vcpu_run)(struct kvm_vm *vm);
+	void (*after_vcpu_run)(struct kvm_vm *vm, int ret, int err);
 	void (*before_vcpu_join) (void);
 } log_modes[LOG_MODE_NUM] = {
 	{
@@ -365,12 +425,12 @@ static void log_mode_collect_dirty_pages(struct kvm_vm *vm, int slot,
 	mode->collect_dirty_pages(vm, slot, bitmap, num_pages);
 }
 
-static void log_mode_after_vcpu_run(struct kvm_vm *vm)
+static void log_mode_after_vcpu_run(struct kvm_vm *vm, int ret, int err)
 {
 	struct log_mode *mode = &log_modes[host_log_mode];
 
 	if (mode->after_vcpu_run)
-		mode->after_vcpu_run(vm);
+		mode->after_vcpu_run(vm, ret, err);
 }
 
 static void log_mode_before_vcpu_join(void)
@@ -394,15 +454,21 @@ static void *vcpu_worker(void *data)
 	int ret;
 	struct kvm_vm *vm = data;
 	uint64_t *guest_array;
+	struct sigaction sigact;
+
+	current_vm = vm;
+	memset(&sigact, 0, sizeof(sigact));
+	sigact.sa_handler = vcpu_sig_handler;
+	sigaction(SIG_IPI, &sigact, NULL);
 
 	guest_array = addr_gva2hva(vm, (vm_vaddr_t)random_array);
 
 	while (!READ_ONCE(host_quit)) {
+		/* Clear any existing kick signals */
 		generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
 		/* Let the guest dirty the random pages */
-		ret = _vcpu_run(vm, VCPU_ID);
-		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
-		log_mode_after_vcpu_run(vm);
+		ret = __vcpu_run(vm, VCPU_ID);
+		log_mode_after_vcpu_run(vm, ret, errno);
 	}
 
 	return NULL;
@@ -549,7 +615,6 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 		     unsigned long interval, uint64_t phys_offset)
 {
-	pthread_t vcpu_thread;
 	struct kvm_vm *vm;
 	unsigned long *bmap;
 
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 4b78a8d3e773..e64fbfe6bbd5 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -115,6 +115,7 @@ vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva);
 struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
 int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
+int __vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_set_mp_state(struct kvm_vm *vm, uint32_t vcpuid,
 		       struct kvm_mp_state *mp_state);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 25edf20d1962..5137882503bd 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1203,6 +1203,14 @@ int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
 	return rc;
 }
 
+int __vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+	return ioctl(vcpu->fd, KVM_RUN, NULL);
+}
+
 void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid)
 {
 	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-- 
2.24.1

