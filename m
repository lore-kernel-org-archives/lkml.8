Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A0DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03332467D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193739;
	bh=PFjH3ZbA6H/pJdTWTzfP5SXvIjQF07uUkr1TpxSry/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n84tJg3ScE8PrOC+TSLKlGGxljsnJ6j9xwGjpZc8uieitvp8nK58/hhNbsiZBwUjH
	 09oMrutW0+v4WnklNMt5blgrCRZg7k54kxd2PDckzPeJGPSrPT03ZNzw+GBRZo+l4S
	 rVETkip3AeSRxu3uOhLcasSBRFVvHDhPeOtPPWwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbgAPQzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:55:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732705AbgAPQzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:55:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7078D2464B;
        Thu, 16 Jan 2020 16:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193723;
        bh=PFjH3ZbA6H/pJdTWTzfP5SXvIjQF07uUkr1TpxSry/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1528iOCwCWfLHPCqt11PdHIE93YqIzzPQdVhopacYOz78WsIPIsGZCIWLtppJV1UE
         GMOLvluRsCUSLNvxuYE6sQwTgHixoNiVQIvKDWgKkmJStToZpEEF5j/uI9StXJRrQh
         aFEYZU0DLif7EcDpcNhapxQ7O6avoGN678z1Z7jc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 017/671] ASoC: wm9712: fix unused variable warning
Date:   Thu, 16 Jan 2020 11:44:08 -0500
Message-Id: <20200116165502.8838-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 18380dcc52cc8965e5144ce33fdfad7e168679a5 ]

The 'ret' variable is now only used in an #ifdef, and causes a
warning if it is declared outside of that block:

sound/soc/codecs/wm9712.c: In function 'wm9712_soc_probe':
sound/soc/codecs/wm9712.c:641:6: error: unused variable 'ret' [-Werror=unused-variable]

Fixes: 2ed1a8e0ce8d ("ASoC: wm9712: add ac97 new bus support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm9712.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index ade34c26ad2f..e873baa9e778 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -638,13 +638,14 @@ static int wm9712_soc_probe(struct snd_soc_component *component)
 {
 	struct wm9712_priv *wm9712 = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap;
-	int ret;
 
 	if (wm9712->mfd_pdata) {
 		wm9712->ac97 = wm9712->mfd_pdata->ac97;
 		regmap = wm9712->mfd_pdata->regmap;
 	} else {
 #ifdef CONFIG_SND_SOC_AC97_BUS
+		int ret;
+
 		wm9712->ac97 = snd_soc_new_ac97_component(component, WM9712_VENDOR_ID,
 						      WM9712_VENDOR_ID_MASK);
 		if (IS_ERR(wm9712->ac97)) {
-- 
2.20.1

