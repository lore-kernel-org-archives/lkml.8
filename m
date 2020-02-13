Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E21C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF01217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608232;
	bh=ZHKaTW72O/ICIe1McLvpYTtjEEyNdR+al3GhkznqujA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZFeAwKTyPqChfWDJIm7910/4CQ9jWtow1CNeZqwHzeiFsQCG3vlNiacrJEf+D9/9L
	 27uMn1MQryplJA1IwrjzFa6PFTAGh7aARXGzsWaX7T1tW+k6e94bJ643zqyKVH9naL
	 aXjlzl/aZ7rMSdMaNSso5rcxlPzrl54jPSW9xvN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbgBMP3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:29:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbgBMP0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:52 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8D7924676;
        Thu, 13 Feb 2020 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607611;
        bh=ZHKaTW72O/ICIe1McLvpYTtjEEyNdR+al3GhkznqujA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+JfOcnPjf73Ts3+ln29CSON3Q+KPWpPMWUlRwCTAWfQY9ww/KVlqQjHUYGZ3zkie
         BqNlIq8SMoDH8/0C8xDwI8Jpu13+Nz7ABGcivtF89ExRiJ8hIrGPJ3Knbx2PxHMmRr
         3lVpESKGxKc+za0Xe5HKcF8QX+cbyocRoZesJaY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Beata Michalska <beata.michalska@linaro.org>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 4.19 37/52] KVM: arm: Fix DFSR setting for non-LPAE aarch32 guests
Date:   Thu, 13 Feb 2020 07:21:18 -0800
Message-Id: <20200213151825.523552739@linuxfoundation.org>
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
@@ -192,10 +192,12 @@ static void inject_abt32(struct kvm_vcpu
 
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


