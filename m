Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FD7C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEA92073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609230;
	bh=FoBufS6Nzi59yMVdZnEZO2IaKbQUoklu4vDsnimns+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sinkDHHnfC8mggrkQ2r46onn0Pi6iRIySxOsBNanTvoGsdNjtvZuTTJrQegrEqVZZ
	 A+CGXyMaWU5FKRbOO1SuSI47b07sxkQI5qf4YP2nxql9IpfnUUwDDpBSS1ov8jOPc1
	 L+WtnDNELCvH63WW6ATt1efhH72ukSwlcb4peqk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbgBMPxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:53:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387401AbgBMP0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:01 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987A1246B8;
        Thu, 13 Feb 2020 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607560;
        bh=FoBufS6Nzi59yMVdZnEZO2IaKbQUoklu4vDsnimns+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=juGWgADwQF0POlJQda32nXCShu+wPD1jl99FbQ8H12n9TQYMKuGTq45n+MigcetSQ
         Lv/EPEohZT7ckdKuZ4+TBWTomKeKRyUiHrWCadNsV0aTQ4igjeRTxoGrJEHJmen8cJ
         fMEkYHgXnrGu4pa5ICxcjlPd/ongJKLbkp35hR7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 133/173] KVM: nVMX: vmread should not set rflags to specify success in case of #PF
Date:   Thu, 13 Feb 2020 07:20:36 -0800
Message-Id: <20200213152005.541858066@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
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
index c579cda1721e1..809d1b031fd9e 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8014,8 +8014,10 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 		/* _system ok, nested_vmx_check_permission has verified cpl=0 */
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



