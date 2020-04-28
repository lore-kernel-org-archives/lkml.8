Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328FDC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18BF6206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgD1XK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:10:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:60554 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgD1XK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:10:28 -0400
IronPort-SDR: yVkiZlyB4g6jhH4wMTZeigN/m3XZc6/paauO/BPMuK31V7c8UNtVBidrplolzfJH2gqyYl3+5h
 MeRYiWAUv9xQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 16:10:27 -0700
IronPort-SDR: 8mjifliADJUc5yUTmjVIPpF7tVD9vpYhGAqmSy/i42N505Ex7/pgBZXs+2ONDQFz+EowldtZ4y
 w+pyGs/7nYWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="257774902"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2020 16:10:26 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] KVM: nVMX: vmcs.SYSENTER optimization and "fix"
Date:   Tue, 28 Apr 2020 16:10:23 -0700
Message-Id: <20200428231025.12766-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 is a "fix" for handling SYSENTER_EIP/ESP in L2 on a 32-bit vCPU.
The primary motivation is to provide consistent behavior after patch 2.

Patch 2 is essentially a re-submission of a nested VMX optimization to
avoid redundant VMREADs to the SYSENTER fields in the nested VM-Exit path.

After patch 2 and without patch 1, KVM would end up with weird behavior
where L1 and L2 would only see 32-bit values for their own SYSENTER_E*P
MSRs, but L1 could see a 64-bit value for L2's MSRs.

Sean Christopherson (2):
  KVM: nVMX: Truncate writes to vmcs.SYSENTER_EIP/ESP for 32-bit vCPU
  KVM: nVMX: Drop superfluous VMREAD of vmcs02.GUEST_SYSENTER_*

 arch/x86/kvm/vmx/nested.c |  4 ----
 arch/x86/kvm/vmx/vmx.c    | 18 ++++++++++++++++--
 2 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.26.0

