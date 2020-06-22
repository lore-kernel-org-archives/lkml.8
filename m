Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09994C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D738C20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbgFVUVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:21:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:62017 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgFVUUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:20:37 -0400
IronPort-SDR: l++Z9FGEOun75Bma4YL2fqDjTbkidsGgIqjwxyGG+gFMkhv8npLztpRvT8+JcTqQ99C4Vw7Uf3
 fut/k88NdSjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="209057476"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="209057476"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 13:20:36 -0700
IronPort-SDR: qjf8BmVwwTKKh/NfBlovYCte1uRmUHIAlDQbELvRqqYzpAqCUiCRvslgcuqZ7mrybfQy+OIqW5
 7GhoD3xuUE8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="478506318"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2020 13:20:36 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] KVM: x86/mmu: Move mmu_audit.c and mmutrace.h into the mmu/ sub-directory
Date:   Mon, 22 Jun 2020 13:20:29 -0700
Message-Id: <20200622202034.15093-2-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200622202034.15093-1-sean.j.christopherson@intel.com>
References: <20200622202034.15093-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move mmu_audit.c and mmutrace.h under mmu/ where they belong.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/{ => mmu}/mmu_audit.c | 0
 arch/x86/kvm/{ => mmu}/mmutrace.h  | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/x86/kvm/{ => mmu}/mmu_audit.c (100%)
 rename arch/x86/kvm/{ => mmu}/mmutrace.h (99%)

diff --git a/arch/x86/kvm/mmu_audit.c b/arch/x86/kvm/mmu/mmu_audit.c
similarity index 100%
rename from arch/x86/kvm/mmu_audit.c
rename to arch/x86/kvm/mmu/mmu_audit.c
diff --git a/arch/x86/kvm/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
similarity index 99%
rename from arch/x86/kvm/mmutrace.h
rename to arch/x86/kvm/mmu/mmutrace.h
index ffcd96fc02d0..9d15bc0c535b 100644
--- a/arch/x86/kvm/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -387,7 +387,7 @@ TRACE_EVENT(
 #endif /* _TRACE_KVMMMU_H */
 
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH mmu
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE mmutrace
 
-- 
2.26.0

