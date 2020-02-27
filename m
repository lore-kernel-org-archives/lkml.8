Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA42C3F374
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8D224656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811731;
	bh=zGuNwgBkEi5yvKSF45AMZe+eW5wo5oCZKqvBCQSxQBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eahiYA0UOpQdDET8ez1hc2tdWmkDE82qSFq82AuVpDWt0t3E60bk9PqHa6ImMzR3T
	 OL1hUk9djGLdCNMgw1wDxqydjNLunqy+0humsjqPDJ29hznScUy8KCh4Xkp4eVQAej
	 baR6QqbLutRk+Gu7KVCy2HUiUYnedqBgwj1Puo9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbgB0Nz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:55:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731967AbgB0NzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:55:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 119A72469B;
        Thu, 27 Feb 2020 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811719;
        bh=zGuNwgBkEi5yvKSF45AMZe+eW5wo5oCZKqvBCQSxQBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0/XHrQ84oQB0LsqSZb44c++4i3nGjU5vHzXNum+Kxpn3YXISrl0DGcysongfiti1
         j2dADA4evjLVx5xXLwy/4i7L8iswSWHVmVMI4JGT5bhuRBXlowjdGJ6NS3Cf0F0VUa
         BbGXsR4Fywq+DnFquHsSu2BJfEPLkDE8Kt55ivkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 036/237] Revert "KVM: nVMX: Use correct root level for nested EPT shadow page tables"
Date:   Thu, 27 Feb 2020 14:34:10 +0100
Message-Id: <20200227132259.367739216@linuxfoundation.org>
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

This reverts commit 740d876bd9565857a695ce7c05efda4eba5bc585.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/vmx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 997926a9121c0..3791ce8d269e0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2968,9 +2968,6 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 
 static int get_ept_level(struct kvm_vcpu *vcpu)
 {
-	/* Nested EPT currently only supports 4-level walks. */
-	if (is_guest_mode(vcpu) && nested_cpu_has_ept(get_vmcs12(vcpu)))
-		return 4;
 	if (cpu_has_vmx_ept_5levels() && (cpuid_maxphyaddr(vcpu) > 48))
 		return 5;
 	return 4;
-- 
2.20.1



