Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30933C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0149A215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgA3MYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:24:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:49436 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbgA3MYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:24:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 04:24:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,381,1574150400"; 
   d="scan'208";a="262155240"
Received: from lxy-dell.sh.intel.com ([10.239.13.109])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2020 04:24:44 -0800
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH 0/2] kvm: split_lock: Fix emulator and extend #AC handler 
Date:   Thu, 30 Jan 2020 20:19:37 +0800
Message-Id: <20200130121939.22383-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As kernel split lock patch[1] merged into tip tree, kvm emulator needs to be
fixed and vmx's #AC handler needs to be extended.

Patch 1 fixes x86/emulator to emualte split lock access as write to avoid
malicous guest[2] exploiting it to populate host kernel log.

Patch 2 extends vmx's #AC handler that we can make old guestes (has split_lock
buges) survive on certain cases.

[1] https://lore.kernel.org/lkml/158031147976.396.8941798847364718785.tip-bot2@tip-bot2/
[2] https://lore.kernel.org/lkml/8c5b11c9-58df-38e7-a514-dc12d687b198@redhat.com/

Xiaoyao Li (2):
  KVM: x86: Emulate split-lock access as a write
  KVM: VMX: Extend VMX's #AC handding

 arch/x86/include/asm/cpu.h  | 13 ++++++++++++
 arch/x86/kernel/cpu/intel.c | 18 ++++++++++------
 arch/x86/kvm/vmx/vmx.c      | 42 ++++++++++++++++++++++++++++++++++---
 arch/x86/kvm/vmx/vmx.h      |  3 +++
 arch/x86/kvm/x86.c          | 11 ++++++++++
 5 files changed, 78 insertions(+), 9 deletions(-)

-- 
2.23.0

