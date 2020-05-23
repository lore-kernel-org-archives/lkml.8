Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FD6C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 22:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16E3207CB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 22:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cA78rLkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbgEWW5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 18:57:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56812 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388265AbgEWW5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 18:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590274651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axZO0oxS1oTWaBb+moPh6wvEC4bE59rtqAl5fhCdw3Q=;
        b=cA78rLkENIiTXmtN+jYZA1t8bPm1bYfWaSX4RvLNNLt3o5nS1aBaVEESY0NfsNKQzt79tW
        4TlOZqfjFPjJToQpA6vZ6q+Z8J237K3y7s+rWmhYIJLxX3Y6lHmvqQRWluvShGz7S7AyfQ
        JR0mkV9RclsaAkvcL0Yx1MDVH+6SgMY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-e4UiEDz-Mu262yGdEZLyKg-1; Sat, 23 May 2020 18:57:29 -0400
X-MC-Unique: e4UiEDz-Mu262yGdEZLyKg-1
Received: by mail-qt1-f200.google.com with SMTP id f1so1977847qti.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 15:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axZO0oxS1oTWaBb+moPh6wvEC4bE59rtqAl5fhCdw3Q=;
        b=TfE0GL2hyKzz//DYbG3YNxDkvt4NxMwdruFxmuPyfLwBLqe8B+jfEtqzHYW4xhFhd6
         Rd1OpRGr9BVWlBOYs8l6dM2RqyApN4t2ql8wbTzsxNLnXCVqfCs8J8o85tMLAGAjhViV
         ABNbEjLmeGMRYjZWNPCSkjp+zei2s57YzaTGz4ZLPL/CKSQ/V9g5f5us67bDbFflcy+P
         AU4SWCmBLO/BjgPqglqch9t7KpMoWrKUGjqE49rt3Fulgo2DYngIT7m3MhW+lpSqoYcj
         zKl0Dn+TEI91/doasWcnAYDHGhB3bzz/JhdYSUnFXCzAdqeOHV7Vpj9Q4zPyore6RAts
         UpzA==
X-Gm-Message-State: AOAM533QM67mO/XGqTaw5pYkUjqGP+fAS+/kJSLXhHLPQSFk43LGlL0U
        gDxC5WBQRUvZwEIWbSJ2hqLyIG1r8hYHbTvrtZbvgdnHwDhzdiSsD0PflrNZNqBBb/OoV4/kRyI
        SY6tmoM2OCSi+EOC6GiISO8co
X-Received: by 2002:a37:7143:: with SMTP id m64mr22579392qkc.215.1590274648726;
        Sat, 23 May 2020 15:57:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGOKtaxwRt9cX9tUeBPOrcE0x6cxPLOX+tlt0GXDcJGWCOcF5SK4lQ6EA4mB1W5QeKdhrGRQ==
X-Received: by 2002:a37:7143:: with SMTP id m64mr22579372qkc.215.1590274648477;
        Sat, 23 May 2020 15:57:28 -0700 (PDT)
Received: from xz-x1.hitronhub.home (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id w14sm11630979qtt.82.2020.05.23.15.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 15:57:27 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>, peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH v9 09/14] KVM: selftests: Sync uapi/linux/kvm.h to tools/
Date:   Sat, 23 May 2020 18:56:54 -0400
Message-Id: <20200523225659.1027044-10-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523225659.1027044-1-peterx@redhat.com>
References: <20200523225659.1027044-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be needed to extend the kvm selftest program.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 53 ++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 428c7dde6b4b..74f150c69ee6 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -236,6 +236,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
 #define KVM_EXIT_ARM_NISV         28
+#define KVM_EXIT_DIRTY_RING_FULL  29
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -1017,6 +1018,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_VCPU_RESETS 179
 #define KVM_CAP_S390_PROTECTED 180
 #define KVM_CAP_PPC_SECURE_GUEST 181
+#define KVM_CAP_DIRTY_LOG_RING 182
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1518,6 +1520,9 @@ struct kvm_pv_cmd {
 /* Available with KVM_CAP_S390_PROTECTED */
 #define KVM_S390_PV_COMMAND		_IOWR(KVMIO, 0xc5, struct kvm_pv_cmd)
 
+/* Available with KVM_CAP_DIRTY_LOG_RING */
+#define KVM_RESET_DIRTY_RINGS		_IO(KVMIO, 0xc6)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
@@ -1671,4 +1676,52 @@ struct kvm_hyperv_eventfd {
 #define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
 #define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
 
+/*
+ * Arch needs to define the macro after implementing the dirty ring
+ * feature.  KVM_DIRTY_LOG_PAGE_OFFSET should be defined as the
+ * starting page offset of the dirty ring structures.
+ */
+#ifndef KVM_DIRTY_LOG_PAGE_OFFSET
+#define KVM_DIRTY_LOG_PAGE_OFFSET 0
+#endif
+
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
2.26.2

