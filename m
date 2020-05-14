Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D87AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8F120575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="P+q8w1go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgENIAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726072AbgENIAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:00:08 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91613C05BD0B
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:00:08 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id m12so24244095wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYamWCGpGqZL1TdMciPU3s1N0hd2ppZ++0/IfJ1caGY=;
        b=P+q8w1goUvDD7gR6IchyV00vB3pVcrHK1pDbN1eYY/VOYjgNmBkbQGQCYfXXV+eFP6
         4nf1Uy7o9a0eFzUc8hHDpXmqBGjs705jAZsWOO2j2XQAD5HlSFiVxGUeeRognXurIqJe
         FPIsufHTJ4GuF9r/qJTFwlF/Fy+VxgGQq58XWZHFrz4MxV/et4oTsm0Oxzuw/HD9nc34
         8yEi+GIBBK+Y9nC12SRDgelejI8LlrfC6x25QcgYArrW4SBm3ZgFtZI/79b1TeNOtPUw
         LLPr2Q1C3Wtpg+JZ6L/7KyJwhrYoECFXR4fNhARaTt4abxJ9QBuZXWngiMdxSPFy1aIr
         7f6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYamWCGpGqZL1TdMciPU3s1N0hd2ppZ++0/IfJ1caGY=;
        b=cz532JbZJVBUxzVwTd5gPUw4xGHuKFHDrSCxw0EyUE5DjXjvnpU+Lm8r39POjCTk13
         W6trLQ7lKRQEOu5OPJrV3JMQVbIKDnmgKhIi8OqA0tcuSzm8St77xL7HZ/bZQ619lETz
         DGjU3MOKIciKeSxuyPqGs8127msBq0EyaZ6ThSL7VmngFOJqZU3HgrMm7MJyzG8LLnqs
         M7FEs8ZHEtCpO43xb0kZmW0KTicvPc+oZH9WbuEiLscl7JW9h4V8w/gBPRHhUjD4afb+
         afbNF5TZippWlKFZAtpZq3F3wyuTDL5yp08hXvoj/ThkKRL5y/XNh2gDkqR6eQDFpG90
         qr1w==
X-Gm-Message-State: AGi0PuZ2K8TagPeSAqWgmdhAMK+gSL3Ve/Ig3IebRSw0atoFK75+c0Iy
        BsVKGBp1X5Q309lcjGWZuKAG/BSFZ2w=
X-Google-Smtp-Source: APiQypLkU2jxnKbFs8gBgz1ml8D56KMxK6JlEHw7o56nvtnY9O7hz8Oxa+M4tm30hkKVFqKw1ft9IQ==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr45714052wmb.41.1589443207361;
        Thu, 14 May 2020 01:00:07 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id 81sm23337446wme.16.2020.05.14.01.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 01:00:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
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
Subject: [PATCH v3 02/15] dt-bindings: add new compatible to mediatek,pericfg
Date:   Thu, 14 May 2020 09:59:29 +0200
Message-Id: <20200514075942.10136-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200514075942.10136-1-brgl@bgdev.pl>
References: <20200514075942.10136-1-brgl@bgdev.pl>
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

