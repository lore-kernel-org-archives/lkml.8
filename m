Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49765C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B67208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgCKFHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:07:05 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:42644 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727184AbgCKFGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:06:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id CBEC2181D3028;
        Wed, 11 Mar 2020 05:06:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bread73_1f0bc20945b1e
X-Filterd-Recvd-Size: 7226
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:06:53 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next 007/491] KERNEL VIRTUAL MACHINE FOR ARM/ARM64 (KVM/arm, KVM/arm64): Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:21 -0700
Message-Id: <af51bd879a723c790ffed82b81bc30e207001153.1583896348.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm64/kvm/handle_exit.c  |  2 +-
 arch/arm64/kvm/hyp/debug-sr.c | 60 +++++++++++++++++------------------
 virt/kvm/arm/hyp/vgic-v3-sr.c | 16 +++++-----
 3 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index aacfc5..b14d6a 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -128,7 +128,7 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	switch (ESR_ELx_EC(hsr)) {
 	case ESR_ELx_EC_WATCHPT_LOW:
 		run->debug.arch.far = vcpu->arch.fault.far_el2;
-		/* fall through */
+		fallthrough;
 	case ESR_ELx_EC_SOFTSTP_LOW:
 	case ESR_ELx_EC_BREAKPT_LOW:
 	case ESR_ELx_EC_BKPT32:
diff --git a/arch/arm64/kvm/hyp/debug-sr.c b/arch/arm64/kvm/hyp/debug-sr.c
index 0fc987..b074d3 100644
--- a/arch/arm64/kvm/hyp/debug-sr.c
+++ b/arch/arm64/kvm/hyp/debug-sr.c
@@ -18,70 +18,70 @@
 #define save_debug(ptr,reg,nr)						\
 	switch (nr) {							\
 	case 15:	ptr[15] = read_debug(reg, 15);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 14:	ptr[14] = read_debug(reg, 14);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 13:	ptr[13] = read_debug(reg, 13);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 12:	ptr[12] = read_debug(reg, 12);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 11:	ptr[11] = read_debug(reg, 11);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 10:	ptr[10] = read_debug(reg, 10);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 9:		ptr[9] = read_debug(reg, 9);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 8:		ptr[8] = read_debug(reg, 8);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 7:		ptr[7] = read_debug(reg, 7);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 6:		ptr[6] = read_debug(reg, 6);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 5:		ptr[5] = read_debug(reg, 5);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 4:		ptr[4] = read_debug(reg, 4);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 3:		ptr[3] = read_debug(reg, 3);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 2:		ptr[2] = read_debug(reg, 2);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 1:		ptr[1] = read_debug(reg, 1);			\
-			/* Fall through */				\
+			fallthrough;					\
 	default:	ptr[0] = read_debug(reg, 0);			\
 	}
 
 #define restore_debug(ptr,reg,nr)					\
 	switch (nr) {							\
 	case 15:	write_debug(ptr[15], reg, 15);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 14:	write_debug(ptr[14], reg, 14);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 13:	write_debug(ptr[13], reg, 13);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 12:	write_debug(ptr[12], reg, 12);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 11:	write_debug(ptr[11], reg, 11);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 10:	write_debug(ptr[10], reg, 10);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 9:		write_debug(ptr[9], reg, 9);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 8:		write_debug(ptr[8], reg, 8);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 7:		write_debug(ptr[7], reg, 7);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 6:		write_debug(ptr[6], reg, 6);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 5:		write_debug(ptr[5], reg, 5);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 4:		write_debug(ptr[4], reg, 4);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 3:		write_debug(ptr[3], reg, 3);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 2:		write_debug(ptr[2], reg, 2);			\
-			/* Fall through */				\
+			fallthrough;					\
 	case 1:		write_debug(ptr[1], reg, 1);			\
-			/* Fall through */				\
+			fallthrough;					\
 	default:	write_debug(ptr[0], reg, 0);			\
 	}
 
diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
index ccf1fde..93331f2 100644
--- a/virt/kvm/arm/hyp/vgic-v3-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
@@ -349,10 +349,10 @@ void __hyp_text __vgic_v3_save_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		cpu_if->vgic_ap0r[3] = __vgic_v3_read_ap0rn(3);
 		cpu_if->vgic_ap0r[2] = __vgic_v3_read_ap0rn(2);
-		/* Fall through */
+		fallthrough;
 	case 6:
 		cpu_if->vgic_ap0r[1] = __vgic_v3_read_ap0rn(1);
-		/* Fall through */
+		fallthrough;
 	default:
 		cpu_if->vgic_ap0r[0] = __vgic_v3_read_ap0rn(0);
 	}
@@ -361,10 +361,10 @@ void __hyp_text __vgic_v3_save_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		cpu_if->vgic_ap1r[3] = __vgic_v3_read_ap1rn(3);
 		cpu_if->vgic_ap1r[2] = __vgic_v3_read_ap1rn(2);
-		/* Fall through */
+		fallthrough;
 	case 6:
 		cpu_if->vgic_ap1r[1] = __vgic_v3_read_ap1rn(1);
-		/* Fall through */
+		fallthrough;
 	default:
 		cpu_if->vgic_ap1r[0] = __vgic_v3_read_ap1rn(0);
 	}
@@ -386,10 +386,10 @@ void __hyp_text __vgic_v3_restore_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[3], 3);
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[2], 2);
-		/* Fall through */
+		fallthrough;
 	case 6:
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[1], 1);
-		/* Fall through */
+		fallthrough;
 	default:
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[0], 0);
 	}
@@ -398,10 +398,10 @@ void __hyp_text __vgic_v3_restore_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[3], 3);
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[2], 2);
-		/* Fall through */
+		fallthrough;
 	case 6:
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[1], 1);
-		/* Fall through */
+		fallthrough;
 	default:
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[0], 0);
 	}
-- 
2.24.0

