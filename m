Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7C6C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B9221473
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S+SylMyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgIGKeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgIGKdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:33:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E670AC061757
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:33:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so15266771wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6ekjVHHl1G5/D6z3ZhBAoRFnwR5DCyzrgYRrKEa25I=;
        b=S+SylMyZpxmwj4mcBT7WTpiH4GLTdETsmC8lnnqcV4yWPz9wdM+1FkxdtJGuf0lEom
         5LjDGUu4pGsEvEVxcoKGTpTol8BoCTPV97HmKUVuRZt1RsYIImDXn9IpV7Sm3su+iAp5
         FIZDpMp5RxvK/q4KDp3r/Guo3zcIjmsahtl4pc/xofKvZ7r4d7kHi0fpa0YVvCNnBzZE
         zxl58uQjCVd7O+V0eKxDveuMSvxlEgdzJrdE1ceWNom1zI//PNBZG6YAoci7KRPAoUa5
         Pgza/wBQ7PNpjcrJc6k4q0t0vkGepZKhTwmBEr+XnYrn8eJRKXPkzBLj51XwCyGcSM/1
         gYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6ekjVHHl1G5/D6z3ZhBAoRFnwR5DCyzrgYRrKEa25I=;
        b=fC7xYplbe8Rb+habSJ68sPcDXSv/YrU2d8rJlfaOXTizR8dybiP18+gEM6OeM8wBG9
         pox+AQnpikYMkVBr916WYhaAQ4ZRJ8YTYp7I/Gf4I/XofgCmMAfAVF650M9TqwUnObA9
         9h920lXJ/Agetakb/z/WoBjgdICSsJP1QixXHILf4vybAvHXmY4ho26tCKnMeX9qqNJ2
         BynUnSLBh0Zz/CnI3AtJS/ZNHh4aGVtvlm5epAfUNnjYQ1R6L0+XAVVyJXfUEpHpDceq
         79XH/6BHx5k1JKM2u9P4d8nlTt5g5mX9b+wMCrVuZGFzJZPUUZAOqkHZGJqNtV30PSOT
         Hn4g==
X-Gm-Message-State: AOAM532w1sj7z2YjYhJ3BGTysJH6k0vcXnguh6aEbY88D0vkK1vl0Bo9
        I2DOE1RJwEQfbxYMbhht09xN91l6MOjVTw==
X-Google-Smtp-Source: ABdhPJwjKwQllFn+saBynC/VhmE+K/Vf8TiG/Xr793krk5Bv4hodlaR5hg661i9gmKlUh6jMQ4lS2Q==
X-Received: by 2002:a5d:458e:: with SMTP id p14mr21107466wrq.61.1599474801341;
        Mon, 07 Sep 2020 03:33:21 -0700 (PDT)
Received: from localhost.localdomain (122.105.23.93.rev.sfr.net. [93.23.105.122])
        by smtp.gmail.com with ESMTPSA id i1sm32395936wrc.49.2020.09.07.03.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 03:33:20 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Cc:     hsin-hsiung.wang@mediatek.com, lee.jones@linaro.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/3] dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
Date:   Mon,  7 Sep 2020 12:33:10 +0200
Message-Id: <20200907103311.1601907-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907103311.1601907-1-fparent@baylibre.com>
References: <20200907103311.1601907-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

v5:
	* rebased
	* Rename MT6397/MT6392/MT6323 into MT63XX to make it more readable when
	  the list of support PMIC increase
	* Removed Reviewed-by from Rob Herring because of the new extra changes
	  made to this patch
	* change the compatible for MT6392 to also contains MT6397 since MT6392 PMIC
	  key driver is compatible with mt6397.

v4:
	* Patch was previously sent separately but merge to this patch series
	  since there is a hard dependency on the MFD patch.

---
 .../devicetree/bindings/input/mtk-pmic-keys.txt     | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
index 535d92885372..71c82687ab92 100644
--- a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
+++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
@@ -1,15 +1,18 @@
-MediaTek MT6397/MT6323 PMIC Keys Device Driver
+MediaTek MT63xx PMIC Keys Device Driver
 
-There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
+There are two key functions provided by MT63xx PMIC, pwrkey
 and homekey. The key functions are defined as the subnode of the function
-node provided by MT6397/MT6323 PMIC that is being defined as one kind
+node provided by MT63xx PMIC that is being defined as one kind
 of Muti-Function Device (MFD)
 
-For MT6397/MT6323 MFD bindings see:
+For MT63xx MFD bindings see:
 Documentation/devicetree/bindings/mfd/mt6397.txt
 
 Required properties:
-- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+- compatible: Should be one of:
+	- "mediatek,mt6323-keys" for MT6323 PMIC
+	- "mediatek,mt6392-keys", "mediatek,mt6397-keys" for MT6392 PMIC
+	- "mediatek,mt6397-keys" for MT6397 PMIC
 - linux,keycodes: See Documentation/devicetree/bindings/input/input.yaml
 
 Optional Properties:
-- 
2.28.0

