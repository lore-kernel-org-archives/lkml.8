Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E89DC3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F9C20866
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgCEBek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:34:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:31855 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgCEBej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:34:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 17:34:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,516,1574150400"; 
   d="scan'208";a="234301737"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga008.fm.intel.com with ESMTP; 04 Mar 2020 17:34:38 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 0/7] KVM: x86: CPUID emulation and tracing fixes
Date:   Wed,  4 Mar 2020 17:34:30 -0800
Message-Id: <20200305013437.8578-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Round two of trying to wrangle kvm_cpuid() into submission.  Two more bug
fixes, both related to querying for an "AMD" vendor, in addition to the
fixes in v1 (tracing and Hypervisor/Centaur range checks).

In theory, everything up to the refactoring is non-controversial, i.e. we
can bikeshed the refactoring without delaying the bug fixes.

v2:
  - Use Jan's patch to fix the trace bug. [Everyone]
  - Rework Hypervisor/Centaur handling so that only the Hypervisor
    sub-ranges get the restrictive 0xffffff00 mask, and so that Centaur's
    range only gets recognized when the guest vendor is Centaur. [Jim]
  - Add the aforementioned bug fixes.
  - Add a patch to do build time assertions on the vendor string, which
    are hand coded u32s in the emulator (for direct comparison against
    CPUID register output).
  - Drop the patch to add CPUID.maxphyaddr emulator helper. [Paolo]
  - Redo refactoring patches to land them after all the bug fixes
    and to do the refactoring without any semantic changes in the
    emulator.

Jan Kiszka (1):
  KVM: x86: Trace the original requested CPUID function in kvm_cpuid()

Sean Christopherson (6):
  KVM: x86: Add helpers to perform CPUID-based guest vendor check
  KVM x86: Extend AMD specific guest behavior to Hygon virtual CPUs
  KVM: x86: Fix CPUID range checks for Hypervisor and Centaur classes
  KVM: x86: Add build-time assertions on validity of vendor strings
  KVM: x86: Refactor out-of-range logic to contain the madness
  KVM: x86: Refactor kvm_cpuid() param that controls out-of-range logic

 arch/x86/include/asm/kvm_emulate.h |  37 +++++++++-
 arch/x86/kvm/cpuid.c               | 111 +++++++++++++++++++++--------
 arch/x86/kvm/cpuid.h               |   8 ++-
 arch/x86/kvm/emulate.c             |  64 ++++++++---------
 arch/x86/kvm/mmu/mmu.c             |   3 +-
 arch/x86/kvm/svm.c                 |   2 +-
 arch/x86/kvm/x86.c                 |   7 +-
 7 files changed, 162 insertions(+), 70 deletions(-)

-- 
2.24.1

