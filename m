Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E202C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3C120746
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="IONh+Dpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgEKPI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730229AbgEKPI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:08:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AAEC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:08:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s8so11414359wrt.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75HMiSxkO2iGkQyQ4GVIN4XRI1pdsKTRs1XUFo380Tg=;
        b=IONh+DpnmejFuXALAwr/I/OjxLG9/eNbjfLpyONcGQibovX8pI46VIZgC9xXwCv98H
         Ky9NUKjT2vd6Ug4cS8NQuuG/ijvNN86K2vpP/v5IdxeXFOrdi9TwLnprkwDDJXsKFnuw
         /vRoJJX2IslmnZxnrfWaBBRCyW1JbduGoxT58Yx/n3jOInNrLcgpirPWOVnp07i32Q7+
         vjHPKCdqY5TRz9Krgcho0oar/Ep/f5M5qDpMJgBk88UWDXbKxzhxsOeSaIA8vbRlD2Eo
         XUzGSDPMVx702v2gEp1ifsTebqSwhxEbem43H0bhsSH+4P7qfxv5J+IWtyUaPlnHxjuF
         Fq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75HMiSxkO2iGkQyQ4GVIN4XRI1pdsKTRs1XUFo380Tg=;
        b=YX/CMlc9Sl7ss5/yc5aEz1/1xoMOEUD1W/8PUUTEU7IYd1iCysb+qbdVDcDWwN5ybv
         Z1WqTObR0TtKhapm78y8aSM5ipIfTO4KxM3IRS43yZWX8gjEQPY02aM4tTCeeS22lpjh
         ceuBKxYeg9O2PbX3WqhaWRWIVPRBOOKW8S1uDugQawvd0Z0jcCuzrUH5YCP0u9ee3vjs
         bPq7BiSPWFfvrP8AG1aH+sw4Rm7R8w4gQkQly0mCoFr0ozH0J9WdO+c4IOfcOkw4Fsc2
         aFshQ3kdrpLrxJE3vLg4JYDg4JH+961KrOIkmqFL8BG9/2a+ymoLPEDB4sneq1im8upQ
         r8TQ==
X-Gm-Message-State: AGi0PuZW96U2KVzyHj5T1OI+wfBH9w2nguFFl7+YbmdUTRmOLt//Sm9d
        26iMPv1uTVXZQst/OKm6LoEPVjU6RXk=
X-Google-Smtp-Source: APiQypIP0Bn3KOIOBxC1UBNqcqDai8qWfKN8IcFL5zqV14Hb8VXZDCZKqkzaVDqG/Ivki43uegY3ag==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr8322148wrp.427.1589209705382;
        Mon, 11 May 2020 08:08:25 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id 94sm3514792wrf.74.2020.05.11.08.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:08:24 -0700 (PDT)
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
Subject: [PATCH v2 04/14] net: ethernet: mediatek: remove unnecessary spaces from Makefile
Date:   Mon, 11 May 2020 17:07:49 +0200
Message-Id: <20200511150759.18766-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200511150759.18766-1-brgl@bgdev.pl>
References: <20200511150759.18766-1-brgl@bgdev.pl>
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

