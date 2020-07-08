Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A9EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248BB2078D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQP3kVbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgGHTfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:35:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21266 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726845AbgGHTec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594236871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Frsr00VTIsYjdqDeTzSRco7BaTYBstaIvbV6rdyHlg=;
        b=JQP3kVbBCsMNHp5r6QtA13veXWfGfDique/5XXzTNxa1Yz90gnmDbQ6EvMz40WyM9PTkB/
        dal/ufeW3x0R3Mw1yY3mfQHBDxUQe38pfikRDXknfsRhptU/Bv2Q6z5Wfwn7qoBMTzXaEn
        NClDR3qLGFLrd0oHWo9UKWtKldxpDSg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-pzovjpSsOBqq_O5aaSHhxQ-1; Wed, 08 Jul 2020 15:34:29 -0400
X-MC-Unique: pzovjpSsOBqq_O5aaSHhxQ-1
Received: by mail-qk1-f198.google.com with SMTP id 13so16893867qks.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Frsr00VTIsYjdqDeTzSRco7BaTYBstaIvbV6rdyHlg=;
        b=tib4gOIeEnkmuuTjoQBq3IfQYCximWA7uDWP66KW2+76WWVNQC+kuRj9LsKsQ0Je+N
         CbcigAeRhqBjv7V8qK2Q29gOaK3XCVFv+TqKmLPTYAyOdmLVasK6g5NQnlpqCJUMHa5+
         7KICEJHhQGZ+ldRj59E/9xYJPtZOJkBDE/YM7eW2yPdqjxujo4Y9C/XumXq7ZvRyeD4c
         8Rsh9W56PnF1EtYPWw6T66CyRCcs9OQ5nQ3+rNn4hV6v/xYVepx49F07l4WK+I+fwoFc
         1LkzVp/nJc2vDKHGXRaGyLxMOato04Ckzen7EPwWxUVlMsTbMq3+nSgfSK3lMAMrkV49
         O/LQ==
X-Gm-Message-State: AOAM531NTg5QEoRKYH5bhJlDUQoQQFMMJ9Gq1mTMS45ZqxyOJw+ZZJ0A
        kC+xG3VQ17F6bDsfQr3j4ni4hY7Y35nNQzxqWWuPKfJRLN6xZWePTNYR9Y8xfEJYRZfMKqAezbU
        myMVH7RsDHu/g455ziMKZbHzW
X-Received: by 2002:a05:6214:12c:: with SMTP id w12mr12785332qvs.78.1594236869167;
        Wed, 08 Jul 2020 12:34:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhhogDlEob2FtS8KDhjvuCX9hbkX64dztP+mMW9Xu5ZFyStLlHU0ETMPRqGMDCdqiDAPAv0Q==
X-Received: by 2002:a05:6214:12c:: with SMTP id w12mr12785311qvs.78.1594236868931;
        Wed, 08 Jul 2020 12:34:28 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c8:6f::1f4f])
        by smtp.gmail.com with ESMTPSA id f18sm664884qtc.28.2020.07.08.12.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 12:34:28 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v11 10/13] KVM: selftests: Introduce after_vcpu_run hook for dirty log test
Date:   Wed,  8 Jul 2020 15:34:05 -0400
Message-Id: <20200708193408.242909-11-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708193408.242909-1-peterx@redhat.com>
References: <20200708193408.242909-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a hook for the checks after vcpu_run() completes.  Preparation
for the dirty ring test because we'll need to take care of another
exit reason.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 36 +++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 139ccb550618..a2160946bcf5 100644
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
@@ -261,25 +282,16 @@ static void *vcpu_worker(void *data)
 	struct kvm_vm *vm = data;
 	uint64_t *guest_array;
 	uint64_t pages_count = 0;
-	struct kvm_run *run;
-
-	run = vcpu_state(vm, VCPU_ID);
 
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
2.26.2

