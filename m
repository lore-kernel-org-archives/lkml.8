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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D60C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FE020724
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as+53TFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgHWWBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 18:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgHWWAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:00:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A751BC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:00:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v12so7457568ljc.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gjrzodt6fBD8RB4wFRtbeU8eetdbh6wPtgtlByTKAf8=;
        b=as+53TFFNT6fihPBDkvzycxenFTKDCvg/t5zgGUdrj7EmKaFY0mRkqhXN8HyCpmVnR
         1CRlCO+L2RmEnm7ZwS027ylSeRTFTs8f5rOKwgPzZEl5R1w/YaW5RRB9Ml/u1a9vwb4n
         +8sX8Muojm2bVa1WcxYMHe7oEq8Z3TaWTPzXGywwwiIerPbxhQ7rULz9+2t3Urma97ek
         MCOsLuHD5FyrWrdFKvLQyrIUw5WMPPLpXnpLbFdGh4vpo0Zc0FAs+bgg89Qy9QV8CS+x
         TttQ0tHR7JcprmA6cHWFe1qTJf+fAj2jmytyM4e3vBFBTy0+/cP3ylE8LRP6TUA7PxyR
         Ccvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gjrzodt6fBD8RB4wFRtbeU8eetdbh6wPtgtlByTKAf8=;
        b=HTdd0laJJOuS69b7ADUty9KTwdHQ86tA5u1okmw400IpaptqME+bScHhx8oqjhs8/9
         ZeAm98d0vY7CV9Ly3iErLcrYqhKcnNF87UzeFZjncQlUon6dMycfpJWk69B3O9oICjMk
         UnR/3BfJLWtFmONXYygHeKbuO1AnGsdnGF6A4qT7Mj8yZU33mmUvjQOpDNW5AFJVOa6G
         Csruy8WLlns/S3xOFy1yi95ZrdLtSazk0h5tApG5pL9QswvV/oOd467okDlGisijnjtT
         4dvMkEYCyDKd+PZXXLwA7VFB4yCe5bwIH1Lo+27pJAxTM2QscSYm7o7WSDzq4NMmhc89
         Fw6A==
X-Gm-Message-State: AOAM532issj/6OLUZylOnZd0p+9yC7YbMFwzsq08zM1RYfmzXhLSv2xJ
        xXATxNAnhNvzsNkDFHpDcaQ=
X-Google-Smtp-Source: ABdhPJzGiRO1GRRvF/rlUNa1IL1wepwklaQsNYb82stkr77aXlw/KDLHMf/qFNdf3NmX/s7xqTQgyw==
X-Received: by 2002:a2e:9946:: with SMTP id r6mr1308164ljj.127.1598220044134;
        Sun, 23 Aug 2020 15:00:44 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id g11sm1825097lfc.46.2020.08.23.15.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 15:00:43 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Seungwon Jeon <essuuj@gmail.com>
Subject: [PATCH 7/8] phy: samsung-ufs: Constify samsung_ufs_phy_ops
Date:   Mon, 24 Aug 2020 00:00:24 +0200
Message-Id: <20200823220025.17588-8-rikard.falkeborn@gmail.com>
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
 drivers/phy/samsung/phy-samsung-ufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index 9832599a0283..dd9ab1519d83 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -268,7 +268,7 @@ static int samsung_ufs_phy_exit(struct phy *phy)
 	return 0;
 }
 
-static struct phy_ops samsung_ufs_phy_ops = {
+static const struct phy_ops samsung_ufs_phy_ops = {
 	.init		= samsung_ufs_phy_init,
 	.exit		= samsung_ufs_phy_exit,
 	.power_on	= samsung_ufs_phy_power_on,
-- 
2.28.0

