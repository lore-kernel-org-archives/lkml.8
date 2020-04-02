Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D30C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857D620757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389669AbgDBP4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:56:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:50591 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389618AbgDBP4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:56:51 -0400
IronPort-SDR: Bg/mpS8NduwrtGlxKS1TB2XNC7o3imN/846LvE3avKky3cYU75ab9SobGeBXHf3xeG1XVl4ZKp
 CpwGIfDbJzDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 08:56:49 -0700
IronPort-SDR: jyOiuXukMJhwojIPNuzpfJ9nU3RopoRR/yNMidbUYgAtGsQVDkUlYbJPSk/0GofpqJEnUBPx+z
 dZ40IbSFVtFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="396413079"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga004.jf.intel.com with ESMTP; 02 Apr 2020 08:56:49 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, "Kenneth R . Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] x86: KVM: VMX: Add basic split-lock #AC handling
Date:   Thu,  2 Apr 2020 08:55:51 -0700
Message-Id: <20200402155554.27705-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200402124205.334622628@linutronix.de>
References: <20200402124205.334622628@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First three patches from Xiaoyao's series to add split-lock #AC support
in KVM.

Xiaoyao Li (3):
  KVM: x86: Emulate split-lock access as a write in emulator
  x86/split_lock: Refactor and export handle_user_split_lock() for KVM
  KVM: VMX: Extend VMX's #AC interceptor to handle split lock #AC in
    guest

 arch/x86/include/asm/cpu.h  |  4 ++--
 arch/x86/kernel/cpu/intel.c |  7 ++++---
 arch/x86/kernel/traps.c     |  2 +-
 arch/x86/kvm/vmx/vmx.c      | 30 +++++++++++++++++++++++++++---
 arch/x86/kvm/x86.c          | 12 +++++++++++-
 5 files changed, 45 insertions(+), 10 deletions(-)

-- 
2.24.1

