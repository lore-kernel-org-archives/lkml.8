Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55E3C3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D0A20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608084;
	bh=GWMijhkMymqjblTVbuq2KK6lu2cqa3S12LTf6rYgJfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KUdeL9PcStdAFH5L4ZuJefguANmq+z6wbU4LrpClDrzv63TIAXUtg3eRSwYcSwwNX
	 l1F5njWUqISAYj3UADnUQhZKvYi2Cke1rucoovxyQOwxYSSKa+ebaUJXeq+LNcfK9v
	 /vxBf+NmZAqZItDuty5GP3rSjW51I90ctSt7KOLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgBMPdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:33:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbgBMP2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:55 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08EA824670;
        Thu, 13 Feb 2020 15:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607735;
        bh=GWMijhkMymqjblTVbuq2KK6lu2cqa3S12LTf6rYgJfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uq2X4pOeu4zvQ4ezbkN2jCLidotznsY9ixig9jaa8RM3xD0nncPbn1Tv9W32ufkQq
         XOwa9kLIkLWPS/URwNFo4bTGTyzKdJa4O+32kQkTp1K3CuZrpMR7mh2f7ARXgYwsgx
         JorTXSCK7QDA3LPFC6kw7iFKIHDdLe3iqiLldS5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Beata Michalska <beata.michalska@linaro.org>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 5.5 086/120] KVM: arm: Fix DFSR setting for non-LPAE aarch32 guests
Date:   Thu, 13 Feb 2020 07:21:22 -0800
Message-Id: <20200213151930.329667412@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

commit 018f22f95e8a6c3e27188b7317ef2c70a34cb2cd upstream.

Beata reports that KVM_SET_VCPU_EVENTS doesn't inject the expected
exception to a non-LPAE aarch32 guest.

The host intends to inject DFSR.FS=0x14 "IMPLEMENTATION DEFINED fault
(Lockdown fault)", but the guest receives DFSR.FS=0x04 "Fault on
instruction cache maintenance". This fault is hooked by
do_translation_fault() since ARMv6, which goes on to silently 'handle'
the exception, and restart the faulting instruction.

It turns out, when TTBCR.EAE is clear DFSR is split, and FS[4] has
to shuffle up to DFSR[10].

As KVM only does this in one place, fix up the static values. We
now get the expected:
| Unhandled fault: lock abort (0x404) at 0x9c800f00

Fixes: 74a64a981662a ("KVM: arm/arm64: Unify 32bit fault injection")
Reported-by: Beata Michalska <beata.michalska@linaro.org>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200121123356.203000-2-james.morse@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/aarch32.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/virt/kvm/arm/aarch32.c
+++ b/virt/kvm/arm/aarch32.c
@@ -181,10 +181,12 @@ static void inject_abt32(struct kvm_vcpu
 
 	/* Give the guest an IMPLEMENTATION DEFINED exception */
 	is_lpae = (vcpu_cp15(vcpu, c2_TTBCR) >> 31);
-	if (is_lpae)
+	if (is_lpae) {
 		*fsr = 1 << 9 | 0x34;
-	else
-		*fsr = 0x14;
+	} else {
+		/* Surprise! DFSR's FS[4] lives in bit 10 */
+		*fsr = BIT(10) | 0x4; /* 0x14 */
+	}
 }
 
 void kvm_inject_dabt32(struct kvm_vcpu *vcpu, unsigned long addr)


