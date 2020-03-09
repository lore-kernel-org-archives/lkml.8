Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115AFC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D428324649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3DCPFqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCIWZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:25:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22570 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727314AbgCIWZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583792729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WYsgWKedk4JgdTdZEDHh7mPLAInxvRsrPeWFUx8JX40=;
        b=P3DCPFqhHwklaR1ajy8fxPQni6/irXHYYouQfto1wymgh2OKpv6BevVdWNmi+hb+G+bj3P
        GmvlclmxFBF9Fbmc3SlUVrrIVBYHZ8YYAB4SBGawWaaMiNxJ2EMgnt/+QDqF6H1QYe+2kA
        8SIhLxuUTe7UvimQE/G3dTBrWsB3fIs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-b_GyE0N5PtC-t3V8FXQNIg-1; Mon, 09 Mar 2020 18:25:27 -0400
X-MC-Unique: b_GyE0N5PtC-t3V8FXQNIg-1
Received: by mail-qt1-f200.google.com with SMTP id q7so7812052qtp.16
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 15:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYsgWKedk4JgdTdZEDHh7mPLAInxvRsrPeWFUx8JX40=;
        b=hmQybCzQEh+WrH5NzUn57SDpHEjI4/23d9/LSOvAZ48HAuuP2aHpgeDbQ+dM8pe2bx
         nTqcy8YlTGNzYcrTqJLHFeclYqi3FS+dwjRXdTGb2VC7RDOO/Wvul8ly9Bb2b+3Um8UN
         3SzSxAobGyioa7zn4rQUgHaPZAZ0KIb24PrvYisM/XObcMpU1GmyECjEFUqGe1PXmEbY
         RZzm15B0ax2Qf2nOl+WpR2jYEqnmSpYW5jC1JoSFzTrJHRoZYGdWvZcqxkCGR29ODmEL
         3fD/Ub+7AbBaSF2QagdO0e94mwVL3tm45t+gdFgRqX/QBMrDDLsnBjq8APq2V5kpBrl/
         BIEg==
X-Gm-Message-State: ANhLgQ1/hXrzz0A8wPLk6+9h6NhJ038AkFzsMrE4vbEqLBPktQ898rmM
        h+kzbZfj5mPgVWgPcusrYRoAG0yPexTplia3S6TNBnftxxA63DzKrZXIdnZHXmz8F9rMbqCO3s2
        3P3xkxpZSAjzlETaFmo4gVGnt
X-Received: by 2002:a37:a0c1:: with SMTP id j184mr10432510qke.351.1583792726904;
        Mon, 09 Mar 2020 15:25:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv2Ogo2VnD+jgwtXg8mGNvF8li+aVTc7yLXr21eAVFTV6vWz/X/IJj/CZ8DwudKU5ic+0psOA==
X-Received: by 2002:a37:a0c1:: with SMTP id j184mr10432487qke.351.1583792726674;
        Mon, 09 Mar 2020 15:25:26 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j17sm23660450qth.27.2020.03.09.15.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 15:25:26 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v6 11/14] KVM: selftests: Introduce after_vcpu_run hook for dirty log test
Date:   Mon,  9 Mar 2020 18:25:24 -0400
Message-Id: <20200309222524.345649-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309214424.330363-1-peterx@redhat.com>
References: 
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
 tools/testing/selftests/kvm/dirty_log_test.c | 39 ++++++++++++--------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 642886394e34..b6fb4f86032c 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -173,6 +173,15 @@ static void clear_log_collect_dirty_pages(struct kvm_vm *vm, int slot,
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
@@ -182,16 +191,20 @@ struct log_mode {
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
 
@@ -241,6 +254,14 @@ static void log_mode_collect_dirty_pages(struct kvm_vm *vm, int slot,
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
@@ -254,31 +275,17 @@ static void *vcpu_worker(void *data)
 	int ret;
 	struct kvm_vm *vm = data;
 	uint64_t *guest_array;
-	uint64_t pages_count = 0;
-	struct kvm_run *run;
-
-	run = vcpu_state(vm, VCPU_ID);
 
 	guest_array = addr_gva2hva(vm, (vm_vaddr_t)random_array);
-	generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
 
 	while (!READ_ONCE(host_quit)) {
+		generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
 		/* Let the guest dirty the random pages */
 		ret = _vcpu_run(vm, VCPU_ID);
 		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
-		if (get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC) {
-			pages_count += TEST_PAGES_PER_LOOP;
-			generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
-		} else {
-			TEST_ASSERT(false,
-				    "Invalid guest sync status: "
-				    "exit_reason=%s\n",
-				    exit_reason_str(run->exit_reason));
-		}
+		log_mode_after_vcpu_run(vm);
 	}
 
-	DEBUG("Dirtied %"PRIu64" pages\n", pages_count);
-
 	return NULL;
 }
 
-- 
2.24.1

