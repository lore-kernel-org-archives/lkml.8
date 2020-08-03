Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86A8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD2DA22D07
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgHCVAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:00:39 -0400
Received: from 8bytes.org ([81.169.241.247]:34800 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729256AbgHCVAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:00:37 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1833D217; Mon,  3 Aug 2020 23:00:36 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] KVM: SVM: SEV-ES groundwork
Date:   Mon,  3 Aug 2020 23:00:30 +0200
Message-Id: <20200803210034.26386-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

here is v4 of the groundwork patches for the upcoming SEV-ES support in
the Linux kernel. They are part of both the client patch-set and the KVM
hypervisor patches (under development).

Patch 1 necessary to fix a compile warning about a stack-frame getting
too large. Patches 2 and 3 define the Guest Hypervisor Communication
Block (GHCB) and accessor functions and the last patch is a cleanup.

This version addresses more review comments from Sean.  Additionally the
patches are now checkpatch-clean.

It would be great if you could consider them for v5.9, so that the
client and the hypervisor patch-sets can be developed more independently
of each other.

Please let me know what you think.

Regards,

	Joerg

Borislav Petkov (1):
  KVM: SVM: Use __packed shorthand

Joerg Roedel (2):
  KVM: SVM: nested: Don't allocate VMCB structures on stack
  KVM: SVM: Add GHCB Accessor functions

Tom Lendacky (1):
  KVM: SVM: Add GHCB definitions

 arch/x86/include/asm/svm.h | 100 ++++++++++++++++++++++++++++++++++---
 arch/x86/kvm/svm/nested.c  |  47 +++++++++++------
 arch/x86/kvm/svm/svm.c     |   2 +
 3 files changed, 128 insertions(+), 21 deletions(-)

-- 
2.17.1

