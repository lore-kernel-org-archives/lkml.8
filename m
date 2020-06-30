Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1F9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73292067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VVXEmE+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgF3Sw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgF3Sw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:52:27 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065AAC061755;
        Tue, 30 Jun 2020 11:52:27 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w6so21699523ejq.6;
        Tue, 30 Jun 2020 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nqdN/DtL1FPJtnCKYqqpb2D+QdO6a50HYApL797grw=;
        b=VVXEmE+j/hjCH3pWCO8dHuk5iq3pTQstsDqI4JFWMtgOtgcIC7M18NwFBAoDldbDT7
         nvMzMx40nIWXaj58CwhiEpbb6hkMacXjY3jzmxhHpHzCr9IxG3+VTLpI/2k4lzp7jYu7
         EZxQ5X4lXvITxuRZRNGuVg+56tLClsxxuas9kcVnYWzUTcPMYLCBjPGDX+Zzre7sUqG7
         OLuMz49fA8AvNFTioIn2yUHrs6fKjcVT/IpsJ5MwyLmSrquvOoxH55nuMB+NL4leqtdZ
         V7bDIdXpolpoYWzaxevhYGihLpexg0vg7HlyXMQY69J8u+3cjSkZstJuc/VvFxM9sLDN
         YA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nqdN/DtL1FPJtnCKYqqpb2D+QdO6a50HYApL797grw=;
        b=cWIDZcMVSIFxao2tBcI/BH43Iyle0ar3yjv/KKVYXjMDvoJEmWamNxpsv2XqY2kbVz
         ICYSImKNvDEXQBXn/eP7mbSzRLxMnXSRlA9VDdY4VTOjxYyC4DKEIPe5fMzht0LiHjS6
         h4hGuqLbiYfXktEYj9ZOp41P5JhS2ivDIjl9sfAaackQfKV3eWTcgpG4rxnQTIsIp2Dj
         YKzjMEScvFZ7pX5BtYZPAw/pp7jiu07Xrf5b088zYOlJ0t1YQU+q10Zt+4QY1OgwFucU
         LIw8w/cmNK4vULenxOARXmRZCzSn5rhenzfpS/kgIibRGbCI6mFMeq0stAAQjfWLRiku
         7LSw==
X-Gm-Message-State: AOAM531XZa9cOzGOIPRGvI3WP542Ul2ZHgB3fJ6x0A4fEjl6vIatQpIu
        nhw1zyGr2L5WhBihOQfXiUgnyziK
X-Google-Smtp-Source: ABdhPJyJYmUINPWafUSJQB3I2lK93BO+uU/hXDiOS11xDHGFnGMt/hHwq+cdzjYqxgcYqv3Bnzc+Cg==
X-Received: by 2002:a17:906:f101:: with SMTP id gv1mr14727720ejb.327.1593543144767;
        Tue, 30 Jun 2020 11:52:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:bb9:bc00::fc])
        by smtp.googlemail.com with ESMTPSA id e16sm2677238ejt.14.2020.06.30.11.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 11:52:24 -0700 (PDT)
From:   Christoph Fritz <chf.fritz@googlemail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] regulator: Add FAN53880 support
Date:   Tue, 30 Jun 2020 20:52:01 +0200
Message-Id: <20200630185203.22882-1-chf.fritz@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a regulator driver with dt-bindings documentation in
the new yaml format for a power management IC from Fairchild (now ON
Semiconductor) named FAN53880.

The chip was found on a camera sensor board which will get a v4lsubdev
driver in the future.

The FAN53880 differs a lot compared to the older FAN53555 which already
has driver support.

Christoph Fritz (2):
  regulator: fan53880: Add initial support
  dt-bindings: regulator: Document bindings for fan53880

 .../bindings/regulator/onnn,fan53880.yaml     |  85 +++++++++
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/fan53880.c                  | 179 ++++++++++++++++++
 4 files changed, 275 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/onnn,fan53880.yaml
 create mode 100644 drivers/regulator/fan53880.c

-- 
2.20.1

