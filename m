Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C717C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E854424658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgBRXaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:30:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:38644 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgBRXaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:30:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 15:29:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,458,1574150400"; 
   d="scan'208";a="282936694"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Feb 2020 15:29:58 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/13] KVM: x86: Allow userspace to disable the kernel's emulator
Date:   Tue, 18 Feb 2020 15:29:53 -0800
Message-Id: <20200218232953.5724-14-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200218232953.5724-1-sean.j.christopherson@intel.com>
References: <20200218232953.5724-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the emulator control to userspace via a module param.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f9134e1104c2..ca3aa185f5ee 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -159,7 +159,8 @@ EXPORT_SYMBOL_GPL(enable_vmware_backdoor);
 static bool __read_mostly force_emulation_prefix = false;
 module_param(force_emulation_prefix, bool, S_IRUGO);
 
-static const bool enable_emulator = true;
+static bool __read_mostly enable_emulator = true;
+module_param_named(emulator, enable_emulator, bool, 0440);
 
 int __read_mostly pi_inject_timer = -1;
 module_param(pi_inject_timer, bint, S_IRUGO | S_IWUSR);
-- 
2.24.1

