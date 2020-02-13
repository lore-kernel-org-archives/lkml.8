Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E43AC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08568218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607792;
	bh=5IGcf0Cuf4hPbDef247OB/duOvf0GB+NRDuUUuPMJ1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wwudgkg5XTIzorte4SFolR66lIlHb/TOla5KROBZytpwui20dHMphuhlMu6+3xU9l
	 iqAt/JxFEZVZZjX5mcH0WL3F0ax5vz/rC3daJInwSUOOi6aGwbDn9jD15H2Zo1mAZI
	 rb7PnIpHV96VfGgp2XBNx/lgrs7MR6A8Z2RNyWYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbgBMP3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:29:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbgBMP0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:53 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E32C2465D;
        Thu, 13 Feb 2020 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607612;
        bh=5IGcf0Cuf4hPbDef247OB/duOvf0GB+NRDuUUuPMJ1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSXz3X59z1WrHimIx3KtS0jee8rbxirpy2aTS1wAaXD+uGjgM+quJqc87OcTnnpQH
         C8JZJycRhB2Y/4UvnyabXnZ/1qRHq8CGAx4WFybjP7yzbEDJYAQFycnh2XH7rLZ4r9
         mSCzQvorY6Y6dHuoCQFgwzNPiTxC2un8qhAUazuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Beata Michalska <beata.michalska@linaro.org>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 4.19 38/52] KVM: arm: Make inject_abt32() inject an external abort instead
Date:   Thu, 13 Feb 2020 07:21:19 -0800
Message-Id: <20200213151825.869221014@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151810.331796857@linuxfoundation.org>
References: <20200213151810.331796857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

commit 21aecdbd7f3ab02c9b82597dc733ee759fb8b274 upstream.

KVM's inject_abt64() injects an external-abort into an aarch64 guest.
The KVM_CAP_ARM_INJECT_EXT_DABT is intended to do exactly this, but
for an aarch32 guest inject_abt32() injects an implementation-defined
exception, 'Lockdown fault'.

Change this to external abort. For non-LPAE we now get the documented:
| Unhandled fault: external abort on non-linefetch (0x008) at 0x9c800f00
and for LPAE:
| Unhandled fault: synchronous external abort (0x210) at 0x9c800f00

Fixes: 74a64a981662a ("KVM: arm/arm64: Unify 32bit fault injection")
Reported-by: Beata Michalska <beata.michalska@linaro.org>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200121123356.203000-3-james.morse@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/aarch32.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/virt/kvm/arm/aarch32.c
+++ b/virt/kvm/arm/aarch32.c
@@ -26,6 +26,10 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 
+#define DFSR_FSC_EXTABT_LPAE	0x10
+#define DFSR_FSC_EXTABT_nLPAE	0x08
+#define DFSR_LPAE		BIT(9)
+
 /*
  * Table taken from ARMv8 ARM DDI0487B-B, table G1-10.
  */
@@ -193,10 +197,10 @@ static void inject_abt32(struct kvm_vcpu
 	/* Give the guest an IMPLEMENTATION DEFINED exception */
 	is_lpae = (vcpu_cp15(vcpu, c2_TTBCR) >> 31);
 	if (is_lpae) {
-		*fsr = 1 << 9 | 0x34;
+		*fsr = DFSR_LPAE | DFSR_FSC_EXTABT_LPAE;
 	} else {
-		/* Surprise! DFSR's FS[4] lives in bit 10 */
-		*fsr = BIT(10) | 0x4; /* 0x14 */
+		/* no need to shuffle FS[4] into DFSR[10] as its 0 */
+		*fsr = DFSR_FSC_EXTABT_nLPAE;
 	}
 }
 


