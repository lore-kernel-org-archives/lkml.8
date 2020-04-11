Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF62C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCFC206F7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648927;
	bh=RDf0IwB6pbgawCvfT6ZQKVrQehfWd21JQ8a5a+4VaN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GL+N1I3TihZhdBSigq1QHn9Zlf8d3+e0icpADWaUoPJniiBB8pM4MdZ/F5ODCCsRk
	 qa0xhNx5YyJJanGRLmi4dKYZZeroU6+bQLEXwKfdMbIb6eVGWu//Ads4ssqJnmL0ea
	 gMiYXRlFAOPmaZtYsXXvcsok2cghdMpT8bAwfQnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgDKXEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbgDKXE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:04:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81C8320CC7;
        Sat, 11 Apr 2020 23:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646266;
        bh=RDf0IwB6pbgawCvfT6ZQKVrQehfWd21JQ8a5a+4VaN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUysD0yZY22puJrBzOjNs0n6Cr9JD8cdu+blByuD4smj5s8/v/yVe6AVGIQEKnNqv
         RCPUC6ly5mOgxjv+5rgBIA9XcR6gsvFCoJj5iju8umNL1G6tveM/R+n3/XltnNjHrj
         G6ybETfNluCqc2Bkd/iweP8y/7+00n0c9Nj6ixvk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 031/149] drm/tegra: dc: Release PM and RGB output when client's registration fails
Date:   Sat, 11 Apr 2020 19:01:48 -0400
Message-Id: <20200411230347.22371-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit 0411ea89a689531e1829fdf8af3747646c02c721 ]

Runtime PM and RGB output need to be released when host1x client
registration fails. The releasing is missed in the code, let's correct it.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/dc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 7c70fd31a4c24..870f9a68ad2c5 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2588,10 +2588,16 @@ static int tegra_dc_probe(struct platform_device *pdev)
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
 			err);
-		return err;
+		goto disable_pm;
 	}
 
 	return 0;
+
+disable_pm:
+	pm_runtime_disable(&pdev->dev);
+	tegra_dc_rgb_remove(dc);
+
+	return err;
 }
 
 static int tegra_dc_remove(struct platform_device *pdev)
-- 
2.20.1

