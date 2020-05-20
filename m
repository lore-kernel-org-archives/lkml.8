Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0547C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8D0204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="G2HzL5rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgETLo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgETLo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:44:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF810C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:44:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l18so2812507wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4BoYkqJ2NsZ2nSSjChgUqJJCyqhbfFRrbuVJ3n7szg=;
        b=G2HzL5rdxl8gOOIQV4qlZMw3KWQcZxPW/z+oED1akrqOkokebIn2QxctEc0qMGDENR
         fnBBgU7agpoX1odvaMiQMUaCWrKwE3w7DwOPyGoM5q07zcNglYB1JReA7BQ9Lnf7Ho5N
         X+dwG8oPPExdKj/4jVBNByIeraaDXpT0uVTtEvtSUeuC6Pe7J47V/bSYcOkQD87Jaqdo
         gvrlYFLb2bO/N5ysRqcO1/aOVVirM77Zra0to9qgOQxKpGhC/2rl6GcazkmeCMmjTo/U
         ofBPPKGz0CMTClSICNtkP+NiGp4om1xqGgOZGmUe6v7G9i3pjDQcnm4Hty7lEAXw6smR
         10vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4BoYkqJ2NsZ2nSSjChgUqJJCyqhbfFRrbuVJ3n7szg=;
        b=qitjRer+7utf6ziXuBn0RMFMFk2oZAgKtgxuBlL5WmgM4nvLjYR+TQpVHf2QU69YA4
         z6okzi10C15WG6HNNgv5soLIRRFvfJs1rMg/8oY5ThL0Mhv0ibAAGjZCEVNqRgt+CwcQ
         nFv9JByT0FwonSI8S9qa/Y+qwZ2/nA4fOfp4+4Bu53UOPQlgK/odj7sT7ZOEn+fHis6M
         N8sg95YHlYtk36gK5vRJt9q96EKabN5e6/KTja6HAl/YrMhgnSjW+X3nf9P7U7UhcAkw
         9U4Vry/skOjjZknuG4pEMykjk/RdZSa4Q5Mgn/kFbPmYkrvErFcDYfmeAlgyGebdV0oq
         bChw==
X-Gm-Message-State: AOAM530G6RdFE95Wz4SDhf8wNkJmtVQtO5AabhKNCngnvbOVO8K79YpO
        BXen1Ea6P2mBdqI8RSLDgfeVnQ==
X-Google-Smtp-Source: ABdhPJwCKG6qiFzuF7aH6jSWA6csbzJ8395j7lIhL5oX0eAbSe/2g9fc+9TJo6lUPU9TiTHyfgaB9g==
X-Received: by 2002:adf:afe9:: with SMTP id y41mr4193800wrd.56.1589975063620;
        Wed, 20 May 2020 04:44:23 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id q2sm2530782wrx.60.2020.05.20.04.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:44:23 -0700 (PDT)
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
Subject: [PATCH 1/5] Documentation: devres: add a missing section for networking helpers
Date:   Wed, 20 May 2020 13:44:11 +0200
Message-Id: <20200520114415.13041-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200520114415.13041-1-brgl@bgdev.pl>
References: <20200520114415.13041-1-brgl@bgdev.pl>
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

