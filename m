Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1346C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E68C2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738513;
	bh=GQiAvbWLjMvJk09cCba+syEJkkqYycnVG/FlajrljWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RxRK06R3DG9QY/QwFf2X4BfpDDK23KHUzdGA3nj58nzzIze6eacFFmtHclFAQOBL7
	 oqzRCcIhAMAhmBo1RaW4e58OilsWyqh8kGLJegSfLJWCid6E5WIY+B8V5wHSSNl+37
	 UqO2dJe91N9x2f5NPRm/guIB1WwlaDcYHNGrDxZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbgAKK2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:28:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730398AbgAKK23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:28:29 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C80B2082E;
        Sat, 11 Jan 2020 10:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738509;
        bh=GQiAvbWLjMvJk09cCba+syEJkkqYycnVG/FlajrljWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f+vbQ9pNKNG86xsBq+8HI7jii921gfMZGRkoC06WgqdPAF1FH3YgMGkJ90nl/zpCq
         Q4JdpfhlOHmvXDlHW+IVyyFIpOodbeOn7W6GhHrMdMUi2dlfwRAbDcFBALKl08rncO
         JfNPidXzPMBhX7KZCKMcYjw8oUpwlkKQe5p+hL0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 090/165] ASoC: wm8962: fix lambda value
Date:   Sat, 11 Jan 2020 10:50:09 +0100
Message-Id: <20200111094928.703357933@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 556672d75ff486e0b6786056da624131679e0576 ]

According to user manual, it is required that FLL_LAMBDA > 0
in all cases (Integer and Franctional modes).

Fixes: 9a76f1ff6e29 ("ASoC: Add initial WM8962 CODEC driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/1576065442-19763-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 3e5c69fbc33a..d9d59f45833f 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2788,7 +2788,7 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
 
 	if (target % Fref == 0) {
 		fll_div->theta = 0;
-		fll_div->lambda = 0;
+		fll_div->lambda = 1;
 	} else {
 		gcd_fll = gcd(target, fratio * Fref);
 
@@ -2858,7 +2858,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 		return -EINVAL;
 	}
 
-	if (fll_div.theta || fll_div.lambda)
+	if (fll_div.theta)
 		fll1 |= WM8962_FLL_FRAC;
 
 	/* Stop the FLL while we reconfigure */
-- 
2.20.1



