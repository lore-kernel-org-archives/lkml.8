Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4EAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E07D206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVz8Oiap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbgF2Txa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387790AbgF2TxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:53:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0969BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:53:11 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q198so16466075qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oyEodCgkXhNOrxY4Db2raIEhJBe/zcrPZ6JM1bawZr0=;
        b=bVz8OiapgEka8x6YtNWVDwk6aWW04aYZrWQR1RhB3i8t5MbJ4ylwQLukcm9wzGU/40
         tLZ0D7YQrL9fWT3i0zp4Tkh4NN+IDCF7wdSaKO5oN7ARFc6wClflvVFZ/queIBBjAB8T
         nIMmXoJBEQL3RM7KH/VVoktOklJgn4lUTRkXFNq+dhL5EX6KCGfuIBdUKCU+xN6f6cQF
         PTdLT6rqPyEouO2b8FWpA1wZFNGBo9w8WvD1v+/t+iF5AmjOlizau0LWULoERm93Ybkb
         eYTNBycgPYOHH3JLAHWoaluu+mVeeqJpcD2aaRD9WwWAMgRy5ZOzbxxWH8LL4kF4O+Mo
         2wKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oyEodCgkXhNOrxY4Db2raIEhJBe/zcrPZ6JM1bawZr0=;
        b=fnsZwncZuomIte2eSc1uvp+1ooCOtc174jpQ5SvAccYlM8AkTPVrUu3mf7CNDKQfho
         g/BrVu2lR7K45YNMqX9oM/MQVI49KQ15+T9lj3gm6rkJimzUUMk/wLzqRv7RTMQ0NBb7
         wyVSi1/jmSCa2aMqeiVAdHLPDTJkmETE/zpWDWbd5OfiqoDpz6HBRjGXuYkxURKeIvt+
         a6CXoCmjrIKc15mksFSUpBOiR5ikkx1+X77Spp+pakzDYfKaqNgRZlhmywIXV+F/Ev7O
         uNlwGtUjBUZGAU3y4D0YtESFn3Wg3gXQE4kz8r+tG7N44yBMtDff0ESBP/H4Hf9zsAEu
         D80Q==
X-Gm-Message-State: AOAM531Mtse17K3h5BpwHsTtxm7em7p/mWo3AJ8TwesVU2uvojgCnNpO
        xKXROSyQmueNK6rlmgHfQIo=
X-Google-Smtp-Source: ABdhPJwX18jDoBGiBdMyQNJUUV/2hvnsDjfOh/ZD9ytFt9u/2MrGF+GqE0gb225g6POrhgTsWW24mg==
X-Received: by 2002:ae9:f814:: with SMTP id x20mr16596296qkh.253.1593460390137;
        Mon, 29 Jun 2020 12:53:10 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id e25sm655098qtc.93.2020.06.29.12.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 12:53:09 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: spi-nor: Add support for Winbond w25q64jvm spi flash
Date:   Mon, 29 Jun 2020 15:53:06 -0400
Message-Id: <20200629195306.1030-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip is (nearly) identical to the Winbond w25q64 which is
already supported by Linux. Compared to the w25q64, the 'jvm'
has a different JEDEC ID.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

v1 -> v2:
  - Tudor Ambarus: name the chip "w25q64jvm"

Tree: 5.8-rc3

To: Tudor Ambarus <tudor.ambarus@microchip.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

 drivers/mtd/spi-nor/winbond.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 5062af10f138..18bdff02f57f 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -65,6 +65,7 @@ static const struct flash_info winbond_parts[] = {
 			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 	{ "w25x64", INFO(0xef3017, 0, 64 * 1024, 128, SECT_4K) },
 	{ "w25q64", INFO(0xef4017, 0, 64 * 1024, 128, SECT_4K) },
+	{ "w25q64jvm", INFO(0xef7017, 0, 64 * 1024, 128, SECT_4K) },
 	{ "w25q64dw", INFO(0xef6017, 0, 64 * 1024, 128,
 			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
-- 
2.17.1

