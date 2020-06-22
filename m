Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0EBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330F82073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgFVWmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:42:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:27423 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730785AbgFVWmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:42:52 -0400
IronPort-SDR: SZzMoYu9k/bsi0TippxRgeAI4JxXAfP+FR3M3cob+SM0FTxCcKX6hb1BoUzXHmKgvl2y7BM79t
 spMgJg8usHSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="131303559"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="131303559"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 15:42:51 -0700
IronPort-SDR: MYHhyweIOug5uQxuzf6wMIfLHQQjD0kMpblb0upFpf1vVCk42LvEPB8R3p8Bk8lpnjgXvaWDhW
 Ehq4FpvIUOmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="264634897"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2020 15:42:50 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] KVM: x86: VMX: Fix MSR namespacing
Date:   Mon, 22 Jun 2020 15:42:34 -0700
Message-Id: <20200622224249.29562-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to clean up VMX's MSR namespacing, which is in
unimitigated disaster (keeping things PG).

There are a variety of ways VMX saves and restores guest MSRs, all with
unique properties and mechanisms, but with haphazard namespacing (assuming
there is any namespacing at all).  Some fun collisions:

  __find_msr_index(), find_msr_entry() and vmx_find_msr_index()

  vmx_set_guest_msr() and vmx_set_msr() 

  structs vmx_msrs, vmx_msr_entry, shared_msr_entry, kvm_shared_msrs and
  kvm_shared_msrs_values

  vcpu_vmx fields guest_msrs, msr_autoload.guest and msr_autostore.guest

Probably the most infurating/confusing nomenclature is "index", which can
mean MSR's ECX index, index into one of several VMX arrays, or index into
a common x86 array.  __find_msr_index() even manages to mix at least three
different meanings in about as many lines of code.

The biggest change is to rename the "shared MSRs" mechanism to "user
return MSRs" (details in patch 1), most everything else is either derived
from that rename or is fairly straightforward cleanup.

No true functional changes, although the update_transition_efer() change
in patch 10 dances pretty close to being a functional change.

Sean Christopherson (15):
  KVM: x86: Rename "shared_msrs" to "user_return_msrs"
  KVM: VMX: Prepend "MAX_" to MSR array size defines
  KVM: VMX: Rename "vmx_find_msr_index" to "vmx_find_loadstore_msr_slot"
  KVM: VMX: Rename the "shared_msr_entry" struct to "vmx_uret_msr"
  KVM: VMX: Rename vcpu_vmx's "nmsrs" to "nr_uret_msrs"
  KVM: VMX: Rename vcpu_vmx's "save_nmsrs" to "nr_active_uret_msrs"
  KVM: VMX: Rename vcpu_vmx's "guest_msrs_ready" to
    "guest_uret_msrs_loaded"
  KVM: VMX: Rename "__find_msr_index" to "__vmx_find_uret_msr"
  KVM: VMX: Check guest support for RDTSCP before processing MSR_TSC_AUX
  KVM: VMX: Move uret MSR lookup into update_transition_efer()
  KVM: VMX: Add vmx_setup_uret_msr() to handle lookup and swap
  KVM: VMX: Rename "find_msr_entry" to "vmx_find_uret_msr"
  KVM: VMX: Rename "vmx_set_guest_msr" to "vmx_set_guest_uret_msr"
  KVM: VMX: Rename "vmx_msr_index" to "vmx_uret_msrs_list"
  KVM: VMX: Rename vmx_uret_msr's "index" to "slot"

 arch/x86/include/asm/kvm_host.h |   4 +-
 arch/x86/kvm/vmx/nested.c       |  22 ++--
 arch/x86/kvm/vmx/vmx.c          | 184 ++++++++++++++++----------------
 arch/x86/kvm/vmx/vmx.h          |  24 ++---
 arch/x86/kvm/x86.c              | 101 +++++++++---------
 5 files changed, 168 insertions(+), 167 deletions(-)

-- 
2.26.0

