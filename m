Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767B9C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43579207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624292;
	bh=ZX8raDUJKT4l8g1LIpcJWxxJM22a2en8tJQcUCwfS7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bcmWSkfiC0piZjnSAXf6bhLSQk54Xz2SDTIJ8TJftWXHN9xh5y6QmQRgMwXjLEz7h
	 CjQNKdTyVeRnavpY/w0C/pCFg3qZKQ1XGBQjfSig+aVPOES3/GosZacz4Mday4499V
	 o/k9HVO5hG5JGRJwqMxKudfjvg7Lz83RyArzrFWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgCSNYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbgCSNYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:24:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC310207FC;
        Thu, 19 Mar 2020 13:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624288;
        bh=ZX8raDUJKT4l8g1LIpcJWxxJM22a2en8tJQcUCwfS7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqbAL5BFm33CPp9SAEehazLQjAkFQfeXSl31fnm52W+SjTCca7iz7TyqBfjNtmx52
         c2BP0ddDtaFUd9UyFmSXK9s/sglANqKlgJSzTH/mWr3SXaZ4x2NldMmaEz4zVAcAp+
         SkTuoGegV/wTlaBjOdnKgpjcfnHnj732rrxc1Z3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 02/65] pinctrl: qcom: ssbi-gpio: Fix fwspec parsing bug
Date:   Thu, 19 Mar 2020 14:03:44 +0100
Message-Id: <20200319123927.198953416@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123926.466988514@linuxfoundation.org>
References: <20200319123926.466988514@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit f98371476f36359da2285d1807b43e5b17fd18de ]

We are parsing SSBI gpios as fourcell fwspecs but they are
twocell. Probably a simple copy-and-paste bug.

Tested on the APQ8060 DragonBoard and after this ethernet
and MMC card detection works again.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: stable@vger.kernel.org
Reviewed-by: Brian Masney <masneyb@onstation.org>
Fixes: ae436fe81053 ("pinctrl: ssbi-gpio: convert to hierarchical IRQ helpers in gpio core")
Link: https://lore.kernel.org/r/20200306143416.1476250-1-linus.walleij@linaro.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index 73d986a903f1b..3059b245ad2b2 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -794,7 +794,7 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
 	girq->fwnode = of_node_to_fwnode(pctrl->dev->of_node);
 	girq->parent_domain = parent_domain;
 	girq->child_to_parent_hwirq = pm8xxx_child_to_parent_hwirq;
-	girq->populate_parent_alloc_arg = gpiochip_populate_parent_fwspec_fourcell;
+	girq->populate_parent_alloc_arg = gpiochip_populate_parent_fwspec_twocell;
 	girq->child_offset_to_irq = pm8xxx_child_offset_to_irq;
 	girq->child_irq_domain_ops.translate = pm8xxx_domain_translate;
 
-- 
2.20.1



