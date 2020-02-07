Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3F4C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 23:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E97D214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 23:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBGXSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 18:18:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58546 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgBGXSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 18:18:37 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j0Ct4-0000E9-2R; Fri, 07 Feb 2020 23:18:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] KVM: x86: remove redundant WARN_ON check of an unsigned less than zero
Date:   Fri,  7 Feb 2020 23:18:13 +0000
Message-Id: <20200207231813.786224-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check cpu->hv_clock.system_time < 0 is redundant since system_time
is a u64 and hence can never be less than zero. Remove it.

Addresses-Coverity: ("Macro compares unsigned to 0")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/kvm/x86.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fbabb2f06273..d4967ac47e68 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2448,7 +2448,6 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
 	vcpu->hv_clock.tsc_timestamp = tsc_timestamp;
 	vcpu->hv_clock.system_time = kernel_ns + v->kvm->arch.kvmclock_offset;
 	vcpu->last_guest_tsc = tsc_timestamp;
-	WARN_ON(vcpu->hv_clock.system_time < 0);
 
 	/* If the host uses TSC clocksource, then it is stable */
 	pvclock_flags = 0;
-- 
2.24.0

