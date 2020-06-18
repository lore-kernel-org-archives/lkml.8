Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F91C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C2520776
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448630;
	bh=4qBR61r3nM6bdJZcmW6Y39cAB3ZUpIlI9O50ZJzCDrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cfYRC/epB0oGS4owl576md6+kxcG7JuTREI1RKiTOy/UeHhFZJ1f0TGyw8iiU8eIT
	 fyOx6F5vww1qcYeStjM57M+IdEUI0trFWfVGEq7DMyukeBFDWWqL8IxunOL7aePlpL
	 c2k0iXiZC2eFV+zIypHC8/PtXxg/RTm4apNXjgNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgFRCu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbgFRBJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:09:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 121BC21D7B;
        Thu, 18 Jun 2020 01:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442559;
        bh=4qBR61r3nM6bdJZcmW6Y39cAB3ZUpIlI9O50ZJzCDrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKLacmhr/x34DIiETgiaYugUxWvufWTR/Z9iiLlAMrFySa6H6lc+okRCRo9Dr8Jom
         4CY4fLbFdVNNMm1inSaAPBvVJx4Kuy5vAmOPsHSctALYEQzhJmOxueMGVDeKu5Z2Zd
         i9Hl9zWP1mcVYf64NGIFvsh+5sSUqT92Y64bNt0o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.7 055/388] ASoC: SOF: Do nothing when DSP PM callbacks are not set
Date:   Wed, 17 Jun 2020 21:02:32 -0400
Message-Id: <20200618010805.600873-55-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

[ Upstream commit c26fde3b15ed41f5f452f1da727795f787833287 ]

This provides a better separation between runtime and PM sleep
callbacks.

Only do nothing if given runtime flag is set and calback is not set.

With the current implementation, if PM sleep callback is set but runtime
callback is not set then at runtime resume we reload the firmware even
if we do not support runtime resume callback.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20200515135958.17511-2-kai.vehmanen@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/pm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index c410822d9920..01d83ddc16ba 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -90,7 +90,10 @@ static int sof_resume(struct device *dev, bool runtime_resume)
 	int ret;
 
 	/* do nothing if dsp resume callbacks are not set */
-	if (!sof_ops(sdev)->resume || !sof_ops(sdev)->runtime_resume)
+	if (!runtime_resume && !sof_ops(sdev)->resume)
+		return 0;
+
+	if (runtime_resume && !sof_ops(sdev)->runtime_resume)
 		return 0;
 
 	/* DSP was never successfully started, nothing to resume */
@@ -175,7 +178,10 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 	int ret;
 
 	/* do nothing if dsp suspend callback is not set */
-	if (!sof_ops(sdev)->suspend)
+	if (!runtime_suspend && !sof_ops(sdev)->suspend)
+		return 0;
+
+	if (runtime_suspend && !sof_ops(sdev)->runtime_suspend)
 		return 0;
 
 	if (sdev->fw_state != SOF_FW_BOOT_COMPLETE)
-- 
2.25.1

