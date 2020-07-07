Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387E2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B1420773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqqZZ4pE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgGGOiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgGGOiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B643AC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so23134889wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3kHcmoqkZhWZ4oxxNqqC7HGSrDg94q7cDYwU1R7wZ0=;
        b=QqqZZ4pESAuIWwDoPRnNoufHsQOPJdYeYXwBBwabjk1uLwS42wFEAqiWGt+bbkxoUW
         Dt3j7tTPi2S2uGuSN7pApq05aDzKTfIvedNoOVayX3DFlIlmVjjshralPJmUdpHAZFHT
         bC02jDQsGPGvkAYuqHMUQ7SAKmIEE5Wyv/WRDH3TsDo4+Bw+1tP3WM07zo8+K5aWDv0T
         kRTLqiFyThI4W4Ar9ywWWAc2Tw43IULOb4U6bNqk+lako8lgAWUP4Y8adbJUjgSe9ayR
         yO5vgvDWxlAskhJoxs7gLDV7z90M4c5hTTn7ZoTzaC/0ksGTuUevFdvu7htJ+Yqa37w+
         Vi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3kHcmoqkZhWZ4oxxNqqC7HGSrDg94q7cDYwU1R7wZ0=;
        b=b6Mk+Od8+8cuUFivRJziEUFBqLrlgmoP9BjLD2xFkoTKo8+xiske25+/NHkMH0stVY
         W9rmur17bWLQkJ02gYPc1QV+/tq8JgSW42Nj9CLugAvFpgm46hWcoctMDmYd9mHzDlI5
         oE64pa6HY5pcbXiqxeOuYD/7VM9yag/+PjIFmWh1BFdu8xtxLwC9GKxeyqnk0Wal4WCC
         dxR7Jco7a5PPfqm/y4QlpuUBj85k/55G7RoMPPlUPk7cCwQRkX7McwUQmm+ZLb7mzJAz
         31n/+vX71InUAFpboLMhUa2i5PJOa56CzZDKrY0KYWiP9auORZ0YzEQI/Qg1NFuBAwi6
         Yv5A==
X-Gm-Message-State: AOAM530N9xSkh5sfrOakVS60ftDveulQH3Ibj7rzzDon60x4XJtA/zzP
        Qzhc/pPqqs6a3YpRFH/9DBMeTg==
X-Google-Smtp-Source: ABdhPJwsSC0UeTUN9Csfj74emOCu/UtJQH5pDIqnq5THkRvAxrdrQ5fybem8qUGk6n26vzyQHj4srg==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr53013495wru.418.1594132692517;
        Tue, 07 Jul 2020 07:38:12 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrea Venturi <be17068@iperbole.bo.it>,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v2 18/28] ASoC: sunxi: sun4i-spdif: Fix misspelling of 'reg_dac_txdata'
Date:   Tue,  7 Jul 2020 15:37:32 +0100
Message-Id: <20200707143742.2959960-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Property name descriptions need to match exactly.

Fixes the following W=1 kernel build warning(s):

 sound/soc/sunxi/sun4i-spdif.c:178: warning: Function parameter or member 'reg_dac_txdata' not described in 'sun4i_spdif_quirks'

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andrea Venturi <be17068@iperbole.bo.it>
Cc: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 86779a99df751..326dd45e39dab 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -167,7 +167,7 @@
 /**
  * struct sun4i_spdif_quirks - Differences between SoC variants.
  *
- * @reg_dac_tx_data: TX FIFO offset for DMA config.
+ * @reg_dac_txdata: TX FIFO offset for DMA config.
  * @has_reset: SoC needs reset deasserted.
  * @val_fctl_ftx: TX FIFO flush bitmask.
  */
-- 
2.25.1

