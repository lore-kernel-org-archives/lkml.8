Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5639C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50542075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551781;
	bh=KYVbrnZQ7AJD/sDVMLkUCoghFt+lMHOAtPcsirwNruA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eg14ToH8F+DzG05YMLGbDCQkxzmZjzdaVmXBWXV3+2aug/XB5HZM7vFyBShdOVar2
	 qhrwBT/AyBZSnBY/QPuTb9xLN3hlwzrzgHHF50aG27DZYySyHSlMA9pzTm04uSbsHk
	 zR9wBP6/QtNfOzpBVrSj/kkOuM34XSf45Zqh7SwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbgDVKgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbgDVKXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:23:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A264F2076B;
        Wed, 22 Apr 2020 10:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550990;
        bh=KYVbrnZQ7AJD/sDVMLkUCoghFt+lMHOAtPcsirwNruA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkflgV9oHyUU+Es8k0vjicPnNkQkki/1Tfj8hrJxZS/pewnNGz8cnk2GA1Egxs40x
         Pvf/dRky6eJAztBzVWJhL7Xs1V32z6m/pO8ZWfhnkDZrBEuzdbTyIGTR8stK5ngQod
         ve4Zh4jKs0FPgXlgauzdYStzOilnE60E1Eok7Of4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 055/166] memory: tegra: Correct debugfs clk rate-range on Tegra20
Date:   Wed, 22 Apr 2020 11:56:22 +0200
Message-Id: <20200422095054.847251371@linuxfoundation.org>
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

[ Upstream commit 2243af41115d0e36e6414df6dd2a0386e022d9f8 ]

Correctly set clk rate-range if number of available timings is zero.
This fixes noisy "invalid range [4294967295, 0]" error messages during
boot.

Fixes: 8209eefa3d37 ("memory: tegra: Implement EMC debugfs interface on Tegra20")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/tegra/tegra20-emc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 8ae474d9bfb90..b16715e9515d0 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -628,6 +628,11 @@ static void tegra_emc_debugfs_init(struct tegra_emc *emc)
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



