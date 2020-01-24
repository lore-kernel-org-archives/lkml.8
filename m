Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D144C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA69220708
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864454;
	bh=ecNkzIOQBMhCoFQXdm0acT31SGIU+wVGKjkTX2DkPZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QqqjWczdQCPRrqP3FJEuhhz8QD2RD7vwqGc4BO/Wj/WmDKbVXzPueQBZToEAKtKJQ
	 ar1HknEZHj2aND3mTzrnDSR3BmU1eQL225oN4sR/a8FTc8G0n5+g0+12lcoQXvz4Hi
	 JDGjBWOsYFQjOUuaIgK8AuGuZeYEL2l2nI9sLfrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390109AbgAXLOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389486AbgAXLOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:14:05 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D60E20663;
        Fri, 24 Jan 2020 11:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864444;
        bh=ecNkzIOQBMhCoFQXdm0acT31SGIU+wVGKjkTX2DkPZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nu02F78c0V0NMR9CaYBkwGtj6wIrbVV0mwujOdg0CB6MtP9n2Giho2sHFyXlBJstx
         O9XPgrvpSgo6/tSQX6kZAh8bOmlQsZ87jf3219NP+W0NsYUA9P5pqCV9pMdhc5STS4
         vs1Rp0M5fFJKhutSy/9yMplHSkTGoRRjPPKZ4F3w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andyt Lutomirski <luto@kernel.org>,
        dave.hansen@linux.intel.com, peterz@infradead.org, bp@alien8.de,
        hpa@zytor.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 254/639] x86/mm: Remove unused variable cpu
Date:   Fri, 24 Jan 2020 10:27:04 +0100
Message-Id: <20200124093118.531722123@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index a6836ab0fcc73..b72296bd04a29 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -664,9 +664,6 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
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



