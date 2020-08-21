Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC6CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7946120656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598029562;
	bh=PJlJN9iz55FCW+gfWE6Dcvm0SreHsE+AMvFKVq4QXKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VRI4PK58Y2EIoZgZhkRMjgyX+dVfVc4gAeDnbmD9kiFhDskdxXK6mPn9mIefDDt3h
	 zr31A8brKPyeq3ZpxNPoCR/Cjwc0LNNE45isBWrGcYFGbJdXI0yrn+Ft4K1qFzMh7X
	 etSDoL1Q0utNriXusq04O9Pr97Zy1KicZMVORtIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgHURGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgHUQS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:18:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D070422BF3;
        Fri, 21 Aug 2020 16:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026690;
        bh=PJlJN9iz55FCW+gfWE6Dcvm0SreHsE+AMvFKVq4QXKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=raC5drJaEkeATdmMdczeWbWijmgfADtdK/OiYiWtTzIKpPJamjvR0ml931XcGLx+T
         4TqTuhgDD3KvfLZw3/WBaH9py/BQWkRP6oImXFbBy42EmZB6OvPL7JWsHtdTK5yzqb
         nMyFIZfhlOsbmCIojLmNo4x836KrNNsB+JIrNrnM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 02/38] ASoC: img: Fix a reference count leak in img_i2s_in_set_fmt
Date:   Fri, 21 Aug 2020 12:17:31 -0400
Message-Id: <20200821161807.348600-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161807.348600-1-sashal@kernel.org>
References: <20200821161807.348600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit c4c59b95b7f7d4cef5071b151be2dadb33f3287b ]

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code, causing incorrect ref count if
pm_runtime_put_noidle() is not called in error handling paths.
Thus call pm_runtime_put_noidle() if pm_runtime_get_sync() fails.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Link: https://lore.kernel.org/r/20200614033749.2975-1-wu000273@umn.edu
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/img/img-i2s-in.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index c22880aea82a2..7e48c740bf550 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -346,8 +346,10 @@ static int img_i2s_in_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	chan_control_mask = IMG_I2S_IN_CH_CTL_CLK_TRANS_MASK;
 
 	ret = pm_runtime_get_sync(i2s->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(i2s->dev);
 		return ret;
+	}
 
 	for (i = 0; i < i2s->active_channels; i++)
 		img_i2s_in_ch_disable(i2s, i);
-- 
2.25.1

