Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE996C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 09:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9481F2076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 09:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdR8VeUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgEXJzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 05:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgEXJzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 05:55:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895BCC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 02:55:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id o14so17730507ljp.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 02:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZ5rNx2mKHea6ziFpnpByE/+bvm4N/4KCV6x0MsWCGg=;
        b=KdR8VeUTaxaBmMtt74YwPZa9dv1fO+5MfbIbg8qwK3cIv7i6h2+f5LGtYc8bjpsvPy
         sTQbgnSDJXFNhbRgt/NgHg9PYUjnNz9CZwg32ZM7OYb77yyiZeTa3rPOnXRMbLZ5NW/r
         XFSIk20QRo203k5XMticqZe8miywq7VutGsF714/HuV1omTZuxDyUVFCYOdwOQ56gTGd
         xLoqbT+R9GLR8X3Pcv/ZRvdsko7qvQ4DLnzkw7Lvxhet+VJQ0z7q9DZDPWKJXVFzlJy/
         fXGR2m/ddGkrGM8bKPqESObkBiF3ABI9GsKEaaGqtygjhwd4PKcjQY8Cg+JdyqAYpIrr
         uiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZ5rNx2mKHea6ziFpnpByE/+bvm4N/4KCV6x0MsWCGg=;
        b=i/17g8ZVdRxwSCRuEelJhIVysPybzHk1S3k2/2340ksfdM44ZtXn2Sdaah7SLXLORT
         tFm8Rs1TPaf4dLjI5njVZLebDaDgwdRhCFxIkNHzrWheRO2/t9nE6GUKsaoYSzLbOphL
         B3SU3K5tOkRyERgS4gmIW1To5N2tgYPme5EJxn+nedFD++Kz8rL58eSzxyvg7SIhc7b6
         guzc9jDFu4Rtax+89d1eJR9rwm/s5/PtFYvcsMqvTb9xFs+Txm/vD54fRuBtc3ElQldL
         TbU8Imyfbki1zqTyDfQ9pBSb62Er93HeCImUHQqyZXiuvr5aemgyClYNYlWnOhmUjFxd
         m2Ug==
X-Gm-Message-State: AOAM533HAhguvtNOrRHQV7J89XsWe+MBWxa4+SDbZLdr5MM3CEZW/yrW
        zSXfFrhbh6o6657rUvyX6v8=
X-Google-Smtp-Source: ABdhPJxRaljo2ochm3Lm4mSsTCgSrdmFwtxxR+/bQX9dA8t4gL3njOF3kPfIOoNXBWf7UBJ1uuTC7A==
X-Received: by 2002:a2e:81d1:: with SMTP id s17mr11923751ljg.91.1590314135112;
        Sun, 24 May 2020 02:55:35 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id 72sm2153576lfa.52.2020.05.24.02.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 02:55:34 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 1/2] phy: ti: am654-serdes: Constify regmap_config
Date:   Sun, 24 May 2020 11:55:15 +0200
Message-Id: <20200524095516.25227-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524095516.25227-1-rikard.falkeborn@gmail.com>
References: <20200524095516.25227-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap_config is not modified and can be made static to allow the compiler
to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
  12328    3644      64   16036    3ea4 drivers/phy/ti/phy-am654-serdes.o

After:
   text    data     bss     dec     hex filename
  12648    3324      64   16036    3ea4 drivers/phy/ti/phy-am654-serdes.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/ti/phy-am654-serdes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index 0a166d5a6414..a174b3c3f010 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -72,7 +72,7 @@ struct serdes_am654_clk_mux {
 #define to_serdes_am654_clk_mux(_hw)	\
 		container_of(_hw, struct serdes_am654_clk_mux, hw)
 
-static struct regmap_config serdes_am654_regmap_config = {
+static const struct regmap_config serdes_am654_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-- 
2.26.2

