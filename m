Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C24C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E1520758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MlZFmJDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgETLZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgETLZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:25:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CD8C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:25:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so2757043wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYamWCGpGqZL1TdMciPU3s1N0hd2ppZ++0/IfJ1caGY=;
        b=MlZFmJDyD2RZ0Ws/5qF1VLg+XZqBfCrw5K6YfU6++Rjm1khpRCp2qSfB3fktDPddjo
         SIh9uNo9u5rfZE1ob3KokCrgAMAhLPTcLIK8eKdJWkwBxUHcT1oeN6lBdchQAAZUmWUm
         iv3hO7QiHeYoeyE5g4oOcw7e2gZ50XZzRDFrUggoPsuCrmI/HD2umiHSiQWTwo4qZPZL
         padqQ0vvTzkXV/zWCUj6CeVwJa6DNj9juCzcolT0I3DdZXpZMhYPRXpBho3emdf0EZhL
         ofy9F8wr+8xgzSBC+TUvDDIzMq9i1jojRdCeCqEnCj1xBbsJ0A3OgTxz+jUdxV655lt0
         qvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYamWCGpGqZL1TdMciPU3s1N0hd2ppZ++0/IfJ1caGY=;
        b=sYB0J01Ux5fcQs2rpItSo123vMX1oeq2UGF70MttGDpPHoyOoAvll9ye78CkBtw8Cp
         31OXceFH+FvdoDLkNtjIVUZOShPV8pXqKWy9590I1ASX9Gwxie5aq1+0BFdMQzEUpvDS
         AbfzNDtXLaRpnbD3BMqt/oGxmuXUAtSt1xSxrzWst+zYHZZ0DNFihirn4xJ83mWlKMCi
         Qot+GQVdLl459CfI+9DwMHXeJw/zxe4vm4Zrwrk9P0ODBwPlgKoF6p0MWyWfWOKmchwX
         P73UvdZ9IiT0Pybi48kbaqki0NbdphU57W+zrfxm8LilcoXKrxFQh8IhlL5uRCpW5u7Z
         qnLw==
X-Gm-Message-State: AOAM533zWY6OIc34vXdGzbdGNj4zUvnhctaOME7EUCwqSYyLitcqNz5C
        XR4bmv3E1q1W5X9qkBNuiA5r4Q==
X-Google-Smtp-Source: ABdhPJzP2SU8b7Ejhx9OfVfAUXunYJXKq9PtL2lhB4iCfhl7vIH39xSNcZZZPhsOwqd7i2bPARRi6w==
X-Received: by 2002:a5d:61c3:: with SMTP id q3mr3723732wrv.405.1589973934414;
        Wed, 20 May 2020 04:25:34 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id v22sm2729265wml.21.2020.05.20.04.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:25:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 02/11] dt-bindings: add new compatible to mediatek,pericfg
Date:   Wed, 20 May 2020 13:25:14 +0200
Message-Id: <20200520112523.30995-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200520112523.30995-1-brgl@bgdev.pl>
References: <20200520112523.30995-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The PERICFG controller is present on the MT8516 SoC. Add an appropriate
compatible variant.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
index 1340c6288024..55209a2baedc 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
@@ -25,6 +25,7 @@ properties:
           - mediatek,mt8135-pericfg
           - mediatek,mt8173-pericfg
           - mediatek,mt8183-pericfg
+          - mediatek,mt8516-pericfg
         - const: syscon
       - items:
         # Special case for mt7623 for backward compatibility
-- 
2.25.0

