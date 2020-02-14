Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A46C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C5720848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703398;
	bh=iW0pG2/jtj3T1OIrSI9apWm9rnCO1tmNfqWZdpAN9to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Np1GaFuEPVt3iJjOX0Vb308oSTUj9tAkOmf+7gZBFBZyIHETEye3WLgs/5TBuhaXY
	 TJEz4pgmkEc513LAXMgjLoT+P1H/ph32Oknc7uXqiiJCMnNPbyDqZlMQ8GrcTGz6Mf
	 bH1fGPkfe+BgfDMs9zyiccU+BRBmhvt5FAzqfR1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbgBNSDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:03:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387621AbgBNPzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:55:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B7F24676;
        Fri, 14 Feb 2020 15:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695746;
        bh=iW0pG2/jtj3T1OIrSI9apWm9rnCO1tmNfqWZdpAN9to=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6nhcrTKRJsHpPaQ1JwzxZcdo91MGSVDsf8HrA2O87twnDd4jGdIw0MiEA0kvmXHy
         /xlYHpYNNpmFoAA6TGQ74Qt/S0iV4x2OOLTV6d0si/3mZqF3kutiOb+DzTm2GEQa+j
         b6epqRphK4ugnQbrIMvRyov5/LHWNJ1i8WvEJfEA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 317/542] soc/tegra: fuse: Correct straps' address for older Tegra124 device trees
Date:   Fri, 14 Feb 2020 10:45:09 -0500
Message-Id: <20200214154854.6746-317-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
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
index df76778af601e..f8b9c4058926b 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -123,7 +123,7 @@ void __init tegra_init_apbmisc(void)
 			apbmisc.flags = IORESOURCE_MEM;
 
 			/* strapping options */
-			if (tegra_get_chip_id() == TEGRA124) {
+			if (of_machine_is_compatible("nvidia,tegra124")) {
 				straps.start = 0x7000e864;
 				straps.end = 0x7000e867;
 			} else {
-- 
2.20.1

