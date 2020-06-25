Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0698BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E022020720
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390766AbgFYIEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:04:34 -0400
Received: from 8bytes.org ([81.169.241.247]:48816 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390452AbgFYIDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:03:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9AD44249; Thu, 25 Jun 2020 10:03:30 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 1/4] KVM: SVM: Rename struct nested_state to svm_nested_state
Date:   Thu, 25 Jun 2020 10:03:22 +0200
Message-Id: <20200625080325.28439-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200625080325.28439-1-joro@8bytes.org>
References: <20200625080325.28439-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Renaming is only needed in the svm.h header file.

No functional changes.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kvm/svm/svm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 6ac4c00a5d82..6a1864a1f029 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -81,7 +81,7 @@ struct kvm_svm {
 
 struct kvm_vcpu;
 
-struct nested_state {
+struct svm_nested_state {
 	struct vmcb *hsave;
 	u64 hsave_msr;
 	u64 vm_cr_msr;
@@ -133,7 +133,7 @@ struct vcpu_svm {
 
 	ulong nmi_iret_rip;
 
-	struct nested_state nested;
+	struct svm_nested_state nested;
 
 	bool nmi_singlestep;
 	u64 nmi_singlestep_guest_rflags;
-- 
2.27.0

