Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D133C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7442A20657
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOqAq+p4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgEPMEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726294AbgEPMEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:04:51 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B60BC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:04:51 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 82so4058821lfh.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZtGNddsPiN40XpfekAEMy+zvEziOJvot6f/+EXwVris=;
        b=WOqAq+p4fEYnMrnBFRNbb/gg7hHBLYyLW1976SzisATeN87t6FUNUcscsMZViHb5w7
         gfVE9LskYO4ZREYaBVq0XkuGz3uFWjcbIO4j2Uhaz/PxXodYtxm1WZxe7qepAC11noTh
         +fZmrcF27ziZh/2VzXbCO/RpOMPELceyKWsiJREkBaBwxPD1Gs6mJwZy7ykBG/+OXCqN
         tY2u0M56yozEVIp3m1JLd2nBNdwwnT58j6zdd/MRSlO6105cRul2mMYm9iJsHvUX1waC
         fx+ZNt2/BwayjCnrj8c28UKpxwt0vDRzEsEp93X2nUxh5Kx4voJai3tJEoS3URGiog5V
         UDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZtGNddsPiN40XpfekAEMy+zvEziOJvot6f/+EXwVris=;
        b=Ge5q9MBjQScfLyrhtSsHTD2X3K+LfyZVxGvUK3DQ1HqiN3FjPGlTHem7xX5sHAxcUg
         PQ9Ip3dgxSUQOtinPJGXMeN/qxfPePjVeKupgjSDw0/fIdssBQksObEw8ZC0peM5NJMC
         A0S4dXeVRLIm6X7ROwYT2cBwxXmK6wOCrMyXV4nvN3rO8qlpOeKPD53jPJ3t9DF7BB8L
         uEbRJK/E9zDR6s6WgxGoVuhvh/t84OW2MZD7kmO6Bh71MgFSI/CjDqzWtQ9KnKTsZD2Z
         03eTgO724S0I3kXBVQhpgukYi+T1/oz7C0YzBXk3XCGgOW/xuzKp50EaE1DgdPsJXdJi
         C7dw==
X-Gm-Message-State: AOAM532Uq0QfNFabXS0mf7UVxQqUFBGV4VhUILCO1SLD1oycnnmmerU8
        4/fCbLGrbTZw0BR1rcvSsH98wTsrzlc=
X-Google-Smtp-Source: ABdhPJw0Uncne792FTsTxPW58I0gd+GTxNrxo3+OHukFSapwKTixeEjIfpnEqRgGhfGSwNq18VLUKA==
X-Received: by 2002:ac2:4213:: with SMTP id y19mr5184745lfh.99.1589630689786;
        Sat, 16 May 2020 05:04:49 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id r20sm2581538ljj.44.2020.05.16.05.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 05:04:49 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, alcooperx@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/3] phy: sr-usb: Constify phy_ops
Date:   Sat, 16 May 2020 14:04:40 +0200
Message-Id: <20200516120441.7627-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516120441.7627-1-rikard.falkeborn@gmail.com>
References: <20200516120441.7627-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phy_ops are never modified and can therefore be made const to allow the
compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
   4310    1244       0    5554    15b2 drivers/phy/broadcom/phy-bcm-sr-usb.o

After:
   text    data     bss     dec     hex filename
   4438    1116       0    5554    15b2 drivers/phy/broadcom/phy-bcm-sr-usb.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/broadcom/phy-bcm-sr-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
index fe6c58910e4c..e04be8f52744 100644
--- a/drivers/phy/broadcom/phy-bcm-sr-usb.c
+++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
@@ -256,7 +256,7 @@ static int bcm_usb_phy_init(struct phy *phy)
 	return ret;
 }
 
-static struct phy_ops sr_phy_ops = {
+static const struct phy_ops sr_phy_ops = {
 	.init		= bcm_usb_phy_init,
 	.reset		= bcm_usb_phy_reset,
 	.owner		= THIS_MODULE,
-- 
2.26.2

