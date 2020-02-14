Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB33C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FD520873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702639;
	bh=VxGyWnEba5VNmYC+QZbrZ1DU0OE8ldnVhLLrAP06RRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vSqT60YoUYoRBlXp53YBgfJ3g9bwrRR3zoiDWp4Fg2kAHCoHSx0e1EOcsb6PdZUaW
	 FcUeLF0g3Yb7MW9d84ymm5bTeq750icZk5W9bGR6A2r6MtBd0OvIEB3ry+Lgm7YgYV
	 Ajts2/B34XXMP91oPJvM+dgui3P7M8i2UQNTVBso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388444AbgBNP7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:59:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388700AbgBNP6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:58:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 842DC24682;
        Fri, 14 Feb 2020 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695928;
        bh=VxGyWnEba5VNmYC+QZbrZ1DU0OE8ldnVhLLrAP06RRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HaZeb9uP/2uHDIoi5Yr9k0Cfae9804QWQ3OS1274DO1j9S4HwwFx01ULqCgHaSY/I
         lwaJXCVpDrrYqfNeTVX2vo5G70N5ZYszPftXdOK+dnoiccCD7ZCJzf29d/S5OsDE5F
         TQAydFQcN6Rj38RsTg/1lBXNl/8XRpW9YY7rBf7o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Bringmann <mwb@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.5 464/542] powerpc/pseries/lparcfg: Fix display of Maximum Memory
Date:   Fri, 14 Feb 2020 10:47:36 -0500
Message-Id: <20200214154854.6746-464-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Bringmann <mwb@linux.ibm.com>

[ Upstream commit f1dbc1c5c70d0d4c60b5d467ba941fba167c12f6 ]

Correct overflow problem in calculation and display of Maximum Memory
value to syscfg.

Signed-off-by: Michael Bringmann <mwb@linux.ibm.com>
[mpe: Only n_lmbs needs casting to unsigned long]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/5577aef8-1d5a-ca95-ff0a-9c7b5977e5bf@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/lparcfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index e33e8bc4b69bd..38c306551f76b 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -435,10 +435,10 @@ static void maxmem_data(struct seq_file *m)
 {
 	unsigned long maxmem = 0;
 
-	maxmem += drmem_info->n_lmbs * drmem_info->lmb_size;
+	maxmem += (unsigned long)drmem_info->n_lmbs * drmem_info->lmb_size;
 	maxmem += hugetlb_total_pages() * PAGE_SIZE;
 
-	seq_printf(m, "MaxMem=%ld\n", maxmem);
+	seq_printf(m, "MaxMem=%lu\n", maxmem);
 }
 
 static int pseries_lparcfg_data(struct seq_file *m, void *v)
-- 
2.20.1

