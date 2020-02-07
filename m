Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1AFC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A33020838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBGRhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:37:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:53093 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgBGRhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:37:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 09:37:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,414,1574150400"; 
   d="scan'208";a="346067524"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2020 09:37:48 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] KVM: x86/mmu: nVMX: 5-level paging fixes and enabling
Date:   Fri,  7 Feb 2020 09:37:40 -0800
Message-Id: <20200207173747.6243-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fixes for 5-level paging bugs with a 100% fatality rate, a patch to
enable 5-level EPT in L1, and additional clean up on top (mostly renames
of functions/variables that caused me no end of confusion when trying to
figure out what was broken).

Tested fixed kernels at L0, L1 and L2, with most combinations of EPT,
shadow paging, 4-level and 5-level.  EPT kvm-unit-tests runs clean in L0.
Patches for kvm-unit-tests incoming to play nice with 5-level nested EPT.

Ideally patches 1 and 2 would get into 5.6, 5-level paging is quite
broken without them.

v2:
  - Increase the nested EPT array sizes to accomodate 5-level paging in
    the patch that adds support for 5-level nested EPT, not in the bug
    fix for 5-level shadow paging.

Sean Christopherson (7):
  KVM: nVMX: Use correct root level for nested EPT shadow page tables
  KVM: x86/mmu: Fix struct guest_walker arrays for 5-level paging
  KVM: nVMX: Allow L1 to use 5-level page walks for nested EPT
  KVM: nVMX: Rename nested_ept_get_cr3() to nested_ept_get_eptp()
  KVM: nVMX: Rename EPTP validity helper and associated variables
  KVM: x86/mmu: Rename kvm_mmu->get_cr3() to ->get_guest_cr3_or_eptp()
  KVM: nVMX: Drop unnecessary check on ept caps for execute-only

 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/include/asm/vmx.h      | 12 +++++++
 arch/x86/kvm/mmu/mmu.c          | 35 ++++++++++----------
 arch/x86/kvm/mmu/paging_tmpl.h  |  6 ++--
 arch/x86/kvm/svm.c              | 10 +++---
 arch/x86/kvm/vmx/nested.c       | 58 ++++++++++++++++++++-------------
 arch/x86/kvm/vmx/nested.h       |  4 +--
 arch/x86/kvm/vmx/vmx.c          |  2 ++
 arch/x86/kvm/x86.c              |  2 +-
 9 files changed, 79 insertions(+), 52 deletions(-)

-- 
2.24.1

