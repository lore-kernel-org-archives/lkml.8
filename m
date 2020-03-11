Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583C8C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBA62146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgCKFHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:07:20 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:51800 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728130AbgCKFHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:07:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4B629101684F2;
        Wed, 11 Mar 2020 05:07:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: queen12_21d50d9d4a639
X-Filterd-Recvd-Size: 2278
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:07:12 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH -next 015/491] KERNEL VIRTUAL MACHINE FOR MIPS (KVM/mips): Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:29 -0700
Message-Id: <5a1ee76be0f502af626f50313456730d75fe424b.1583896348.git.joe@perches.com>
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
 arch/mips/kvm/emulate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 754094..8c80333 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -64,7 +64,7 @@ static int kvm_compute_return_epc(struct kvm_vcpu *vcpu, unsigned long instpc,
 		switch (insn.r_format.func) {
 		case jalr_op:
 			arch->gprs[insn.r_format.rd] = epc + 8;
-			/* Fall through */
+			fallthrough;
 		case jr_op:
 			nextpc = arch->gprs[insn.r_format.rs];
 			break;
@@ -140,7 +140,7 @@ static int kvm_compute_return_epc(struct kvm_vcpu *vcpu, unsigned long instpc,
 		/* These are unconditional and in j_format. */
 	case jal_op:
 		arch->gprs[31] = instpc + 8;
-		/* fall through */
+		fallthrough;
 	case j_op:
 		epc += 4;
 		epc >>= 28;
@@ -1724,14 +1724,14 @@ enum emulation_result kvm_mips_emulate_load(union mips_instruction inst,
 
 	case lhu_op:
 		vcpu->mmio_needed = 1;	/* unsigned */
-		/* fall through */
+		fallthrough;
 	case lh_op:
 		run->mmio.len = 2;
 		break;
 
 	case lbu_op:
 		vcpu->mmio_needed = 1;	/* unsigned */
-		/* fall through */
+		fallthrough;
 	case lb_op:
 		run->mmio.len = 1;
 		break;
-- 
2.24.0

