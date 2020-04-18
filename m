Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E89C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E45421D82
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587219095;
	bh=djjlQD49nGvDfZ8Xq1ihlGnvcW0C3lWCW9SYDIgq2iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vhWFpvHonbEarsqd9PRRo8PpjleGGqAMACU98Y0q+mMDHNIuoE0PEExMXtbo9r7GK
	 zZZ61UqnLQWcYGfIAZOoHb5ujD7UfzwLTb5+WMxPVqga8difVGDOsdnb2q0M3X+IAu
	 Cj44frPEW2i/uUV6rPF7G6Nc32U2SKNf7rQ/j0Dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgDROLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgDROK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:10:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BCFB21D82;
        Sat, 18 Apr 2020 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587219026;
        bh=djjlQD49nGvDfZ8Xq1ihlGnvcW0C3lWCW9SYDIgq2iU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ieYRvYnPZ7Ny47sRDI++kiSCs7CRG9fekgKYpW0RiH3XMjtHkLrpGWapfQsTMpOqF
         64s8Pv6wjHfwZ88GGOHM4SKcYon6zKpr1J1ZIivVRnMGXq5WEdZQUSTyX4UrUbxy85
         2seXBYZV44TpiTMapgOSnGZr7GeTdME0smoqco4Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.5 61/75] ASoC: Intel: bytcr_rt5640: Add quirk for MPMAN MPWIN895CL tablet
Date:   Sat, 18 Apr 2020 10:08:56 -0400
Message-Id: <20200418140910.8280-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit c8b78f24c1247b7bd0882885c672d9dec5800bc6 ]

The MPMAN MPWIN895CL tablet almost fully works with out default settings.
The only problem is that it has only 1 speaker so any sounds only playing
on the right channel get lost.

Add a quirk for this model using the default settings + MONO_SPEAKER.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200405133726.24154-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 243f683bc02a7..e62e1d7815aa9 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -591,6 +591,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{
+		/* MPMAN MPWIN895CL */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MPMAN"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "MPWIN8900CL"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* MSI S100 tablet */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
-- 
2.20.1

