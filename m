Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8110C35DEE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9034024656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814432;
	bh=ALJFu7IESkTZwkNiXtuqDRqI1jrSFS0kIq8FsnmF+ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d1ZEmCIxIC0elkGmY8Hn3/L8rGiFl6ibbMH8md2/Waphsm682o7ixwgieolbdgewr
	 RMjaruB3kZ9Y+dQKszCSW6atLEvcBjnHteKUm3vfcY9kTEwyQTZQwahZO1MDE7Rrqi
	 0xJR7RYm5ZqfuwWXSXnPQFqWaxuxrTTZqpuiKxqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbgB0NxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:53:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731630AbgB0NxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:53:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A086E21D7E;
        Thu, 27 Feb 2020 13:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811585;
        bh=ALJFu7IESkTZwkNiXtuqDRqI1jrSFS0kIq8FsnmF+ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V09f3KeQlsBYh9+dBeyWPJQ7unsVFFB5ps4rcIlp3OXHWVO6L/m6eKppTmg0C0VQz
         DlKqEnVi4Qz7pq4Y6ghkNgi7pKOvbbb1YnQaTHrU7AB42FZ2t4S5CdCZTleDDgt1Qa
         vruCdhAUOSCIHOd+JXZv/kcd8lH7Eg58k4qWQ+jg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 023/237] KVM: nVMX: Use correct root level for nested EPT shadow page tables
Date:   Thu, 27 Feb 2020 14:33:57 +0100
Message-Id: <20200227132257.963667044@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 148d735eb55d32848c3379e460ce365f2c1cbe4b upstream.

Hardcode the EPT page-walk level for L2 to be 4 levels, as KVM's MMU
currently also hardcodes the page walk level for nested EPT to be 4
levels.  The L2 guest is all but guaranteed to soft hang on its first
instruction when L1 is using EPT, as KVM will construct 4-level page
tables and then tell hardware to use 5-level page tables.

Fixes: 855feb673640 ("KVM: MMU: Add 5 level EPT & Shadow page table support.")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/vmx.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2968,6 +2968,9 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu,
 
 static int get_ept_level(struct kvm_vcpu *vcpu)
 {
+	/* Nested EPT currently only supports 4-level walks. */
+	if (is_guest_mode(vcpu) && nested_cpu_has_ept(get_vmcs12(vcpu)))
+		return 4;
 	if (cpu_has_vmx_ept_5levels() && (cpuid_maxphyaddr(vcpu) > 48))
 		return 5;
 	return 4;


