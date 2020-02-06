Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D448AC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A572F21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgBFHJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 02:09:21 -0500
Received: from mga04.intel.com ([192.55.52.120]:56103 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgBFHJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:09:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 23:09:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,408,1574150400"; 
   d="scan'208";a="231957171"
Received: from lxy-dell.sh.intel.com ([10.239.13.109])
  by orsmga003.jf.intel.com with ESMTP; 05 Feb 2020 23:09:17 -0800
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>, tony.luck@intel.com
Cc:     peterz@infradead.org, fenghua.yu@intel.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v3 0/8] kvm/split_lock: Add feature split lock detection support in kvm
Date:   Thu,  6 Feb 2020 15:04:04 +0800
Message-Id: <20200206070412.17400-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to add the virtualization of split lock detection
for guest, while containing the fix of X86_FEATURE_SPLIT_LOCK_DETECT that
KVM needs to ensure the existence of feature through this flag.

Whether or not we advertise split lock detection to guest, we have to make
a choice between not burning the old guest and preventing DoS attack from
guest since we cannot identify whether a guest is malicious.

Since sld_warn mode allows userspace applications to do split lock, we
extend the same policy to guest that regards guest as user space application
and use handle_user_split_lock() to handle unexpected #AC caused by split
lock.

To prevent DoS attack from either host or guest, we must use
split_lock_detec=fatal in host.

BTW, Andy,

We will talk to Intel hardware architect about the suggestion of MSR_TEST_CTRL
sticky/lock bit[1] if you think it's OK.

[1]: https://lore.kernel.org/kvm/20200204060353.GB31665@linux.intel.com/

Xiaoyao Li (8):
  x86/split_lock: Export handle_user_split_lock()
  x86/split_lock: Ensure X86_FEATURE_SPLIT_LOCK_DETECT means the
    existence of feature
  x86/split_lock: Cache the value of MSR_TEST_CTRL in percpu data
  x86/split_lock: Add and export split_lock_detect_enabled() and
    split_lock_detect_fatal()
  kvm: x86: Emulate split-lock access as a write
  kvm: vmx: Extend VMX's #AC interceptor to handle split lock #AC
    happens in guest
  kvm: x86: Emulate MSR IA32_CORE_CAPABILITIES
  x86: vmx: virtualize split lock detection

 arch/x86/include/asm/cpu.h      | 12 ++++-
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kernel/cpu/intel.c     | 82 +++++++++++++++++++++----------
 arch/x86/kernel/traps.c         |  2 +-
 arch/x86/kvm/cpuid.c            |  5 +-
 arch/x86/kvm/vmx/vmx.c          | 86 +++++++++++++++++++++++++++++++--
 arch/x86/kvm/vmx/vmx.h          |  1 +
 arch/x86/kvm/x86.c              | 41 +++++++++++++++-
 8 files changed, 194 insertions(+), 36 deletions(-)

-- 
2.23.0

