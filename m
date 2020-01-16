Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16BBC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B0D206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199419;
	bh=pdaL2usdeANw5MYykla2raJgzZsvaXsWZHnDQa4pUo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PQMlbfMbk+/yKJ54Ol4uOmaG6D/vu6+/uxgOoW26FWVvYnTb8/Qb5y2lUrAnQ3gxW
	 2vWnhBf+t39mSDVxWCuntF6c5KeMFhrFYEGxLhB6wL6Vie3R4DDjIR7bPTsFSeSgrc
	 uxUMs+zUGroADGP86lnuD0qcHn0lyiMXq62IfFIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436728AbgAPSaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392125AbgAPRZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:25:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2212A246BE;
        Thu, 16 Jan 2020 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195537;
        bh=pdaL2usdeANw5MYykla2raJgzZsvaXsWZHnDQa4pUo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bq8bF7hBIClANPqH8QcHzmA3oQiVLiHdJ+xV0q4uIV34myJ2Rl8/8bocsXolqYfmu
         dgY1Os5UB0TcJuB/82JuQEMcXpWIo5jfZlUV0t3W3jazYrKDcBJL0JS1RdmcvAJ3oQ
         CNxsekwI6nKNvun6MvRPF7BvGu+sgHs8rzPILmjo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Andyt Lutomirski <luto@kernel.org>,
        dave.hansen@linux.intel.com, peterz@infradead.org, bp@alien8.de,
        hpa@zytor.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 131/371] x86/mm: Remove unused variable 'cpu'
Date:   Thu, 16 Jan 2020 12:20:03 -0500
Message-Id: <20200116172403.18149-74-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

[ Upstream commit 3609e31bc8dc03b701390f79c74fc7fe92b95039 ]

The commit a2055abe9c67 ("x86/mm: Pass flush_tlb_info to
flush_tlb_others() etc") removed the unnecessary cpu parameter from
uv_flush_tlb_others() but left an unused variable.

arch/x86/mm/tlb.c: In function 'native_flush_tlb_others':
arch/x86/mm/tlb.c:688:16: warning: variable 'cpu' set but not used
[-Wunused-but-set-variable]
   unsigned int cpu;
                ^~~

Fixes: a2055abe9c67 ("x86/mm: Pass flush_tlb_info to flush_tlb_others() etc")
Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andyt Lutomirski <luto@kernel.org>
Cc: dave.hansen@linux.intel.com
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20190228220155.88124-1-cai@lca.pw
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/tlb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5400a24e1a8c..c5d7b4ae17ca 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -651,9 +651,6 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 		 * that UV should be updated so that smp_call_function_many(),
 		 * etc, are optimal on UV.
 		 */
-		unsigned int cpu;
-
-		cpu = smp_processor_id();
 		cpumask = uv_flush_tlb_others(cpumask, info);
 		if (cpumask)
 			smp_call_function_many(cpumask, flush_tlb_func_remote,
-- 
2.20.1

