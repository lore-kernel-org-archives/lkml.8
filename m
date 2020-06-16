Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A897C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE8E2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323991;
	bh=yHE3Mizda/15sFcSyx9CzxSGL2SEfdk8gsWNYgqb0s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=klTrdHcb4EIqQ7PVJsH5O/DywqvKrsLxl4PpNcEl+W/zAZpcjsCWxR+jq9fw5C9LR
	 Vkm/Rc2bXtK41ndAPpbr8RrJ2eTN6CMHjOu1FjTxCj0Etq0dTPyOUJQSljzc+HB7Il
	 yEPyKkVI0dr9xNptKuHMnDQdkhckSz3geiAMIvrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbgFPPng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:32890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731807AbgFPPnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:43:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2A6F21475;
        Tue, 16 Jun 2020 15:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322213;
        bh=yHE3Mizda/15sFcSyx9CzxSGL2SEfdk8gsWNYgqb0s4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UG82lUoKHRoFtpZVcFO2YtohXL7ly9HO2DmzhHtUhsazA6BUFmvkOm1PpYcQcgZjS
         McD34IP4PJBFLw+7J1zs/2s4P/ddoqGR3M9vIfaff3tJhwcjzEYz+E80Ll4ijdaK/K
         Kq/wGMeF/P2MPZEZ70KGIvte5LOYrJdwk/M/k5os=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.7 044/163] KVM: x86: dont expose MSR_IA32_UMWAIT_CONTROL unconditionally
Date:   Tue, 16 Jun 2020 17:33:38 +0200
Message-Id: <20200616153108.974705115@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Levitsky <mlevitsk@redhat.com>

commit f4cfcd2d5aea4e96c5d483c476f3057b6b7baf6a upstream.

This msr is only available when the host supports WAITPKG feature.

This breaks a nested guest, if the L1 hypervisor is set to ignore
unknown msrs, because the only other safety check that the
kernel does is that it attempts to read the msr and
rejects it if it gets an exception.

Cc: stable@vger.kernel.org
Fixes: 6e3ba4abce ("KVM: vmx: Emulate MSR IA32_UMWAIT_CONTROL")
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-Id: <20200523161455.3940-3-mlevitsk@redhat.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5242,6 +5242,10 @@ static void kvm_init_msr_list(void)
 			if (!kvm_cpu_cap_has(X86_FEATURE_RDTSCP))
 				continue;
 			break;
+		case MSR_IA32_UMWAIT_CONTROL:
+			if (!kvm_cpu_cap_has(X86_FEATURE_WAITPKG))
+				continue;
+			break;
 		case MSR_IA32_RTIT_CTL:
 		case MSR_IA32_RTIT_STATUS:
 			if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT))


