Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F81C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9079F2071B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="doHu4bBn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0rhYLX79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgH3TkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:40:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56510 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3TkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:40:14 -0400
Date:   Sun, 30 Aug 2020 19:40:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598816412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XiAAgUvSNccOgA7JpVc10IsS1/IXlp9LFkRCl50OY5Y=;
        b=doHu4bBn5sYLzFYH3HxsCbV0PJfZQRvF3CbBodxNa8SA0tksx5b4nUi75+4GZkr9AgV7EZ
        Gi3xTA9mrcGHNIzvLnjbOOgy9Bx5IZ26scDvjGGrFQJPEH11+21UibsZTVPzJQQm2x+nzr
        7QBGs78qmB9ImtVqwX7pSEsA9XyckQUu3CIwpNkb2SXpicjyMwNSEm0G/rU1XlrV3NXv+o
        boaIMIzyllh95k566EZwRbeNe+NJisDjqYxDKKnORjVbeNVreh0tEotlGRxyKPR9+lc5kr
        1BH1KS/V7sslmBofhgIzvgJ+cvWktLluCOx3AfGAMzH7H490WtlNW9gLrH/NFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598816412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XiAAgUvSNccOgA7JpVc10IsS1/IXlp9LFkRCl50OY5Y=;
        b=0rhYLX79ZEpxRtQlYR1GDnVBrrbS8m9qSxOzRxDo9NJnE1J6VvDuDkwWKnYT5LkYGOFj3C
        TQ632WYuGhwp+3Cg==
From:   "tip-bot2 for Cathy Zhang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/kvm: Expose TSX Suspend Load Tracking feature
Cc:     Cathy Zhang <cathy.zhang@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1598316478-23337-3-git-send-email-cathy.zhang@intel.com>
References: <1598316478-23337-3-git-send-email-cathy.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <159881641103.20229.17685673567805540731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     61aa9a0a5eae2100c171698bffabde8d5e9f694d
Gitweb:        https://git.kernel.org/tip/61aa9a0a5eae2100c171698bffabde8d5e9f694d
Author:        Cathy Zhang <cathy.zhang@intel.com>
AuthorDate:    Tue, 25 Aug 2020 08:47:58 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 30 Aug 2020 21:34:10 +02:00

x86/kvm: Expose TSX Suspend Load Tracking feature

TSX suspend load tracking instruction is supported by the Intel uarch
Sapphire Rapids. It aims to give a way to choose which memory accesses
do not need to be tracked in the TSX read set. It's availability is
indicated as CPUID.(EAX=7,ECX=0):EDX[bit 16].

Expose TSX Suspend Load Address Tracking feature in KVM CPUID, so KVM
could pass this information to guests and they can make use of this
feature accordingly.

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1598316478-23337-3-git-send-email-cathy.zhang@intel.com
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3fd6eec..7456f9a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -371,7 +371,7 @@ void kvm_set_cpu_caps(void)
 		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
 		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(INTEL_STIBP) |
 		F(MD_CLEAR) | F(AVX512_VP2INTERSECT) | F(FSRM) |
-		F(SERIALIZE)
+		F(SERIALIZE) | F(TSXLDTRK)
 	);
 
 	/* TSC_ADJUST and ARCH_CAPABILITIES are emulated in software. */
