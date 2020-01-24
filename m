Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF57C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473E2214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860164;
	bh=YBo4URw0WTkmn86vVl865SELQwwuNf/MkRaLaF5h8d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DAiqJRa/bIBSlfq6wTzAn2cUzLcWTzq0JZcHP4atARsjhNDDJyBB6/0cNOoL1Pe1V
	 uBoohZF0L7/pbrCUeJbUcIzjWLpayvXpnr33ANL1ocMH1ZnwXHjmlPs4qHH3tC6eld
	 hzEDZt021QHSjijIYj2ce88IKCpQ4snNShG7tBjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbgAXKCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:02:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731035AbgAXKCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:02:41 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 833402075D;
        Fri, 24 Jan 2020 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860161;
        bh=YBo4URw0WTkmn86vVl865SELQwwuNf/MkRaLaF5h8d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJi/D8mjIPw1AmnYIfcw0i7YRjMth0voWo/neSH02AanuxZK13olI69B8pUFtAVYJ
         29dKc+TeZfZgFzzzW3289hj4jB/OEzIAQcpGJZBhDFdq0od2Qpy4CUss6J8ypC/ESb
         5MNbdsZPjmmylVaYF74MO4s2S5mstHOyQoPY9jQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 272/343] ASoC: wm8737: Fix copy-paste error in wm8737_snd_controls
Date:   Fri, 24 Jan 2020 10:31:30 +0100
Message-Id: <20200124092955.701952166@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
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
index f0cb1c4afe3ce..c5a8d758f58b8 100644
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



