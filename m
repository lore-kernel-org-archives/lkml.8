Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC23C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A322D20659
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425131;
	bh=QaUmGOs6VeR87aE8yHZMtpxIbTBHgOfdmQpPxvkOCs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eMdwqEf3vr5YSSBoBJNQsmGhpygc2BI1qGXGkdDwgxaQgLeW9zk1Q4qX200fReto7
	 ntbyghHNamI8Z5+9KF+PkfwzZ46h5GqfRu/dhg3Uiy5xotWNon5mkohw2a0tEZkoiq
	 MolEG+W4FdfB1VzK0RtkFSiU+VlEX2dIZnet9zgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgBWCXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgBWCXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:23:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA6A20707;
        Sun, 23 Feb 2020 02:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424589;
        bh=QaUmGOs6VeR87aE8yHZMtpxIbTBHgOfdmQpPxvkOCs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KU+L7qypDmL2RhBqw3Q6DKJexz1n0/0iIr2dM9leMngmWDly+bmD/0C1m2vqjHCke
         pAcRvb8D25WfvG0SNYO/8jKAbRVO/invzkGgcyOVvkds+YX0VF3VsCjQaF9YcKaF7j
         aFwU5NoSlED7ZzlWBDR8BTmpaKfP65j/jm+mL9Co=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>,
        kbuild test robot <lkp@intel.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 27/50] soc/tegra: fuse: Fix build with Tegra194 configuration
Date:   Sat, 22 Feb 2020 21:22:12 -0500
Message-Id: <20200223022235.1404-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022235.1404-1-sashal@kernel.org>
References: <20200223022235.1404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 6f4ecbe284df5f22e386a640d9a4b32cede62030 ]

If only Tegra194 support is enabled, the tegra30_fuse_read() and
tegra30_fuse_init() function are not declared and cause a build failure.
Add Tegra194 to the preprocessor guard to make sure these functions are
available for Tegra194-only builds as well.

Link: https://lore.kernel.org/r/20200203143114.3967295-1-thierry.reding@gmail.com
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/tegra/fuse/fuse-tegra30.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index be9424a871734..9c3ef0a02fd4e 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -35,7 +35,8 @@
     defined(CONFIG_ARCH_TEGRA_124_SOC) || \
     defined(CONFIG_ARCH_TEGRA_132_SOC) || \
     defined(CONFIG_ARCH_TEGRA_210_SOC) || \
-    defined(CONFIG_ARCH_TEGRA_186_SOC)
+    defined(CONFIG_ARCH_TEGRA_186_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_194_SOC)
 static u32 tegra30_fuse_read_early(struct tegra_fuse *fuse, unsigned int offset)
 {
 	if (WARN_ON(!fuse->base))
-- 
2.20.1

