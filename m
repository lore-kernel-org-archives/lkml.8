Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21195C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3302186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582868;
	bh=4D/TzCF5dNrWPr8uoeNBCXOeMzlLAPWBUdsM219bCok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kXMECDC0aI7KVBAnflN+9dXWVA7rarPQuWmHZahv23+3abQSQOaSoTL2+DOq/1CZu
	 UKD0otR3Cd1ptDDHYCip8OzH1SDxdFXJF65D1sfWeaXf/YicZoP5GmLQEVtHaa1dAo
	 uOWP9I6T6YzVaMPxFpqxAN/eMH8bBcq1zFfmTvL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391744AbgFSPIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391722AbgFSPIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:08:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5BEC20776;
        Fri, 19 Jun 2020 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579301;
        bh=4D/TzCF5dNrWPr8uoeNBCXOeMzlLAPWBUdsM219bCok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVCUFYMkJKlf/MsMW33bZkoUai55BcWEvlq5qNzCyqZ6DAUEZYE6plLhOJEqnRTVd
         hg096cNkWl/HIyupZtsynytGafjF03I2JAlBoIupsX+9xGBATzMLRDusGSFyf9v0Bk
         AJnhZJvbuazDhI+gex2A7U9qZCVm3MLnXdFFc17U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 083/261] drivers/perf: hisi: Fix typo in events attribute array
Date:   Fri, 19 Jun 2020 16:31:34 +0200
Message-Id: <20200619141653.869212495@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



