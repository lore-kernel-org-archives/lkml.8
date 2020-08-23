Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540D7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E35620724
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTg+E2yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgHWWBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 18:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgHWWAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:00:41 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452DDC061573;
        Sun, 23 Aug 2020 15:00:41 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v4so7491618ljd.0;
        Sun, 23 Aug 2020 15:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPZuS7I229v2rKOhfu7+ce1NyRVmKq/AHQWhLmKujP4=;
        b=cTg+E2ydKwcInMKpR3G8waBqOeQXI6b1Yvvta+Aff/dHc+qAKsIsTPfqYLMlS+DLBg
         GNdqdoI/vH4LiNMLjydYF7KzB/wXahqqqgvQEWf9JoKfak3xmNVrhw19wAc2Uuq3A+RX
         aHpcavoIsaplGXjKD6f+V02r7I77Q7rE9o4XKPTFEPi8VTw8ONh3c6r+jJ5vC2YIM630
         woojk/MX4HurR2SV3ob99fpskXGJ0s4Mdb6QJntTl71cvVc4VYjEJbfWFBvn100uGCJA
         Sx+/822CRvMQQ+dHNC5fnc2BzzmnBTnPZIgrcNniiuvLtE1h9McsCzN6/+lpZD9sdTtr
         U7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPZuS7I229v2rKOhfu7+ce1NyRVmKq/AHQWhLmKujP4=;
        b=d0sjdbFHdQHwSbllG5gM406uByqoO4BF4Koez7tQRE3Zm0fQrSAeV2dyzoBfd9bpDV
         JbXye5s6FJ7VnCoPV9W6qNFJeEn2b4UK+LITkw6TIT17P27wwpjsY3WI/5yj/lHorQrT
         ZuuA/5N/0dYaEYpf18R6Wf8xd85psRTpSy8UHqPyhL1POEHvuZ/ZdPPJeqomG/jOSp9H
         9LJRcdG/ikQO55iAcv+GgeVV4XONZ+KFyWFY0MBJU9lu/Lpw4h1pLyKnLZG+Cb7T8x8H
         OQPTVaJIHwk04FInV6SBtAES4qzhUphSHejh/1dwScSk+8219qfvYEuTLvF6xEPO9UDW
         RzOA==
X-Gm-Message-State: AOAM532UoGotd+t7+JszYETT9U+qie9amQrWqUby6mhKrPK16yD9Skxh
        DFQs7C7N1zTE+SJgQg/nZ10=
X-Google-Smtp-Source: ABdhPJzW+lVIxAbZZMzVpx99MwYlCHKd16McQ4UG52nPDjpInTQMoO8aRibYEin4DYIWm20b6dWQFQ==
X-Received: by 2002:a2e:87cd:: with SMTP id v13mr1406397ljj.180.1598220039776;
        Sun, 23 Aug 2020 15:00:39 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id g11sm1825097lfc.46.2020.08.23.15.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 15:00:39 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Yu Chen <chenyu56@huawei.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 3/8] phy: hisilicon; Constify hi3660_phy_ops
Date:   Mon, 24 Aug 2020 00:00:20 +0200
Message-Id: <20200823220025.17588-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200823220025.17588-1-rikard.falkeborn@gmail.com>
References: <20200823220025.17588-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage is to pass its address to devm_phy_create() which takes a
const pointer. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/hisilicon/phy-hi3660-usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/hisilicon/phy-hi3660-usb3.c b/drivers/phy/hisilicon/phy-hi3660-usb3.c
index cc0af2c044d0..84adce9b4277 100644
--- a/drivers/phy/hisilicon/phy-hi3660-usb3.c
+++ b/drivers/phy/hisilicon/phy-hi3660-usb3.c
@@ -161,7 +161,7 @@ static int hi3660_phy_exit(struct phy *phy)
 	return ret;
 }
 
-static struct phy_ops hi3660_phy_ops = {
+static const struct phy_ops hi3660_phy_ops = {
 	.init		= hi3660_phy_init,
 	.exit		= hi3660_phy_exit,
 	.owner		= THIS_MODULE,
-- 
2.28.0

