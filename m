Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754CFC3B1B1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46018206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702878;
	bh=F7yV7B9cZ2IEW8ez9zw43MwkFZxqGIZ/+JFHLnfbauw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bcbZ23p5USzae1L26jPaDA1z6m3CKXAhUCnApa94m8WntTjjUF/tfRMzm55eeGKP2
	 i2+eIQZIq6KOHAxT+tie0/qsdpKL/Xug0U6oLVSrNyG00/FAobXmI3UiK6oVswL0i9
	 K60ofv+/7wQfC4reXX7GKfwWVLg/yRFL7ltfxgp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389198AbgBNRyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:54:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388430AbgBNP6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:58:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 693C3206D7;
        Fri, 14 Feb 2020 15:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695880;
        bh=F7yV7B9cZ2IEW8ez9zw43MwkFZxqGIZ/+JFHLnfbauw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mA95CccIbGV+GR3VZwB+Uq7Iqcu7UQ+yqSWp/NSjKuviZXxyVwZezt7snONzSdL3d
         3v93TTvLRNr18yL8Xkz91qm6+sqkN4GRBExr0buP3f59psfTp0rZQLfao2ziRsvEQ+
         LMgOvaV3eQhrGU5INOom23iWGhm5o9iW0zJdV7Ls=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 424/542] regulator: core: Fix exported symbols to the exported GPL version
Date:   Fri, 14 Feb 2020 10:46:56 -0500
Message-Id: <20200214154854.6746-424-sashal@kernel.org>
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
index e7d167ce326cb..d015d99cb59d9 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3470,7 +3470,7 @@ int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 out:
 	return ret;
 }
-EXPORT_SYMBOL(regulator_set_voltage_rdev);
+EXPORT_SYMBOL_GPL(regulator_set_voltage_rdev);
 
 static int regulator_limit_voltage_step(struct regulator_dev *rdev,
 					int *current_uV, int *min_uV)
@@ -4035,7 +4035,7 @@ int regulator_get_voltage_rdev(struct regulator_dev *rdev)
 		return ret;
 	return ret - rdev->constraints->uV_offset;
 }
-EXPORT_SYMBOL(regulator_get_voltage_rdev);
+EXPORT_SYMBOL_GPL(regulator_get_voltage_rdev);
 
 /**
  * regulator_get_voltage - get regulator output voltage
-- 
2.20.1

