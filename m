Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF8BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7571208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599059119;
	bh=+N6q1YJgfkLs8EZM9mxvvQccXncnvw5Q0C+jLti0f9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rzEqKjVKixzkHmA1nZLTdBIdGiRPoE99LyU/wbpsLfuWcXgjK/aOrdGT/5glawD3I
	 Sa6OlCzBPpaCFThhBRIDUcobpb/8GbVGWAwtFOLmXjvE++Bhospe4F3GQ21PcSNz2l
	 D3xC8CgOoD/Wg4lvStGpej6bjfb84gzleTuHrwT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgIBPFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgIBPEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:04:40 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A09C2098B;
        Wed,  2 Sep 2020 15:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599059079;
        bh=+N6q1YJgfkLs8EZM9mxvvQccXncnvw5Q0C+jLti0f9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6VLW4pm2GPNyHbS4iNQfaHzhq2l4iShqkdD6O+gMRV+p6sKZrdwT0CLLT2+8JKZy
         vX/wSJUSvsLizhnOLPNqGK0FaV6rc4qi3qcmGvoos8abQFlsrjcwymQvFOAciinCnx
         IVWrf/nJ4MvpgxCEfacGOCV8FjzYUHjtiZ8ogPSE=
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
Subject: [PATCH 09/10] clk: davinci: Add missing kerneldoc
Date:   Wed,  2 Sep 2020 17:03:47 +0200
Message-Id: <20200902150348.14465-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902150348.14465-1-krzk@kernel.org>
References: <20200902150348.14465-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing kerneldoc to fix compile warning:

  drivers/clk/davinci/da8xx-cfgchip.c:578: warning: Function parameter or member 'dev' not described in 'da8xx_cfgchip_register_usb1_clk48'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/davinci/da8xx-cfgchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index bdc52364b421..77d18276bfe8 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -571,6 +571,7 @@ static const struct clk_ops da8xx_usb1_clk48_ops = {
 
 /**
  * da8xx_cfgchip_register_usb1_clk48 - Register a new USB 1.1 PHY clock
+ * @dev: The device
  * @regmap: The CFGCHIP regmap
  */
 static struct da8xx_usb1_clk48 *
-- 
2.17.1

