Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828AAC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D647206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609993;
	bh=SUT5isPHcnz1hvd4IoH+4GjO7/8/YTikFMxYBhvJ5sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ASzB5WODnBLe5svONKdLIpJDAXBt+YDjAk2Uks4X2c2M/Ky+lfW2vRyAoUvn+XEC7
	 w9u7b0T5HJRQ9lZwon3rfzYgnJ6se6L2F6B8uTyjG3fNdR7GMA+d0rkzdEwcyIQ7r0
	 oBcuCrZCM+eObglEcHLB4Oia/tbyls7543mjGGJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgBMPXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:23:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbgBMPW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:57 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 871BD24699;
        Thu, 13 Feb 2020 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607376;
        bh=SUT5isPHcnz1hvd4IoH+4GjO7/8/YTikFMxYBhvJ5sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ayZs3PVp9vYJFY+siKz0IE8E5Ik/+36IZww7EFzVzYBWAYRnGkAHfaqofLGcuU/iG
         2/ITDwmQMUNFMhShGx2APMzr5x99Xb2b7+1KwaAsPTAGL+ohIWSq7+DeM+cotIP4uv
         aTp7hLVu8GNFidY6tM4XSUD0zpMkl6gRBqEu4c4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 71/91] KVM: x86: Protect kvm_lapic_reg_write() from Spectre-v1/L1TF attacks
Date:   Thu, 13 Feb 2020 07:20:28 -0800
Message-Id: <20200213151849.829866482@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marios Pomonis <pomonis@google.com>

[ Upstream commit 4bf79cb089f6b1c6c632492c0271054ce52ad766 ]

This fixes a Spectre-v1/L1TF vulnerability in kvm_lapic_reg_write().
This function contains index computations based on the
(attacker-controlled) MSR number.

Fixes: 0105d1a52640 ("KVM: x2apic interface to lapic")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/lapic.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 3c70f6c76d3a2..ce8c4ae25c157 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -36,6 +36,7 @@
 #include <asm/delay.h>
 #include <linux/atomic.h>
 #include <linux/jump_label.h>
+#include <linux/nospec.h>
 #include "kvm_cache_regs.h"
 #include "irq.h"
 #include "trace.h"
@@ -1432,15 +1433,21 @@ static int apic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 	case APIC_LVTTHMR:
 	case APIC_LVTPC:
 	case APIC_LVT1:
-	case APIC_LVTERR:
+	case APIC_LVTERR: {
 		/* TODO: Check vector */
+		size_t size;
+		u32 index;
+
 		if (!kvm_apic_sw_enabled(apic))
 			val |= APIC_LVT_MASKED;
 
-		val &= apic_lvt_mask[(reg - APIC_LVTT) >> 4];
+		size = ARRAY_SIZE(apic_lvt_mask);
+		index = array_index_nospec(
+				(reg - APIC_LVTT) >> 4, size);
+		val &= apic_lvt_mask[index];
 		apic_set_reg(apic, reg, val);
-
 		break;
+	}
 
 	case APIC_LVTT:
 		if (!kvm_apic_sw_enabled(apic))
-- 
2.20.1



