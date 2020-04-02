Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2532C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A414C206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zGjcgAXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbgDBJe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:34:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36383 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBJe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:34:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so3348453wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 02:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/JfishAOGXVYoBQSrKHeYa8JDBK0eNBxRAqMOtM/eC8=;
        b=zGjcgAXJC0cvkQmg5AHOFLWM6LOrm1MKo973ZuXAsPEPdIABiL61jdtlfMmJwR1TjH
         QmQNINPbryEdS+wLf8cunhwUEThDmQxncJ3zmmsr3+hEfPCCD5OFCpFoDarDgT6/64wC
         CeiZLojAXT0zfweEhRHskaN6gcDBiryNcNJL61J+s33E3OKhWty58K5GHdVfIiOgWBmH
         x6LAizpOYmtrOpNJ6am3nyAARiSMWQv+WBLrJBT487lybtC5nmpDpQbUUd1FRRg4WwA1
         D6RD2KfQp2g5Jgxn7FvVb5ZZCeqUwlzbisBQx1idmVk2aZrlfdQN+RGfX2I+wB1YjhrG
         7F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/JfishAOGXVYoBQSrKHeYa8JDBK0eNBxRAqMOtM/eC8=;
        b=fu4xX7wDVFAb6UaZeG4+9lVJYihjtK7apkA80LzTbb61JCsFnSxkzzlQhcGbkLc4an
         vCqJS1bMZwxPKxANtgmILtlECW5tds+pOluBrNtY5gEqblcrIvfyyuel+uZlrYUEYShZ
         nMnfA5bmL0/kRGSGjEg0e3y7hX+sjwPzZpSEldFOoATXati3ECPzJnyDmjItrI5pFI8Q
         EvT8heaox2hnyNoSg155JzHzp/Y42DoZkKHuWo3CRYo7JSXrI1OsIB09ija0Ltp3EBI7
         RYw8nhZ7SAz9usx4P3K7cN96GQa5Rm12jW6VtxDzx97lnvroJ4wcaw86xf8tNto1lfel
         Z6yA==
X-Gm-Message-State: AGi0PubjtJ5Kmz3a5xmVsJMGDjgzjN0oBmWVufb6zI5hoW6CJtOtjmeB
        Rz7zHGKg+irMb84oo/a9K7J5JA==
X-Google-Smtp-Source: APiQypKmqFjl8B/AWQFjq2q5ZN9yvy7ZyTVYBSo8g0LRGX2p1bc7qJ2fARK4rAjHDfe7Zu/GTRGgdQ==
X-Received: by 2002:a5d:6182:: with SMTP id j2mr2487136wru.131.1585820066899;
        Thu, 02 Apr 2020 02:34:26 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 189sm6528042wme.31.2020.04.02.02.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 02:34:26 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linux@armlinux.org.uk, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ARM: configs: sunxi: Add sun8i analog codec
Date:   Thu,  2 Apr 2020 09:34:21 +0000
Message-Id: <1585820061-24172-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my orange pi PC, I got lot of "sun4i-codec 1c22c00.codec: Failed to register our card".
This was due to a missing compoment: the sun8i analog codec.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 61b8be19e527..b105ce7120cc 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -107,6 +107,7 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SUN4I_CODEC=y
+CONFIG_SND_SUN8I_CODEC_ANALOG=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
-- 
2.24.1

