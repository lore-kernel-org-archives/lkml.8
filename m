Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5C3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF94206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nQ9byLrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389514AbgF2UnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731636AbgF2TOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9683C00E3D1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:04:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so15126630wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vANIsXo74NzXiDIyR10LVPoVvN0SF3cCppVREngNaSg=;
        b=nQ9byLrDn58wjHMhoadRsTTETa0UhC6JF4a46q+PYUs7UZGZeUDV+Ialz0dd7h+UZR
         mhqFHyY0EbcDbESld8SYOxPhwBLpUwtVkb7pnzsNitFSbO7EEfGSOy2q2y7CP79Hex0H
         1b+M8CdLjEStcijSVXMq80kujGFckpNmUPo54ebhhky847n6l7blHRFboEfpPZTyy81E
         MMdTQ19QQn9i1JzgLPdR6Txwa+fNw+Wy8dARSM1y/DGypJ0Whb8UBnHg8y/LnybqbSGv
         f43pJWnxIJUXGw1WzhE2J9N+9sBt5Oq9JRyYdz9w5VzjVb+Gsr45rKUvPRAqZkU/fFCF
         warw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vANIsXo74NzXiDIyR10LVPoVvN0SF3cCppVREngNaSg=;
        b=lqgJZF+A0vx86sQXZayOjNWdKIUP/Rl+4L64nZEzCWELR0uhoNRM0iMK3EnhLVGl4D
         bfWc5dSXiug3mg05GW0cbOqEaOnsWwMUty3SMWVR+Tn0z6/uJW7ih+w68I+EJ/Muw4Di
         pvPvmWoR9/HnFm0aaRY2/X9QygVu1e4sijSk2dOxmoNsPLzgQnQpy9f/VOIkL0N8/jfx
         1nPMYmxttXwkEXCcteYh0cBWBeO8QEB8hIVV1cyOWUkexFBK4QoTiRpyermbQ/T41Udy
         WBn4WcaW2fI0R+M2AudQWk9wqEzvmmuy2/L6F45HF2S63q5nAv98iD9TIicpP+jpnGlL
         a5WQ==
X-Gm-Message-State: AOAM531qBvfhZh7+29QuLzeX0N1MkLIYyRKZv5uuFnyYp6bXjBUI1vls
        BvPG+laL/9mpL5HKVKmK5S9KJw==
X-Google-Smtp-Source: ABdhPJzzIpHdKMTQ6SjqhWeqI//sR8Iftgms6VcGQcyabxIbGKuFkf8bRkm3ckDgSAITcNYh0w9Y4Q==
X-Received: by 2002:a7b:c746:: with SMTP id w6mr17250018wmk.171.1593432257471;
        Mon, 29 Jun 2020 05:04:17 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id d81sm25274347wmc.0.2020.06.29.05.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:04:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 04/10] Documentation: devres: add missing mdio helper
Date:   Mon, 29 Jun 2020 14:03:40 +0200
Message-Id: <20200629120346.4382-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200629120346.4382-1-brgl@bgdev.pl>
References: <20200629120346.4382-1-brgl@bgdev.pl>
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

