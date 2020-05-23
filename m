Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB5FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 23:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A93B207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 23:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+8ddYVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbgEWXHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 19:07:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59980 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388160AbgEWXHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 19:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590275220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwkOICvOQaXOWcko8kpLlTGev7mN/mGmU8J6lWaTsxY=;
        b=f+8ddYVME4S844PA8MtT8h5vqeQX8ZDaEf3IOF2RvdFyoDpgm+tbh/+KnDeJIUpjeaoxtx
        ZNFH+MmUojm+RIcnnljOw5qJN+iENL0Ud4MUWHyatpz1xVdmmyITCU4LbTbhaVfe7DPvJd
        mz+HwogUcP6sURzyRB16A1NURRd+jrM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-_tZtgEvgO4aiU1t-HXFB3g-1; Sat, 23 May 2020 19:06:59 -0400
X-MC-Unique: _tZtgEvgO4aiU1t-HXFB3g-1
Received: by mail-qk1-f198.google.com with SMTP id d145so6159661qkg.22
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 16:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nwkOICvOQaXOWcko8kpLlTGev7mN/mGmU8J6lWaTsxY=;
        b=eUm7HyYNbJhkqeQ4F20gQZnjP0LmMSkaFAeWpchBdNJtH19yjYpMILkF5yaCwnzggr
         a868RYdjgLSSzFYJXdI1mgJ10duGQzDGHSbDROu7IgYi9KL7ofOSVFJTNvlBcS5lYV4a
         bjk4cjQJF9ts+U+JfaVh4k4oTY2Vfgt+OLsbRTVMl0VnhY7JpKlxB1nNgx9ZheTgOfPk
         ES52Nk7oEwPEIbWTNTUbaCQNv/tvhWlh2yxQUhxqya8J8blp9+yUwJ6skMZRGVnZg0Ml
         /7uAIHC2uJaTvzcWz8xZ+LarDo6kX2O2NQE6IOBZAt6OmNZr4poR1heIF+vTCSRd04pk
         uskg==
X-Gm-Message-State: AOAM532IeMGViEo1K56upZhU8fIkUjc80hoSpU5mqTfx5fBLeheV7m9y
        QtiQmWocjqNvBwHCZxTwwKOLby34KEeWqv4WY+v5YkySRevxF0FIfYEgx3TAaqsAeQsfAjHoTDq
        sbDTW/KwcwkIAYnp82cPC8EWV
X-Received: by 2002:ae9:e712:: with SMTP id m18mr22284742qka.11.1590275218414;
        Sat, 23 May 2020 16:06:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3+7M+BOYMIiRez3HPTu3ttrMiTKzHgpFweKE3yDe+kC5BAlNphOrLXyvBosx0xXK6Njm+dw==
X-Received: by 2002:ae9:e712:: with SMTP id m18mr22284726qka.11.1590275218157;
        Sat, 23 May 2020 16:06:58 -0700 (PDT)
Received: from xz-x1.hitronhub.home (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id d207sm10494590qkc.49.2020.05.23.16.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 16:06:57 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v9 14/14] KVM: selftests: Add "-c" parameter to dirty log test
Date:   Sat, 23 May 2020 19:06:54 -0400
Message-Id: <20200523230654.1027882-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523225659.1027044-1-peterx@redhat.com>
References: <20200523225659.1027044-1-peterx@redhat.com>
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

