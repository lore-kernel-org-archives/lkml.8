Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA1DC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 13:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AF7206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 13:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6vPkonj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgC1NnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 09:43:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45539 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgC1NnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 09:43:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so15101165wrw.12;
        Sat, 28 Mar 2020 06:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UskpCEE5TUQheW2HfAHjtymRH8q/A2y17+Pe+kWt7r8=;
        b=I6vPkonjI1vmCLWrBbdBoShliZoMh2Q0CP1gRdVhAMsW1q/U5UeFVxKasJ6haMM8vg
         MmHM+eFI0T9PqRASKHYBxuCRzcVTnPEjn5ehRY09aiuBMv0Z5a2YF/HdeSeMYaAq7w4C
         fs6HKV8UGQ/oWYUMdz9ErBoML7qBrhSoXEL2gG8uWkxf6gcHBPcv7nQjq28bzOGNrTg6
         hpo2BRgAFChXpRjKqFfi6809WhdkanGteLp6KPH/K6+sr7juGPENz4KJHfDsJR8zyYC+
         ZVQCJMnhTgkPi/8G5U22gJyJFmpsoNbAwzWb4R05Ou4ipJE9YZ6GxMaTujlI8kS6+WbF
         NqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UskpCEE5TUQheW2HfAHjtymRH8q/A2y17+Pe+kWt7r8=;
        b=h5Nnb8nmI7cXR6nJ8A5oeK6dmL6HVLmpxjSTNTw2IxLFp+DaWUHbku3dbGTZRd496R
         t5nKzCNJ+l++02WZXOi/tDkYELQ2wyM9N76Qqovm9D1d9ZA5cjyQp2OZmulJ6u1QQVGz
         7orZ3NCIaVVx7EABZBCIw2ijJH1wdabbAsMpKK6tYQ6+XxC8VSwddXd5HEqWjeveBNFG
         A1TS3wktzOUAQg7e2s0MvgDXQfisn0J5mtR5O3GD0zST+5j9jFo4VpFYPTZDdRCrvxaL
         Cisu9x7dsxMRdnCALVCvVzCnZs95dxXeFLcvYxCB6KMkvhY+SIJbEEYYBEKuHHE1OJNm
         aSUA==
X-Gm-Message-State: ANhLgQ3CT5Ji7qs1SePNXkTUdW4NmkJ8CByzeY7aCcOZDnRQhRmk0ps9
        zIk/kOnkXC/nexgw1hz091I=
X-Google-Smtp-Source: ADFU+vu2jQ5CPsH2nB+2wu8Fp2D/gjd/7NJkKh2i8aKtFr+9rflUKnTWCv7i56dVnn7DBT/CUl6oRw==
X-Received: by 2002:adf:cd12:: with SMTP id w18mr4841366wrm.311.1585402994449;
        Sat, 28 Mar 2020 06:43:14 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dbb:cb00:7d36:e5ed:6ff6:44e4])
        by smtp.gmail.com with ESMTPSA id 23sm11515974wmj.34.2020.03.28.06.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 06:43:13 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: clarify maintenance of ARM Dove drivers
Date:   Sat, 28 Mar 2020 14:43:04 +0100
Message-Id: <20200328134304.7317-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 44e259ac909f ("ARM: dove: create a proper PMU driver for power
domains, PMU IRQs and resets") introduced new drivers for the ARM Dove SOC,
but did not add those drivers to the existing entry ARM/Marvell
Dove/MV78xx0/Orion SOC support in MAINTAINERS. Hence, these drivers were
considered to be part of "THE REST".

Clarify now that these drivers are maintained by the ARM/Marvell
Dove/MV78xx0/Orion SOC support maintainers. Also order the T: entry to the
place it belongs to, while at it.

This was identified with a small script that finds all files only belonging
to "THE REST" according to the current MAINTAINERS file, and I acted upon
its output.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and on next-20200327

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b8abe756ae0..38fff0374082 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1979,6 +1979,7 @@ M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 M:	Gregory Clement <gregory.clement@bootlin.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+T:	git git://git.infradead.org/linux-mvebu.git
 F:	Documentation/devicetree/bindings/soc/dove/
 F:	arch/arm/mach-dove/
 F:	arch/arm/mach-mv78xx0/
@@ -1986,7 +1987,7 @@ F:	arch/arm/mach-orion5x/
 F:	arch/arm/plat-orion/
 F:	arch/arm/boot/dts/dove*
 F:	arch/arm/boot/dts/orion5x*
-T:	git git://git.infradead.org/linux-mvebu.git
+F:	drivers/soc/dove/
 
 ARM/Marvell Kirkwood and Armada 370, 375, 38x, 39x, XP, 3700, 7K/8K, CN9130 SOC support
 M:	Jason Cooper <jason@lakedaemon.net>
-- 
2.17.1

