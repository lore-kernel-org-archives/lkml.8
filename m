Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D12C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8692020720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ip3T8f6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGHTek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:34:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35678 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726187AbgGHTeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594236875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwkOICvOQaXOWcko8kpLlTGev7mN/mGmU8J6lWaTsxY=;
        b=ip3T8f6tccdkxoFoWGtI/tpKytfsNaprv1faEEgTjJoNVQzzCM17UxlC4D/YTyyYB80iWB
        qvdgF1oX0wm3fYzSJwcpYaqS0pXtp4bOS64UdOX1t1Vtinf/TlbPzlAPlvLNdc9YVqbAuh
        BPY6EBFLFXp8XahvMcvW4pil+NM7B7I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-p3N6SddKNZWmhcEHDRkPVg-1; Wed, 08 Jul 2020 15:34:33 -0400
X-MC-Unique: p3N6SddKNZWmhcEHDRkPVg-1
Received: by mail-qv1-f71.google.com with SMTP id m8so12418358qvv.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nwkOICvOQaXOWcko8kpLlTGev7mN/mGmU8J6lWaTsxY=;
        b=n7aPQiZpu3lFgUDuEkAIv+wS5TVyI+Jl4CCFEz8ynBd9LyTcB8uP2fdSgAOeGl9d0q
         HcC75GoMjzZleCp+eUsyFh/y1ApoFM5Rn8RHyJImkODPUBtcf8G6b5LfzV9gcYuCaF2J
         IVhm7xAHiTeqABuoLpnPOyyJ5vMEMiF20UBU7CY5M5MrNp50kqenqqZLYO3Du1tY7cN3
         RISSRD/M87e4iJXq6+4NF/jza49YE4/lzHUHzbtNduNiGCnwQHK/6Afh75Pu2fNZoKom
         n78p+8Ey8i/yxMnS/lT8ZEm6BKanGCAeCxLusSuBM1tObKy2juQLLIXzLJepce88o2ch
         y4nA==
X-Gm-Message-State: AOAM533RXj0JlEZ/VCJtCibb9+S/qAOr2rxO7f9sK1Jd5zIgGUWyYQoe
        PEHlKkjdkZXoM8nXTpDEi/Hv9LLN2YVDjR8UCM7uxf9m7DTSxxv0A/dbXQZuEV1g8wQhog5bdqx
        SuPyiV40p2bV+wk++d+Ez0jfj
X-Received: by 2002:ac8:47ce:: with SMTP id d14mr61485539qtr.285.1594236873030;
        Wed, 08 Jul 2020 12:34:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzr9Hn7DgKOB0eSRHWqePldCPb4gTgHpgitkXaRkiQjSqZ7uVPKSjC183UXZv6LE8NZNKN3dg==
X-Received: by 2002:ac8:47ce:: with SMTP id d14mr61485520qtr.285.1594236872793;
        Wed, 08 Jul 2020 12:34:32 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c8:6f::1f4f])
        by smtp.gmail.com with ESMTPSA id f18sm664884qtc.28.2020.07.08.12.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 12:34:32 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v11 13/13] KVM: selftests: Add "-c" parameter to dirty log test
Date:   Wed,  8 Jul 2020 15:34:08 -0400
Message-Id: <20200708193408.242909-14-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708193408.242909-1-peterx@redhat.com>
References: <20200708193408.242909-1-peterx@redhat.com>
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
2.26.2

