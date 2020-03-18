Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F7DC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6779C20753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+wn8440"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgCRQiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:38:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41527 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727244AbgCRQip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584549523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FINdKLbbHP/xOh0Xglhm9n3sMdHfcvPlDNVTGKPb5V4=;
        b=T+wn8440kBl4u4HFpe7wVkG2hNFG3LRdauXFopcxjKFR4WRao02WRMJb33vabNxeo8e7cn
        /3nzG/WxMCcvb2+hhqzmVX65njzipqatdeVmTvt2npl6BKa6dEo5z9nRIZpga7hQ+DgYnt
        i8nLmCM1D9k7QDEGiaiL2b+mLFS8qVk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-EQvwF9wKPWe6gWjmis3nDQ-1; Wed, 18 Mar 2020 12:38:42 -0400
X-MC-Unique: EQvwF9wKPWe6gWjmis3nDQ-1
Received: by mail-wm1-f72.google.com with SMTP id f185so1282632wmf.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 09:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FINdKLbbHP/xOh0Xglhm9n3sMdHfcvPlDNVTGKPb5V4=;
        b=eA+bpR53/AVmDv9DQMpPa513q6bQw0SGflbPVt6OnuTxaS7uQqqr5BqoRleisgvaZ6
         2f5J1ZB/NgLPCIUXtUGySJe6I4Yr1JjpZwax1ItWlYGCUITG/q5m0jbS5u6V/x/xv2v3
         ebcKnu90Yj/CsqAr9bgEGT0UG+1j0MXCvDscgB0947Es5Z6L+S6hz4YmB7DH2y0APYjJ
         mF2jcXKLarl4mPUKK/osr3gD3102FmXXf3snpAs1JPwx1w50rA46Y0VFIpInQoYuMGTK
         cdK/36Ba3H9ZV7fRTkML447v4+06EpwErihoTrrBsxYO7hmlzQDWk8dKnbk3xQ1FDaqy
         nY9g==
X-Gm-Message-State: ANhLgQ1+C1eZCLW/fFiujZCq0jveSyFmfcIMDFxKwtOS0W09gy+g72nH
        If2r0GhWmDkogJOaDuUSmY0BSGzjc2NE7bSQ9RYCv69g3BZWeo5kq3a7YDqbxqKv38MUc/r3tST
        KZ3OqbrzqwqX3yoyz6jfKoSwj
X-Received: by 2002:a1c:e1c3:: with SMTP id y186mr2852237wmg.151.1584549519245;
        Wed, 18 Mar 2020 09:38:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv8Z8cppQXQ29GsS0JjpdcT/eLmYBtaeDT+iFLEtrrWGXEFawmBCsPt4YkOsh7q/jt6uoOyow==
X-Received: by 2002:a1c:e1c3:: with SMTP id y186mr2852217wmg.151.1584549518972;
        Wed, 18 Mar 2020 09:38:38 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id t9sm6764971wrx.31.2020.03.18.09.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 09:38:38 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>, peterx@redhat.com,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7 11/14] KVM: selftests: Introduce after_vcpu_run hook for dirty log test
Date:   Wed, 18 Mar 2020 12:37:17 -0400
Message-Id: <20200318163720.93929-12-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318163720.93929-1-peterx@redhat.com>
References: <20200318163720.93929-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a hook for the checks after vcpu_run() completes.  Preparation
for the dirty ring test because we'll need to take care of another
exit reason.

Since at it, drop the pages_count because after all we have a better
summary right now with statistics, and clean it up a bit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 41 ++++++++++++++------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 139ccb550618..94122c2e0185 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -178,6 +178,15 @@ static void clear_log_collect_dirty_pages(struct kvm_vm *vm, int slot,
 	kvm_vm_clear_dirty_log(vm, slot, bitmap, 0, num_pages);
 }
 
+static void default_after_vcpu_run(struct kvm_vm *vm)
+{
+	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+
+	TEST_ASSERT(get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC,
+		    "Invalid guest sync status: exit_reason=%s\n",
+		    exit_reason_str(run->exit_reason));
+}
+
 struct log_mode {
 	const char *name;
 	/* Return true if this mode is supported, otherwise false */
@@ -187,16 +196,20 @@ struct log_mode {
 	/* Hook to collect the dirty pages into the bitmap provided */
 	void (*collect_dirty_pages) (struct kvm_vm *vm, int slot,
 				     void *bitmap, uint32_t num_pages);
+	/* Hook to call when after each vcpu run */
+	void (*after_vcpu_run)(struct kvm_vm *vm);
 } log_modes[LOG_MODE_NUM] = {
 	{
 		.name = "dirty-log",
 		.collect_dirty_pages = dirty_log_collect_dirty_pages,
+		.after_vcpu_run = default_after_vcpu_run,
 	},
 	{
 		.name = "clear-log",
 		.supported = clear_log_supported,
 		.create_vm_done = clear_log_create_vm_done,
 		.collect_dirty_pages = clear_log_collect_dirty_pages,
+		.after_vcpu_run = default_after_vcpu_run,
 	},
 };
 
@@ -247,6 +260,14 @@ static void log_mode_collect_dirty_pages(struct kvm_vm *vm, int slot,
 	mode->collect_dirty_pages(vm, slot, bitmap, num_pages);
 }
 
+static void log_mode_after_vcpu_run(struct kvm_vm *vm)
+{
+	struct log_mode *mode = &log_modes[host_log_mode];
+
+	if (mode->after_vcpu_run)
+		mode->after_vcpu_run(vm);
+}
+
 static void generate_random_array(uint64_t *guest_array, uint64_t size)
 {
 	uint64_t i;
@@ -261,25 +282,23 @@ static void *vcpu_worker(void *data)
 	struct kvm_vm *vm = data;
 	uint64_t *guest_array;
 	uint64_t pages_count = 0;
-	struct kvm_run *run;
+	struct sigaction sigact;
 
-	run = vcpu_state(vm, VCPU_ID);
+	current_vm = vm;
+	vcpu_fd = vcpu_get_fd(vm, VCPU_ID);
+	memset(&sigact, 0, sizeof(sigact));
+	sigact.sa_handler = vcpu_sig_handler;
+	sigaction(SIG_IPI, &sigact, NULL);
 
 	guest_array = addr_gva2hva(vm, (vm_vaddr_t)random_array);
-	generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
 
 	while (!READ_ONCE(host_quit)) {
+		generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
+		pages_count += TEST_PAGES_PER_LOOP;
 		/* Let the guest dirty the random pages */
 		ret = _vcpu_run(vm, VCPU_ID);
 		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
-		if (get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC) {
-			pages_count += TEST_PAGES_PER_LOOP;
-			generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
-		} else {
-			TEST_FAIL("Invalid guest sync status: "
-				  "exit_reason=%s\n",
-				  exit_reason_str(run->exit_reason));
-		}
+		log_mode_after_vcpu_run(vm);
 	}
 
 	pr_info("Dirtied %"PRIu64" pages\n", pages_count);
-- 
2.24.1

