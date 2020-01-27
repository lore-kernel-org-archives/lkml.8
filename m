Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C95C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0057620702
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgA0KhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:37:24 -0500
Received: from foss.arm.com ([217.140.110.172]:42426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729184AbgA0KhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:37:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C23F030E;
        Mon, 27 Jan 2020 02:37:23 -0800 (PST)
Received: from e123195-lin.cambridge.arm.com (e123195-lin.cambridge.arm.com [10.1.196.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE6EB3F52E;
        Mon, 27 Jan 2020 02:37:22 -0800 (PST)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Subject: [PATCH] KVM: arm64: Treat emulated TVAL TimerValue as a signed 32-bit integer
Date:   Mon, 27 Jan 2020 10:36:52 +0000
Message-Id: <20200127103652.2326-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the ARM ARM, registers CNT{P,V}_TVAL_EL0 have bits [63:32]
RES0 [1]. When reading the register, the value is truncated to the least
significant 32 bits [2], and on writes, TimerValue is treated as a signed
32-bit integer [1, 2].

When the guest behaves correctly and writes 32-bit values, treating TVAL
as an unsigned 64 bit register works as expected. However, things start
to break down when the guest writes larger values, because
(u64)0x1_ffff_ffff = 8589934591. but (s32)0x1_ffff_ffff = -1, and the
former will cause the timer interrupt to be asserted in the future, but
the latter will cause it to be asserted now.  Let's treat TVAL as a
signed 32-bit register on writes, to match the behaviour described in
the architecture, and the behaviour experimentally exhibited by the
virtual timer on a non-vhe host.

[1] Arm DDI 0487E.a, section D13.8.18
[2] Arm DDI 0487E.a, section D11.2.4

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 include/kvm/arm_arch_timer.h | 2 ++
 virt/kvm/arm/arch_timer.c    | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index d120e6c323e7..be912176b7a3 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -10,6 +10,8 @@
 #include <linux/clocksource.h>
 #include <linux/hrtimer.h>
 
+#define ARCH_TIMER_TVAL_MASK	((1ULL << 32) - 1)
+
 enum kvm_arch_timers {
 	TIMER_PTIMER,
 	TIMER_VTIMER,
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index f182b2380345..5d40f17f7024 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -805,6 +805,7 @@ static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
 	switch (treg) {
 	case TIMER_REG_TVAL:
 		val = timer->cnt_cval - kvm_phys_timer_read() + timer->cntvoff;
+		val &= ARCH_TIMER_TVAL_MASK;
 		break;
 
 	case TIMER_REG_CTL:
@@ -850,7 +851,7 @@ static void kvm_arm_timer_write(struct kvm_vcpu *vcpu,
 {
 	switch (treg) {
 	case TIMER_REG_TVAL:
-		timer->cnt_cval = kvm_phys_timer_read() - timer->cntvoff + val;
+		timer->cnt_cval = kvm_phys_timer_read() - timer->cntvoff + (s32)val;
 		break;
 
 	case TIMER_REG_CTL:
-- 
2.20.1

