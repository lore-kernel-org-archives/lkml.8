Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C27C35240
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 00:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AF020720
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 00:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgA0AlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 19:41:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:63120 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgA0AlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 19:41:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 16:41:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,367,1574150400"; 
   d="scan'208";a="223116774"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2020 16:41:14 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] KVM: x86: VM alloc bug fix and cleanup
Date:   Sun, 26 Jan 2020 16:41:10 -0800
Message-Id: <20200127004113.25615-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a (fairly) long standing NULL pointer dereference if VM allocation
fails, and do a bit of clean up on top.

I would have preferred to omit patch 01, i.e. fix the bug via patch 02,
but unfortunately (long term support) kernel 4.19 doesn't have the
accounting changes, which would make backporting the fix extra annoying
for no real benefit.

Sean Christopherson (3):
  KVM: x86: Gracefully handle __vmalloc() failure during VM allocation
  KVM: x86: Directly return __vmalloc() result in ->vm_alloc()
  KVM: x86: Consolidate VM allocation and free for VMX and SVM

 arch/x86/include/asm/kvm_host.h | 12 ++++--------
 arch/x86/kvm/svm.c              | 15 ++++-----------
 arch/x86/kvm/vmx/vmx.c          | 16 ++++------------
 arch/x86/kvm/x86.c              |  7 +++++++
 4 files changed, 19 insertions(+), 31 deletions(-)

-- 
2.24.1

