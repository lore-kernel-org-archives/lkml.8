Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB148C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53982075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883046;
	bh=Cm3N7O2MN4MEZNeRuTifdeRPG8I+2G5uqGf6sx1QAY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tf45xNG6nPQ/seRIFC8Tp/k/zu1SPTqwK2CO/eYo9HXhby68UyongpNRYooXC5pv9
	 CSse+AYluuz1b2ddOki6rniZqLV+qJtHn1D+6RI45gW47ydlxDjk6g5/do8cyMxZJC
	 IhlK/Z2mhi5aCDl35Q0FOL86THLQOVjqh63K9niA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440606AbgDNQun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440450AbgDNQtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:33 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8171621569;
        Tue, 14 Apr 2020 16:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882972;
        bh=Cm3N7O2MN4MEZNeRuTifdeRPG8I+2G5uqGf6sx1QAY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C9dx3Ho63fqNvGy2eq52ejcMT6LA0YLyK+KZKkTNSW2ts2yLGJK5wBnQClKzWkDGd
         FXSAIvXf98ROxh8Ng2Q0q42ysiS/8Z/yD38eJlz05C+fI5gvtyVM0h4dQAjyCqF5uw
         CBq755xIePOGMKGDagibMHtdCwA0e+7P2rOjjiyw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Jay Zhou <jianjay.zhou@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 10/15] tools headers kvm: Sync linux/kvm.h with the kernel sources
Date:   Tue, 14 Apr 2020 13:48:49 -0300
Message-Id: <20200414164854.26026-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from:

  9a5788c615f5 ("KVM: PPC: Book3S HV: Add a capability for enabling secure guests")
  3c9bd4006bfc ("KVM: x86: enable dirty log gradually in small chunks")
  13da9ae1cdbf ("KVM: s390: protvirt: introduce and enable KVM_CAP_S390_PROTECTED")
  e0d2773d487c ("KVM: s390: protvirt: UV calls in support of diag308 0, 1")
  19e122776886 ("KVM: S390: protvirt: Introduce instruction data area bounce buffer")
  29b40f105ec8 ("KVM: s390: protvirt: Add initial vm and cpu lifecycle handling")

So far we're ignoring those arch specific ioctls, we need to revisit
this at some time to have arch specific tables, etc:

  $ grep S390 tools/perf/trace/beauty/kvm_ioctl.sh
      egrep -v " ((ARM|PPC|S390)_|[GS]ET_(DEBUGREGS|PIT2|XSAVE|TSC_KHZ)|CREATE_SPAPR_TCE_64)" | \
  $

This addresses these tools/perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/arm/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm/include/uapi/asm/kvm.h'
  diff -u tools/arch/arm/include/uapi/asm/kvm.h arch/arm/include/uapi/asm/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Jay Zhou <jianjay.zhou@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 47 ++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 4b95f9a31a2f..428c7dde6b4b 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -474,12 +474,17 @@ struct kvm_s390_mem_op {
 	__u32 size;		/* amount of bytes */
 	__u32 op;		/* type of operation */
 	__u64 buf;		/* buffer in userspace */
-	__u8 ar;		/* the access register number */
-	__u8 reserved[31];	/* should be set to 0 */
+	union {
+		__u8 ar;	/* the access register number */
+		__u32 sida_offset; /* offset into the sida */
+		__u8 reserved[32]; /* should be set to 0 */
+	};
 };
 /* types for kvm_s390_mem_op->op */
 #define KVM_S390_MEMOP_LOGICAL_READ	0
 #define KVM_S390_MEMOP_LOGICAL_WRITE	1
+#define KVM_S390_MEMOP_SIDA_READ	2
+#define KVM_S390_MEMOP_SIDA_WRITE	3
 /* flags for kvm_s390_mem_op->flags */
 #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
 #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
@@ -1010,6 +1015,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_NISV_TO_USER 177
 #define KVM_CAP_ARM_INJECT_EXT_DABT 178
 #define KVM_CAP_S390_VCPU_RESETS 179
+#define KVM_CAP_S390_PROTECTED 180
+#define KVM_CAP_PPC_SECURE_GUEST 181
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1478,6 +1485,39 @@ struct kvm_enc_region {
 #define KVM_S390_NORMAL_RESET	_IO(KVMIO,   0xc3)
 #define KVM_S390_CLEAR_RESET	_IO(KVMIO,   0xc4)
 
+struct kvm_s390_pv_sec_parm {
+	__u64 origin;
+	__u64 length;
+};
+
+struct kvm_s390_pv_unp {
+	__u64 addr;
+	__u64 size;
+	__u64 tweak;
+};
+
+enum pv_cmd_id {
+	KVM_PV_ENABLE,
+	KVM_PV_DISABLE,
+	KVM_PV_SET_SEC_PARMS,
+	KVM_PV_UNPACK,
+	KVM_PV_VERIFY,
+	KVM_PV_PREP_RESET,
+	KVM_PV_UNSHARE_ALL,
+};
+
+struct kvm_pv_cmd {
+	__u32 cmd;	/* Command to be executed */
+	__u16 rc;	/* Ultravisor return code */
+	__u16 rrc;	/* Ultravisor return reason code */
+	__u64 data;	/* Data or address */
+	__u32 flags;    /* flags for future extensions. Must be 0 for now */
+	__u32 reserved[3];
+};
+
+/* Available with KVM_CAP_S390_PROTECTED */
+#define KVM_S390_PV_COMMAND		_IOWR(KVMIO, 0xc5, struct kvm_pv_cmd)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
@@ -1628,4 +1668,7 @@ struct kvm_hyperv_eventfd {
 #define KVM_HYPERV_CONN_ID_MASK		0x00ffffff
 #define KVM_HYPERV_EVENTFD_DEASSIGN	(1 << 0)
 
+#define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
+#define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
+
 #endif /* __LINUX_KVM_H */
-- 
2.21.1

