Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD36C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49F8208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgFQKzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:55:09 -0400
Received: from foss.arm.com ([217.140.110.172]:55582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbgFQKzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:55:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86BF3C0A;
        Wed, 17 Jun 2020 03:55:08 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 384F03F71F;
        Wed, 17 Jun 2020 03:55:06 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH v2] KVM: arm64: kvm_reset_vcpu() return code incorrect with SVE
Date:   Wed, 17 Jun 2020 11:54:56 +0100
Message-Id: <20200617105456.28245-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If SVE is enabled then 'ret' can be assigned the return value of
kvm_vcpu_enable_sve() which may be 0 causing future "goto out" sites to
erroneously return 0 on failure rather than -EINVAL as expected.

Remove the initialisation of 'ret' and make setting the return value
explicit to avoid this situation in the future.

Fixes: 9a3cdf26e336 ("KVM: arm64/sve: Allow userspace to enable SVE for vcpus")
Reported-by: James Morse <james.morse@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
Changes since v1:
 * Fix embarrassing accidental inversion of the if() test

The problematic chunk isn't visible in the diff, so reproduced here:

	if (!kvm_arm_vcpu_sve_finalized(vcpu)) {
		if (test_bit(KVM_ARM_VCPU_SVE, vcpu->arch.features)) {
			ret = kvm_vcpu_enable_sve(vcpu);
			if (ret)
				goto out;
		}
	} else {
		kvm_vcpu_reset_sve(vcpu);
	}

 arch/arm64/kvm/reset.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index d3b209023727..6ed36be51b4b 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -245,7 +245,7 @@ static int kvm_vcpu_enable_ptrauth(struct kvm_vcpu *vcpu)
  */
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 {
-	int ret = -EINVAL;
+	int ret;
 	bool loaded;
 	u32 pstate;
 
@@ -269,15 +269,19 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 
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
-			if (!cpus_have_const_cap(ARM64_HAS_32BIT_EL1))
+			if (!cpus_have_const_cap(ARM64_HAS_32BIT_EL1)) {
+				ret = -EINVAL;
 				goto out;
+			}
 			pstate = VCPU_RESET_PSTATE_SVC;
 		} else {
 			pstate = VCPU_RESET_PSTATE_EL1;
-- 
2.20.1

