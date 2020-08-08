Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BF9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241C4206D8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596929775;
	bh=K1Ma8cAdRm4cq5FiYwAP+gpk459mF5A3ggKalD13s7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gbTKFAYcskQQUZULYXkFZuEiKNjADSKNoK+1H4iaXaRAZ2AxNRHD9s/Y9qI9r7ZEn
	 fDoBqREn/0IwQQ04do4oSndW/wv72r68qLf+hOTGRgCQ8aDCwI/rrcRNZG4TpnMODv
	 QpXswGJE5lKYQHTM4e68+us3zKzWKM7uQH0h5YNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHHXgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbgHHXgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:36:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACEFD206E9;
        Sat,  8 Aug 2020 23:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929763;
        bh=K1Ma8cAdRm4cq5FiYwAP+gpk459mF5A3ggKalD13s7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsD40c1k04OhuzR9bG4FbsU+6Kw9Nk0srtLDKQcCo6LQvx3qnPWghx9RHcImTrat6
         lE3W2K4WYIUINqN6hcGrg1XsPgxQaVS274mUZL4pa0njBqMFbT30LQnPVs+HCGnlkc
         Ze42c1zj/cZQeEz5tWQp31Ta++y0x5wkXrxlgE4s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 16/72] memory: tegra: Fix an error handling path in tegra186_emc_probe()
Date:   Sat,  8 Aug 2020 19:34:45 -0400
Message-Id: <20200808233542.3617339-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233542.3617339-1-sashal@kernel.org>
References: <20200808233542.3617339-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit c3d4eb3bf6ad32466555b31094f33a299444f795 ]

The call to tegra_bpmp_get() must be balanced by a call to
tegra_bpmp_put() in case of error, as already done in the remove
function.

Add an error handling path and corresponding goto.

Fixes: 52d15dd23f0b ("memory: tegra: Support DVFS on Tegra186 and later")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/tegra/tegra186-emc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 97f26bc77ad41..c900948881d5b 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -185,7 +185,7 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 	if (IS_ERR(emc->clk)) {
 		err = PTR_ERR(emc->clk);
 		dev_err(&pdev->dev, "failed to get EMC clock: %d\n", err);
-		return err;
+		goto put_bpmp;
 	}
 
 	platform_set_drvdata(pdev, emc);
@@ -201,7 +201,7 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 	err = tegra_bpmp_transfer(emc->bpmp, &msg);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to EMC DVFS pairs: %d\n", err);
-		return err;
+		goto put_bpmp;
 	}
 
 	emc->debugfs.min_rate = ULONG_MAX;
@@ -211,8 +211,10 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 
 	emc->dvfs = devm_kmalloc_array(&pdev->dev, emc->num_dvfs,
 				       sizeof(*emc->dvfs), GFP_KERNEL);
-	if (!emc->dvfs)
-		return -ENOMEM;
+	if (!emc->dvfs) {
+		err = -ENOMEM;
+		goto put_bpmp;
+	}
 
 	dev_dbg(&pdev->dev, "%u DVFS pairs:\n", emc->num_dvfs);
 
@@ -237,7 +239,7 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 			"failed to set rate range [%lu-%lu] for %pC\n",
 			emc->debugfs.min_rate, emc->debugfs.max_rate,
 			emc->clk);
-		return err;
+		goto put_bpmp;
 	}
 
 	emc->debugfs.root = debugfs_create_dir("emc", NULL);
@@ -254,6 +256,10 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 			    emc, &tegra186_emc_debug_max_rate_fops);
 
 	return 0;
+
+put_bpmp:
+	tegra_bpmp_put(emc->bpmp);
+	return err;
 }
 
 static int tegra186_emc_remove(struct platform_device *pdev)
-- 
2.25.1

