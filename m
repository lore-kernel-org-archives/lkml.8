Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC0BC47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC612192A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589045861;
	bh=284oPI9GIPHpEC5gNFA9Sv4pwU6P4+U98zOmf/LPL2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V50OBc0DKnaqq9IbRlov3QoyHz9xwIWbiwKfn1Ipv1vMExl9o8ez+kYzRI0ezCgAR
	 +aLtNAHsI8/Rjbk2+f9CGU6Yt/BLQ7vkMn4RJVM2UNI41poi0S88EV5ubxCqso5Igu
	 HV8HJF0w9vu2K9TT36MRO7qX3J7oCVFk+dqp3fus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgEIRhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 13:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbgEIRhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 13:37:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60A5424954;
        Sat,  9 May 2020 17:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589045839;
        bh=284oPI9GIPHpEC5gNFA9Sv4pwU6P4+U98zOmf/LPL2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quXByJtSl5IETEoFeurCPYJOKwWaZO0CXyKFtkszbr6FOGaSgjTxR5ueRrZRtPZiX
         eRtwR9wPTOVnTgOggWleDfnHQT4wZT7/Jk5hoqKDtuMLxjKXXF+lwGcnPD9kzPF62V
         NvMPFDx08d8lQuJkClzfDVNdE63bCOyPOm7frlL4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v11 14/18] x86/speculation/swapgs: Check FSGSBASE in enabling SWAPGS mitigation
Date:   Sat,  9 May 2020 13:36:51 -0400
Message-Id: <20200509173655.13977-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509173655.13977-1-sashal@kernel.org>
References: <20200509173655.13977-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

Before enabling FSGSBASE the kernel could safely assume that the content
of GS base was a user address. Thus any speculative access as the result
of a mispredicted branch controlling the execution of SWAPGS would be to
a user address. So systems with speculation-proof SMAP did not need to
add additional LFENCE instructions to mitigate.

With FSGSBASE enabled a hostile user can set GS base to a kernel address.
So they can make the kernel speculatively access data they wish to leak
via a side channel. This means that SMAP provides no protection.

Add FSGSBASE as an additional condition to enable the fence-based SWAPGS
mitigation.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ed54b3b21c396..487603ea51cd1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -450,14 +450,12 @@ static void __init spectre_v1_select_mitigation(void)
 		 * If FSGSBASE is enabled, the user can put a kernel address in
 		 * GS, in which case SMAP provides no protection.
 		 *
-		 * [ NOTE: Don't check for X86_FEATURE_FSGSBASE until the
-		 *	   FSGSBASE enablement patches have been merged. ]
-		 *
 		 * If FSGSBASE is disabled, the user can only put a user space
 		 * address in GS.  That makes an attack harder, but still
 		 * possible if there's no SMAP protection.
 		 */
-		if (!smap_works_speculatively()) {
+		if (boot_cpu_has(X86_FEATURE_FSGSBASE) ||
+		    !smap_works_speculatively()) {
 			/*
 			 * Mitigation can be provided from SWAPGS itself or
 			 * PTI as the CR3 write in the Meltdown mitigation
-- 
2.20.1

