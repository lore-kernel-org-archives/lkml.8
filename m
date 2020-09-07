Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A460C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0563D2080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FSI2tvGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgIGRxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbgIGLWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:22:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD338C061795
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:02:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so15360973wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=njSxaAkrShaev6nBmwWk4gz2+gzrgoVD7cG8Ur2KLZY=;
        b=FSI2tvGbCDcFLdRpiiybbNb4UiGRnVNftq8LrfnfRDbZB0bgyf9asszI7O09fQtHf4
         9KfwujbHAzz7fG/ok96HkfFth+HZM/ApW1FO6/B9kQbkQkV36nEJusYnj617lJqxXJ7J
         nuC3hhNe1MSis/mQWPeplAsiol7hpWBbi/PtTWjHqgzMSP5C/ZQLXxBoJDcSAgahQqI7
         sUb5+pokelyqRhxVA7pNdJ3zigIsU0tv8VOwKEKykD4t0X/cbP19ikXXORFNMyv1QdaZ
         6tDxptY4GLT04g1szxXUxU+VVoDoh9alnas+CpU1K8xynXhimcfV2PwMiyZPW1QoAve+
         lgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=njSxaAkrShaev6nBmwWk4gz2+gzrgoVD7cG8Ur2KLZY=;
        b=rEZ0xmv5Pi2fbsyACChOq7TqZNTmJmhBJph0priEFPRGDl+ZQgLfJUjRGow9MG8zTY
         5t3gxSpkLb2kXkh4KihNQ+/RPcoJZGezFTPmo76h0gC7KkIOjLNPhIkJxUiRUr4MsouS
         O6QbqQ4n+9xlyfjJa0kKd1TqaIaOeYAEk7LKn059uiYSc5C1mLUB3IT8DbIhoAgvz5cU
         QVHiOqJtKB5AV33zs7N9BcJYG2otvzhflOIjRZh0lk6BYWEFPVvhK2rZeNff1hmeDgl4
         pfgdyjwzrDCWJysWteNL+vsRpRUmX/ObxabRKccCUG+ExOFJM0lmh+Zb9z2Ka7uwSXr/
         Sq9Q==
X-Gm-Message-State: AOAM530lWn8DK8YQ4nmwlaBXrkJ6t7c/vBLWPo0U7VcoCoKjCuGZnc01
        x+6HQLI9q6ce3THUytbluH8VJ/T9ltlykg==
X-Google-Smtp-Source: ABdhPJzOyuMiOAWKozCxyMN8m5sL4WTHm2Ix5ZGgYp4lsJ5S1lIv8ykGUEEGNH299l5r2VPmDA+mgA==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr22168295wru.326.1599476546279;
        Mon, 07 Sep 2020 04:02:26 -0700 (PDT)
Received: from localhost.localdomain (122.105.23.93.rev.sfr.net. [93.23.105.122])
        by smtp.gmail.com with ESMTPSA id 2sm28909545wrs.64.2020.09.07.04.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 04:02:25 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        linus.walleij@linaro.org, sean.wang@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/2] pinctrl: mt65xx: add OF bindings for MT8167
Date:   Mon,  7 Sep 2020 13:02:20 +0200
Message-Id: <20200907110221.1691168-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of pinctrl-mt65xx for MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
index 205be98ae078..931a18cd1e23 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
@@ -10,6 +10,7 @@ Required properties:
 	"mediatek,mt7623-pinctrl", compatible with mt7623 pinctrl.
 	"mediatek,mt8127-pinctrl", compatible with mt8127 pinctrl.
 	"mediatek,mt8135-pinctrl", compatible with mt8135 pinctrl.
+	"mediatek,mt8167-pinctrl", compatible with mt8167 pinctrl.
 	"mediatek,mt8173-pinctrl", compatible with mt8173 pinctrl.
 	"mediatek,mt8516-pinctrl", compatible with mt8516 pinctrl.
 - pins-are-numbered: Specify the subnodes are using numbered pinmux to
-- 
2.28.0

