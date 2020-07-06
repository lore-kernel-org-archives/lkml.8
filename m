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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746ACC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C961206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzNFeVTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgGFRfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgGFRfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:35:04 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEA6C061755;
        Mon,  6 Jul 2020 10:35:04 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id e22so35765701edq.8;
        Mon, 06 Jul 2020 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OL4BIoHfo4ESD2HkTeJ2OTpKVO9hzHwpMJmzstmiNVg=;
        b=pzNFeVTSQqmQBRBaCx9hwMgTaGftD6bb3g3apo+av6qMPYCMRghznZWG8/gqBb/MLP
         E7DNIVUH162bhujtG8TKhNRNmdSA3Frpxr5dubN8p7nqaF62jC3CI+iNQnKN6q7K5DzI
         g92n5Yq8m+WiV8oHcTyUDa/y9sjuvkjj4X4NV/wLLLbsMCEZGgSOR9mRZG1t67n4MSlS
         CSd7wZ5RnGK5DJ3EFzAsSwCHYCiXqIiQKzuFjuAZw0NIlfQsoruj6RQCfk92zOWkD/xn
         IWi+Z+iHWomW8Eop9QoV0vyuQZ61W2eSKuTd/wpUbOtERjXZ2830bf0GBCjRdinSRqt8
         4LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OL4BIoHfo4ESD2HkTeJ2OTpKVO9hzHwpMJmzstmiNVg=;
        b=hd3pHzYZShwoGnTaiytpy/Bg8nT5Qbgggs7g5ZtDCJPI9gAETBeiK/qdIdtjpblYBf
         +4A9H1h01JPf/eM66AMiYQaCrl63U2h//JdV5HL3UfkqFbqjrOxjYN0nNfPmDC73c7GM
         SZnZTi42MEr2XonRdWaoM46Fd/4r4PKLEAmOHyHimDxdM7/JIlgI/CiLz7OhfLUal8Qy
         6vRa6OS9si9Z3WT388BXYwoCbc4AO7PgnIpA+73qLP7RE/LWkmyHBMt4vusThApS8hvg
         t2+qcL7FoPtNvzBb+b7J7VTTCNJjTqBV663ySpd8KEDhtn/qfbUYKls2Zb/U5xDdaK6B
         KsOw==
X-Gm-Message-State: AOAM533MMsVTbY0KMJpP/cYztnRpSfCLmdj/qVv7Z8xzWpl/tTek0/AT
        hIkBRLj9tv6JLfNoNJwbvwI=
X-Google-Smtp-Source: ABdhPJwFsnEgy2TMnmCzBwlfhsHoeEroFsIMnCsgdDoNwl7SSxE4VISYVrxGPV72yRwsV0ZI9SZg4A==
X-Received: by 2002:a50:d7c1:: with SMTP id m1mr58043823edj.217.1594056903415;
        Mon, 06 Jul 2020 10:35:03 -0700 (PDT)
Received: from localhost.localdomain (asp78.neoplus.adsl.tpnet.pl. [83.26.227.78])
        by smtp.gmail.com with ESMTPSA id y22sm16556258ejj.67.2020.07.06.10.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:35:02 -0700 (PDT)
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
        Stephan Gerhold <stephan@gerhold.net>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: arm: stm32: document Odyssey compatible
Date:   Mon,  6 Jul 2020 19:33:48 +0200
Message-Id: <20200706173353.20525-2-marcin.sloniewski@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706173353.20525-1-marcin.sloniewski@gmail.com>
References: <20200706173353.20525-1-marcin.sloniewski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device tree bindings of Seeed SoM and carrier board.

Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 790e6dd48e34..22b9aaa75eee 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -39,6 +39,8 @@ properties:
           - enum:
               - arrow,stm32mp157a-avenger96 # Avenger96
               - lxa,stm32mp157c-mc1
+              - seeed,stm32mp157c-odyssey
+              - seeed,stm32mp157c-odyssey-som
               - shiratech,stm32mp157a-iot-box # IoT Box
               - shiratech,stm32mp157a-stinger96 # Stinger96
               - st,stm32mp157c-ed1
-- 
2.26.2

