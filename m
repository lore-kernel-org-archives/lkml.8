Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC3AC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970B324649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rq9LH+co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgCIWZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:25:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47380 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727435AbgCIWZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583792745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lv9eFQ9Kzg7exvd9kWxFWYuTarInnzxpnez1RQkbt+o=;
        b=Rq9LH+comL7974EfcTCkIc85AfID/xtB6n3/nB3YjXClqF1Cn67R5v+MQkhce3P3s+eu7W
        /qKWUkRrBA9RXiGCYN66U8EDbwTblGxgvdgBY94O9yB2ozXcwRxdOkwraa0jshOh/J6W3A
        VD0lypWXtgvz7hUz7lOqy9iWzImIgS8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-VL7uDeiIM_6F10SHlwrlXg-1; Mon, 09 Mar 2020 18:25:43 -0400
X-MC-Unique: VL7uDeiIM_6F10SHlwrlXg-1
Received: by mail-qt1-f200.google.com with SMTP id g6so7820306qtp.20
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 15:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lv9eFQ9Kzg7exvd9kWxFWYuTarInnzxpnez1RQkbt+o=;
        b=soOwa8LdLDLog5YCmvbdMJlWqxHhXwvPx7xryQOGhcWCOug+0Tbhv4cyaaqCpRV/aH
         yH6aH+YR2ZVgGmFIrxf94hDQAfqRd2X6/a3sJX5MMGmlaJt4Lw76iGdQVSGXPF1v1Pp0
         rBnzW2Ecz3lPMuUY10PLTWC6nXTj6p2H32gZdNGVGS4K4ADpwpVwmwH3JgNwJxxwNiOU
         7eL9EccMpBbzmfakO0n2Uo7gogGRPEo9RcZRIhK+NKA8x1UFEw+N5tZ/TlqQIsNVJE3J
         Z9+f63yKmO5DSR9ptTw8TJJV4VmKXdS0hGKrcblV8zlvE1ADWBpQDziIL6/serpl/1mP
         KdMQ==
X-Gm-Message-State: ANhLgQ1KSmycKejZOlPord+n6i0n6lWgBqVY7VkcTfs/EDQGYPq6SGLM
        Pat0mdECJpMxq9CyOmiucK9rfplHBCXAqMf+JxEx777nQy0VGF2p+M7+9h2MzJfN8kq98Z9LMz9
        31uNX3PftOO4DXRvFmpdhCBG1
X-Received: by 2002:a0c:e886:: with SMTP id b6mr16499388qvo.31.1583792742573;
        Mon, 09 Mar 2020 15:25:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsPtpOUg/cm4Otshe5Cw28CoeO4qDCsTFo+0ne7OfrggSuGkqc5mpGQRPZPwbGgFIA9BFALGw==
X-Received: by 2002:a0c:e886:: with SMTP id b6mr16499368qvo.31.1583792742342;
        Mon, 09 Mar 2020 15:25:42 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 184sm6156469qkh.63.2020.03.09.15.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 15:25:41 -0700 (PDT)
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
Subject: [PATCH v6 14/14] KVM: selftests: Add "-c" parameter to dirty log test
Date:   Mon,  9 Mar 2020 18:25:40 -0400
Message-Id: <20200309222540.345796-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309214424.330363-1-peterx@redhat.com>
References: 
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index b07e52858e87..60f3921e6c40 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -168,6 +168,7 @@ static enum log_mode_t host_log_mode_option = LOG_MODE_ALL;
 /* Logging mode for current run */
 static enum log_mode_t host_log_mode;
 pthread_t vcpu_thread;
+static uint32_t test_dirty_ring_count = TEST_DIRTY_RING_COUNT;
 
 /* Only way to pass this to the signal handler */
 struct kvm_vm *current_vm;
@@ -245,7 +246,7 @@ static void dirty_ring_create_vm_done(struct kvm_vm *vm)
 	 * Switch to dirty ring mode after VM creation but before any
 	 * of the vcpu creation.
 	 */
-	vm_enable_dirty_ring(vm, TEST_DIRTY_RING_COUNT *
+	vm_enable_dirty_ring(vm, test_dirty_ring_count *
 			     sizeof(struct kvm_dirty_gfn));
 }
 
@@ -267,7 +268,7 @@ static uint32_t dirty_ring_collect_one(struct kvm_dirty_gfn *dirty_gfns,
 	uint32_t count = 0;
 
 	while (true) {
-		cur = &dirty_gfns[*fetch_index % TEST_DIRTY_RING_COUNT];
+		cur = &dirty_gfns[*fetch_index % test_dirty_ring_count];
 		if (!dirty_gfn_is_dirtied(cur))
 			break;
 		TEST_ASSERT(cur->slot == slot, "Slot number didn't match: "
@@ -774,6 +775,9 @@ static void help(char *name)
 	printf("usage: %s [-h] [-i iterations] [-I interval] "
 	       "[-p offset] [-m mode]\n", name);
 	puts("");
+	printf(" -c: specify dirty ring size, in number of entries\n");
+	printf("     (only useful for dirty-ring test; default: %"PRIu32")\n",
+	       TEST_DIRTY_RING_COUNT);
 	printf(" -i: specify iteration counts (default: %"PRIu64")\n",
 	       TEST_HOST_LOOP_N);
 	printf(" -I: specify interval in ms (default: %"PRIu64" ms)\n",
@@ -829,8 +833,11 @@ int main(int argc, char *argv[])
 	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
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

