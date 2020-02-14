Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71017C3B1A6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F64A222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701006;
	bh=qgXInRCOrnBs55A2/zS0szRQNvhB0rfj8Etl8C/D+6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ERBT68IxXm1CGo0dDnpOYCypZBOqOruJIFbBJ3ls7tEhaSszSeewBMgS1+6/8nXAG
	 cl9J78zH+nuEoxaIroLjyHAd2xSiu0wZHuww44EtlVxH2QklHz9SmUqpGMA7Uohy5V
	 WpBRvDOgTMr2Flue7+PFn6ydzoQoMjJ0cU5tr+gA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391018AbgBNRXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:23:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391314AbgBNQJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92BDA24682;
        Fri, 14 Feb 2020 16:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696575;
        bh=qgXInRCOrnBs55A2/zS0szRQNvhB0rfj8Etl8C/D+6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3iIeYq+B60t32XOk/h3mP8XRh+5vSj0kVQF+o1XhBgA58kRVivPeXZkigxDUN1pa
         +avxjmzWqZaja6SRHXbfYUHBl5unnXmWiiJKnOMnNrSwgK3BnI9mJMQVm+rvnxmiYI
         RwdnNSQdFSa2dWN4oxSnZB9+r06BGTt4K6ZJWaao=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 364/459] regulator: core: Fix exported symbols to the exported GPL version
Date:   Fri, 14 Feb 2020 11:00:14 -0500
Message-Id: <20200214160149.11681-364-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

[ Upstream commit 3d7610e8da993539346dce6f7c909fd3d56bf4d5 ]

Change the exported symbols introduced by commit e9153311491da
("regulator: vctrl-regulator: Avoid deadlock getting and setting the voltage")
from EXPORT_SYMBOL() to EXPORT_SYMBOL_GPL(), like is used for all the core
parts.

Fixes: e9153311491da ("regulator: vctrl-regulator: Avoid deadlock getting and setting the voltage")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Link: https://lore.kernel.org/r/20200120123921.1204339-1-enric.balletbo@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c6fa0f4451aeb..0011bdc15afbb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3462,7 +3462,7 @@ int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 out:
 	return ret;
 }
-EXPORT_SYMBOL(regulator_set_voltage_rdev);
+EXPORT_SYMBOL_GPL(regulator_set_voltage_rdev);
 
 static int regulator_limit_voltage_step(struct regulator_dev *rdev,
 					int *current_uV, int *min_uV)
@@ -4027,7 +4027,7 @@ int regulator_get_voltage_rdev(struct regulator_dev *rdev)
 		return ret;
 	return ret - rdev->constraints->uV_offset;
 }
-EXPORT_SYMBOL(regulator_get_voltage_rdev);
+EXPORT_SYMBOL_GPL(regulator_get_voltage_rdev);
 
 /**
  * regulator_get_voltage - get regulator output voltage
-- 
2.20.1

