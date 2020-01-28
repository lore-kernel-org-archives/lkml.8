Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD05C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5742A20678
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220728;
	bh=ih9BgcBo6Yc8wvAFbGnt0L8Fekm/bCbr/yESvFa9eNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p9gBgaxyOxISrCtSA5/yxSIDnNVSDC/Ix+byT0UkrO63tpnhSUVJYKEUB8UUhyfOA
	 ttNymuw62glgG41gUKyHMvHKup1kKuvDcHXttU1W1Wk6nSj+kRSW4H0EaGQRN5dFXd
	 hvsuYXRHwun7bPjtc2td4Yq8GGXP86M/G5KnXYLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgA1OMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbgA1OME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:12:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72BDD24685;
        Tue, 28 Jan 2020 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220723;
        bh=ih9BgcBo6Yc8wvAFbGnt0L8Fekm/bCbr/yESvFa9eNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKEiv6oV8RtF5qkmeNzdMrEdtNV/K85rSpgSfR620rL8SX7/IqS2eed+4GeRcM6DZ
         5j5o48/Qkq5q0vklFTo+AgAqK5RqsdoxskVFT+dllKBluxwA+FiAIRcEeu9p4g4Hvl
         WTUU9hRPLW0rxxnb3oWSfu+WVZp3v7ajrhfcB/oc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 122/183] ASoC: wm8737: Fix copy-paste error in wm8737_snd_controls
Date:   Tue, 28 Jan 2020 15:05:41 +0100
Message-Id: <20200128135842.113122211@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 554b75bde64bcad9662530726d1483f7ef012069 ]

sound/soc/codecs/wm8737.c:112:29: warning:
 high_3d defined but not used [-Wunused-const-variable=]

'high_3d' should be used for 3D High Cut-off.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 2a9ae13a2641 ("ASoC: Add initial WM8737 driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20190815091920.64480-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8737.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index e7807601e675c..ae69cb790ac38 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -170,7 +170,7 @@ SOC_DOUBLE("Polarity Invert Switch", WM8737_ADC_CONTROL, 5, 6, 1, 0),
 SOC_SINGLE("3D Switch", WM8737_3D_ENHANCE, 0, 1, 0),
 SOC_SINGLE("3D Depth", WM8737_3D_ENHANCE, 1, 15, 0),
 SOC_ENUM("3D Low Cut-off", low_3d),
-SOC_ENUM("3D High Cut-off", low_3d),
+SOC_ENUM("3D High Cut-off", high_3d),
 SOC_SINGLE_TLV("3D ADC Volume", WM8737_3D_ENHANCE, 7, 1, 1, adc_tlv),
 
 SOC_SINGLE("Noise Gate Switch", WM8737_NOISE_GATE, 0, 1, 0),
-- 
2.20.1



