Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637FAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCD92071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262882;
	bh=2WqdaqYNLMI3GI7UkDLyVTeint5ew7zR2IiT361LbKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ceZh4GYYkqE5ia+2xjsFmXvwQvu9lfBtSL0VwizZpRjGwWC3X7qnm19od0lAK0Z2p
	 KfxjUfzqyRskbhtBHPiNw0nHEmvoGM6IPDesmYrIDjkPwqySqf7aFZ2Ipn6OPsf3D/
	 i1Zdum1hQNSciJ6bJ7nfztw4faMOxEXCHff95f7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgHXJyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbgHXIhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:37:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20575221E2;
        Mon, 24 Aug 2020 08:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258243;
        bh=2WqdaqYNLMI3GI7UkDLyVTeint5ew7zR2IiT361LbKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cuN1RAoT+MRTzSfI+tR3qQHj1wELBoODBNsLk3hdVPbVeLNPE0k6761nsa4oFf3y3
         o288VnZbA/YF1Dn6zDJUN4zyZpDAZM8FMEnAnbf+GNJg2t86omAo5SSwXfDklpu9f3
         DX6TZvCI8sehX07MstiEq31LuX0SOZFIstfvhWLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 128/148] powerpc: Add POWER10 raw mode cputable entry
Date:   Mon, 24 Aug 2020 10:30:26 +0200
Message-Id: <20200824082420.146914546@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhavan Srinivasan <maddy@linux.ibm.com>

[ Upstream commit 327da008e65a25b8206b36b7fc0c9e4edbb36a58 ]

Add a raw mode cputable entry for POWER10. Copies most of the fields
from commit a3ea40d5c736 ("powerpc: Add POWER10 architected mode")
except for oprofile_cpu_type, machine_check_early, pvr_mask and
pvr_mask fields. On bare metal systems we use DT CPU features, which
doesn't need a cputable entry. But in VMs we still rely on the raw
cputable entry to set the correct values for the PMU related fields.

Fixes: a3ea40d5c736 ("powerpc: Add POWER10 architected mode")
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
[mpe: Reorder vs cleanup patch and add Fixes tag]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200817005618.3305028-2-maddy@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/cputable.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index b4066354f0730..bb0c7f43a8283 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -75,6 +75,7 @@ extern void __restore_cpu_power10(void);
 extern long __machine_check_early_realmode_p7(struct pt_regs *regs);
 extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
 extern long __machine_check_early_realmode_p9(struct pt_regs *regs);
+extern long __machine_check_early_realmode_p10(struct pt_regs *regs);
 #endif /* CONFIG_PPC64 */
 #if defined(CONFIG_E500)
 extern void __setup_cpu_e5500(unsigned long offset, struct cpu_spec* spec);
@@ -541,6 +542,25 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check_early	= __machine_check_early_realmode_p9,
 		.platform		= "power9",
 	},
+	{	/* Power10 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00800000,
+		.cpu_name		= "POWER10 (raw)",
+		.cpu_features		= CPU_FTRS_POWER10,
+		.cpu_user_features	= COMMON_USER_POWER10,
+		.cpu_user_features2	= COMMON_USER2_POWER10,
+		.mmu_features		= MMU_FTRS_POWER10,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
+		.oprofile_cpu_type	= "ppc64/power10",
+		.oprofile_type		= PPC_OPROFILE_INVALID,
+		.cpu_setup		= __setup_cpu_power10,
+		.cpu_restore		= __restore_cpu_power10,
+		.machine_check_early	= __machine_check_early_realmode_p10,
+		.platform		= "power10",
+	},
 	{	/* Cell Broadband Engine */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00700000,
-- 
2.25.1



