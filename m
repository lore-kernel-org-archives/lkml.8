Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73A0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4A52075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863757;
	bh=qz9DazI9OkcyP03T0kcBKG8MUWNZiyP5VX2500Ls8DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OAE5YQhc/+A1UIYKq02vsSgUUcs9Ye2GenIyA4wWJVdkjWADLltic/5k5wPg5+Umy
	 sRaFK7w6RAPiDL0a6ZJNBa5GlU/g9zsM0Za9OVpSkKCOaZhIh3q7XER1CkHFYSOBVF
	 6bLUVPVT57331ZC152w+od8ppm8YVP/D3SpUsCT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbgAXLCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:02:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731019AbgAXLCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:02:34 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EFC72087E;
        Fri, 24 Jan 2020 11:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863754;
        bh=qz9DazI9OkcyP03T0kcBKG8MUWNZiyP5VX2500Ls8DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9wkthPoQwLcgg5/XoMP1SXGUGxkMnTcgkJMsMngorDfXzwg/wWXcyqrFgUv+ctes
         1gvxEy93Vf9daUJHjO6QjET6HU+UZN8NuJ9MjVgacsFlLrA6u+j4UjooZbDsGzj1/g
         96cbVTYizA+j0ocT7LIBS98NwaZ+F98D1yUnBTns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 066/639] ASoC: sun8i-codec: add missing route for ADC
Date:   Fri, 24 Jan 2020 10:23:56 +0100
Message-Id: <20200124093055.674363334@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

[ Upstream commit 9ee325d029c4abb75716851ce38863845911d605 ]

sun8i-codec misses a route from ADC to AIF1 Slot 0 ADC. Add it
to the driver to avoid adding it to every dts.

Fixes: eda85d1fee05d ("ASoC: sun8i-codec: Add ADC support for a33")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index bf615fa16dc8a..a3db6a68dfe6d 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -465,7 +465,11 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	{ "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
 	  "AIF1 Slot 0 Right"},
 
-	/* ADC routes */
+	/* ADC Routes */
+	{ "AIF1 Slot 0 Right ADC", NULL, "ADC" },
+	{ "AIF1 Slot 0 Left ADC", NULL, "ADC" },
+
+	/* ADC Mixer Routes */
 	{ "Left Digital ADC Mixer", "AIF1 Data Digital ADC Capture Switch",
 	  "AIF1 Slot 0 Left ADC" },
 	{ "Right Digital ADC Mixer", "AIF1 Data Digital ADC Capture Switch",
-- 
2.20.1



