Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35D4C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7074520787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586647385;
	bh=gBIiINfZVDVqHSfSGPKg1OdDvQLhSXtd5hAhwzOamTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J63ann2e2vo1RrVE0SQ+DvDdjV+FKgCgTY5X7Ux0fXDc/m80a8w0EmPq7r1ShnMCW
	 KEs53jjbyxMBmm9qMqhX5a+yc0DDrCXNtp/kg6ebwYiI7CgMDLdQ64FeDbNuhimNF6
	 X0w+cxKfjO1qZWQpC0lN0a39+jVIyKiXWQN+MT0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgDKXXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730255AbgDKXNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:13:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B51C21744;
        Sat, 11 Apr 2020 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646788;
        bh=gBIiINfZVDVqHSfSGPKg1OdDvQLhSXtd5hAhwzOamTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BihWNkA6UCrJ1GCaGZtvL+6wePsMIoPeo1iimruEsXVeY6UtqHudSw/WPx+ptFee/
         S5gMYWR6O0E/HJn6ai7mexyJIKChM+LKqLBbMjJYP2dqMA/7TUoH4r+Rnwig26oUpb
         NRO1MpHx6Wt396O1QsMd3NJV+3OmIE0RNj5MowF4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 53/66] ASoC: Intel: Skylake: Enable codec wakeup during chip init
Date:   Sat, 11 Apr 2020 19:11:50 -0400
Message-Id: <20200411231203.25933-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411231203.25933-1-sashal@kernel.org>
References: <20200411231203.25933-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit e603f11d5df8997d104ab405ff27640b90baffaa ]

Follow the recommendation set by hda_intel.c and enable HDMI/DP codec
wakeup during bus initialization procedure. Disable wakeup once init
completes.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200305145314.32579-4-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 50f16a0f6535f..463078c2346f9 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -128,6 +128,7 @@ static int skl_init_chip(struct hdac_bus *bus, bool full_reset)
 	struct hdac_ext_link *hlink;
 	int ret;
 
+	snd_hdac_set_codec_wakeup(bus, true);
 	skl_enable_miscbdcge(bus->dev, false);
 	ret = snd_hdac_bus_init_chip(bus, full_reset);
 
@@ -136,6 +137,7 @@ static int skl_init_chip(struct hdac_bus *bus, bool full_reset)
 		bus->io_ops->reg_writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
 
 	skl_enable_miscbdcge(bus->dev, true);
+	snd_hdac_set_codec_wakeup(bus, false);
 
 	return ret;
 }
-- 
2.20.1

