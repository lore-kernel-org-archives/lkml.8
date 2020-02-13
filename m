Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B03C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF42217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609850;
	bh=4GOdcqzyVkvvW4T2Fc27eJrxRpenRkYFgU/XzvaDaho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q0x0lAPnWSvSGCutz6Rm3ddB0gHagTHsf4INjEa1OrvZERKzFEbMznB58kkbzLXRT
	 0fzgCz/o9MYOtg9XWeF7f6G7bc+LYjN49CgcwBlKfUwTvZoqftyWYmdYzh7HWaQrB8
	 mFfnlSLVRMqc/gTsLoXSy35tdYxQ1hNcM0l40nIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbgBMQEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:04:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbgBMPYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:09 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16933246C3;
        Thu, 13 Feb 2020 15:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607449;
        bh=4GOdcqzyVkvvW4T2Fc27eJrxRpenRkYFgU/XzvaDaho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y3k3n643gCNlwOxpRBLixILmKUA/DhKWXQ1KbkTJsubfXSUG1JdTUs0ZvqEIstjJ9
         HHec4CX8Tx5Oa2f3xvgWlM8ovkn8IPi1FVZuPzhp9bSmht1cqqiUQxvKbSdi1yXJB2
         2Yfuh4QS74++83H5qyvRgyMID4uwrXRA20n+PUJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 092/116] KVM: nVMX: vmread should not set rflags to specify success in case of #PF
Date:   Thu, 13 Feb 2020 07:20:36 -0800
Message-Id: <20200213151918.646422947@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit a4d956b9390418623ae5d07933e2679c68b6f83c ]

In case writing to vmread destination operand result in a #PF, vmread
should not call nested_vmx_succeed() to set rflags to specify success.
Similar to as done in VMPTRST (See handle_vmptrst()).

Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@vger.kernel.org
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index f76caa03f4f80..67cdb08a736f0 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7653,8 +7653,10 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 		/* _system ok, as nested_vmx_check_permission verified cpl=0 */
 		if (kvm_write_guest_virt_system(vcpu, gva, &field_value,
 						(is_long_mode(vcpu) ? 8 : 4),
-						&e))
+						&e)) {
 			kvm_inject_page_fault(vcpu, &e);
+			return 1;
+		}
 	}
 
 	nested_vmx_succeed(vcpu);
-- 
2.20.1



