Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18ACC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B093120575
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586956673;
	bh=vWk7gWqHU/rr1AfSECvbX+1y/08BdStuBe2bUqRvfl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LzDBCvglNAqxcPwLI9wZsDkBtE7xqAqYLZXKvSzRLp/cP28ERgwhY3E8tPjPZaUcj
	 6y2OkR/dxdgntMu7oPtsEyAhXdPQFbPtKhG9Sl6yAX4ta4o15WPBpDX0sI9v282a/w
	 jOCdBPFXomS9c8I80ks0WIVPjuMDP68P1qHjixMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506272AbgDONRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897024AbgDOLfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:35:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C6B2078A;
        Wed, 15 Apr 2020 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950508;
        bh=vWk7gWqHU/rr1AfSECvbX+1y/08BdStuBe2bUqRvfl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sX0UMu/D+IbuSSaW0FqEWvDktfXuEuQAWyqvxQRCklUDYo2kqr5l+WebxTBRUzWlY
         GzJ1AnjgGl9I28FJuK3Dwug9xKQb18ZxWDkO5MTBcNkDyqBqOU9E3QqB1TkOTBsCX8
         evsbNsQ3msJYmRG255ee+Tur9UkpKC3ZXMrAf5eM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 019/129] memory: tegra: Correct debugfs clk rate-range on Tegra30
Date:   Wed, 15 Apr 2020 07:32:54 -0400
Message-Id: <20200415113445.11881-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

