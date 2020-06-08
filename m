Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D206DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D661207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660095;
	bh=4D/TzCF5dNrWPr8uoeNBCXOeMzlLAPWBUdsM219bCok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=figM7mGfqaDML5KpD9aLOObpYfyWx8M99LP+dJ6yzLmQ6zKI/XU8tSfhJJTDHHK7E
	 zMU7hnS0rl096MNLBmnyg+VzEiDylnSknYoJNqlmZf73q24hsK2UxTHu/DzcpJAntU
	 CsTmJWiqBaNWUeqvT8ek7MJPajLbXQtzELnd2yUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbgFHXZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbgFHXUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:20:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F722086A;
        Mon,  8 Jun 2020 23:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658448;
        bh=4D/TzCF5dNrWPr8uoeNBCXOeMzlLAPWBUdsM219bCok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0MS1wW7ZrXpZOZO2Y/RawGcVm+gKZrlBu2y9FRw469SnSx/D28ReVJCa5H+Bx0/aY
         Tbq03RJ6vdmKiTM/O8YHjGVQCHnKWQazUKe9jrHLISaXKu3WIB4Jt15oHFZMmpOxyX
         O1cIgZkzQVxMecS51xvDpF7mrVNPwHOb4LsXLOUM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 090/175] drivers/perf: hisi: Fix typo in events attribute array
Date:   Mon,  8 Jun 2020 19:17:23 -0400
Message-Id: <20200608231848.3366970-90-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaokun Zhang <zhangshaokun@hisilicon.com>

[ Upstream commit 88562f06ebf56587788783e5420f25fde3ca36c8 ]

Fix up one typo: wr_dr_64b -> wr_ddr_64b.

Fixes: 2bab3cf9104c ("perf: hisi: Add support for HiSilicon SoC HHA PMU driver")
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/1587643530-34357-1-git-send-email-zhangshaokun@hisilicon.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index f28063873e11..0d6325d6a4ec 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -285,7 +285,7 @@ static struct attribute *hisi_hha_pmu_events_attr[] = {
 	HISI_PMU_EVENT_ATTR(rx_wbip,		0x05),
 	HISI_PMU_EVENT_ATTR(rx_wtistash,	0x11),
 	HISI_PMU_EVENT_ATTR(rd_ddr_64b,		0x1c),
-	HISI_PMU_EVENT_ATTR(wr_dr_64b,		0x1d),
+	HISI_PMU_EVENT_ATTR(wr_ddr_64b,		0x1d),
 	HISI_PMU_EVENT_ATTR(rd_ddr_128b,	0x1e),
 	HISI_PMU_EVENT_ATTR(wr_ddr_128b,	0x1f),
 	HISI_PMU_EVENT_ATTR(spill_num,		0x20),
-- 
2.25.1

