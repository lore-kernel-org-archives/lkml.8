Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24384C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECE02080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598459665;
	bh=94vf/goBzfoC5nm9rDlXYfi2mPg0KiLVJ1zsM82yLYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O+jnDoMQ5cRojAsyFXhLgoICzvTm9xDNc1uwT/nb613cehx+j5mKlopYMItHqW5mm
	 wvnWRRs3USpqdfhc+cvdjEvWeUnSo1hXMc4lFpdNEMUmh1tLT8EvDjP1u5GBR/YI1w
	 y9E/YEjnfRhB0Jhz+whO9ZmqS1AAdrwKCkpXY3hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHZQd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgHZQdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:33:52 -0400
Received: from localhost.localdomain (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CCB8208E4;
        Wed, 26 Aug 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598459632;
        bh=94vf/goBzfoC5nm9rDlXYfi2mPg0KiLVJ1zsM82yLYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3M7kpFcW9rvXK7isAcnGvGZ/dhMidJUXYrPYnBcaFk8piZn/jdgyMM35TM2ByHyw
         KvTezzZdeZYbSno4ee+7fF5xE0SSRyNziVZwKfrBcLdUVWPdlbAkBnW8+79fZ4QtqF
         bhF0ConO4FxAw3+20EVyxNR3y468Ohk4Idzx+zbY=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ryan Lee <ryans.lee@maximintegrated.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 1/5] ASoC: max98373: Fix return check for devm_regmap_init_sdw()
Date:   Wed, 26 Aug 2020 22:03:36 +0530
Message-Id: <20200826163340.3249608-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200826163340.3249608-1-vkoul@kernel.org>
References: <20200826163340.3249608-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_regmap_init_sdw() returns a valid pointer on success or ERR_PTR on
failure which should be checked with IS_ERR. Also use PTR_ERR for
returning error codes.

Reported-by: Takashi Iwai <tiwai@suse.de>
Fixes: 56a5b7910e96 ("ASoC: codecs: max98373: add SoundWire support")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/codecs/max98373-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
index 5fe724728e84..e4675cfff7b2 100644
--- a/sound/soc/codecs/max98373-sdw.c
+++ b/sound/soc/codecs/max98373-sdw.c
@@ -838,8 +838,8 @@ static int max98373_sdw_probe(struct sdw_slave *slave,
 
 	/* Regmap Initialization */
 	regmap = devm_regmap_init_sdw(slave, &max98373_sdw_regmap);
-	if (!regmap)
-		return -EINVAL;
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
 	return max98373_init(slave, regmap);
 }
-- 
2.26.2

