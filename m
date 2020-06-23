Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0985AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9DD120702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943946;
	bh=CaUoCBxYI9U26p0mgol98Ovh0DIucD7EMkmPGdlCuew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zfLF9iw3SSE17SREOGC3s9B2iPXq5+u98DPcyEX7MRPM97rGlpe0z813GMm0TQUSo
	 ZP+SpcIJ574mZhif8eWde0ItGLPW0T1VXj1Xyvii1tjzuEsh59NC0zVp67hr0czolW
	 pVJgVi2etCGPX3VZ/Y43nzP3NyqJ9pXUFwNlYVtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390586AbgFWUZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390572AbgFWUZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:25:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A03206EB;
        Tue, 23 Jun 2020 20:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943940;
        bh=CaUoCBxYI9U26p0mgol98Ovh0DIucD7EMkmPGdlCuew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pplINrmF/33mFDgcRqsrLbofSe9fO8i2kqOjQaoNdk4LaTcEei4hdZp03Df+4ra9F
         Y+Cs+n5dYSU4p9+kPRvGGiAVYAo7ff6d/zyYK1N8zXEI0kyLhfoUQueqkUUOoF6/qR
         PeaTjIoUiGAdjKhCd136JaE4mMVSDgjCp5EpZkNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 111/314] ASoC: max98373: reorder max98373_reset() in resume
Date:   Tue, 23 Jun 2020 21:55:06 +0200
Message-Id: <20200623195344.161814193@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index cae1def8902dd..96718e3a1ad0e 100644
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



