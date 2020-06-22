Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117C2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D77206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xtlQ6vt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgFVKBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgFVKBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:01:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDD2C061797
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:01:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u26so13163507wmn.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vANIsXo74NzXiDIyR10LVPoVvN0SF3cCppVREngNaSg=;
        b=xtlQ6vt2ftcI+XabUk5dlYEY+EoWH8nR8xcQ0FineEvTFIyHxwdZru/XNV/dfPCuwH
         p+2SV3EvOLiwS1nhvc60TsvMW4YNirrfN8g/xcNwpKisI/ZQhpTItmGFfFpSHrXsGu+S
         b7MvvTAW41tXqhs9scOYapiZqZ36Pfyhf81lebKF4vMaR5ghYo5mQz1TbDxar4ISYJoU
         r97GfAQhf4HMDRDYdamUBfw7XB2G5c/8Yd3xQBk2wd2NRH8kL2poxNolBqJT2m6c+bYv
         ZbtsK6uSEB72jNc60WhrddXbm/mQa5m5tZApNrkGL3PmfTcjFpfrBr+Em/UQj5iDvDis
         u71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vANIsXo74NzXiDIyR10LVPoVvN0SF3cCppVREngNaSg=;
        b=DN1OOdoKr2eefR0df/FUBrmtZxdDc5TuQEGZ/1dOsBPSwg7foN/2l7O64BelcCOo66
         SQXSkn8zvYPDZV2xxqUEdPyI+1FB7hSwYcAEhJ6iJW2lfgzP1BxTknNAKQ/XAATVNxvM
         6H35uyQB8CwPmN1onJq4sgfIU0EO3j1TnYCK5vEprlH3aSc6lKA+ENDuMEu8cV9yDI2T
         MhecAuo7tdBKhEP7arrDokkCURIUNtfAvYBguKN0QETw3es9sw+G8jKuznnc5Zjn0i/A
         3keQzZCP4HE2sLNRnpTcDjhOfT9Wqtcz9M/10myqroeP4Cq10h+nFdwpFBnESrLIwXdi
         5i8Q==
X-Gm-Message-State: AOAM532NIxrtMZ/jC4mdn0F0UW2RJ2jGrJMyT/nLa28sn92K3ZaBbty5
        aIC2pwRxWgDM0Yrfku14tsMrLIIAkKA=
X-Google-Smtp-Source: ABdhPJzUHixuKfQa4u9XvxcXJoOatBovm5nA4dkuN9R2ixW6hpip+ioKdNDg9ycFUOAJ0KD49goWaA==
X-Received: by 2002:a1c:c1:: with SMTP id 184mr17443884wma.74.1592820073899;
        Mon, 22 Jun 2020 03:01:13 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id x205sm16822187wmx.21.2020.06.22.03.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 03:01:12 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 05/11] Documentation: devres: add missing mdio helper
Date:   Mon, 22 Jun 2020 12:00:50 +0200
Message-Id: <20200622100056.10151-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200622100056.10151-1-brgl@bgdev.pl>
References: <20200622100056.10151-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We have a devres variant of mdiobus_register() but it's not listed in
devres.rst. Add it under other mdio devm functions.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/driver-api/driver-model/devres.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index e0b58c392e4f..5463fc8a60c1 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -343,6 +343,7 @@ MDIO
   devm_mdiobus_alloc()
   devm_mdiobus_alloc_size()
   devm_mdiobus_free()
+  devm_mdiobus_register()
 
 MEM
   devm_free_pages()
-- 
2.26.1

