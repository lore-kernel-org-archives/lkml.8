Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E133C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15F020714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339202;
	bh=mUM/kUTuheMEU5s0EMgtV8p8tBKS0IMx5NwaDt9nmXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EKRs4J3J0GzW/q2NvAo4g7PwL8EqISYydTEWjGJSpu8uxSB5pBsm4f//6x43BTV7/
	 KmG2bFvIETk7K8mf/LtZZxyLf8hN6KUZY+/fpdOQU9M763+u6wmkmnY7is+uaBq6Bq
	 4ahwseRKrBUg6Hx0DC7/B+15TrO8FZmx4DKNsb10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgBJMxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:53:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730183AbgBJMmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:42:12 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C81320838;
        Mon, 10 Feb 2020 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338532;
        bh=mUM/kUTuheMEU5s0EMgtV8p8tBKS0IMx5NwaDt9nmXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GiYALMHRhz8wGg+8hfN1al48md5+Xt3iqLMexxhPHkPQK0z1Q9rg8rTkD2rHjhFuI
         RXOB9vX54iPgb6oeqjxXMBmo3Kt+XvUKN2wXHpuHZGojyetVeCqIWpCjAPpkyg4WlM
         RPdXogvZsz9/EyUCZbpCWU7Fvr4WqU1ScRvNNHLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 357/367] KVM: nVMX: vmread should not set rflags to specify success in case of #PF
Date:   Mon, 10 Feb 2020 04:34:30 -0800
Message-Id: <20200210122455.380067506@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
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
 arch/x86/kvm/vmx/nested.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4aea7d304bebd..5bfa8228f0c74 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4807,8 +4807,10 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 				vmx_instruction_info, true, len, &gva))
 			return 1;
 		/* _system ok, nested_vmx_check_permission has verified cpl=0 */
-		if (kvm_write_guest_virt_system(vcpu, gva, &field_value, len, &e))
+		if (kvm_write_guest_virt_system(vcpu, gva, &field_value, len, &e)) {
 			kvm_inject_page_fault(vcpu, &e);
+			return 1;
+		}
 	}
 
 	return nested_vmx_succeed(vcpu);
-- 
2.20.1



