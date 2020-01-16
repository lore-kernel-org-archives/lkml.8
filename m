Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DAAC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB9A246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196465;
	bh=WyWH7LNQJ0NSwvH5kHYfLW+98iJEQECuZ3jEX0WehT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0vnq8NzXiIlqyGLp3P4oHOZ3QOWVsKc27hLXbZJ5EUf8NuJhXLvmt4GBsXxOpWCYf
	 8T2Vl2VEHJCzAsfN469ojJj+2Yl4LYhLY3x7+XeXx5FcJEY1sALnI/SIgtrn+xJ+r9
	 cJYHM7mVzGVp/LgMh+CDZBKIpdiy2L0LMRp0Q/20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405529AbgAPRlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:41:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389326AbgAPRkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:40:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7BBC246FC;
        Thu, 16 Jan 2020 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196405;
        bh=WyWH7LNQJ0NSwvH5kHYfLW+98iJEQECuZ3jEX0WehT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQk7Pfqqpx7QdJzoOMJwxk1mYf96oPmPy+C5CnFEqfVKHX2i+Nsh+AMmaHJDjvVaF
         kfbI8EirTrZbr4REXG5AutFQPyd4/DlFQCcmRNRDDS2s+5BB3Ltqnji/WdoIfV+Y58
         Hnd8dTElYVKdG86jNrHNZCWonGV4xNw1v8p4zvg4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.9 181/251] ASoC: cs4349: Use PM ops 'cs4349_runtime_pm'
Date:   Thu, 16 Jan 2020 12:35:30 -0500
Message-Id: <20200116173641.22137-141-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 9b4275c415acca6264a3d7f1182589959c93d530 ]

sound/soc/codecs/cs4349.c:358:32: warning:
 cs4349_runtime_pm defined but not used [-Wunused-const-variable=]

cs4349_runtime_pm ops already defined, it seems
we should enable it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e40da86 ("ASoC: cs4349: Add support for Cirrus Logic CS4349")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815090157.70036-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs4349.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index 231ca935cdf3..c232c42ccead 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -380,6 +380,7 @@ static struct i2c_driver cs4349_i2c_driver = {
 	.driver = {
 		.name		= "cs4349",
 		.of_match_table	= cs4349_of_match,
+		.pm = &cs4349_runtime_pm,
 	},
 	.id_table	= cs4349_i2c_id,
 	.probe		= cs4349_i2c_probe,
-- 
2.20.1

