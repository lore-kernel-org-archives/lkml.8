Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFB0C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FD920CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646460;
	bh=LC74n3QaVoY+lqR3p+4SLHMpMxRO1p0cRsDU3p1DfiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ykYu8yXzcAAwJE4URt0wP8S+Fv6kL5R3IBJ5AMniyR9QKWKvHWWhQPMqgk9lR7IEB
	 6f4BLSVaRNweV7lf5+jOddHwyrkjRYPKJw9XJyuIEznZA8GaCfgYtn+TXNN24/kWlp
	 JM26VmOGiqzCQG/xgV+BqaKr9158M9zEkjz7BzNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgDKXHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgDKXHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:07:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A6DA21924;
        Sat, 11 Apr 2020 23:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646457;
        bh=LC74n3QaVoY+lqR3p+4SLHMpMxRO1p0cRsDU3p1DfiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RbXsoYOdOBJIZLLHy495T1DlDHZESkIuxWvtI1V54HhVeIZogo0QEDButUJY32d7U
         NQ9HeYlOQWBXSy7sjTH00g7s6RA615yiRkvRUTunwSorTNYdztqSbzz1uFmzLvgCrz
         SwvkpUrJUkMi48PCZ4qqxsVhFPaL+cokdLo27DlI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 026/121] drm/tegra: dc: Release PM and RGB output when client's registration fails
Date:   Sat, 11 Apr 2020 19:05:31 -0400
Message-Id: <20200411230706.23855-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
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
index 714af052fbefe..ed870117c72c9 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2506,10 +2506,16 @@ static int tegra_dc_probe(struct platform_device *pdev)
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

