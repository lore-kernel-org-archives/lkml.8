Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E15C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB26216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbgDOVov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:44:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:2384 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729965AbgDOVoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:44:19 -0400
IronPort-SDR: wFj/djImGxDDMCfplq3+51oEMvM5fDzfHqb/4WjXi15ihaKNsqaj2zsTwwqxrKVqp5rSgEkLlg
 ie57TipOAffg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 14:44:15 -0700
IronPort-SDR: mP2+PDzN60teQtLbePMMO6U7zyS3zNRQVJvl2S2ygWLdn0s77oMWgQjXcYG/cgnesKVh9vUGf3
 esKYMQl9hA8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="427584259"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga005.jf.intel.com with ESMTP; 15 Apr 2020 14:44:15 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 0/2] KVM: x86/mmu: Minor cleanup in try_async_pf()
Date:   Wed, 15 Apr 2020 14:44:12 -0700
Message-Id: <20200415214414.10194-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two cleanups with no functional changes.

I'm not 100% on whether or not open coding the private memslot check in
patch 2 is a good idea.  Avoiding the extra memslot lookup is nice, but
that could be done by providing e.g. kvm_is_memslot_visible().  On one
hand, I like deferring the nonexistent and invalid checks to common code,
but on the other hand it creates the possibility of missing some future
case where kvm_is_gfn_visible() adds a check that's not also incoporated
into __gfn_to_hva_many(), though that seems like a rather unlikely
scenario.

Sean Christopherson (2):
  KVM: x86/mmu: Set @writable to false for non-visible accesses by L2
  KVM: x86/mmu: Avoid an extra memslot lookup in try_async_pf() for L2

 arch/x86/kvm/mmu/mmu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.26.0

