Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E00AC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A2C2467E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195414;
	bh=88sMCRQAKkwZ+wQKf7/96Vqp/6NS71a2FVJAav/VwAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=keleAI84XTAt5XBcpVl1cehhToSrc8VTxccz/3IBknYV2gz8dLbOMviFqTL/DHjwp
	 WRYWVP8Tc80ONSfciYsL2qtk6onVShUGk4xBmfM+P1+OVak5rW3Y2NucsGeVAjukoa
	 DHcsPMctrtyKVhgNzI0AzfO2ij87cjGaE4sQiwJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390667AbgAPRNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:13:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390022AbgAPRNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:13:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37D08246AA;
        Thu, 16 Jan 2020 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194784;
        bh=88sMCRQAKkwZ+wQKf7/96Vqp/6NS71a2FVJAav/VwAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvXuemRdPpFp3m/k+7P7J/LBwEgbGC8PK9O5Q+HQ5JIdtlhiM55mPw2CiSIBcBD7s
         BHzEWPfXeEscLOirTRn6rmStwN5MAQs7uvRTXGqwpRshuMOKnWOVV5eT0t+ibqNSeW
         zTGsbZLQbeJ2nimpabpE3pmZ1LD1+RDNoLEhzffA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 599/671] arm64: hibernate: check pgd table allocation
Date:   Thu, 16 Jan 2020 12:03:57 -0500
Message-Id: <20200116170509.12787-336-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@soleen.com>

[ Upstream commit 8c551f919a73c1dfa690a70a691be1da394145e8 ]

There is a bug in create_safe_exec_page(), when page table is allocated
it is not checked that table is allocated successfully:

But it is dereferenced in: pgd_none(READ_ONCE(*pgdp)).  Check that
allocation was successful.

Fixes: 82869ac57b5d ("arm64: kernel: Add support for hibernate/suspend-to-disk")
Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/hibernate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 9859e1178e6b..dbeeeffdb9c9 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -202,6 +202,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 gfp_t mask)
 {
 	int rc = 0;
+	pgd_t *trans_pgd;
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
@@ -216,7 +217,13 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	memcpy((void *)dst, src_start, length);
 	__flush_icache_range(dst, dst + length);
 
-	pgdp = pgd_offset_raw(allocator(mask), dst_addr);
+	trans_pgd = allocator(mask);
+	if (!trans_pgd) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
 		pudp = allocator(mask);
 		if (!pudp) {
-- 
2.20.1

