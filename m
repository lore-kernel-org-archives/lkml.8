Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FFCC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26AE246AD
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196746;
	bh=4DnERebs/mPKi7GhrQ5vDiIFtaJxnJX4Mn+pekOJ+dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WRFmAB1kGSbaGKJKWXz04L07IvODCMAII6jiHRnISyluNtj6N0iiGkV1S14zECtwp
	 QAANCXo2ISAhXoMan5dBNM+inSjEaRw36vFZlAiA7FuCwxANZoWAfRlSW19LFLXtpa
	 XQI65UMMyaZyzbcnPWsCBy2c0hPTz9cZNVKkoiho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406494AbgAPRpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:45:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406486AbgAPRpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:45:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D7CA24787;
        Thu, 16 Jan 2020 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196738;
        bh=4DnERebs/mPKi7GhrQ5vDiIFtaJxnJX4Mn+pekOJ+dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RjtuBlo7dvAaJZMsaNHGAECyHr6vJhj/ZEI342iyOr5j/aLK9qWChdO/+QH9IvvkL
         66OAnHLmyVMUfQM6//kmhijXtoj7huX+/7sjTEe7Pi53Q8GyQP2KTHU5W5fcJMPOb1
         kWJAWbSt3EBjRbjazHVI0+GX8yio24tepm6rMVEI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.4 120/174] ASoC: es8328: Fix copy-paste error in es8328_right_line_controls
Date:   Thu, 16 Jan 2020 12:41:57 -0500
Message-Id: <20200116174251.24326-120-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 630742c296341a8cfe00dfd941392025ba8dd4e8 ]

It seems 'es8328_rline_enum' should be used
in es8328_right_line_controls

Fixes: 567e4f98922c ("ASoC: add es8328 codec driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815092300.68712-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index afa6c5db9dcc..2bf30d0eb82f 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -210,7 +210,7 @@ static const struct soc_enum es8328_rline_enum =
 			      ARRAY_SIZE(es8328_line_texts),
 			      es8328_line_texts);
 static const struct snd_kcontrol_new es8328_right_line_controls =
-	SOC_DAPM_ENUM("Route", es8328_lline_enum);
+	SOC_DAPM_ENUM("Route", es8328_rline_enum);
 
 /* Left Mixer */
 static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
-- 
2.20.1

