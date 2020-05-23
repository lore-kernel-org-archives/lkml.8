Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D54DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8B520727
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Jb+5ZKal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbgEWN1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 09:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387789AbgEWN1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 09:27:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1271DC08C5C2
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:27:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so13024748wru.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4BoYkqJ2NsZ2nSSjChgUqJJCyqhbfFRrbuVJ3n7szg=;
        b=Jb+5ZKalM86utufO41gum/2tS7OCDO9S01QHf7MGzAdq8QJbiQutr25oxxnlWFKFjx
         SZR18qW8XesCnotOkM8H9quVQqYTgPCdLi6Hhg42qTzojhe4TfWrzycKi3iHikDyNJsf
         Ky8/1dwIBaNGn+BmOnu4CzyVMTy5XGhLj6c2FWrDQ7sNwWtbGGg15vH/P5a5y6+hovy8
         0rlqQeKnqGk4cNbfwQjDY2T8Oh4k/d1T2eWIevxv44tfqW6CCjW1/zyJBqc/LB1fD7fQ
         e6hxAoYbB+3ek0K4qJKeZW6zAPnzXJfiIuSvoj5gtKzV/sqVyURCSsJZ7bY796SijLfg
         e/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4BoYkqJ2NsZ2nSSjChgUqJJCyqhbfFRrbuVJ3n7szg=;
        b=pBNu1j06kUmbW8n+WOCOJyBYO8++CrG6RaVQ/5Q2OIqAtfVMPgQQ/GRU+YCExhQ2R5
         nQM5vnsfhf7hVxvatm618CrgW3yuXu4R2ZOSFUe16IDYBBPRpX+a0iqNUgW+udBLAdla
         yg2Z8sK7ciuoSG/mW2sIfpUZoUG/t3NLd7kBdKvdZ+55ZNGBY9MMEMjjUg5bv9w+bw/Q
         riYXC/5g17NqJAkBasBVx/MN3yi8Jldv5og4jIPnX3wARxc8eqPg4oKelsGjHpj23hqg
         GNjUM87LQt7JqHvRZ12rTfeFeTimzXpp4Q1tyCmIu4GvnTGenBP4d0TIrszoGtnjR7JR
         XBTg==
X-Gm-Message-State: AOAM533LCIdl3l7vfubcJzxyyXUV+4j63c7OvBvrnft7E45iMUH4wxMx
        EUkHERIbzWYnTyyN72eHkhACDQ==
X-Google-Smtp-Source: ABdhPJwRfYPqDnrdo+HMqNm8KeR9hux7USj8U+isJ4xnjN1tAmXFnQplrYileiKI5uqJotyI3sPrWw==
X-Received: by 2002:adf:f907:: with SMTP id b7mr7636363wrr.203.1590240440783;
        Sat, 23 May 2020 06:27:20 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id g69sm8098703wmg.15.2020.05.23.06.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 06:27:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
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
Subject: [PATCH v2 1/5] Documentation: devres: add a missing section for networking helpers
Date:   Sat, 23 May 2020 15:27:07 +0200
Message-Id: <20200523132711.30617-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200523132711.30617-1-brgl@bgdev.pl>
References: <20200523132711.30617-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a new section for networking devres helpers to devres.rst and list
the two existing devm functions.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/driver-api/driver-model/devres.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 46c13780994c..50df28d20fa7 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -372,6 +372,10 @@ MUX
   devm_mux_chip_register()
   devm_mux_control_get()
 
+NET
+  devm_alloc_etherdev()
+  devm_alloc_etherdev_mqs()
+
 PER-CPU MEM
   devm_alloc_percpu()
   devm_free_percpu()
-- 
2.25.0

