Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA0FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB8C2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgE2HoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:44:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:51936 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2HoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:44:23 -0400
IronPort-SDR: QbrQpwry0wytSmxjbDW4HybwYad/NCebnLhtdBRRaq0Lz+GvWAh3okOCPDxhdiqfiPQdqZGzdG
 wTga6sl3CCQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 00:44:22 -0700
IronPort-SDR: G8obcFmNPHbFVkBmPQcY6wTi9d68PgeMjhnoNMTkZSkgpOzBGvfQEXibGPK++EiL6eCORSjyBt
 GNZs9mOtj8ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="302754519"
Received: from sqa-gate.sh.intel.com (HELO clx-ap-likexu.tsp.org) ([10.239.48.212])
  by fmsmga002.fm.intel.com with ESMTP; 29 May 2020 00:44:20 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <like.xu@linux.intel.com>
Subject: [PATCH RESEND] Enable full width counting for KVM: x86/pmu
Date:   Fri, 29 May 2020 15:43:43 +0800
Message-Id: <20200529074347.124619-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

As you said, you will queue the v3 of KVM patch, but it looks like we
are missing that part at the top of the kvm/queue tree.

For your convenience, let me resend v4 so that we can upstream this
feature in the next merged window. Also this patch series includes
patches for qemu and kvm-unit-tests. Please help review.

Previous:
https://lore.kernel.org/kvm/f1c77c79-7ff8-c5f3-e011-9874a4336217@redhat.com/

Like Xu (1):
  KVM: x86/pmu: Support full width counting
  [kvm-unit-tests] x86: pmu: Test full-width counter writes 
  [Qemu-devel] target/i386: define a new MSR based feature
 word - FEAT_PERF_CAPABILITIES

Wei Wang (1):
  KVM: x86/pmu: Tweak kvm_pmu_get_msr to pass 'struct msr_data' in

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/cpuid.c            |  2 +-
 arch/x86/kvm/pmu.c              |  4 +-
 arch/x86/kvm/pmu.h              |  4 +-
 arch/x86/kvm/svm/pmu.c          |  7 ++--
 arch/x86/kvm/vmx/capabilities.h | 11 +++++
 arch/x86/kvm/vmx/pmu_intel.c    | 71 +++++++++++++++++++++++++++------
 arch/x86/kvm/vmx/vmx.c          |  3 ++
 arch/x86/kvm/x86.c              |  6 ++-
 9 files changed, 87 insertions(+), 22 deletions(-)

-- 
2.21.3

