Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFDEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A6B2076A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgFONWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:22:40 -0400
Received: from thoth.sbs.de ([192.35.17.2]:54459 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730380AbgFONWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:22:35 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 05FDMVd7008842
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jun 2020 15:22:31 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.53.252])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05FDMT0q009427;
        Mon, 15 Jun 2020 15:22:30 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: gpio: pca953x: add nxp,pcal9535
Date:   Mon, 15 Jun 2020 15:22:28 +0200
Message-Id: <213b571eda0ac65a2605df83e60fc20a9b37070a.1592227348.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592227348.git.jan.kiszka@siemens.com>
References: <cover.1592227348.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

The NXP PCAL9535 is an extended variant of the PCA9535.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Documentation/devicetree/bindings/gpio/gpio-pca953x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
index dab537c20def..3126c3817e2a 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
@@ -19,6 +19,7 @@ Required properties:
 	nxp,pca9698
 	nxp,pcal6416
 	nxp,pcal6524
+	nxp,pcal9535
 	nxp,pcal9555a
 	maxim,max7310
 	maxim,max7312
-- 
2.26.2

