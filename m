Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED8CC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF6624649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRcoLTiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgCIWZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:25:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51336 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727206AbgCIWZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583792719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Thxl5wIjIKH5B5NXRPkB8aLAOUeG1jEuoKaVSkWq1z8=;
        b=GRcoLTiFmJhiUd4rH3bZaGIX6sR3G7xBjNd7aG1gf3fVaxQbxeaOkZBNQ3F0cJSaLt6lFa
        UnmRWKt6wia1YAxHXzBWawJQmXFgBy5E+1XmAkXUh8rXHUXUF6ZATSI1/mCRYPdHDlf6qx
        wevQHESoaOrxNJJgbjTe8p2yIQybhIs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-TRZmKQYTPT-2vBndfbEsIA-1; Mon, 09 Mar 2020 18:25:17 -0400
X-MC-Unique: TRZmKQYTPT-2vBndfbEsIA-1
Received: by mail-qk1-f198.google.com with SMTP id o3so2980972qkh.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 15:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Thxl5wIjIKH5B5NXRPkB8aLAOUeG1jEuoKaVSkWq1z8=;
        b=eKzp+JZKIc2EKD7QU3Wfop63KQ0ZpQ+ek62c6AB2sf2vWuAuulsyQc9VfzQ9hjAR7p
         zs1q5tqVtLpcNtERMDIojEZwWCZB803qgHkcEzU3a/fsIb6r+8zmhSkwFuW9FHnXHu0y
         dNEXMoubiRE8aMwr1awljnDJ9a2NxxHI111xPkLKQ4D3i44DLv42P1TDAeheXLCZHfRq
         SIjoLPUW6Y/FbRr1EAGOgZpdNaDJqSkeGGS9IeNVo8RJvTm1t5QVIK7+K8ItulBFH58C
         BON6M7uDH9svXCpuuVIbNrxtmQr021CAQ2hCmNmVCT28/XXY4VNCb8EVPgaoJ4BH6D+4
         TeMQ==
X-Gm-Message-State: ANhLgQ3JFZtEqW1jLVBkMAwY3AQmS4eR4gt7SABIEn58wXsfAmOX0mo0
        AJd2sPakGK2ars/pNOwtoy6G6ZgjSKQXwg+d8JxcnRT9HTfE/RvHS+bXgEhUFVAa8y/Zh2UZN5y
        7R+uSP4SLDyhFvQQzaicXATmU
X-Received: by 2002:a05:6214:11e6:: with SMTP id e6mr2251488qvu.22.1583792716630;
        Mon, 09 Mar 2020 15:25:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vubzTyXkWiBklNfqu0HRtTuxAcmpUSp+Pb3Co+Z0PAU3CLBmZZaa1nK74Ks9GVPN1HHz83pqQ==
X-Received: by 2002:a05:6214:11e6:: with SMTP id e6mr2251465qvu.22.1583792716363;
        Mon, 09 Mar 2020 15:25:16 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id i11sm9183431qka.92.2020.03.09.15.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 15:25:15 -0700 (PDT)
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
Subject: [PATCH v6 09/14] KVM: selftests: Sync uapi/linux/kvm.h to tools/
Date:   Mon,  9 Mar 2020 18:25:14 -0400
Message-Id: <20200309222514.345553-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309214424.330363-1-peterx@redhat.com>
References: 
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
index 4b95f9a31a2f..50bf39d24f17 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -236,6 +236,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
 #define KVM_EXIT_ARM_NISV         28
+#define KVM_EXIT_DIRTY_RING_FULL  29
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -1010,6 +1011,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_NISV_TO_USER 177
 #define KVM_CAP_ARM_INJECT_EXT_DABT 178
 #define KVM_CAP_S390_VCPU_RESETS 179
+#define KVM_CAP_DIRTY_LOG_RING 180
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1478,6 +1480,9 @@ struct kvm_enc_region {
 #define KVM_S390_NORMAL_RESET	_IO(KVMIO,   0xc3)
 #define KVM_S390_CLEAR_RESET	_IO(KVMIO,   0xc4)
 
+/* Available with KVM_CAP_DIRTY_LOG_RING */
+#define KVM_RESET_DIRTY_RINGS     _IO(KVMIO, 0xc5)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
@@ -1628,4 +1633,43 @@ struct kvm_hyperv_eventfd {
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

