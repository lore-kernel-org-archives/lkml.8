Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0205C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813DE2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549777;
	bh=I5yny2GtYN115SjnGt3YvfV6A1qPLytPlWeA7gh9i8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W5jRMSR2slDW49S89j6b0eFbbpTPI2SKMXxwbb3FmnvQM0wjPeruw1f77YIjC0BeY
	 MmqRrOwgNp145WTEDESCXgJEjsd5UX39D6xDS7tHaIGAVIIvzAPtFsicHH0XMV2/tA
	 S/vgya+cx41+ogY7i7iOfrpa3ob2kk+gp4THBiyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDVKC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgDVKCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:02:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1770420882;
        Wed, 22 Apr 2020 10:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549773;
        bh=I5yny2GtYN115SjnGt3YvfV6A1qPLytPlWeA7gh9i8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=frOnmKsY6fQw+oOJh/ZtdfaI/owFmwssiP0/nhgRakp/bs08kvXRYzb1sluvOswi9
         j3rLwMu+WpwgeiwccphkDUs6xfMCrkSyMprZoM+ydx6sS0l3DdkUuz0EFuUAOIERGc
         h0WRRN2zG7ruFyoCCHf4LbTOcAEntJh/OF2MDITA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Evalds Iodzevics <evalds.iodzevics@gmail.com>
Subject: [PATCH 4.4 099/100] x86/microcode/intel: replace sync_core() with native_cpuid_reg(eax)
Date:   Wed, 22 Apr 2020 11:57:09 +0200
Message-Id: <20200422095040.684764961@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evalds Iodzevics <evalds.iodzevics@gmail.com>

On Intel it is required to do CPUID(1) before reading the microcode
revision MSR. Current code in 4.4 an 4.9 relies on sync_core() to call
CPUID, unfortunately on 32 bit machines code inside sync_core() always
jumps past CPUID instruction as it depends on data structure boot_cpu_data
witch are not populated correctly so early in boot sequence.

It depends on:
commit 5dedade6dfa2 ("x86/CPU: Add native CPUID variants returning a single
datum")

This patch is for 4.4 but also should apply to 4.9

Signed-off-by: Evalds Iodzevics <evalds.iodzevics@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/microcode_intel.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -60,7 +60,7 @@ static inline u32 intel_get_microcode_re
 	native_wrmsrl(MSR_IA32_UCODE_REV, 0);
 
 	/* As documented in the SDM: Do a CPUID 1 here */
-	sync_core();
+	native_cpuid_eax(1);
 
 	/* get the current revision from MSR 0x8B */
 	native_rdmsr(MSR_IA32_UCODE_REV, dummy, rev);


