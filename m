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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8EAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC58620724
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V74dtCU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHWWBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 18:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgHWWAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:00:42 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4235BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:00:42 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id s9so3443831lfs.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PVkKQ+rBkOrviFA3gyJDGe3unI5VCeDUb05QjWVQmnI=;
        b=V74dtCU0eEAN3ERAydHkgKWbp5GZGVVvfixyfJju2k5H8XyjMLhtzNlH5lMzSnpi33
         gtRboKHsNW145qboKAoBOuSEpiIUlbx6r71mgXKyZPrCF/xcJqdJQvBes4FXmMxuEmjZ
         kz9cSg9R9PfM1qrFNFg7PNcxb9ZnBrP1G5XX6umZh/35RTfFsYbULBzVVLGr29EUUKvC
         sN3KjHVzfLlHRZyjmiVBo6kY3tFIwqmtGSg/PBtnsHp5ZF5tY5wxiBBfPuQs+WwPQDmi
         C8LWzS9nXU68W5RfJMl7JMZejiVch1fNL9c+6NTmrpsIxwIMkEcQsOU2P+6RoavP6fyN
         biEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PVkKQ+rBkOrviFA3gyJDGe3unI5VCeDUb05QjWVQmnI=;
        b=WSUpCCGm9uK+SU7woLhMd4FOqEwNeZPwjtwF1Pntr9DEP2yoicDhTjqjaGHaAiQbDd
         QYiCnOwRbJJ1WscALbLLVQQkBhK4PO6/m124P3OdHisQIQmntsXpXEbc7dGbXkRwRmlK
         9XZiv1ZIMtKGkys8iZbqtd3S09oEwntT9vKKOoB8xa7kM2Hpz2Dg/gtl03ScjMKkqmgc
         lV/DNr2Zz+1TsHEcOAIS45yX8Yr2HEamXPfSS/7nnRy8Zfjpl5gN+njWEheJUFXdvDbY
         GAqxbyCzAzeZqpTUmqrEc6xtCTmbUC/N2niGHt2edYnlu72aXFX7yH69cJhcsohOlBmW
         yYZw==
X-Gm-Message-State: AOAM5339bkZqO6uIiH4zfeWXu2uiA9ifp2/XmkFS5yvZ1Z5fMzQvaWRd
        3Jj3xZiznwFQF3Ppc0Wp2n0jjAEpxPcXsw==
X-Google-Smtp-Source: ABdhPJzG/XAjhe2FmDDt3Xi+XmG4WtjYwzHMOd+o5TVEG9CgwbINbxgb2XPhr5aW0L7oRU4qUL2OGQ==
X-Received: by 2002:a05:6512:3e8:: with SMTP id n8mr1209460lfq.210.1598220040768;
        Sun, 23 Aug 2020 15:00:40 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id g11sm1825097lfc.46.2020.08.23.15.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 15:00:40 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 4/8] phy: lantiq: rcu-usb2: Constify ltq_rcu_usb2_phy_ops
Date:   Mon, 24 Aug 2020 00:00:21 +0200
Message-Id: <20200823220025.17588-5-rikard.falkeborn@gmail.com>
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
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
index be09b1530ae6..a7d126192cf1 100644
--- a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
+++ b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
@@ -141,7 +141,7 @@ static int ltq_rcu_usb2_phy_power_off(struct phy *phy)
 	return 0;
 }
 
-static struct phy_ops ltq_rcu_usb2_phy_ops = {
+static const struct phy_ops ltq_rcu_usb2_phy_ops = {
 	.init		= ltq_rcu_usb2_phy_init,
 	.power_on	= ltq_rcu_usb2_phy_power_on,
 	.power_off	= ltq_rcu_usb2_phy_power_off,
-- 
2.28.0

