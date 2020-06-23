Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F0FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C85420738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbgFWL6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:58:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:58474 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732333AbgFWL6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:58:21 -0400
IronPort-SDR: PIlYuRk389QU4nB7axuXkyLlby9Pd0ObtWGRJI44Jj/0rfeDlUtsdyp7AJQzRPdmQEUntBkNJr
 zZ8TtICRBkpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="228710021"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="228710021"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 04:58:21 -0700
IronPort-SDR: Bl9ke7FbJRHMn+rrIwBEbdYADJmeC7EVQg6ou+uNdm0TXzolbkxhl/Lye+UQPBNsnTp1zbfhTY
 6cX/OJSFmWog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="285745012"
Received: from lxy-dell.sh.intel.com ([10.239.159.21])
  by orsmga007.jf.intel.com with ESMTP; 23 Jun 2020 04:58:18 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 0/7] Refactor handling flow of SET_CPUID* 
Date:   Tue, 23 Jun 2020 19:58:09 +0800
Message-Id: <20200623115816.24132-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.18.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serial is the extended version of
https://lkml.kernel.org/r/20200528151927.14346-1-xiaoyao.li@intel.com

First two patches are bug fixing, and the others aim to refactor the flow
of SET_CPUID* as:

1. cpuid check: check if userspace provides legal CPUID settings;

2. cpuid update: Update some special CPUID bits based on current vcpu
                 state, e.g., OSXSAVE, OSPKE, ...

3. update vcpu model: Update vcpu model (settings) based on the final CPUID
                      settings. 


v2:
 - rebase to kvm/queue: a037ff353ba6 ("Merge branch 'kvm-master' into HEAD")
 - change the name of kvm_update_state_based_on_cpuid() to
   kvm_update_vcpu_model() [Sean]
 - Add patch 5 to rename kvm_x86_ops.cpuid_date() to
   kvm_x86_ops.update_vcpu_model()

v1:
https://lkml.kernel.org/r/20200529085545.29242-1-xiaoyao.li@intel.com


Xiaoyao Li (7):
  KVM: X86: Reset vcpu->arch.cpuid_nent to 0 if SET_CPUID fails
  KVM: X86: Go on updating other CPUID leaves when leaf 1 is absent
  KVM: X86: Introduce kvm_check_cpuid()
  KVM: X86: Split kvm_update_cpuid()
  KVM: X86: Rename cpuid_update() to update_vcpu_model()
  KVM: X86: Move kvm_x86_ops.update_vcpu_model() into
    kvm_update_vcpu_model()
  KVM: X86: Move kvm_apic_set_version() to kvm_update_vcpu_model()

 arch/x86/include/asm/kvm_host.h |   2 +-
 arch/x86/kvm/cpuid.c            | 108 ++++++++++++++++++++------------
 arch/x86/kvm/cpuid.h            |   3 +-
 arch/x86/kvm/svm/svm.c          |   4 +-
 arch/x86/kvm/vmx/nested.c       |   2 +-
 arch/x86/kvm/vmx/vmx.c          |   4 +-
 arch/x86/kvm/x86.c              |   1 +
 7 files changed, 77 insertions(+), 47 deletions(-)

-- 
2.18.2

