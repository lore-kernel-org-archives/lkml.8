Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25F5C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4922075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgDHTAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:00:50 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgDHTAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:00:49 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N33ZD-1jAeuX3IBJ-013QLf; Wed, 08 Apr 2020 21:00:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Thierry Reding <treding@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memory: tegra: avoid unused function warnings
Date:   Wed,  8 Apr 2020 21:00:30 +0200
Message-Id: <20200408190043.532711-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vxi0ZoZ/gTKClwkqlSDz5/fhno22l9gBMFUMDwqFhI+YG00xmiG
 KeD3ufvZ6WWsY8hidN6p95DkiWplhrGUD7hA+pyN5ZQduUHwXDPqNm/rD/Pvkcx12+c+Kx9
 bYBS5QCYNERahmMya1KQAyL7AV/FUs9H6C7sbv3yktGB1rr7iPgAD2DGvwWgj7u+ee9CLVO
 8EX6XpCDTdyD3LK+evwow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TaULm99Uc84=:ILs8DU73hec5byNS1czGIe
 m/de9mCMWtVW5jfLJhO1fgx7ZpakgaUwmNmBHObF3wYhhYxFmi0gjNam7/jEX4lShqImN5HVI
 zUOKveNGf5ASyaTvSaFBuEWgntmvstNNPjQgkY2UyiNEYx8k6r75Ibjqku2bWhYCfMbJgGH9u
 yA7EyWcATerG1Wtg5HMUlgVG6SQoU2NcfxRPiwIry/Kk2/fCIT1VenuVx15GziUQvZqoh6XbZ
 fSRmHDwf0LMEud/EwmypeYo6RgI4nGEc7PcnPOOQd5eGNzGHzUVr25tgaSOwB48DADc3yrjp+
 GgYSOqEzOBpeuupTRQwCaFEi59gjzw5hvG8RDlXbysNm2zs3vINNPJINEuHP5qatkcTK5dX/K
 YdK0oD05LmDoJ6v0L40wgI0ZLJQz5zJwPD1Zxvswqk+uYkSii+OH3CiPee88ZZbmbHXIxXmCB
 qwZI9DLjk6ttqfe+Cn8qK2toRjq8+cv18Ljv52lNqUP0ndTkhLut4tETGx3dTESeQlipWekbC
 4neYwdyEm4s1pbCAouZrXON0Fw7bpL+ljCRe2jo0FsIMsuLLFgWJHRWHCvCfBD9MavwA4qXJU
 edV5O0MTtU3lhOk+/pftzqlJ6CSp/LjMkLIyFB/Q6QwQjBRwZLcrKz87G+ac6GvmqrtQ87qom
 GW5t9pXS+8S4rHkVzW94K7gX+FprqQ1RXhMVAURdTJzyGURSSv6u1sndgmn8G0M0kbYXB7csb
 dZjZpRiCT8vMCTtJafZcyO0O+Vx6fwvhbx7GQpJC6oCBdMZVQYZ9bGQnpxFUBZgQ4gbQ5rAsQ
 BfIGcG57D8AsoAkh8NP6LZ3zXWJSEH3xdLA4Tjqv2DVt4xFrcM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suspend/resume functions have no callers depending on
configuration, so they must be marked __maybe_unused to
avoid these harmless warnings:

drivers/memory/tegra/tegra186.c:1578:12: error: 'tegra186_mc_resume' defined but not used [-Werror=unused-function]
 1578 | static int tegra186_mc_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~
drivers/memory/tegra/tegra186.c:1573:12: error: 'tegra186_mc_suspend' defined but not used [-Werror=unused-function]
 1573 | static int tegra186_mc_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~

Fixes: 177602b00641 ("memory: tegra: Add system sleep support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/memory/tegra/tegra186.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 5d53f11ca7b6..e25c954dde2e 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -1570,12 +1570,12 @@ static const struct of_device_id tegra186_mc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra186_mc_of_match);
 
-static int tegra186_mc_suspend(struct device *dev)
+static int __maybe_unused tegra186_mc_suspend(struct device *dev)
 {
 	return 0;
 }
 
-static int tegra186_mc_resume(struct device *dev)
+static int __maybe_unused tegra186_mc_resume(struct device *dev)
 {
 	struct tegra186_mc *mc = dev_get_drvdata(dev);
 
-- 
2.26.0

