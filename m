Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684DBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA5720671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823986;
	bh=mBawSD8zkHBMF5n1BRmQOVnLra3BFmatr3Y/TIxOxeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wGEVfILLHNgvqkAHu9GfBPwukpewkIoKhtSMNlLZTowhjl1bwxTC3ssZKYAcw2ewS
	 wE6huLwStaYkjxqvVoUCjv9nZD160qti7xavNT5yTrx60ov4wYZn9UeR/Nyyd2TftN
	 7JHaWeXXxDF5zMpSvOEIFe43N/HA/s4Chbzg14oM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgERRqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbgERRqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:46:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3257620715;
        Mon, 18 May 2020 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823979;
        bh=mBawSD8zkHBMF5n1BRmQOVnLra3BFmatr3Y/TIxOxeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xngi7dSWOxgv82Rj1as/S9n2fG6hVbHz9G0pmKQUntL9ahDHqipfRZAleRx11DIA+
         3G3f7PmmhvtxJT68YkG+wZn/fx/DJNkV61lxltygbYXH4OuS0vI4bbDH9JgKX/2oAR
         vfy6nNJaMPXlwQbMo5W7o5zhRCTDZLbFBA/FGTZ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Andr=C3=A9=20Przywara?= <andre.przywara@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 4.14 022/114] KVM: arm: vgic: Fix limit condition when writing to GICD_I[CS]ACTIVER
Date:   Mon, 18 May 2020 19:35:54 +0200
Message-Id: <20200518173507.737668504@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

commit 1c32ca5dc6d00012f0c964e5fdd7042fcc71efb1 upstream.

When deciding whether a guest has to be stopped we check whether this
is a private interrupt or not. Unfortunately, there's an off-by-one bug
here, and we fail to recognize a whole range of interrupts as being
global (GICv2 SPIs 32-63).

Fix the condition from > to be >=.

Cc: stable@vger.kernel.org
Fixes: abd7229626b93 ("KVM: arm/arm64: Simplify active_change_prepare and plug race")
Reported-by: André Przywara <andre.przywara@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/vgic/vgic-mmio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -260,7 +260,7 @@ static void vgic_mmio_change_active(stru
 static void vgic_change_active_prepare(struct kvm_vcpu *vcpu, u32 intid)
 {
 	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3 ||
-	    intid > VGIC_NR_PRIVATE_IRQS)
+	    intid >= VGIC_NR_PRIVATE_IRQS)
 		kvm_arm_halt_guest(vcpu->kvm);
 }
 
@@ -268,7 +268,7 @@ static void vgic_change_active_prepare(s
 static void vgic_change_active_finish(struct kvm_vcpu *vcpu, u32 intid)
 {
 	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3 ||
-	    intid > VGIC_NR_PRIVATE_IRQS)
+	    intid >= VGIC_NR_PRIVATE_IRQS)
 		kvm_arm_resume_guest(vcpu->kvm);
 }
 


