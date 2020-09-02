Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC9AC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B8620773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599059095;
	bh=FNfm1tmiP1SHAfynJEL7ATFOXsx4dnDu44NKhojfEPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mbt3oPmrOrRckDWVqAE/qpqFHz/T4f3Bd4u8bzGI7dWcFOv3ECPxNmk75taXtJBpG
	 uVpll/A+Y5RkObRyOslb5vDxB4u3idTO1O3AzJBTDJOwfq7BX5DgXzfSyqriMM9ffE
	 oSxG6mUlnrsYOm8iyglw9JweiYHodbZ1nE85T+J0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgIBPEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbgIBPEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:04:30 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C637214F1;
        Wed,  2 Sep 2020 15:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599059069;
        bh=FNfm1tmiP1SHAfynJEL7ATFOXsx4dnDu44NKhojfEPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQQX60L2h/dw5HVupUkQlD1zgBiZVmY6Sewdlbk4yzSvBYGknX6upVlBsPtmbqrRZ
         jYdpNiDqbblahHoEMcAbKX1i+FaDn89u0TwxJUpqxr9gmf0BrxEqDntza3h6uxJtpX
         xImEZhMVLadjoDGFhceFvcH+ssVbmoKBO7PFUxuU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 07/10] clk: meson: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 17:03:45 +0200
Message-Id: <20200902150348.14465-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902150348.14465-1-krzk@kernel.org>
References: <20200902150348.14465-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/meson/axg-audio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 53715e36326c..dc22b0c45743 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -1509,12 +1509,8 @@ static int devm_clk_get_enable(struct device *dev, char *id)
 	int ret;
 
 	clk = devm_clk_get(dev, id);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get %s", id);
-		return ret;
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get %s", id);
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-- 
2.17.1

