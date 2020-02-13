Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A51C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77BC21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609958;
	bh=WkXP5THQLpgyAgHz6BXhPjPpeimWm8UHRJ3AEUw7n1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZxXMhYQJXaxkzcPVOXuj29pBKdIHZi9FZlmZ+dWKu5M8Af0DPJrdVyL88xVjWYF1V
	 ikICIXcjk+89ONMWl8Hyva57hsrh5ZqDvdn1bSdFhLCi3n+t/Tj1jVeamHuTMDbFRE
	 CRMkW5tcx521toYyn6nI7a0RZzMZonKWrJ129+J8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgBMQF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:05:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728453AbgBMPXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:44 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FE7F2469A;
        Thu, 13 Feb 2020 15:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607422;
        bh=WkXP5THQLpgyAgHz6BXhPjPpeimWm8UHRJ3AEUw7n1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y+Qq/RHRQfObTwDOqR20EZT/3J/R/F8JkSe1ApUGGkWQ5Si1BD9hFg+8O8T4dfeWx
         Jje0LowmZAjeg2q9ZKW0ZR2PYamyZGOb06zL2glIxWoLor2HsYcvc0aAAJHrbxS8Jl
         2PlQ85mL3qlaW2sbLt/Ci2vNBc+71sHp1BIh/rMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 051/116] KVM: x86: Protect MSR-based index computations from Spectre-v1/L1TF attacks in x86.c
Date:   Thu, 13 Feb 2020 07:19:55 -0800
Message-Id: <20200213151902.581826169@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marios Pomonis <pomonis@google.com>

commit 6ec4c5eee1750d5d17951c4e1960d953376a0dda upstream.

This fixes a Spectre-v1/L1TF vulnerability in set_msr_mce() and
get_msr_mce().
Both functions contain index computations based on the
(attacker-controlled) MSR number.

Fixes: 890ca9aefa78 ("KVM: Add MCE support")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2130,7 +2130,10 @@ static int set_msr_mce(struct kvm_vcpu *
 	default:
 		if (msr >= MSR_IA32_MC0_CTL &&
 		    msr < MSR_IA32_MCx_CTL(bank_num)) {
-			u32 offset = msr - MSR_IA32_MC0_CTL;
+			u32 offset = array_index_nospec(
+				msr - MSR_IA32_MC0_CTL,
+				MSR_IA32_MCx_CTL(bank_num) - MSR_IA32_MC0_CTL);
+
 			/* only 0 or all 1s can be written to IA32_MCi_CTL
 			 * some Linux kernels though clear bit 10 in bank 4 to
 			 * workaround a BIOS/GART TBL issue on AMD K8s, ignore
@@ -2498,7 +2501,10 @@ static int get_msr_mce(struct kvm_vcpu *
 	default:
 		if (msr >= MSR_IA32_MC0_CTL &&
 		    msr < MSR_IA32_MCx_CTL(bank_num)) {
-			u32 offset = msr - MSR_IA32_MC0_CTL;
+			u32 offset = array_index_nospec(
+				msr - MSR_IA32_MC0_CTL,
+				MSR_IA32_MCx_CTL(bank_num) - MSR_IA32_MC0_CTL);
+
 			data = vcpu->arch.mce_banks[offset];
 			break;
 		}


