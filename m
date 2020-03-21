Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3BBC4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 11:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3154920724
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 11:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsLAT8+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCULkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 07:40:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45180 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgCULkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 07:40:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id t7so5879430wrw.12;
        Sat, 21 Mar 2020 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7jR/DJniamHEDhpAAfPOcbN20Xg7ftVEruh/hyhO0PE=;
        b=LsLAT8+uDmGSdQQJntAF8vnUqUnpGplRkCu3wIrpjOm72QwxiPSyucWszlZYxKozpk
         qp1vUdTtSmAetmlLU6jTQsYrGZZvda/aPVoulZxELtCJkR0Tsk815tDkL+3HK/YXbxmF
         jtLdYdPDUeiOXDU/BXFfAiZiw+i+o+K8v/k6ReFNHkMNTlclmAibR2TVRvpJfZhdkJjf
         PO6EcEnhKLmfdn1TCVDGkM0VDNM4QsMMh+da0N9WrkDmlYc+Nei1FaumMXpQqwIkgw4S
         CSLK6Su/ZLNqr4Y5WZVY9LyUUDLzSlUN8nngsIj++Gs1w7nQoRTiQsF98zCyGaGin7Oz
         uAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7jR/DJniamHEDhpAAfPOcbN20Xg7ftVEruh/hyhO0PE=;
        b=lnoDl6VB76srfchnE7J18kPiMq0Wm7i35VXnkMH4Bex6m5OHsKoe8zAPf7A0NQyrBW
         lfyWppK91+HOJxajwOnYjXVlft9MBWhgziPMsXq2I24Crvr61f1rarxKopWPAuxWN9If
         UHXKThJpxCXrWtlv/NTQ2jduVkxYMMnbOuXXMVIvI4ZaHbZR2HTrKT9n5uoSbOxvAA2y
         kIdJ/L2RBexJMDvVdm3dZL12lZ9swvo1Nd37Njz/rO9bc60dBJ7JoccBpFH4boFXstb+
         Oviy/ke05J3WLOB54TsXQ1TWp0SU9LPasZCfbeb7peZWpLziEnghQl+GJVQMRK7Y8ced
         X8nA==
X-Gm-Message-State: ANhLgQ10wVdU+46+pNwyWvAml6wdkVOg/oaWGJU6kLbc5wFYfIVl6yX/
        f1NCPCcMfX7uDw/no3AfkD4=
X-Google-Smtp-Source: ADFU+vvxfx5Oi42isr8/wePrVDB2XPv0PjWByfMkPVW34u6Ng9Fb9YvXxU3xXUegrdwEReYm41u9Cg==
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr17009174wrw.52.1584790834729;
        Sat, 21 Mar 2020 04:40:34 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d49:b100:e503:a7c7:f4c6:1aab])
        by smtp.gmail.com with ESMTPSA id t16sm9533091wra.17.2020.03.21.04.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 04:40:34 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jeff Chang <jeff_chang@richtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-spdx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] ASoC: MT6660: make spdxcheck.py happy
Date:   Sat, 21 Mar 2020 12:40:22 +0100
Message-Id: <20200321114022.8545-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPDX-License-Identifier shall not be suffixed with anything further.
This makes ./scripts/spdxcheck.py complain:

  sound/soc/codecs/mt6660.c: 1:36 Invalid token: //

Clean up SPDX-License-Identifier line to make spdxcheck.py happy.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 sound/soc/codecs/mt6660.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/mt6660.c b/sound/soc/codecs/mt6660.c
index a36c416caad4..06ab1d39d2c1 100644
--- a/sound/soc/codecs/mt6660.c
+++ b/sound/soc/codecs/mt6660.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 //
+// SPDX-License-Identifier: GPL-2.0
 
 // Copyright (c) 2019 MediaTek Inc.
 
-- 
2.17.1

