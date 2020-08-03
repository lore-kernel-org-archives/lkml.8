Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235EDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4EA420678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458186;
	bh=6mlTaYz/r5BjFnTgvvrOuhZAkYfGl7AE/Vx8SDbgczY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tPOxbP/V2doXiXEro/UsgXj1XxBuM5+QYl9Obis1/rsfKa4WdmRwagvEOW2+nCIVI
	 598A80W6Aw4cJ9R6zhud88Ea1sYGUuGM4qS2Mxw8lYBCxp7gGMzF2iXgL5yd7VpLLo
	 xQ0wCovpWLazuzdqnls2l8K35agSokZL+HRxoqUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgHCMgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729683AbgHCMfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:35:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 776F52054F;
        Mon,  3 Aug 2020 12:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596458151;
        bh=6mlTaYz/r5BjFnTgvvrOuhZAkYfGl7AE/Vx8SDbgczY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOru/3sBSPTp6Xfd0LpVertu77kCWoH1zX7GH2UAddP4ks8jmwVSK7CmgMSgveLku
         xMX31UDvMyQqV6jsF9bng9fum7kZ7lnxxaDCQIydLws1SsEt6UZ59HMoPDDKPh+rju
         2XdWHr1HkR4EMnZGZSM16Y1PxMWyVWvkrZhOssoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 50/51] KVM: LAPIC: Prevent setting the tscdeadline timer if the lapic is hw disabled
Date:   Mon,  3 Aug 2020 14:20:35 +0200
Message-Id: <20200803121852.014023088@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121849.488233135@linuxfoundation.org>
References: <20200803121849.488233135@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

commit d2286ba7d574ba3103a421a2f9ec17cb5b0d87a1 upstream.

Prevent setting the tscdeadline timer if the lapic is hw disabled.

Fixes: bce87cce88 (KVM: x86: consolidate different ways to test for in-kernel LAPIC)
Cc: <stable@vger.kernel.org>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Message-Id: <1596165141-28874-1-git-send-email-wanpengli@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/lapic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1918,7 +1918,7 @@ void kvm_set_lapic_tscdeadline_msr(struc
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
-	if (!lapic_in_kernel(vcpu) || apic_lvtt_oneshot(apic) ||
+	if (!kvm_apic_present(vcpu) || apic_lvtt_oneshot(apic) ||
 			apic_lvtt_period(apic))
 		return;
 


