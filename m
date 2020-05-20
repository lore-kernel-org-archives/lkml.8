Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20239C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4EF20758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1u1GCCM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgETLZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgETLZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:25:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA97C08C5C4
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:25:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l11so2794687wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGk6SHkwZ0/IFFGnE1iOAP01F59WjRCQF/3H+v3exE4=;
        b=1u1GCCM5c2bb6qe8/N+8q+djj3EHhrgKlG/lCEqSBMbFDOv7cQzuicnqTk22ujLZQy
         XOYPOEuTzeKhoYE02Lkd9aWAYQ2h1yx2ieqL21zBzokQqE5kxB5HjTKsiP36oSzvpEJH
         ffn/2YDsVdgjkZTdQY0NV+IN5rZ10d7VOBYfLqFF/K6J7Ae7qR5jIqeyN23WPXOZwoDl
         0hOl7ks9rQkTYmlrNpkx2U/kuhA8YJWIqwnGfeIXJZ48kChLVMF/yL1KbFO9HTiB/htH
         SFCG4OXKsl1FInWE0Q3VDWBkVRTcIJIExlxnygAuBOXjyz6wlJ41PGSP9LTTQDmaQusR
         yPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGk6SHkwZ0/IFFGnE1iOAP01F59WjRCQF/3H+v3exE4=;
        b=gwv7A6eBkS4v+cs1c5wnydiNmpbAcGdhRzPA5Vt5if6la1K66ifxSaRYpJa+tybOvP
         5ondu3VDwQrmTja8mErQRI4CijGyBZSf3AU9B7TAi1oZaUseERA5ZDm+Ghm2mpB+RZPV
         sSqQTriT3OX8dq7cu1sQ0wHbDYZUqnMSdbYkJXv3TbTmYF/ItuOoe1O/+lYniu4R1V0U
         /5zJ3NR8+a98MoYMr3O1/BjWg0jZUtcfhBVj3fX+QHo5l17W1XyNfAdEU2nNg/gyNylJ
         x6d5ZMeXml5uDnkaJNN8Daci0dsPGwrD8jWkrAw9qgle2SHGETtQW0Bw+84BwoSIaHbv
         tqyQ==
X-Gm-Message-State: AOAM531HHgAeGYDCdvWsr6YRir+7lMHt4KhynLwa8zcrjFC4Z1UqOphw
        dOsKNirFGUUO2V5z7X89TxWhtg==
X-Google-Smtp-Source: ABdhPJwPv1ax+P99yWCKiaCy0kws5G6OxIcHrZdun4qt8M4YjOs6PnOFsrTm5BaB+LGdlSH65WIKPw==
X-Received: by 2002:adf:dcc8:: with SMTP id x8mr3742481wrm.404.1589973937274;
        Wed, 20 May 2020 04:25:37 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id v22sm2729265wml.21.2020.05.20.04.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:25:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 04/11] net: ethernet: mediatek: rename Kconfig prompt
Date:   Wed, 20 May 2020 13:25:16 +0200
Message-Id: <20200520112523.30995-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200520112523.30995-1-brgl@bgdev.pl>
References: <20200520112523.30995-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We'll soon by adding a second MediaTek Ethernet driver so modify the
Kconfig prompt.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/Kconfig b/drivers/net/ethernet/mediatek/Kconfig
index 4968352ba188..5079b8090f16 100644
--- a/drivers/net/ethernet/mediatek/Kconfig
+++ b/drivers/net/ethernet/mediatek/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NET_VENDOR_MEDIATEK
-	bool "MediaTek ethernet driver"
+	bool "MediaTek devices"
 	depends on ARCH_MEDIATEK || SOC_MT7621 || SOC_MT7620
 	---help---
 	  If you have a Mediatek SoC with ethernet, say Y.
-- 
2.25.0

