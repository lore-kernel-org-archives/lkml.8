Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84275C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50BCA207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgE2Izv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:55:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:46106 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2Izv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:55:51 -0400
IronPort-SDR: 8ex6SwceJnB4TZAx47LIO3i7So8Ew13I3c4EPKDOHuRfoiDV2fe5ZBejuVqhAYnskElO/3nv1G
 vXYHLawXBtPA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 01:55:49 -0700
IronPort-SDR: Ul+ulAZFCXjFc9vftd+oM/y7uubCSqC0boFt6Dw0DI5xn9ovGP/gPLoIO7WZSRmYp1K1M7EiUS
 zmAvp/1lpnzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="311188287"
Received: from lxy-dell.sh.intel.com ([10.239.159.21])
  by FMSMGA003.fm.intel.com with ESMTP; 29 May 2020 01:55:47 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 0/6] Refactor handling flow of SET_CPUID*
Date:   Fri, 29 May 2020 16:55:39 +0800
Message-Id: <20200529085545.29242-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.18.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serial is the extended version of
https://lkml.kernel.org/r/20200528151927.14346-1-xiaoyao.li@intel.com

First two patches are bug fixing, and the other aim to refactor the flow
of SET_CPUID* as:
1. cpuid check: check if userspace provides legal CPUID settings;

2. cpuid update: Update some special CPUID bits based on current vcpu
                 state, e.g., OSXSAVE, OSPKE, ...

3. update KVM state: Update KVM states based on the final CPUID
                     settings. 

Xiaoyao Li (6):
  KVM: X86: Reset vcpu->arch.cpuid_nent to 0 if SET_CPUID fails
  KVM: X86: Go on updating other CPUID leaves when leaf 1 is absent
  KVM: X86: Introduce kvm_check_cpuid()
  KVM: X86: Split kvm_update_cpuid()
  KVM: X86: Move kvm_x86_ops.cpuid_update() into
    kvm_update_state_based_on_cpuid()
  KVM: X86: Move kvm_apic_set_version() to
    kvm_update_state_based_on_cpuid()

 arch/x86/kvm/cpuid.c | 107 +++++++++++++++++++++++++++----------------
 arch/x86/kvm/cpuid.h |   3 +-
 arch/x86/kvm/x86.c   |   1 +
 3 files changed, 70 insertions(+), 41 deletions(-)

-- 
2.18.2

