Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E9BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 346AF206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pH/LmHob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgGFRev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgGFReu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:34:50 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF69C061755;
        Mon,  6 Jul 2020 10:34:50 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id by13so25936718edb.11;
        Mon, 06 Jul 2020 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w85FGsskHQRhzaiqM+JZGmGetxz+LIcW62VKFwk5McU=;
        b=pH/LmHobS7hL/45j4qh+7Ykh+Zu0U6JG9fJZS2yOgKqC/MQrhvGuu8eTvQtpWZwQ74
         V2F89+TQxbNl7Ntu1Waax7R91qdBV8TMDFAFirvHDr5ar7Wf6T4rl3E+Yrf8tB6RrUBX
         Bb3Vsxe020UJrNbHRtPU3qn2KsLs5xH7iqO9kpMwrRkbE+JaeUcCUxiKKAYETPHSPuhB
         MjMf1oKcetZziqnxUoAfSoKA3sobZyBCjyR/hPLpDbiCRnDqZB/Q7DcrUDRijEY0U3Vb
         TROt6KiPq+aUcGZ5NPoW5oxlQr+J4HSirNsTbTMF9D8mF6siiunj+iUhHBT0mA6GfFj8
         2K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w85FGsskHQRhzaiqM+JZGmGetxz+LIcW62VKFwk5McU=;
        b=eZCkUqTCp90zeLcBHApfX7ksHL4qVyudD471imTy0Dy8zknUCUo7s1ejyrFmfjDtbo
         9XisIDrbTjo8HnBtczw+eycuEpcHN09YqB9gkEk5WjSPKNSseh+LufvlzhChAOnuItsy
         KK8E9Sv9MRQ3+EifzrYbcL9ZB7LOH8LXHbgcAliUsw6/RYTf9MkUxOq+hg47IrR4YZwC
         Y46k+LILJ26D5yBMGFcR1LzjkinN8N9bFvX946kRIkqkVqqGw3mIDNxH6hQpBIKnAnsQ
         aA8Bxqod3Lgs++WJ6zKzqPr3TF6VIfS8fdxX/G5cH4uIceM+rNiY/aFxts0xcKWuaYTq
         G7xA==
X-Gm-Message-State: AOAM531jPjhAirtWGL1RJQ2zWdOfk9gfrjqR2USaM1f/W3wKSim41OlL
        kjJ2qmZAUF+TXuqXtpmTtdE=
X-Google-Smtp-Source: ABdhPJy4/3XaG+1BN5v1+8nPRey1HgvdRd9Wo2LQRqUjb7BHCQ7PfBhwKRWXTWZs9CaMbHYPc6lqjg==
X-Received: by 2002:a05:6402:21c2:: with SMTP id bi2mr56590150edb.296.1594056889023;
        Mon, 06 Jul 2020 10:34:49 -0700 (PDT)
Received: from localhost.localdomain (asp78.neoplus.adsl.tpnet.pl. [83.26.227.78])
        by smtp.gmail.com with ESMTPSA id y22sm16556258ejj.67.2020.07.06.10.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:34:48 -0700 (PDT)
From:   Marcin Sloniewski <marcin.sloniewski@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add Seeed Studio
Date:   Mon,  6 Jul 2020 19:33:47 +0200
Message-Id: <20200706173353.20525-1-marcin.sloniewski@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "seeed" vendor prefix for Seeed Technology Co., Ltd
Website: https://www.seeedstudio.com/

Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9aeab66be85f..7dd03b3e9d3c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -902,6 +902,8 @@ patternProperties:
     description: Schindler
   "^seagate,.*":
     description: Seagate Technology PLC
+  "^seeed,.*":
+    description: Seeed Technology Co., Ltd
   "^seirobotics,.*":
     description: Shenzhen SEI Robotics Co., Ltd
   "^semtech,.*":
-- 
2.26.2

