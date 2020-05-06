Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6277DC47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD582075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgEFX6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 19:58:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:27430 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbgEFX6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 19:58:52 -0400
IronPort-SDR: GhQ3/yPORJAfzUsvuUi0R4xbH4/167TrP0iWAtknrvykMlAQqCQ14DG+I4aR94LTQakEg/WAOf
 ghBqplo0rmbA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 16:58:51 -0700
IronPort-SDR: r3TEfEBlGCQDnppSb0/B3ZOpwYIpUseXQsClVHbOqACJtHmEpNtf+cELG+aLZ8rdm9Hm3rYnpm
 Q4VUnL8pFlAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; 
   d="scan'208";a="435086063"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by orsmga005.jf.intel.com with ESMTP; 06 May 2020 16:58:51 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] KVM: nVMX: Skip IPBP on nested VMCS switch
Date:   Wed,  6 May 2020 16:58:48 -0700
Message-Id: <20200506235850.22600-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Or as Jim would say, "Really skip IPBP on nested VMCS switch" :-D

Patch 1 is the delta between kvm/queue and v3 of the original patch[*],
i.e. I just cherry-picked v3 and fixed the conflicts.

Patch 2 applies the "no IPBP" logic to copy_vmcs02_to_vmcs12_rare().

Feel free to sqaush both of these to commit 7407a52f23732 ("KVM: nVMX:
Skip IBPB when switching between vmcs01 and vmcs02") if you so desire.

[*] https://lkml.kernel.org/r/20200505044644.16563-1-sean.j.christopherson@intel.com

Sean Christopherson (2):
  KVM: nVMX: Refactor IBPB handling on VMCS switch to genericize code
  KVM: nVMX: Skip IPBP when switching between vmcs01 and vmcs02, redux

 arch/x86/kvm/vmx/nested.c | 13 +++----------
 arch/x86/kvm/vmx/vmx.c    | 19 ++++++++++++++-----
 arch/x86/kvm/vmx/vmx.h    |  4 ++--
 3 files changed, 19 insertions(+), 17 deletions(-)

-- 
2.26.0

