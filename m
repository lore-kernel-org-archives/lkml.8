Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA41C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05D92076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552873;
	bh=6+NsNGoBUYGgDTpE49zA7NtHeO3p2XYxUzXYSEYUNOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dPcEj0LbOXf0LrpYj2sF4TPzAq3rso23+IKFkF5nu/kv2EKsV1q3LPeyyFKjY2YnB
	 NuRRFLWTUARnBp8NTncvwdbIjOjxbmXtfB1ti7xypmYtf4K/XTFg0I+YUp0fGx5heI
	 NtRCyPW+se3F5xkYApeK8hplOOHvDz530e90RGYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgDVKyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728598AbgDVKHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:07:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 281C520857;
        Wed, 22 Apr 2020 10:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550074;
        bh=6+NsNGoBUYGgDTpE49zA7NtHeO3p2XYxUzXYSEYUNOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMAUWeEY+iAAFckZ0EEO5sJAU4uaHgFb3lz+3tCY2/Bvjnyz40miTlV2OWU+9rrCd
         nih58SOqW2J08Ql1QzB5wUzeepPqY8uDkurTq6jU5ua9epHYph/2Br3qFnDed7L1CK
         0/wmaos2wzPRjJhNrq1/cfF8M3afxsdKAgzwO3yk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Evalds Iodzevics <evalds.iodzevics@gmail.com>
Subject: [PATCH 4.9 124/125] x86/microcode/intel: replace sync_core() with native_cpuid_reg(eax)
Date:   Wed, 22 Apr 2020 11:57:21 +0200
Message-Id: <20200422095052.422785226@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
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
@@ -59,7 +59,7 @@ static inline u32 intel_get_microcode_re
 	native_wrmsrl(MSR_IA32_UCODE_REV, 0);
 
 	/* As documented in the SDM: Do a CPUID 1 here */
-	sync_core();
+	native_cpuid_eax(1);
 
 	/* get the current revision from MSR 0x8B */
 	native_rdmsr(MSR_IA32_UCODE_REV, dummy, rev);


