Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23E9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0CCC206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbgFWTkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:40:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:64955 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733248AbgFWTk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:40:29 -0400
IronPort-SDR: 01Y5N8SnWR25b2IwAMr71YQuHXtjkuoLhKeXdY4/zhgD4tXX6N4oLUrjPrqAIvt2OunIU/PeYT
 VwhAOX+q6LrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="205705216"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="205705216"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 12:40:28 -0700
IronPort-SDR: S3TCBbfVG/Ul8arqWcMNB31+ytFBBI3PSAu9amcsKQri8ijG9Cb2pHW7sbdecBkyc+l/lRcQPb
 +c+JKBgkYdTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="319249361"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2020 12:40:28 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Feiner <pfeiner@google.com>,
        Jon Cargille <jcargill@google.com>
Subject: [PATCH 0/2] KVM: x86/mmu: Optimizations for kvm_get_mmu_page()
Date:   Tue, 23 Jun 2020 12:40:25 -0700
Message-Id: <20200623194027.23135-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid multiple hash lookups in kvm_get_mmu_page(), and tweak the cache
loop to optimize it for TDP.

Sean Christopherson (2):
  KVM: x86/mmu: Avoid multiple hash lookups in kvm_get_mmu_page()
  KVM: x86/mmu: Optimize MMU page cache lookup for fully direct MMUs

 arch/x86/kvm/mmu/mmu.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

-- 
2.26.0

