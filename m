Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E3CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84280208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PH7Eqfcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgIJPev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731028AbgIJPcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:32:39 -0400
Received: from mail-oi1-x263.google.com (mail-oi1-x263.google.com [IPv6:2607:f8b0:4864:20::263])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072B9C06136A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:26:05 -0700 (PDT)
Received: by mail-oi1-x263.google.com with SMTP id i17so6267469oig.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N9KMfAmv5gz9m6lApSf8P0rQ6LhDYejBww8cNrHpQok=;
        b=PH7EqfcrI9gbwFUc67/qdfVoPVX/x4PJuxUjvJeXseMzxwVdhBcsyHdWLOP5cGyfx5
         7ZSBopRHdt6dSl26MJHlVEZbcs2PNDaWG3QYJWdgHtTwLu6T/ib8f2QzZMy+M/cSbnFa
         5MjLhstOsdMcqMcTFdZvluz11qF37cAKikXTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N9KMfAmv5gz9m6lApSf8P0rQ6LhDYejBww8cNrHpQok=;
        b=JhWfJEC1HrLWKQwkRZSbNr/T7J/RKYVZt0og1aQxlRRoEsExjcbymOC9Ep6MjKz53Q
         2aibbNbg9hLKrMLHkmCixrzi9klEhcKSJDjWIQnswZKP3oPWLeISLLUw16Yk82yVtSSY
         /8RwmQ+qn3O2nHvTDHYdQWAmOGoWedaLzd4JWylT8/ZRf+77iDD9rVfitFrYdegecD52
         bgzRiHHVJQUps0I9P/9sZl2wUwVV3TKIZOathPqrgmufSDChFVYrPGl07x2zRuO6T1e4
         ekTTFkRRlCt3DGCp6yCVmlF+YcZWBK20WS64kJ5aqlAX2d1vz82SsuX255hmlUaJpIKG
         E3jg==
X-Gm-Message-State: AOAM530XcriX9b43rE9UgK/DQnMwV1FLPgTcqMcXaW0h9Hf892GpZQa9
        YeTfl7X9+jg3890WgPBaCA2ordFLzo6e8Y4iTOQhN5icvImU
X-Google-Smtp-Source: ABdhPJxW+wUZjy6K9BKtFZv7NGBFSRSsF5MWXPbl2+IX73/JOQCBJl9BEXktjrUDKBXePb25dMK3bpyfrhPr
X-Received: by 2002:aca:b454:: with SMTP id d81mr350910oif.150.1599751563367;
        Thu, 10 Sep 2020 08:26:03 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id h4sm943004oom.19.2020.09.10.08.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:26:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Ray Jui <ray.jui@broadcom.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 1/4] dt-bindings: spi: Add compatible string for brcmstb SoCs
Date:   Thu, 10 Sep 2020 08:25:36 -0700
Message-Id: <20200910152539.45584-1-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for brcmstb 7445 SoCs.

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
index f5e518d099f2..9d4d5d866fa0 100644
--- a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
@@ -32,6 +32,8 @@ Required properties:
     			     			  			    BRCMSTB  SoCs
     "brcm,spi-bcm7435-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
     			     			  			    BRCMSTB  SoCs
+    "brcm,spi-bcm7445-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
+                                                                            BRCMSTB  SoCs
     "brcm,spi-bcm7216-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
     			     			  			    BRCMSTB  SoCs
     "brcm,spi-bcm7278-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
-- 
2.17.1

