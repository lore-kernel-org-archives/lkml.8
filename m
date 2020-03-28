Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2655BC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 14:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE5B20716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 14:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSsqhZeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgC1On0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 10:43:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44680 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1On0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 10:43:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id m17so15214549wrw.11;
        Sat, 28 Mar 2020 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/2SFge/OdI1F8toHlmSSduR6vURBBGjynFQSbrlzXYo=;
        b=BSsqhZeIQw2hreUjt12CyIbXJE5/JfOfn8ZMxQUXwOmt4N60nxhcd2zUF8lNYol44g
         JifG2Qcu4wCFExZTmmBap7gF05fngPYfrC/TXWgD5bbu3jnqu96YX0g95Q8sAMuzMumD
         qaZL610CZYSq4JeYF+ZIvr7dZoWD2ojEmNcgQRgy+Ed0OleVQLxupORQaEMzmkKUUov/
         3nYXOHsizmdWW2R0i8grGzxoJlAFFRr4IpuhValols/me2eANB7vayKX29m2BSLqO9eL
         57Q6S1xNETxYO1O+dnVN/ggyyekxoMoffqEigQV03JLpXVGXfLIp4S458CfV1U9fUDZ6
         zMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/2SFge/OdI1F8toHlmSSduR6vURBBGjynFQSbrlzXYo=;
        b=TDzFVgCsPq8PQ8NfO9hd0p+kfOyoBvUJhtUe9K50EvlILqCTly+GnX9DDblNfDXyZk
         0bYTaq13/Hov3fvNga0orOG0vIyF0f24ys3dX5szPqHOZoLpS6FkQlmVgIkbNh6wiesD
         4XocpJ3qrE1lS7JDpm7m8EpF1aybpYpOsqcIrGTnxcE7E6Sg/KGM1F33cg6SKTwe3J45
         ZqjYXD99XON4xD/BlDwBWoRc/+sNAKsq+rRZnxu9IJq/HUsH1dnzsPwyVSgjxOGlgr9e
         qNckr2jfcLIalK0s/6jLKzHE8ZidZ5GKdnPQfN9gTWAkxcUqNyfzPbIlNxVIyhIT/uq2
         MVMg==
X-Gm-Message-State: ANhLgQ3i/pWUu1sQfOsIXIxnvuFyjY2VBs0vIIcxmHoNF//qphMJTUS+
        zXxfvDj0FvlTU+a3ZJALDus=
X-Google-Smtp-Source: ADFU+vv2yZhWereLXqJ6pe5il7BA2inBYqd9HZht8WcTZT+wAFgTcNGXBqPQwf7j2EAnolzDiXl6UA==
X-Received: by 2002:adf:8182:: with SMTP id 2mr4913477wra.37.1585406601132;
        Sat, 28 Mar 2020 07:43:21 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dbb:cb00:7d36:e5ed:6ff6:44e4])
        by smtp.gmail.com with ESMTPSA id k133sm12661570wma.11.2020.03.28.07.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 07:43:20 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: clarify maintenance of Gemini SoC driver
Date:   Sat, 28 Mar 2020 15:43:06 +0100
Message-Id: <20200328144306.574-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 68198dca4569 ("soc: Add SoC driver for Gemini") introduced a Gemini
SoC driver, but did not add the driver to the existing ARM/CORTINA SYSTEMS
GEMINI ARM ARCHITECTURE entry in MAINTAINERS.

Hence, this driver was considered to be part of "THE REST".

Clarify now that this driver is maintained by the ARM/CORTINA SYSTEMS
GEMINI ARM ARCHITECTURE maintainers.

This was identified with a small script that finds all files only
belonging to "THE REST" according to the current MAINTAINERS file, and I
acted upon its output.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20200327

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b8abe756ae0..ae02568afa25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1729,6 +1729,7 @@ F:	arch/arm/mach-gemini/
 F:	drivers/net/ethernet/cortina/
 F:	drivers/pinctrl/pinctrl-gemini.c
 F:	drivers/rtc/rtc-ftrtc010.c
+F:	drivers/soc/gemini/
 
 ARM/CSR SIRFPRIMA2 MACHINE SUPPORT
 M:	Barry Song <baohua@kernel.org>
-- 
2.17.1

