Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC0C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0D524680
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272723;
	bh=tO4IK6qaQxYUSnNMvJsU3p6KHsQXd6nqqTonDg5LQMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=viFX0x7n2uVdd2IIk+XeIXSBxOCHdFX7q42V3E893E0+rPCJ9P8d+HzIx+Ailmk7z
	 NXAwobFlMcGCX9v8+sfZwG5T2AkvZ2hfjMsHwy1k6jqduRVWTcKiNf4+TBJQGIQVvn
	 5u0gk+suKwQhvsglYikoUHolrty1uvKoTdqLb3LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbgBUIMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:12:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732748AbgBUIMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:12:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80E2D24670;
        Fri, 21 Feb 2020 08:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272720;
        bh=tO4IK6qaQxYUSnNMvJsU3p6KHsQXd6nqqTonDg5LQMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fd8o92BOFIj7mV92FMhPwM0TWDadxEzaZcFogfmTmU3MbhkWXwNHLtVqba8M+7JI+
         dZNn4nYS2/wHq+f7XDTgAqqmBdK2FvMJ3miHPKpwzWEKIFpRcdeUn3eonSaE9ElSKT
         /z5nb7e0/NcfMDWrJCHeS+Ia666uCnFc7RowvFaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        zhengbin <zhengbin13@huawei.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 248/344] KVM: PPC: Remove set but not used variable ra, rs, rt
Date:   Fri, 21 Feb 2020 08:40:47 +0100
Message-Id: <20200221072411.973601352@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit 4de0a8355463e068e443b48eb5ae32370155368b ]

Fixes gcc '-Wunused-but-set-variable' warning:

arch/powerpc/kvm/emulate_loadstore.c: In function kvmppc_emulate_loadstore:
arch/powerpc/kvm/emulate_loadstore.c:87:6: warning: variable ra set but not used [-Wunused-but-set-variable]
arch/powerpc/kvm/emulate_loadstore.c: In function kvmppc_emulate_loadstore:
arch/powerpc/kvm/emulate_loadstore.c:87:10: warning: variable rs set but not used [-Wunused-but-set-variable]
arch/powerpc/kvm/emulate_loadstore.c: In function kvmppc_emulate_loadstore:
arch/powerpc/kvm/emulate_loadstore.c:87:14: warning: variable rt set but not used [-Wunused-but-set-variable]

They are not used since commit 2b33cb585f94 ("KVM: PPC: Reimplement
LOAD_FP/STORE_FP instruction mmio emulation with analyse_instr() input")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/emulate_loadstore.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index 2e496eb86e94a..1139bc56e0045 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -73,7 +73,6 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 	u32 inst;
-	int ra, rs, rt;
 	enum emulation_result emulated = EMULATE_FAIL;
 	int advance = 1;
 	struct instruction_op op;
@@ -85,10 +84,6 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	if (emulated != EMULATE_DONE)
 		return emulated;
 
-	ra = get_ra(inst);
-	rs = get_rs(inst);
-	rt = get_rt(inst);
-
 	vcpu->arch.mmio_vsx_copy_nums = 0;
 	vcpu->arch.mmio_vsx_offset = 0;
 	vcpu->arch.mmio_copy_type = KVMPPC_VSX_COPY_NONE;
-- 
2.20.1



