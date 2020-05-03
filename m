Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7AFC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 02:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918C62075B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 02:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X99OffZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgECCNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 22:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726309AbgECCNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 22:13:38 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C98DC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 19:13:38 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id c2so8724111iow.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 19:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ADBzBpzQBfvhpPbSyYsUI5c3id2/Hsq5Y9mJHgKc+Eo=;
        b=X99OffZulaIQy55n/XoFOgsOhCNRhrtFlbmNo+LvRGdSEGiSq5R64AzVm97MOBqcwg
         Vj5xle+GwVCdMgBf3H3QXNz1edKykbt8A/jqz6O2mko1RvrdN13Es2voy5idebK7Q1UB
         l4Xk7EpZq3zurrQJuOFE19FxoE+UNNizmHK+JPkap7NFpykoE1gQALc4wBEgyS8lu87E
         ASBB6e/4X4iJwFbesFjW3XYWy9yO3t4Jiw4wzs7QkTJSnIRNFwMzmm4RJJTLW0t53OvW
         0GbqWV0drUYe5sz/LWdNTT8m9hoTKT+0FDSqbt65RMsH9ZNbVjLbGMKNw5v1hW0rRa/x
         siHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ADBzBpzQBfvhpPbSyYsUI5c3id2/Hsq5Y9mJHgKc+Eo=;
        b=QPz+t/38VsSJo+c0zzBw53/UAeZ9AkepPNCx9xuXc8dVOEX4fcvRqKxO0zJ7EIQZI6
         qlstRYq3QwmtFuPRgnEaoe0aD4WMzt73odMgXMu8Mlfr9vYDe/3n9nPc37wpzJmJ1pJ7
         7n7ueyLTmm0hqBxTppQvDOMNt/q5p/gqJfR00Jmw8v1211irqnunS21SMA6n0pZ3rX96
         QhWIfqr5BXIt46C6BijyH6qRvrRVGu5xnJ9oYbzL9X2zVHyAMWZrn4tNbG5tydxodol7
         iTz0XllX9ai9AEKpTkvPv7Hh8pDOMCJ7asFMz6tMzbySV/5NoRrBwQSq2eLiihw5lb32
         RYLw==
X-Gm-Message-State: AGi0PuZiG5qHkeoY1Szkh88sLduJZYPFA7RarbNVjmIDyVSkQYLfzOo2
        YAdzwJwUe0QArj96OZE8ILc=
X-Google-Smtp-Source: APiQypJwjvuaGmWqLfLEU60RIdP8e5Rl6o+Oy7lzMz6QgXAUAvXDV0syrDiMqlO3lG22rCbX4utrvw==
X-Received: by 2002:a5d:9c02:: with SMTP id 2mr10123761ioe.67.1588472016156;
        Sat, 02 May 2020 19:13:36 -0700 (PDT)
Received: from localhost.net ([2601:681:8600:14a0::c42b])
        by smtp.gmail.com with ESMTPSA id w69sm3069491ili.76.2020.05.02.19.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 19:13:35 -0700 (PDT)
From:   Eric Yu <ejyu99@gmail.com>
To:     hsweeten@visionengravers.com, abbotti@mev.co.uk
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Eric Yu <ejyu99@gmail.com>
Subject: [PATCH] Staging: comedi: drivers: ni_pcimio: Fix variable name
Date:   Sat,  2 May 2020 20:12:47 -0600
Message-Id: <20200503021247.250785-1-ejyu99@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a variable name that was Camel case

Signed-off-by: Eric Yu <ejyu99@gmail.com>
---
 drivers/staging/comedi/drivers/ni_pcimio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/ni_pcimio.c b/drivers/staging/comedi/drivers/ni_pcimio.c
index 7c82d5f9778f..c1d70eec24ab 100644
--- a/drivers/staging/comedi/drivers/ni_pcimio.c
+++ b/drivers/staging/comedi/drivers/ni_pcimio.c
@@ -1214,7 +1214,7 @@ static void m_series_init_eeprom_buffer(struct comedi_device *dev)
 	struct ni_private *devpriv = dev->private;
 	struct mite *mite = devpriv->mite;
 	resource_size_t daq_phys_addr;
-	static const int Start_Cal_EEPROM = 0x400;
+	static const int start_cal_eeprom = 0x400;
 	static const unsigned int window_size = 10;
 	unsigned int old_iodwbsr_bits;
 	unsigned int old_iodwbsr1_bits;
@@ -1234,7 +1234,7 @@ static void m_series_init_eeprom_buffer(struct comedi_device *dev)
 	writel(0xf, mite->mmio + 0x30);
 
 	for (i = 0; i < M_SERIES_EEPROM_SIZE; ++i)
-		devpriv->eeprom_buffer[i] = ni_readb(dev, Start_Cal_EEPROM + i);
+		devpriv->eeprom_buffer[i] = ni_readb(dev, start_cal_eeprom + i);
 
 	writel(old_iodwbsr1_bits, mite->mmio + MITE_IODWBSR_1);
 	writel(old_iodwbsr_bits, mite->mmio + MITE_IODWBSR);
-- 
2.26.2

