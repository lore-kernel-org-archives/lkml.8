Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF66AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1332071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JaPBL52s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgFVJlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbgFVJla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:41:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7EAC06179A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g18so6882044wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mOzBIeRVdsbICiHu3pBzNsfTlUAFWbCE1cSbRbG1tJ8=;
        b=JaPBL52s4sikmFvHY2AeWFMdnIt4op0dMdw+2FQiSixTq4d3+bBSRsdwR810I4r17W
         Dc1Sq8XgKmuI3/9qeQSaRigNEUtgpr3V54J04DIfxrMUrogAvx9GOjtxzTIREfdMQfH/
         ZIoRTVgzdEw7FUgW+wJfkmEOOAhCW69U1CPS7FhzT/GuIAsc5CiRXTTEG/mAZov3cV1/
         Kw2v4DduJlhcgiBk0rJIlyn1FmnjOS6Kg1a7IMwNMqUETbLfpnIxgx6hHvx4LD/zZ23w
         MiFdp3RuROPF6Vz8gGOhgj1XQ/lErO7eajC9HU+kNQCI4qgh6cJgSRDclHcQ/M0Q+ZK0
         akZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mOzBIeRVdsbICiHu3pBzNsfTlUAFWbCE1cSbRbG1tJ8=;
        b=l8vDxFRLKVwB2iN9tnQi2DLeLokeQb46E40HdRp4S8pRKP2H4wJ3n1bD+dtPTIEvBj
         Uf3SxcbSepRth61EzQxz84aZEogrlngoouC7iY1xMCOARYB8d4QfJau15MwT/5wjqKhb
         ViU14Cj4n3anDMXciYb6GdUT/h0EACefyQt5EvD/uUJ2FlVH/Rv4FubKrfZzW2a2vbz9
         2O2dlNKEqGpAvuTygD70L5T7aRTGQ6RED42dOP95UO4hok9MI1Km5YgSXZX8jpSEcInd
         mioXjeraPimIbWN0IBDq4309jqGqejocRAjPOacI68ObZt4lIh+EikX4LVzCEaaEswal
         o2lQ==
X-Gm-Message-State: AOAM532CpH3AyHgEKhbp8fBlJ5E/MoHypCmhTbdrbsSwyfJzRWDPa+gK
        PzCjJ9WFlA70z8n8cVBOqVrGuQ==
X-Google-Smtp-Source: ABdhPJxEiAeVa66A6smNF2oImo2X8TfJpMFC5Ia7rzUA6Mu5ujbCfk8T+XkaVik5JQL7C6EsJsyEww==
X-Received: by 2002:adf:f608:: with SMTP id t8mr3023154wrp.308.1592818889179;
        Mon, 22 Jun 2020 02:41:29 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id j24sm14392652wrd.43.2020.06.22.02.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:41:28 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 04/15] net: mdio: add a forward declaration for reset_control to mdio.h
Date:   Mon, 22 Jun 2020 11:37:33 +0200
Message-Id: <20200622093744.13685-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200622093744.13685-1-brgl@bgdev.pl>
References: <20200622093744.13685-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This header refers to struct reset_control but doesn't include any reset
header. The structure definition is probably somehow indirectly pulled in
since no warnings are reported but for the sake of correctness add the
forward declaration for struct reset_control.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/mdio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 36d2e0673d03..9ac5e7ff6156 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -17,6 +17,7 @@
 #define MII_REGADDR_C45_MASK	GENMASK(15, 0)
 
 struct gpio_desc;
+struct reset_control;
 struct mii_bus;
 
 /* Multiple levels of nesting are possible. However typically this is
-- 
2.26.1

