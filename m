Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CAFC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8165720773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599059349;
	bh=T2xuNDe/mQvJNEoHtYHkEv7VKzb9pmqoEh8NDwVB0KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qSUJPoc0VdH2pRVmqocoxKFJJlRablW1P6e+ed+/rdCBapIYKdk4psJ6aH4dzFmQO
	 FCQF+rkD+ehr9JlgOR3OaHU7xNf2Ya/54+aKnNr5h4uo5hq2SaVNKyYFRpf/iL0T0L
	 vmB+19vNu88QY/yJTLHPztj5gDlmDDI8NL7u/JfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIBPJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgIBPHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:07:41 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 168832145D;
        Wed,  2 Sep 2020 15:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599059261;
        bh=T2xuNDe/mQvJNEoHtYHkEv7VKzb9pmqoEh8NDwVB0KA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cy4I1bg6mFyZCwbFGVjTQLZBoAzSaYbEpWNkFwDU4ONqghQ/Hy87a/INzvBR8Dom9
         sQB2OJA+Ux8Fcqd3TY/kqt9KuqjIcKETNePqmwQScIGQSLbAVVO+30eM1QrdBSchjT
         dr66gUrD76qnWkcWACPmmwMsCGGEQxuWuzF7PXDU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Michal Simek <michal.simek@xilinx.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>,
        linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 9/9] i2c: mux: reg: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 17:06:43 +0200
Message-Id: <20200902150643.14839-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902150643.14839-1-krzk@kernel.org>
References: <20200902150643.14839-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index b59a62f8d7a6..0e0679f65cf7 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -171,13 +171,9 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 			sizeof(mux->data));
 	} else {
 		ret = i2c_mux_reg_probe_dt(mux, pdev);
-		if (ret == -EPROBE_DEFER)
-			return ret;
-
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Error parsing device tree");
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Error parsing device tree");
 	}
 
 	parent = i2c_get_adapter(mux->data.parent);
-- 
2.17.1

