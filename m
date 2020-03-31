Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6BAC2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3609F207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVWa4nzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbgCaTBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:01:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50829 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731285AbgCaTBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585681293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpD2kEQIv9tlf4VTpXdqhelQzLU1X8sWWcoS/iqQyA8=;
        b=bVWa4nzBsxvhKvnTAxhlNXchVtRc5K3HobKcbQCJ0FDkk6ifHS4Rbt3vaBRpR85EAgEL6C
        E44AKHCtFVMQlqrbTnjQ5EVyWmi6BA9xnsX7VVZgCYBjT8RLWrtDnvWdzItwy+6/EIrjZO
        WxE6pPeXOPL1KrtV7WC1/w3dDM8d/Sw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-FX8EvmI-MnWvjOgHRAW2rQ-1; Tue, 31 Mar 2020 15:01:32 -0400
X-MC-Unique: FX8EvmI-MnWvjOgHRAW2rQ-1
Received: by mail-wm1-f70.google.com with SMTP id j18so1065294wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpD2kEQIv9tlf4VTpXdqhelQzLU1X8sWWcoS/iqQyA8=;
        b=rhz6KU3LBUwq7ZISEf2HJNnVJzZkbXQFJ4zx8eXBFP49F1McrJ0ECQ28lxuOw1G0nZ
         yJFWCZtcs00bHjBvtNpVxon2oRr5RRE5u7WWeIbXVaJEJXFclTne+P0HjBSjMDCQ3mxl
         QTkMMolyWbdJL1KhYV7odJwKfZ+gQg9JbD5F1ybOycT0CtANXbmHaugZqo7/VsnfhI6X
         VGJl3QTpyRUoxR//jWn4JmUlHsNHOv3Mxg62nXOzgIS0qBEQlzeP0JeOn0U5oMNJjcQO
         kZBMdfbXgKuAPBlDAsFJCYeGP/mFDjHGx+VYEF/H3HgydvziQks+xfvVVprwcXG7plya
         Y3fg==
X-Gm-Message-State: ANhLgQ0aL3cOGbeSolsQn5XcHI5cvYuSSLePYk9Ip9PDwsPNfdJEnZcw
        DiH/CFnw4VltVsMy6se8cMpw+K86vPYh/nOv89P2nKndAKYqeL94D1d+bePyX90duZ0EA0uSAKT
        7coCFuCAkD8gtVA57LRsY5sit
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr21661328wrp.353.1585681290527;
        Tue, 31 Mar 2020 12:01:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsHKybAaTsS9HEduBHy2riDVsEOagD3f8xBZunLDGxSK2xwbCHDHdt1hzqrHnjR4E9o0Hx1BQ==
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr21661303wrp.353.1585681290320;
        Tue, 31 Mar 2020 12:01:30 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id h10sm29023479wrq.33.2020.03.31.12.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:01:29 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v8 14/14] KVM: selftests: Add "-c" parameter to dirty log test
Date:   Tue, 31 Mar 2020 15:00:00 -0400
Message-Id: <20200331190000.659614-15-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331190000.659614-1-peterx@redhat.com>
References: <20200331190000.659614-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used to override the existing dirty ring size/count.  If
with a bigger ring count, we test async of dirty ring.  If with a
smaller ring count, we test ring full code path.  Async is default.

It has no use for non-dirty-ring tests.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 4b404dfdc2f9..80c42c87265e 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -168,6 +168,7 @@ static enum log_mode_t host_log_mode_option = LOG_MODE_ALL;
 /* Logging mode for current run */
 static enum log_mode_t host_log_mode;
 static pthread_t vcpu_thread;
+static uint32_t test_dirty_ring_count = TEST_DIRTY_RING_COUNT;
 
 /* Only way to pass this to the signal handler */
 static struct kvm_vm *current_vm;
@@ -250,7 +251,7 @@ static void dirty_ring_create_vm_done(struct kvm_vm *vm)
 	 * Switch to dirty ring mode after VM creation but before any
 	 * of the vcpu creation.
 	 */
-	vm_enable_dirty_ring(vm, TEST_DIRTY_RING_COUNT *
+	vm_enable_dirty_ring(vm, test_dirty_ring_count *
 			     sizeof(struct kvm_dirty_gfn));
 }
 
@@ -272,7 +273,7 @@ static uint32_t dirty_ring_collect_one(struct kvm_dirty_gfn *dirty_gfns,
 	uint32_t count = 0;
 
 	while (true) {
-		cur = &dirty_gfns[*fetch_index % TEST_DIRTY_RING_COUNT];
+		cur = &dirty_gfns[*fetch_index % test_dirty_ring_count];
 		if (!dirty_gfn_is_dirtied(cur))
 			break;
 		TEST_ASSERT(cur->slot == slot, "Slot number didn't match: "
@@ -778,6 +779,9 @@ static void help(char *name)
 	printf("usage: %s [-h] [-i iterations] [-I interval] "
 	       "[-p offset] [-m mode]\n", name);
 	puts("");
+	printf(" -c: specify dirty ring size, in number of entries\n");
+	printf("     (only useful for dirty-ring test; default: %"PRIu32")\n",
+	       TEST_DIRTY_RING_COUNT);
 	printf(" -i: specify iteration counts (default: %"PRIu64")\n",
 	       TEST_HOST_LOOP_N);
 	printf(" -I: specify interval in ms (default: %"PRIu64" ms)\n",
@@ -833,8 +837,11 @@ int main(int argc, char *argv[])
 	guest_mode_init(VM_MODE_P40V48_4K, true, true);
 #endif
 
-	while ((opt = getopt(argc, argv, "hi:I:p:m:M:")) != -1) {
+	while ((opt = getopt(argc, argv, "c:hi:I:p:m:M:")) != -1) {
 		switch (opt) {
+		case 'c':
+			test_dirty_ring_count = strtol(optarg, NULL, 10);
+			break;
 		case 'i':
 			iterations = strtol(optarg, NULL, 10);
 			break;
-- 
2.24.1

