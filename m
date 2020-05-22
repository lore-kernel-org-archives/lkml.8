Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2501C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AAE206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="I7AimdvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgEVMHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbgEVMHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:07:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EC6C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:07:28 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u1so8429650wmn.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75HMiSxkO2iGkQyQ4GVIN4XRI1pdsKTRs1XUFo380Tg=;
        b=I7AimdvAZOh1g/UByPwXTG3z06QWyuPRsDF0Y6Dye4Brq8bAXcTR36UrTTrcFRmV0z
         ApTCDxKUugYCbGqBd6jh4pdAjVZB5LNOe18if99Ec/1JIe97HNEOCfXfXu10oJmV6OmW
         9t9TvWm6ZFXkqUfNvBW38GHqf+KiIY4Ck6Bq5FNSeB4KhtkBbVYBv+DU7/Q4cvNK6bT2
         boLjHlkp7E1pzNHDzgB/i418XwGyHKXG/cG9h7nTX2pmZoouvxti476UwfnpJePKI4ng
         bURCFe9jqs2O8IdxAxqztdqMugBYRUqdY248cJi+D+VgWvkQ0FT0ORMOETRpJjaJitXR
         6orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75HMiSxkO2iGkQyQ4GVIN4XRI1pdsKTRs1XUFo380Tg=;
        b=C8WDZVqw8O2MJLWqmtFPXNab6xlyFdPbovEjhCpIl9ozFpKSH3DWiI7D8Q5tzdyH4S
         6EE/coOb760HNEW2lVu+GNmilO6QpVHU7W8jfvraigy54lZzhJCNPm8JYY5p1Upnr3EM
         xOLPtf5CORsqybDOAmST8eDx08QoEKH5P2O+aKmGF9I0qWzwBqOxZEQqcoIkW5740uUv
         q89G/4cHxumG6qWPuI1sN+vK/DUCunA2vE5ihgappyFqed8UXKmpLQrkRPmeIiM+w1sp
         jebhrmld+HJR3SMOyjK/kkxqUX7BlO2Kmw9s4AJkeEGwuQmVKdE02Q7idzNh/TNS8dQe
         Bvxw==
X-Gm-Message-State: AOAM533EfhIdECFdyyxAESh8tDV69rqKXY7If2iyeyl3il6GdkRieMzB
        1z/0Ge7cfCMjMiL20T13TnfMDA==
X-Google-Smtp-Source: ABdhPJwEi7VyHt7K7+omiVssnygbzQxiUSCPmAIEWo/ISCAmaztuxM/ZHSeqf8g+5/jkvW5bZaKWMg==
X-Received: by 2002:a1c:e188:: with SMTP id y130mr14051662wmg.105.1590149247468;
        Fri, 22 May 2020 05:07:27 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id f128sm9946233wme.1.2020.05.22.05.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:07:26 -0700 (PDT)
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
Subject: [PATCH v5 05/11] net: ethernet: mediatek: remove unnecessary spaces from Makefile
Date:   Fri, 22 May 2020 14:06:54 +0200
Message-Id: <20200522120700.838-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200522120700.838-1-brgl@bgdev.pl>
References: <20200522120700.838-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The Makefile formatting in the kernel tree usually doesn't use tabs,
so remove them before we add a second driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/mediatek/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/Makefile b/drivers/net/ethernet/mediatek/Makefile
index 2d8362f9341b..3362fb7ef859 100644
--- a/drivers/net/ethernet/mediatek/Makefile
+++ b/drivers/net/ethernet/mediatek/Makefile
@@ -3,5 +3,5 @@
 # Makefile for the Mediatek SoCs built-in ethernet macs
 #
 
-obj-$(CONFIG_NET_MEDIATEK_SOC)                 += mtk_eth.o
+obj-$(CONFIG_NET_MEDIATEK_SOC) += mtk_eth.o
 mtk_eth-y := mtk_eth_soc.o mtk_sgmii.o mtk_eth_path.o
-- 
2.25.0

