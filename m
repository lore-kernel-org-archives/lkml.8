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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0679C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB4A7206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSNgL22m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHWWAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 18:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgHWWAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:00:39 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C631EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:00:38 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m22so7467672ljj.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B7cJIHsSvb5hbXVJfJh4y83titz5j9Tbj6LXlECxklc=;
        b=ZSNgL22mr5vmLGoMGbgOWCD6cZ3ZwXkpm/JkGbh1eWDXk0jYGEqeWeG9O0d/79WF3P
         XrpjSqnEMxxDjQjA8/fmfEom8sghKgVTEs0QfJYyFDa9sOBeSDNFAQ9EVEtOwsiJLeBm
         i2UOSvcOux5D9oVmHRmGsH2vrtE0qgUoxWygOelWljyCnyopGz5E3mOaCDcxNzSZpElg
         h54Rj776ZdvjUjYGDktJb+oAyCVWHH/HnSE9sSd6QYYat/dJVQB7cRsUN/1XkweXATxg
         3Fe4RpnW2bVPTc6Ui8zoz/gIYTr1ApjwXN24CVsrpZLPrwZQc3ZbuQJir3k75hHYHeJ4
         JF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7cJIHsSvb5hbXVJfJh4y83titz5j9Tbj6LXlECxklc=;
        b=OfgZgohiumCxVZRG5Zv17czxlP+KXP36lewZ0dFTin2/mdfovdDDiP2LjShPO/RnbN
         Uz+ggl/Z3/ROcg2BXdjrUMzWmrF0p1zVBk/u1HYmPwIqVR83moTxj/3Xz9hDBSVer/zC
         +ZniGer+eD7NuipTXxRGIJd8LjDpyWuNpv213aiQH1KvSBm/UkfRg6KctsBmeeAm8hw/
         ZdMM57op3LS6LjjVHJolwXrV2vlK5/u/ctBnaN+mQC7Rr9D43oem0tsq5WMQnZBxdN2l
         iXY/p4yzE9gEu/1n22+GUukE0/Ey6A4xDLOK/6hPObhn1+Xaex2aP3zTqz9FYe3vCkoE
         gssA==
X-Gm-Message-State: AOAM533fFLUkYQacv/98l2MnYLKnz1pHCygqh5e//B1SfoA6OWEjOfWm
        jGnkiLhIBzPSlUM+/LFop+E=
X-Google-Smtp-Source: ABdhPJzP9XMh13FRNLkRGG0952W4JFU6O7z0y3Icgo6PwjR29LlVstTtANJnkti6VkKa8nCilT5fnQ==
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr1366822ljo.286.1598220037261;
        Sun, 23 Aug 2020 15:00:37 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id g11sm1825097lfc.46.2020.08.23.15.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 15:00:36 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 1/8] phy: cadence: salvo: Constify cdns_salvo_phy_ops
Date:   Mon, 24 Aug 2020 00:00:18 +0200
Message-Id: <20200823220025.17588-2-rikard.falkeborn@gmail.com>
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
 drivers/phy/cadence/phy-cadence-salvo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index 016514e4aa54..8c33d3215f2d 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -251,7 +251,7 @@ static int cdns_salvo_phy_power_off(struct phy *phy)
 	return 0;
 }
 
-static struct phy_ops cdns_salvo_phy_ops = {
+static const struct phy_ops cdns_salvo_phy_ops = {
 	.init		= cdns_salvo_phy_init,
 	.power_on	= cdns_salvo_phy_power_on,
 	.power_off	= cdns_salvo_phy_power_off,
-- 
2.28.0

