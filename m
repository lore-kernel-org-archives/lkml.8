Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB23EC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C294C206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199639;
	bh=irA/cM1vWOhJmBs2PD0tW5ZUlPA/Ji3OJu6aU8hDEuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rA5FJJ5CaGPWzdoyM1rj6BzMXmOXPMoP1NDAFB6SRixry1A6P1SqGd9YiS/hD+MEd
	 Feq/vfKrSVVcXhZP+qGRbjdYqo5X1jyuZN5Msm1JSQCYjLxYUIi2qlmCHrH8WoxzUY
	 h5Kmdnq8S0Ak6Fk1J7vgYHmsBJm1ExHChdMpyjUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403804AbgAPRYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:24:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391791AbgAPRYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:24:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58E72246BD;
        Thu, 16 Jan 2020 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195478;
        bh=irA/cM1vWOhJmBs2PD0tW5ZUlPA/Ji3OJu6aU8hDEuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfv7Lzr8ezbvpiBB+Zm+NGQFEIuZlcaX8Lxj90nmTjzYRXuo0Y4ZUv7ROBRDb9HGH
         3g3ZnU3dzcCrMkH9kGSE+E7xSXnOLndynfKp0GWwNpP3LKRhN/Rkv0egqE1FiBkZzY
         vu7XlzHoHJrFNCpxkk8s6wEBTOv/DAXmAMhHRevQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Kao <michael.kao@mediatek.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 083/371] thermal: mediatek: fix register index error
Date:   Thu, 16 Jan 2020 12:19:15 -0500
Message-Id: <20200116172403.18149-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

[ Upstream commit eb9aecd90d1a39601e91cd08b90d5fee51d321a6 ]

The index of msr and adcpnp should match the sensor
which belongs to the selected bank in the for loop.

Fixes: b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")
Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mtk_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 1e61c09153c9..76b92083744c 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -407,7 +407,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 	u32 raw;
 
 	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
-		raw = readl(mt->thermal_base + conf->msr[i]);
+		raw = readl(mt->thermal_base +
+			    conf->msr[conf->bank_data[bank->id].sensors[i]]);
 
 		temp = raw_to_mcelsius(mt,
 				       conf->bank_data[bank->id].sensors[i],
@@ -544,7 +545,8 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 
 	for (i = 0; i < conf->bank_data[num].num_sensors; i++)
 		writel(conf->sensor_mux_values[conf->bank_data[num].sensors[i]],
-		       mt->thermal_base + conf->adcpnp[i]);
+		       mt->thermal_base +
+		       conf->adcpnp[conf->bank_data[num].sensors[i]]);
 
 	writel((1 << conf->bank_data[num].num_sensors) - 1,
 	       mt->thermal_base + TEMP_MONCTL0);
-- 
2.20.1

