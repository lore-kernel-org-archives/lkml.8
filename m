Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01142C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA09206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944105;
	bh=kE7AXXRyM6+rLDBiuSuo6TNEZVzbhrd1WcqgebLczrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U0q3FV6q/3eJgDaE9QPKO1zIfFvysRiX2UQ4DSF/4JKboYrd9Abnx//IsAu9yCZGe
	 iei9VClJ2/v3LJ1D6pmXR7pSn+KXf6+tNb7Z2qYg87qJIRXCnG8vJwWg6hINvfbOXA
	 oT9L8cvErveZvAF576r4i9PscQXBbkuBb4iNqoTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbgFWU2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390846AbgFWU2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:28:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7696F2064B;
        Tue, 23 Jun 2020 20:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944089;
        bh=kE7AXXRyM6+rLDBiuSuo6TNEZVzbhrd1WcqgebLczrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0xCy1zPnfmSsSGK20XsmBOHe8HDEpIXUX4ZakGc2vXyg0jmDYghLDwSd2tSXeknn1
         B5YpqUfa3sQr7D98F1V1WkzhuCD440eK//nWxmlhs8DrSCP5/nWKjFwrAzJ0w9/9Z6
         3Xc4C9l4umkPP2NFv7bQuBtt87whwJOJbEcrIgVo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 128/314] ASoC: SOF: core: fix error return code in sof_probe_continue()
Date:   Tue, 23 Jun 2020 21:55:23 +0200
Message-Id: <20200623195344.977173646@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 7d8785bc7adbb4dc5ba8ee06994107637848ded8 ]

Fix to return negative error code -ENOMEM from the IPC init error
handling case instead of 0, as done elsewhere in this function.

Fixes: c16211d6226d ("ASoC: SOF: Add Sound Open Firmware driver core")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Link: https://lore.kernel.org/r/20200509093337.78897-1-weiyongjun1@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 12aec140819a2..2a6b84d2781ee 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -372,6 +372,7 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 	/* init the IPC */
 	sdev->ipc = snd_sof_ipc_init(sdev);
 	if (!sdev->ipc) {
+		ret = -ENOMEM;
 		dev_err(sdev->dev, "error: failed to init DSP IPC %d\n", ret);
 		goto ipc_err;
 	}
-- 
2.25.1



