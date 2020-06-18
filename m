Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F59C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B077207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446815;
	bh=lffGI+usafluNIt52bJY49hTytGuNJw+IaRZwkMO2Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HSYm2uKYF2XXHvkbJWpcudoidTmyjJBbn7IF2IXUjQf/ZBt4esGdQVb+qNRnW/xYF
	 7O+iItURDaSCEph0XgwJHjwaWjaIuNYprehvoGp2DdMy5a3FBZpwdQRoNZc13uLKVn
	 DivBOdtife0+eH/rIwmw6L/O42EgJQmAVhnT4/14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbgFRCUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729168AbgFRBTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:19:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ED32221F6;
        Thu, 18 Jun 2020 01:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443143;
        bh=lffGI+usafluNIt52bJY49hTytGuNJw+IaRZwkMO2Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCIAQL6+db1cgMjxPJuF6+iqx7d7QWwXpKEtTORPBcrT9VyND2TV/9twzXDNbB5jw
         8js0ARPPowFYC4ujsBLGebdrZUx6Www54ODuqrqf9/S9ofQlqlDQH/RYsvt/2KQzcc
         7PWGgEV4gMzKf8OK2jR5c/nMifJ8xrCrFD7kMtWM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yong Zhi <yong.zhi@intel.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 113/266] ASoC: max98373: reorder max98373_reset() in resume
Date:   Wed, 17 Jun 2020 21:13:58 -0400
Message-Id: <20200618011631.604574-113-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yong Zhi <yong.zhi@intel.com>

[ Upstream commit 1a446873d7dd3a450f685928ce7f1907bde4583d ]

During S3 test, the following error was observed:

[ 726.174237] i2c_designware i2c_designware.0: platform_pm_resume+0x0/0x3d returned 0 after 0 usecs
[ 726.184187] max98373 i2c-MX98373:00: calling max98373_resume+0x0/0x30 [snd_soc_max98373] @ 12698, parent: i2c-11
[ 726.195589] max98373 i2c-MX98373:00: Reset command failed. (ret:-16)

When calling regmap_update_bits(), since map->reg_update_bits is NULL,
_regmap_read() is entered with the following logic:

	if (!map->cache_bypass) {
		ret = regcache_read(map, reg, val);
		if (ret == 0)
			return 0;
	}

	if (map->cache_only)
		return -EBUSY;

regcache_read() hits -EINVAL because MAX98373_R2000_SW_RESET is volatile,
as map->cache_only is set by codec suspend, thus -EBUSY is returned.
Fix by moving max98373_reset() after cache_only set to false in max98373_resume().

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Link: https://lore.kernel.org/r/1588376661-29799-1-git-send-email-yong.zhi@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/max98373.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index cae1def8902d..96718e3a1ad0 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -850,8 +850,8 @@ static int max98373_resume(struct device *dev)
 {
 	struct max98373_priv *max98373 = dev_get_drvdata(dev);
 
-	max98373_reset(max98373, dev);
 	regcache_cache_only(max98373->regmap, false);
+	max98373_reset(max98373, dev);
 	regcache_sync(max98373->regmap);
 	return 0;
 }
-- 
2.25.1

