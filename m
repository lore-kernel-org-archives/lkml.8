Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC55CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D1B20578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690219;
	bh=kO1Y19OI4AfooucGLBEOzmQUbrn5X6bISJvX0cbpDWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZGEFu9SrZhJy/cvocP2ScOKQHQG3qlMM0LYTYo64AtQ/5mZGGu/e61Lw9vqojFcRH
	 nItny5zNEih+CJwmEdg5WsaidDJ4BkYYWa0s6HzssVD64Ww1fDgDuPTCiAAe00xsQ8
	 69ZicodnNYShF1Fn4/7A8tE+eWaJz2HBZ9tfQySs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403897AbgHQSuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387572AbgHQPxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:53:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D20220729;
        Mon, 17 Aug 2020 15:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679624;
        bh=kO1Y19OI4AfooucGLBEOzmQUbrn5X6bISJvX0cbpDWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZT7+VhfoeEkwJvqfeHxjp1H8oQUHQT2Heo5RYMUbnDZyXpia2FBRqboYcIvEUCzGj
         sYc6NDhg6RVrD+kGmgQDyo7s4MVupd0a9Cnajbz33iO+02Uc1Xad/WE/Yc/AXMo5by
         OdrgyJGYtEB8kLMHM7paAL4rRVPXKmjPrrfw0WnA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 278/393] ASoC: soc-core: Fix regression causing sysfs entries to disappear
Date:   Mon, 17 Aug 2020 17:15:28 +0200
Message-Id: <20200817143833.104581277@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 5c74c9d34aec1ac756de6979dd5580096aba8643 ]

The allocation order of things in soc_new_pcm_runtime was changed to
move the device_register before the allocation of the rtd structure.
This was to allow the rtd allocation to be managed by devm. However
currently the sysfs entries are added by device_register and their
visibility depends on variables within the rtd structure, this causes
the pmdown_time and dapm_widgets sysfs entries to be missing for all
rtds.

Correct this issue by manually calling device_add_groups after the
appropriate information is available.

Fixes: d918a37610b1 ("ASoC: soc-core: tidyup soc_new_pcm_runtime() alloc order")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20200730120715.637-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e5433e8fcf19e..b5c4473f1e499 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -443,7 +443,6 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 
 	dev->parent	= card->dev;
 	dev->release	= soc_release_rtd_dev;
-	dev->groups	= soc_dev_attr_groups;
 
 	dev_set_name(dev, "%s", dai_link->name);
 
@@ -502,6 +501,10 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 	rtd->num = card->num_rtd;
 	card->num_rtd++;
 
+	ret = device_add_groups(dev, soc_dev_attr_groups);
+	if (ret < 0)
+		goto free_rtd;
+
 	return rtd;
 
 free_rtd:
-- 
2.25.1



