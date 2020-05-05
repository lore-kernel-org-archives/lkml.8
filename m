Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D53C4725A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EEEA20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kvPVV59b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgEEOEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729327AbgEEODK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:03:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAEDC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:03:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so2868042wrt.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGk6SHkwZ0/IFFGnE1iOAP01F59WjRCQF/3H+v3exE4=;
        b=kvPVV59bLwvQgCRXMMdalhwBGJXiNTAb3RXUaXffdzF/CnPAYnbZfbo5XFRy/U6Hmn
         UYDrC8U2QoSOzSL6kGoZRN+trWItJsZE5rzGhy9yuYPhWqlj27+0bcwhKKCOlWh3BJTz
         l98EqUfia2miyFfDeTxIe2M54ZAExtU1gQ4zySphZmhTJmKHOCSN/LRtVxgdZyy0jInD
         wO02lzvY3Qbg7bm454+9uzwwhlluP7XjN3Ti461uWWCrAgdX/Yj4Iw4pSLlI3+6vKsfZ
         1RqRrgrWqUsGXLeFN6IFuiLJoSlwRD/aG0+tqgvGYmGcLsB9nQQPQtqFBO1K/kBh/rYb
         XAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGk6SHkwZ0/IFFGnE1iOAP01F59WjRCQF/3H+v3exE4=;
        b=eN3lgPJXMX+flC3yCw8/k1tdJ0mRo7NbgIKSGrcN50I3KjZ33oyjo/F+UBgI4TNyGe
         o6ipIJjMCcY7HwyR29DrSnODPBfeDmIPDShLon+NIp6h+6PRH3iEH/ShrzYa1+rc5Mo5
         hsj206lXoC3Er6iQwiwpOt1a6uittgek0Iekq7EtlSVmf6XmeborqFxx3ktR77MkZBNz
         A+kawOHjvUbfWuogorKPm4xqNJmko+Gl8Ts4c8b9YfHTXmcOK+oelsXHGHEK0P2YSCvw
         2ydx06UXpivtApiFLXsF16PbooQrue+goTgPvPNr2f65lY9KXlGi8fSdz30lj3aZkOOD
         DzOg==
X-Gm-Message-State: AGi0PuafsPMs9FzXMu3E2NbQDNKOgwU5tRQmFFXVtlBs8kGCYfv8+khU
        mXYU8spXWis3mMQnzVHcN+rpaw==
X-Google-Smtp-Source: APiQypIPk6Gmfh+TOm1lNpI6ui+UW11cc/DzL7lShUJ6Uv4UPglvQgiExWM6SHeIDM9Wlw/jZVJSDQ==
X-Received: by 2002:adf:8169:: with SMTP id 96mr3846446wrm.283.1588687388304;
        Tue, 05 May 2020 07:03:08 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id c190sm4075755wme.4.2020.05.05.07.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 07:03:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Felix Fietkau <nbd@openwrt.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 03/11] net: ethernet: mediatek: rename Kconfig prompt
Date:   Tue,  5 May 2020 16:02:23 +0200
Message-Id: <20200505140231.16600-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200505140231.16600-1-brgl@bgdev.pl>
References: <20200505140231.16600-1-brgl@bgdev.pl>
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

