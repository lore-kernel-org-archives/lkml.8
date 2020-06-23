Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44214C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 164C42080C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942588;
	bh=9/LBg4O0E12RfutimPzYdGkz066z0xWK9cekAAQRx5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kDjUabEiTycurTzv+BgkxXt7+WJM0EIRWfrPp4PbZznlL73RecORNnZUGqre7DCZv
	 r5OewXFT7L47uKwkCcVDtaEvjmm/zD/ZmsxCLeFUzzE88quO0TQdVnAxOkOCKh9S3q
	 hK+YXaRe1wO7eupS9sFCSAs9BEcKGDiELi+DACZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbgFWUDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387964AbgFWUDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:03:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0539A2078A;
        Tue, 23 Jun 2020 20:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942581;
        bh=9/LBg4O0E12RfutimPzYdGkz066z0xWK9cekAAQRx5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2gsnxsBV4tQv2JTzEV0g60/Ge44pZAcmEbGSPdnt9ty5zdkfAKu6qmUkI0qqeQ80+
         OopOv0DsgoIqw492zgpeCQFL7p3hCJrchvMZkt8bHEa8s0kCtOsLClWWpiMvPsOUUO
         yd3DCRlSb7B/ACobjsP5VbZUh50n3s6Lm9uMaVdE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 054/477] ASoC: SOF: Do nothing when DSP PM callbacks are not set
Date:   Tue, 23 Jun 2020 21:50:51 +0200
Message-Id: <20200623195410.161234058@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index c410822d9920d..01d83ddc16bac 100644
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



