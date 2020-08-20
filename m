Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BC9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64377207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597925462;
	bh=STXLrylRawS0FDnZRpizntYAvlmMhGLBh2PNJnSnZzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CjqTMNPhMfol6twULoXw/HtoAubelKfk/icCWWjeJiawx0f5f/NmJtrlFHbg5zluq
	 L+5EkEVEp79p21X1QwK6GI1W10cEZVydcw8PpXtxXa26BGhHIaD4bq0n1qotjWplM8
	 epDXx7AGzYeU3NwzClYKZx1SxIDIa0vRj4PqcMkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgHTMKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729456AbgHTJ5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:57:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7354820855;
        Thu, 20 Aug 2020 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917471;
        bh=STXLrylRawS0FDnZRpizntYAvlmMhGLBh2PNJnSnZzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xECS6iZh9Za5WssvU1QLFc63PLoOuS+cL3/jibOEpn1mX3ED/PoMzuI2BAXdo4Fh7
         h2XK6ZML246plJqp7fFQ0EKwfpAFeEqItomfCp5M1RaGoWBySA/8JHbOpNI98E4Y51
         ol1FbscEB+o3sAuMdPRU/LP8d4JoFbDDOevj/ouk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 043/212] KVM: LAPIC: Prevent setting the tscdeadline timer if the lapic is hw disabled
Date:   Thu, 20 Aug 2020 11:20:16 +0200
Message-Id: <20200820091604.540887080@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
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
@@ -1756,7 +1756,7 @@ void kvm_set_lapic_tscdeadline_msr(struc
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
-	if (!lapic_in_kernel(vcpu) || apic_lvtt_oneshot(apic) ||
+	if (!kvm_apic_present(vcpu) || apic_lvtt_oneshot(apic) ||
 			apic_lvtt_period(apic))
 		return;
 


