Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B51C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29572082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IamG6JW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBEC7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:59:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28884 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727996AbgBEC67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580871538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVtEI2Wr6dUMivwAFn+kYxL1mBYmiWLoQ2SvNOgo33g=;
        b=IamG6JW8O1YGx/oiafemraOKklRypzGaF0WqqKbQKAKCrMq1RKfJ4+nxFT9aBvxTipswx6
        f3/6lxsRMx2yBCS0bTPbbbI6BgazlHYyq0nES0Krd8UIPKYQvP37qXYMWpMrWw9/AEndOT
        mNS51BPlPIzmuYBX27oy3i62qPL/FME=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-_xCkBMj3PsyIcuQB-t9RKA-1; Tue, 04 Feb 2020 21:58:57 -0500
X-MC-Unique: _xCkBMj3PsyIcuQB-t9RKA-1
Received: by mail-qk1-f200.google.com with SMTP id z21so390639qki.18
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 18:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVtEI2Wr6dUMivwAFn+kYxL1mBYmiWLoQ2SvNOgo33g=;
        b=pb3/MJLZ7uZRg0gZV2RRWVmHBG08kB8aAUd+n2XwP+KtasW43WtZgw72qQxM47X97u
         H9VNJzTxhzYC/UD1AhmMzyP7bDAo6q5PO2LphuGw2JuKa78ThJu43GmkGTBH8hGxJaKW
         PTzhOTARgxm9kJhFSWUEqWyRL3ffnP9QSLhK6EO+2n7wLiqIclsETfipMfV0/w8AMLbC
         Wd1mwqUy7JcrfusZAU76DMBIvshZiQlNx4dIJp409dNLFbAziDwakWWnBTMlnIBBJE4P
         i5WJ+yINCl9GG+kSq/VgOtlnZm+dyQR+I7w+UCJUulji86QSWEdHTqZigx8RqyAOIHKF
         U1/A==
X-Gm-Message-State: APjAAAV7SIY8XZ/OZfSRqTHIaykpWQx58MAU39PcfVUIBg4Pfpy8r4tX
        EL2AdLM2rfgVC1vgqzHG1VxkYbv6N2qKSDnrSz+aNng1daqEdAe+ZakUG44yR9lxpUl5p2viiGt
        TlJVNSKcnmMhKTbSo2RksP3C9
X-Received: by 2002:a37:a587:: with SMTP id o129mr32257550qke.268.1580871536711;
        Tue, 04 Feb 2020 18:58:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzjBu3Cweu+6xXN4q5BSU1kYfV9A2MHlGfTnMfOKOcci7Hyu7FzNRkaxpD0SFrs9MSWaI5Biw==
X-Received: by 2002:a37:a587:: with SMTP id o129mr32257538qke.268.1580871536465;
        Tue, 04 Feb 2020 18:58:56 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id e64sm12961649qtd.45.2020.02.04.18.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 18:58:55 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinechin@redhat.com, sean.j.christopherson@intel.com,
        pbonzini@redhat.com, jasowang@redhat.com, yan.y.zhao@intel.com,
        mst@redhat.com, peterx@redhat.com, kevin.tian@intel.com,
        alex.williamson@redhat.com, dgilbert@redhat.com,
        vkuznets@redhat.com
Subject: [PATCH 09/14] KVM: selftests: Sync uapi/linux/kvm.h to tools/
Date:   Tue,  4 Feb 2020 21:58:37 -0500
Message-Id: <20200205025842.367575-6-peterx@redhat.com>
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

This will be needed to extend the kvm selftest program.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index f0a16b4adbbd..5877d7fa88d1 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -236,6 +236,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
 #define KVM_EXIT_ARM_NISV         28
+#define KVM_EXIT_DIRTY_RING_FULL  29
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -1009,6 +1010,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_GUEST_DEBUG_SSTEP 176
 #define KVM_CAP_ARM_NISV_TO_USER 177
 #define KVM_CAP_ARM_INJECT_EXT_DABT 178
+#define KVM_CAP_DIRTY_LOG_RING 179
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1473,6 +1475,9 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_ARM_SVE */
 #define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
 
+/* Available with KVM_CAP_DIRTY_LOG_RING */
+#define KVM_RESET_DIRTY_RINGS     _IO(KVMIO, 0xc3)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
@@ -1623,4 +1628,43 @@ struct kvm_hyperv_eventfd {
 #define KVM_HYPERV_CONN_ID_MASK		0x00ffffff
 #define KVM_HYPERV_EVENTFD_DEASSIGN	(1 << 0)
 
+/*
+ * KVM dirty GFN flags, defined as:
+ *
+ * |---------------+---------------+--------------|
+ * | bit 1 (reset) | bit 0 (dirty) | Status       |
+ * |---------------+---------------+--------------|
+ * |             0 |             0 | Invalid GFN  |
+ * |             0 |             1 | Dirty GFN    |
+ * |             1 |             X | GFN to reset |
+ * |---------------+---------------+--------------|
+ *
+ * Lifecycle of a dirty GFN goes like:
+ *
+ *      dirtied         collected        reset
+ * 00 -----------> 01 -------------> 1X -------+
+ *  ^                                          |
+ *  |                                          |
+ *  +------------------------------------------+
+ *
+ * The userspace program is only responsible for the 01->1X state
+ * conversion (to collect dirty bits).  Also, it must not skip any
+ * dirty bits so that dirty bits are always collected in sequence.
+ */
+#define KVM_DIRTY_GFN_F_DIRTY           BIT(0)
+#define KVM_DIRTY_GFN_F_RESET           BIT(1)
+#define KVM_DIRTY_GFN_F_MASK            0x3
+
+/*
+ * KVM dirty rings should be mapped at KVM_DIRTY_LOG_PAGE_OFFSET of
+ * per-vcpu mmaped regions as an array of struct kvm_dirty_gfn.  The
+ * size of the gfn buffer is decided by the first argument when
+ * enabling KVM_CAP_DIRTY_LOG_RING.
+ */
+struct kvm_dirty_gfn {
+	__u32 flags;
+	__u32 slot;
+	__u64 offset;
+};
+
 #endif /* __LINUX_KVM_H */
-- 
2.24.1

