Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1664EC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E724E206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC2jBv5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgGXOvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgGXOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:51:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773BAC0619D3;
        Fri, 24 Jul 2020 07:51:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a21so10244899ejj.10;
        Fri, 24 Jul 2020 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SoBgP3OEfZo1S+W2OL+antn28vvn8c/8vKe/rfz3jjQ=;
        b=AC2jBv5CJFC7Q9ATElbSLWXwqiYW3iBMiPBzoTepUfXEzYYG/GVIvKCNoZ5oUk3WyZ
         pxx3miWVrxAt3L95Dqksz8kXt27nvNNn3ISV6pv3KlEK3wM7c//ms3PSaMsjMB0OoGQZ
         R/4YZM+lCjWuS+oy3zhgBLGkDtV3H8Ao92ObOqDWqzn+tUBDwGMGVaMqqyIEjvIAjDrr
         YaMT7IV+tCkDSYb1DgsD8dmcZ5LZy5hCNAz6KMtbh6/eNvdz8nybnqUTqLyDGG7uTvHp
         cQ+k156Dpm98KybgSbg6muYW+1PqDpw0KNPTZSxq2bQ0VRdmVRxdlDhzNuBQfzLUg0jn
         VAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SoBgP3OEfZo1S+W2OL+antn28vvn8c/8vKe/rfz3jjQ=;
        b=FUWJCJ04/wCemJ8j3nnD2JHRQmNzmMYt9xVsThmHJvZBIMzYV1ez7HWLkbfJgr+m0L
         1OXcIW4IaWpKffLvOq+4Oe/nVO5WGVMD83G+2bribcQaLWuZBXgHgJhI8YW1YVqK5FcB
         qgbzrtzJTLZIGQrEpyy38SXPg/LcofaepCTj4KcGRxqqopddL6osRG4/a0ndp0OXXjKr
         O3od2exgDZSdss5gBsn3WM1psT1K8gUSOQNeKC6nZqO0FFHlb7o6ugy2INMnT950nMd1
         ImoDHt7d1jxmLnbKUKFNYkNQYVKqsb+Ep7KqKy+uzVhAhEUpc41dvtPRb2io1UGw73j/
         UB9w==
X-Gm-Message-State: AOAM533ClXZLoj6vulY6uoD1Y/XAfmTLVRsZbQg9+Pa2LHvWKsQK12n+
        p8Ud4o7RNB8+nW6uLU9DaH0=
X-Google-Smtp-Source: ABdhPJwigOug5YS2zDWbTF33JR8oprff0trdhlk1ZkvsxHcvm7s/3uhfS83C7ZSn09NpOyyeSA43mA==
X-Received: by 2002:a17:906:cc4a:: with SMTP id mm10mr7602288ejb.451.1595602289234;
        Fri, 24 Jul 2020 07:51:29 -0700 (PDT)
Received: from blackhead.home ([2a01:112f:a1c:7900:7316:ce1e:7b0b:6bd7])
        by smtp.gmail.com with ESMTPSA id m6sm788309ejq.85.2020.07.24.07.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 07:51:28 -0700 (PDT)
From:   Marcin Sloniewski <marcin.sloniewski@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, mani@kernel.org, a.fatoum@pengutronix.de,
        marcin.sloniewski@gmail.com, sam@ravnborg.org,
        linus.walleij@linaro.org, heiko.stuebner@theobroma-systems.com,
        stephan@gerhold.net, lkundrak@v3.sk, broonie@kernel.org,
        allen.chen@ite.com.tw, robh@kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: arm: stm32: document Odyssey compatible
Date:   Fri, 24 Jul 2020 16:51:06 +0200
Message-Id: <20200724145107.35772-2-marcin.sloniewski@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724145107.35772-1-marcin.sloniewski@gmail.com>
References: <20200724145107.35772-1-marcin.sloniewski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device tree bindings of Seeed SoM and carrier board.

Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 790e6dd48e34..3b318fe15194 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -50,4 +50,10 @@ properties:
           - const: st,stm32mp157c-ev1
           - const: st,stm32mp157c-ed1
           - const: st,stm32mp157
+      - description: Odyssey STM32MP1 SoM based Boards
+        items:
+              - enum:
+                  - seeed,stm32mp157c-odyssey
+              - const: seeed,stm32mp157c-odyssey-som
+              - const: st,stm32mp157
 ...
-- 
2.27.0

