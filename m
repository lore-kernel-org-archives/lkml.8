Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF581C433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8498722B4E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753323;
	bh=xJ5eRZ2PiIgyAhVGGbcA8cN/Vr9pXMazVtnNM1VMiA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xdICvk34WH7PikHM+YlBUwn6x7hvS04CbiK9GMyTFPFcA1VzMV2rK26ALd/2yLEvT
	 e5DVV0KpgWeZhThC3eE3UIKfABkt/7WItuJLG3DXlDyBmd8f5KLQppJqE9jdzByAwJ
	 CXLTbvvp/RDDrzL/y00BD87dLtQnws2pzS2smC9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgGNS64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731249AbgGNS6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:58:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9268F207F5;
        Tue, 14 Jul 2020 18:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753129;
        bh=xJ5eRZ2PiIgyAhVGGbcA8cN/Vr9pXMazVtnNM1VMiA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YEYY50n9aESsUhBHiji+lgAxy1b7RTNosn1vrQntH64eCmpwtgz5q0FTl3JuGUnql
         RB12kCtO+90PNPGgwtUvYpkTY837w9kq+HCEMSUMK9kDvUANXkRYk9l5cEjhkYwFrB
         DjL+gPeQ42Oy2pig/fbwrydFyXuXwx9lDthadAgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        Steven Price <steven.price@arm.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 123/166] KVM: arm64: Fix kvm_reset_vcpu() return code being incorrect with SVE
Date:   Tue, 14 Jul 2020 20:44:48 +0200
Message-Id: <20200714184121.724959653@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Price <steven.price@arm.com>

If SVE is enabled then 'ret' can be assigned the return value of
kvm_vcpu_enable_sve() which may be 0 causing future "goto out" sites to
erroneously return 0 on failure rather than -EINVAL as expected.

Remove the initialisation of 'ret' and make setting the return value
explicit to avoid this situation in the future.

Fixes: 9a3cdf26e336 ("KVM: arm64/sve: Allow userspace to enable SVE for vcpus")
Cc: stable@vger.kernel.org
Reported-by: James Morse <james.morse@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200617105456.28245-1-steven.price@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/reset.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -258,7 +258,7 @@ static int kvm_vcpu_enable_ptrauth(struc
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 {
 	const struct kvm_regs *cpu_reset;
-	int ret = -EINVAL;
+	int ret;
 	bool loaded;
 
 	/* Reset PMU outside of the non-preemptible section */
@@ -281,15 +281,19 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu
 
 	if (test_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, vcpu->arch.features) ||
 	    test_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, vcpu->arch.features)) {
-		if (kvm_vcpu_enable_ptrauth(vcpu))
+		if (kvm_vcpu_enable_ptrauth(vcpu)) {
+			ret = -EINVAL;
 			goto out;
+		}
 	}
 
 	switch (vcpu->arch.target) {
 	default:
 		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
-			if (!cpu_has_32bit_el1())
+			if (!cpu_has_32bit_el1()) {
+				ret = -EINVAL;
 				goto out;
+			}
 			cpu_reset = &default_regs_reset32;
 		} else {
 			cpu_reset = &default_regs_reset;


