Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73217C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4904820775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586950743;
	bh=LvKT9IZJFoDqch09JWfp7jN4pO1lzW0qd658CKnycSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eQFKQq0vRtngzoV56rr2s/Go2wzpEuqB0rMT183TB71oxVNOW/Mwo2XZ4m2SX/CMT
	 Fz9ZYjWuojAj9L+RCQzCYvoR7zUc3/6eyS2jLEDzIS+BxUywaJYWUZ/IUaDw1YGFSA
	 ky6ytUsj/smZ7ZNtdtE72SuhiYomU/IRnHwoViEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897283AbgDOLiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897026AbgDOLfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:35:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE45C2137B;
        Wed, 15 Apr 2020 11:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950509;
        bh=LvKT9IZJFoDqch09JWfp7jN4pO1lzW0qd658CKnycSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOlxj6IcAYkLFqaTd6iq910g2t+ECKwtGODnrEHQW22nqwrUas8ZaW9pHP0dn6K4k
         Mu7m8mofxq+G3SItX/riRDCMJw28Z+WLqk0Osj3WA2i/U3fGeoWdDJYNDu2PwjSZWX
         QqKO5/cX1llmHvODenjN/gSsnjtcEGUktzDpi9yQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 020/129] memory: tegra: Correct debugfs clk rate-range on Tegra124
Date:   Wed, 15 Apr 2020 07:32:55 -0400
Message-Id: <20200415113445.11881-20-sashal@kernel.org>
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

[ Upstream commit 141267bffd1dc19a76e4d50e3e4829f85a806875 ]

Correctly set clk rate-range if number of available timings is zero.
This fixes noisy "invalid range [4294967295, 0]" error messages during
boot.

Fixes: 6b9acd935546 ("memory: tegra: Refashion EMC debugfs interface on Tegra124")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/tegra/tegra124-emc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 21f05240682b8..33b8216bac30c 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1158,6 +1158,11 @@ static void emc_debugfs_init(struct device *dev, struct tegra_emc *emc)
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

