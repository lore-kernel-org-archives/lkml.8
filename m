Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49970C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DF220866
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgCBT5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:57:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:30422 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgCBT5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:57:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 11:57:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,508,1574150400"; 
   d="scan'208";a="438404968"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga005.fm.intel.com with ESMTP; 02 Mar 2020 11:57:36 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 0/6] KVM: x86: CPUID emulation and tracing fixes
Date:   Mon,  2 Mar 2020 11:57:30 -0800
Message-Id: <20200302195736.24777-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fixes related to out-of-range CPUID emulation and related cleanup on
top.

I have a unit test and also manually verified a few interesting cases.
I'm not planning on posting the unit test at this time because I haven't
figured out how to avoid false positives, e.g. if a random in-bounds
leaf just happens to match the output of a max basic leaf.  It might be
doable by hardcoding the cpu model?

Sean Christopherson (6):
  KVM: x86: Fix tracing of CPUID.function when function is out-of-range
  KVM: x86: Fix CPUID range check for Centaur and Hypervisor ranges
  KVM: x86: Add dedicated emulator helper for grabbing CPUID.maxphyaddr
  KVM: x86: Drop return value from kvm_cpuid()
  KVM: x86: Rename "found" variable in kvm_cpuid() to
    "exact_entry_exists"
  KVM: x86: Add requested index to the CPUID tracepoint

 arch/x86/include/asm/kvm_emulate.h |  3 ++-
 arch/x86/kvm/cpuid.c               | 26 ++++++++++++--------------
 arch/x86/kvm/cpuid.h               |  2 +-
 arch/x86/kvm/emulate.c             | 10 +---------
 arch/x86/kvm/trace.h               | 13 ++++++++-----
 arch/x86/kvm/x86.c                 | 10 ++++++++--
 6 files changed, 32 insertions(+), 32 deletions(-)

-- 
2.24.1

