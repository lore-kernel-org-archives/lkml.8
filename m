Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EE8C3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFD224746
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697242;
	bh=ofwbgNjBWpSvnTCV96oBhMiWdtYCquSy3RtoQ52qE2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tS21M0f55iFb0itLIOy82+WVXbImBoR1kj069uOoA2CexoWt6AWv0uKFxNxM5kYKI
	 S/7ee9gHJezLdAGCnVei9/CGVgFPCv1743Pl+4pcPI49s8ty/+ry6igYdtJhoxWtM5
	 B2CK6ztNv2R/gKzT+n4O4kpJoTC8Bxe8TSy3tkTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405250AbgBNQUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:20:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405023AbgBNQTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:19:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DF9124713;
        Fri, 14 Feb 2020 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697177;
        bh=ofwbgNjBWpSvnTCV96oBhMiWdtYCquSy3RtoQ52qE2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZN0LZl9DFBSXQNBcyhzbJphK1dT1hSXorsQoFPQM/Dv3v/3K6sTswizCpoldDSrUn
         uiMBcLcQNbTy/ImZ7+ldkyuwEsAaHIoVZ+gC5IIdbffrCd5+Qu2iZkPJFBdZYj+yqT
         qYv2HPtFKha075kAReKWWp0qd0LIbhaLiZ4dfXSk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 110/186] soc/tegra: fuse: Correct straps' address for older Tegra124 device trees
Date:   Fri, 14 Feb 2020 11:15:59 -0500
Message-Id: <20200214161715.18113-110-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit 2d9ea1934f8ef0dfb862d103389562cc28b4fc03 ]

Trying to read out Chip ID before APBMISC registers are mapped won't
succeed, in a result Tegra124 gets a wrong address for the HW straps
register if machine uses an old outdated device tree.

Fixes: 297c4f3dcbff ("soc/tegra: fuse: Restrict legacy code to 32-bit ARM")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index 5b18f6ffa45c7..cd61c883c19f5 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -134,7 +134,7 @@ void __init tegra_init_apbmisc(void)
 			apbmisc.flags = IORESOURCE_MEM;
 
 			/* strapping options */
-			if (tegra_get_chip_id() == TEGRA124) {
+			if (of_machine_is_compatible("nvidia,tegra124")) {
 				straps.start = 0x7000e864;
 				straps.end = 0x7000e867;
 			} else {
-- 
2.20.1

