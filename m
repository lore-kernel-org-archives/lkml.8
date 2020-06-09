Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4BAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A30B207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8W9VqQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgFILJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgFILJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:09:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29400C05BD1E;
        Tue,  9 Jun 2020 04:09:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so20786370wru.12;
        Tue, 09 Jun 2020 04:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2QWlVvw4wMKxc+Ci1vOHG2QgW2mAuzBv8Io5LaqvsY=;
        b=J8W9VqQY47yQ3goeW3AiZJ5iJ+v+clrOD3aA3OeD9dUgQmmjMW66bxrsz8bxNHf01G
         JZOmIh1wEQw8cJ3S47Dxnrak4Agc+skqReoktOthEI42eh10c+gJuhbuY++z1IPY40Sw
         XgCWC+KjyJ8rn0A+E+UmJxoJVe2uRfInHNh+EPGMUvjBUhHg0sjDboEs2olUjRprD6Ve
         MgPPkT2nL57j43LAytSt3oZ7HD3ceOHYfDCRheMjnloTjPgwgxRMuJmtkpt9fZ+1fhNF
         2luElT0L3weZLr1z9SWccJurfTCptjXNFprbS2ugIlYNeqAnutnzy+k0ayt75WM9cmAo
         mgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2QWlVvw4wMKxc+Ci1vOHG2QgW2mAuzBv8Io5LaqvsY=;
        b=lz/iyIUB44bgxUMDt8ZjEuZz/pEww0eKAl6elceAbTjihfa6H+sOBhH/ZjHFr7GMn6
         fivchpyxojy/Cq6L01o+bXHNzXVYuxYcjVZA6d+gB9w5DSE/MIYicsfL/zUtUTedpPDl
         NETXN0akYyH8dGY5oMkms6Ljdg4Sj1ms605tNwANn3OlWm/EBmLZcxE81sBaNMtSScCr
         pCdUopAVmHYZE0z8NRYebT6qkK9O+Fp8P1COtnA4KAlO1YK3oyUPVqbRtXQst1jawRJ7
         Dobz5SJS83A/8UN6cTG224bcYIORqheZFo2739BYcsRSFOAO5cTThzew3g86tCBH2cPa
         /yDQ==
X-Gm-Message-State: AOAM5336xrSpWjhCjV1zcyCa6eKp263F75N2VV/s2bQgKrIKkPSFciiQ
        5Tj/8ioPM9ZGi3CaZcMzT2E=
X-Google-Smtp-Source: ABdhPJy6NSqRlaJHFiqgB5y5VcHEXb+bOeM3VNkWU8A02NM2pDVyEvDQDt+uk8yfwIGYHEbZQP5r/A==
X-Received: by 2002:adf:a449:: with SMTP id e9mr3814645wra.294.1591700941883;
        Tue, 09 Jun 2020 04:09:01 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id u3sm2988203wrw.89.2020.06.09.04.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 04:09:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, lkp@intel.com,
        jonas.gorski@gmail.com, f4bug@amsat.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH] clk: bcm63xx-gate: fix last clock availability
Date:   Tue,  9 Jun 2020 13:08:46 +0200
Message-Id: <20200609110846.4029620-1-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make the last clock available, maxbit has to be set to the
highest bit value plus 1.

Fixes: 1c099779c1e2 ("clk: add BCM63XX gated clock controller driver")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/clk/bcm/clk-bcm63xx-gate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/bcm/clk-bcm63xx-gate.c b/drivers/clk/bcm/clk-bcm63xx-gate.c
index 98e884957db8..911a29bd744e 100644
--- a/drivers/clk/bcm/clk-bcm63xx-gate.c
+++ b/drivers/clk/bcm/clk-bcm63xx-gate.c
@@ -155,6 +155,7 @@ static int clk_bcm63xx_probe(struct platform_device *pdev)
 
 	for (entry = table; entry->name; entry++)
 		maxbit = max_t(u8, maxbit, entry->bit);
+	maxbit++;
 
 	hw = devm_kzalloc(&pdev->dev, struct_size(hw, data.hws, maxbit),
 			  GFP_KERNEL);
-- 
2.26.2

