Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F3DC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F8A20658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCQExW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 00:53:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:34106 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgCQExO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 00:53:14 -0400
IronPort-SDR: 7kT2j3fSeA0uCaSuJmHlsCfs6s47wYX7ukqZBUCs0llRMK0nt5CRU+VrAeYIsUy+85bYq+MkE/
 DByCtnFgp3qw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 21:53:14 -0700
IronPort-SDR: 6qx7BgOUOq4x9v1/UJe2e7NCxP0ngV0YUL6ratHo5Pz5wlxffVDmwSRYSg2sUBbx114w8sKDnu
 CxpuIUrN9TYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="355252768"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 16 Mar 2020 21:53:14 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 11/32] KVM: VMX: Handle INVVPID fallback logic in vpid_sync_vcpu_addr()
Date:   Mon, 16 Mar 2020 21:52:17 -0700
Message-Id: <20200317045238.30434-12-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317045238.30434-1-sean.j.christopherson@intel.com>
References: <20200317045238.30434-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly invoke vpid_sync_context() to do a global INVVPID when the
individual address variant is not supported instead of deferring such
behavior to the caller.  This allows for additional consolidation of
code as the logic is basically identical to the emulation of the
individual address variant in handle_invvpid().

No functional change intended.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/ops.h | 12 +++++-------
 arch/x86/kvm/vmx/vmx.c |  3 +--
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/ops.h b/arch/x86/kvm/vmx/ops.h
index dd7ab61bfcc1..39122699cfeb 100644
--- a/arch/x86/kvm/vmx/ops.h
+++ b/arch/x86/kvm/vmx/ops.h
@@ -276,17 +276,15 @@ static inline void vpid_sync_context(int vpid)
 		vpid_sync_vcpu_global();
 }
 
-static inline bool vpid_sync_vcpu_addr(int vpid, gva_t addr)
+static inline void vpid_sync_vcpu_addr(int vpid, gva_t addr)
 {
 	if (vpid == 0)
-		return true;
+		return;
 
-	if (cpu_has_vmx_invvpid_individual_addr()) {
+	if (cpu_has_vmx_invvpid_individual_addr())
 		__invvpid(VMX_VPID_EXTENT_INDIVIDUAL_ADDR, vpid, addr);
-		return true;
-	}
-
-	return false;
+	else
+		vpid_sync_context(vpid);
 }
 
 static inline void ept_sync_global(void)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ba49323a89d8..ba24bbda2c12 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2853,8 +2853,7 @@ static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
 {
 	int vpid = to_vmx(vcpu)->vpid;
 
-	if (!vpid_sync_vcpu_addr(vpid, addr))
-		vpid_sync_context(vpid);
+	vpid_sync_vcpu_addr(vpid, addr);
 
 	/*
 	 * If VPIDs are not supported or enabled, then the above is a no-op.
-- 
2.24.1

