Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240BAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00FA920723
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbgE0IyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:54:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:18477 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388019AbgE0IyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:54:02 -0400
IronPort-SDR: NzUkZnxz/Kv4fBGO/iVWpVBiC27CNeS8BjFK3dXnmjVLc0VXMqVkw7qv228EKzHaCx6078gWKn
 U57p+20liE3w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 01:54:01 -0700
IronPort-SDR: X4MCtpRkLljsgR7+EkaTcY9qggKkR+7funFrhV7OCKkBeiyURWXENxtDHbdrLfTArkU5NtAPnL
 /hvq1Txw7Frg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,440,1583222400"; 
   d="scan'208";a="284736246"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by orsmga002.jf.intel.com with ESMTP; 27 May 2020 01:54:01 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+904752567107eefb728c@syzkaller.appspotmail.com
Subject: [PATCH] KVM: x86: Initialize tdp_level during vCPU creation
Date:   Wed, 27 May 2020 01:54:00 -0700
Message-Id: <20200527085400.23759-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize vcpu->arch.tdp_level during vCPU creation to avoid consuming
garbage if userspace calls KVM_RUN without first calling KVM_SET_CPUID.

Fixes: e93fd3b3e89e9 ("KVM: x86/mmu: Capture TDP level when updating CPUID")
Reported-by: syzbot+904752567107eefb728c@syzkaller.appspotmail.com
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b226fb8abe41b..01a6304056197 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9414,6 +9414,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	fx_init(vcpu);
 
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
+	vcpu->arch.tdp_level = kvm_x86_ops.get_tdp_level(vcpu);
 
 	vcpu->arch.pat = MSR_IA32_CR_PAT_DEFAULT;
 
-- 
2.26.0

