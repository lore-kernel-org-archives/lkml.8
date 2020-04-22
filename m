Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046C9C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1BB920656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551783;
	bh=vWk7gWqHU/rr1AfSECvbX+1y/08BdStuBe2bUqRvfl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RfcSNJGH2fyhYFz8Q8iD+rYZsbUO+44ozc643hzWUxeKrDKTWYyDAwQBE9kxfAC/b
	 VqfjMcKQveQuiJtoftLO4B23lefgsQ8AeUjlYVrqF+BJZv6D5I1rcJBv1c4P9frkW+
	 dMLfT7/gf7kIqMcpsfkJGljfGh4pgEEGAWkeIfDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbgDVKgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730285AbgDVKXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:23:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D5A2076B;
        Wed, 22 Apr 2020 10:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550992;
        bh=vWk7gWqHU/rr1AfSECvbX+1y/08BdStuBe2bUqRvfl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=owjzedZRZdgw/JbO5wi4stoVu7mk9J5n7B/AqxrexbTBQhVrMrU7y+VznekeEf+zj
         PvydUee61IgUXpKG+UVvb3ICVS4D+gjurxxyfMD2VKg7aujFG8Mw/0OWITj2Navuis
         UQ5xoZOjbF4GFQE5AargK5/bvSZNjeiPQ49DPCyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 056/166] memory: tegra: Correct debugfs clk rate-range on Tegra30
Date:   Wed, 22 Apr 2020 11:56:23 +0200
Message-Id: <20200422095054.934399992@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit a53670e1a734ba56fac84cf2b93b838bd4a6b835 ]

Correctly set clk rate-range if number of available timings is zero.
This fixes noisy "invalid range [4294967295, 0]" error messages during
boot.

Fixes: 8cee32b40040 ("memory: tegra: Implement EMC debugfs interface on Tegra30")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/tegra/tegra30-emc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index e3efd9529506e..b42bdb667e853 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1256,6 +1256,11 @@ static void tegra_emc_debugfs_init(struct tegra_emc *emc)
 			emc->debugfs.max_rate = emc->timings[i].rate;
 	}
 
+	if (!emc->num_timings) {
+		emc->debugfs.min_rate = clk_get_rate(emc->clk);
+		emc->debugfs.max_rate = emc->debugfs.min_rate;
+	}
+
 	err = clk_set_rate_range(emc->clk, emc->debugfs.min_rate,
 				 emc->debugfs.max_rate);
 	if (err < 0) {
-- 
2.20.1



