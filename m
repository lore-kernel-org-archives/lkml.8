Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1EEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294C6222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701051;
	bh=tO4IK6qaQxYUSnNMvJsU3p6KHsQXd6nqqTonDg5LQMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hYlyxD3GbDJM3lPZo6c//SyjW6bhDTHOGgJtuVC8GkCa7RPOVn7CQaHgSM3ZEUg1s
	 2rCs48nmNjLitSRBnZ3PeenCVYvm0f+EH/YzckwvQrAGI5JvCas4c+RNGmvdSaQQ7e
	 G2WPw9BE0ICNE1vPT4BmiXlhavWng6/QVSuYijiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404740AbgBNRYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:24:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391214AbgBNQJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 586942187F;
        Fri, 14 Feb 2020 16:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696548;
        bh=tO4IK6qaQxYUSnNMvJsU3p6KHsQXd6nqqTonDg5LQMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YEi1j8oBpml5UojAgCrH8gwJeMzz2Iu1WWBm2wqczrh6ez9p5Bd7V6Un0XVV023NP
         2xCl9TxP01Sc8bDAltviQTC26Kwi++VLVpHbTCD96uXt3N36hOp2Jsznchf5vp19bx
         Y49jmCZuGfKGWLvWaucm1EbOcDixtrBk6V7GIErE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <sashal@kernel.org>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 341/459] KVM: PPC: Remove set but not used variable 'ra', 'rs', 'rt'
Date:   Fri, 14 Feb 2020 10:59:51 -0500
Message-Id: <20200214160149.11681-341-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

