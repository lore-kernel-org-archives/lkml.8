Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1008C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A932065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGHFjlpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgGWTh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWTh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:37:57 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB677C0619DC;
        Thu, 23 Jul 2020 12:37:56 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n2so5376606edr.5;
        Thu, 23 Jul 2020 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnSVvBPLgxOr7Okxa4+yFdbMwIKkVndKbRuepRfY/Zs=;
        b=cGHFjlpd9fFxJoTHprdv6bxx7jEzuQfyVGo7hhnORgret3eeD02uMscYszAG1w+6oD
         Ye4gl7/956XvDvUdQHQhlCmY3XjGmUiRo1Gn+ayf/bRyLqZ26rfRyGWcMureVHazph74
         1hKIha1snTai6b2WGSUYSqA01CJixfgnygSjXypsUce32AOcM7JhNtZR+Wrb0SjPNTDR
         VLsAE66PhLX4T0+tW14BKHJO3kNEgd/A2gN8xhp9Ga0sx7T1xmgPnjnTaZcE9/L+hmNW
         VgS+4THVcnnlqzq7HEJNm0nmFrwlNpD0kqO4/eH20DLJoiL9byGCin/ww9eGxjbDrfxl
         f6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnSVvBPLgxOr7Okxa4+yFdbMwIKkVndKbRuepRfY/Zs=;
        b=QMWkh8WNoP6iRXdpfzz4LVgDtgxOiUiA2wv2BY2CAZ1Cxgn2oPw58LGLCdhYX7yztD
         ybsYvakcAaC/7Bs2DPyeO9Piauv7DVrVAkv3wvEFRy03p8mGhpjwzfVSnhDqaq8L9hCW
         99+UfBbc+STl1nsnHEnCwMKFFiIBeXeuKGIr3p8Wfb3l81ft9gJKoFVVpe//0axmUyZ8
         uLDVEZ9cnN0hqpB4n451MvCpupgORTVNfM5RHYxxjqQghVugmcsfZBsRd2CSobkaVTAO
         fjZjrP1377b8MzJOmNBhBSPzUFSh++qSSTy+ljrHZKF/in7H5nrzJwIJqemFMKWNWkqQ
         lhpA==
X-Gm-Message-State: AOAM5329BPGmmOhePo59sYBNhZLZvgH7Qy7XLPUGAEI9cMG+wMPSg9n4
        y0ZkrkkdqQCkW4veXcxwO2A=
X-Google-Smtp-Source: ABdhPJz0Q1XaTDnhZogjytSe3cUi83UxpYnapEIh7JfyZjShqQ3Or7lVzyvtbZvsrUp+F6uOqIrJ5A==
X-Received: by 2002:aa7:da0c:: with SMTP id r12mr3743912eds.109.1595533075477;
        Thu, 23 Jul 2020 12:37:55 -0700 (PDT)
Received: from blackhead.home ([2a01:112f:a1c:7900:7316:ce1e:7b0b:6bd7])
        by smtp.gmail.com with ESMTPSA id o20sm2655719ejr.64.2020.07.23.12.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 12:37:54 -0700 (PDT)
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
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add Seeed Studio
Date:   Thu, 23 Jul 2020 21:37:35 +0200
Message-Id: <20200723193737.190291-1-marcin.sloniewski@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "seeed" vendor prefix for Seeed Technology Co., Ltd
Website: https://www.seeedstudio.com/

Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
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
2.27.0

