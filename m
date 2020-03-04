Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCA2C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E86217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4drWRpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388460AbgCDRuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:50:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58637 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388447AbgCDRul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583344240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uBsS/YmxjQODOBkmb+NINDDG4I3J9mAU22trZxbPnrk=;
        b=c4drWRpLbrruldNQNMCw0+raYhmGtLLbCxAB8CFk4xIb4BFCIJ32/nb4XWkfjqF0+Tnup3
        DvBKCyoJm+kWH5j5m0uMtEJjysW/fRWwFV369qwqs/DfY53FbZZQ57wn9V1MOtoFcH0RYs
        V1p9PvOpUzz9vAtZAni4sIX1B9rAFho=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-QzHQtLaLP829sryb3UKVMQ-1; Wed, 04 Mar 2020 12:50:39 -0500
X-MC-Unique: QzHQtLaLP829sryb3UKVMQ-1
Received: by mail-qt1-f198.google.com with SMTP id f25so1967016qtp.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uBsS/YmxjQODOBkmb+NINDDG4I3J9mAU22trZxbPnrk=;
        b=ZyuQRPgGoJIM0PlpOE1ezADKPgjgxAebwx6oCifjdtmJe3GjNq0TkYUVlNUX8jI6DP
         RmM9lbolIihEAq5kFDVLrif7aRm3cScSfSXAMUB5lbBUNKQ9Uv8nUy7YKi3ebZoqfNbF
         PVQ8dTSN2//3dgi3AhAHt0xY0upLqdOx6WE+S+jU9sFRLkyefHOKsbODackwHLXOJnkB
         6WHkEdZgdbOFyuYg3iITxNNMGJEDm909xptYjf1+JG0tpMDYvPtePUgoENjB1Hy1abHF
         XdeTzJ0WIv6ZI9x49MVClTbvFxsOsbtx7FluD6+7C/5Sbyh5iX25l36mtVrSTIuxcXF7
         qmUA==
X-Gm-Message-State: ANhLgQ2hc4MyBNxROppdKfljTBCJgExGWjAzFmBxZxjlsPB2kzD9Gpui
        9CtKhylth4rCAegqVP/tn+HgZGO/xhCEFfVA4Pvbfn3F4U5jQHNnWNEptFClWflh9PM5/8+Zo7J
        WDwqOOoUtyp6rKBfxxMehMnjA
X-Received: by 2002:a05:6214:18f4:: with SMTP id ep20mr2998451qvb.76.1583344238583;
        Wed, 04 Mar 2020 09:50:38 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvtOskywcCh8+++WY2I+jwaVGUp00xQLcHN1X7GBTJP5eBRi7AmIcA7LT3sPZ8m1MioYkVRGg==
X-Received: by 2002:a05:6214:18f4:: with SMTP id ep20mr2998429qvb.76.1583344238321;
        Wed, 04 Mar 2020 09:50:38 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f13sm9747092qkm.42.2020.03.04.09.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:50:37 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Yan Zhao <yan.y.zhao@intel.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: [PATCH v5 14/14] KVM: selftests: Add "-c" parameter to dirty log test
Date:   Wed,  4 Mar 2020 12:49:47 -0500
Message-Id: <20200304174947.69595-15-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304174947.69595-1-peterx@redhat.com>
References: <20200304174947.69595-1-peterx@redhat.com>
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
index f27e3ac340a2..54283e03d8f3 100644
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

