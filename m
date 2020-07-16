Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D8DC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5851B2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgGPDoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:44:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:54949 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgGPDoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:44:11 -0400
IronPort-SDR: rrdjT8Kh/Aqb5wHcOYeYfj7aCSZMGB9dkkEbUef91a+mI/Z3NDDexkuude93/mlMxsGTibSQKt
 xYAUoy7eHsLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="150699761"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="150699761"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 20:44:10 -0700
IronPort-SDR: cAuAFNKXBGmV5pOIWhocUCC1JqwEtI7ncH5HpTHwW4pvIncSzWWBL6s3nlNM4eeLeXygHnUdZ2
 PuMonLEU/veQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="282314257"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2020 20:44:10 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] KVM: VMX: Clean up RTIT MAXPHYADDR usage
Date:   Wed, 15 Jul 2020 20:44:05 -0700
Message-Id: <20200716034408.6342-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using cpuid_query_maxphyaddr() for a random RTIT MSR check and
unexport said function to discourage future use.

Sean Christopherson (3):
  KVM: VMX: Use precomputed MAXPHYADDR for RTIT base MSR check
  KVM: VMX: Replace MSR_IA32_RTIT_OUTPUT_BASE_MASK with helper function
  KVM: x86: Unexport cpuid_query_maxphyaddr()

 arch/x86/kvm/cpuid.c   |  1 -
 arch/x86/kvm/vmx/vmx.c | 11 +++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.26.0

