Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2A4C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5792D20714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582742841;
	bh=PxNFpD8FpKx31qOUaTdsyYNPm0u56FKyfLv2VWXFM4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=E6NtHCc7/peohtsDf6mL/fDDOAZeJsdftYuoLd98u4D1DTOhEyxYYXiJiqKMkCks5
	 tHqfrpBDTCW7r22d7UmAN6M7FMtIxK7+aGqy4GosbvjwM1Z5D1Ewp8t/fYwiqTieJr
	 fuVCwGWYE9fSlaGykWf4fd2CEfyc5PMLSDRmYrU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgBZSrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:47:20 -0500
Received: from foss.arm.com ([217.140.110.172]:41252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgBZSrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:47:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 271AB30E;
        Wed, 26 Feb 2020 10:47:19 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91FD33F881;
        Wed, 26 Feb 2020 10:47:18 -0800 (PST)
Date:   Wed, 26 Feb 2020 18:47:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, alsa-devel@alsa-project.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: amd: Allow I2S wake event after ACP is powerd On" to the asoc tree
In-Reply-To:  <20200226104746.208656-1-akshu.agrawal@amd.com>
Message-Id:  <applied-20200226104746.208656-1-akshu.agrawal@amd.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: Allow I2S wake event after ACP is powerd On

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 911abf8b050e76591479d35c928f7e72605067ac Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Wed, 26 Feb 2020 16:17:44 +0530
Subject: [PATCH] ASoC: amd: Allow I2S wake event after ACP is powerd On

ACP_PME_EN allows wake interrupt to be generated when I2S wake
feature is enabled. On turning ACP On, ACP_PME_EN gets cleared.
Setting the bit back ensures that wake event can be received
when ACP is On.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Link: https://lore.kernel.org/r/20200226104746.208656-1-akshu.agrawal@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/pci-acp3x.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index da60e2ec5535..f25ce50f1a90 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -38,8 +38,13 @@ static int acp3x_power_on(void __iomem *acp3x_base)
 	timeout = 0;
 	while (++timeout < 500) {
 		val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
-		if (!val)
+		if (!val) {
+			/* Set PME_EN as after ACP power On,
+			 * PME_EN gets cleared
+			 */
+			rv_writel(0x1, acp3x_base + mmACP_PME_EN);
 			return 0;
+		}
 		udelay(1);
 	}
 	return -ETIMEDOUT;
-- 
2.20.1

