Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619DDC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2BB206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nhcwFQHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgAQNe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:34:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39991 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQNe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:34:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so22726198wrn.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 05:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vjAqTiagiAJuIt+I855EK59Bh9rAY4+VmlbULB7XjBU=;
        b=nhcwFQHxSnz+dV9GprwXcD4oiIVNjDaE6b4Z1gVtwnuMdXgy9wBTv4mdfd5R+4O5C5
         TAo7O/1EJo74ic9WeT/gzYaFf82RYCFD+QK5oLiM0pNOQ1pIT2V+QduYScl63zLxQ76z
         SaNfuojAetepaWOS6Dsv/Pq0DGjxLzwnzJejxEN1mX/+kqoqPopYtjvGmXSew3k+ZovI
         I2RfdMwx/ybbZDKeMJyZ+BTFcNlBzqdO3/bllaE0SsOp154uL+uFClwqUtx2vIXQOpEN
         AWmk422EV226QO5mnUPx/bOGO3VBNW6O4os+r1vNboWXx6moiX80S2+YHNxweFTEFdkd
         5axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vjAqTiagiAJuIt+I855EK59Bh9rAY4+VmlbULB7XjBU=;
        b=UfmGP04jxQLzvyNTVLTePsLFivC9whWczQ0u77sX7x/jEHwb/wZ5OhvQ534lfHMPUt
         QUtMSvYvLun++ql7jRkjW72n5vd4xO8HTLfT4er9BUC8DHxEE9eHMU8vyaRIqdlKyVMJ
         XKSlTw3y5SiwQcbrU/ETDyrXwyXzTBs4/GJ0NMl/DctdysPqU321+3tILxcRz40JpSnu
         86KDDAfdytgazx8IUkxoPeO/VQgsdovm/PohReH+b06632tuOl8ajiScTyOjAaH2YIo9
         pmqbTiwZlDpBtinyeD0SmsniP9LybrmNUiOVmZ/KFN4QkR9sPmFKqF3PFu+U9F9bjBr5
         hYBg==
X-Gm-Message-State: APjAAAWR16CBjQ7eFwr1rfBZoEo9aEedzGbz32btIfh3Xp+/0ze/kQap
        08LK4uwBlUjT/zcs9xHioIbNNg==
X-Google-Smtp-Source: APXvYqxOLm+eEqyeR6CqcWIOgeXx2VIKnDcC4O+hh0rHWaq9NA0R4QfRWROMPXD9EnXM5xbkRw2jog==
X-Received: by 2002:adf:f411:: with SMTP id g17mr2965001wro.89.1579268065504;
        Fri, 17 Jan 2020 05:34:25 -0800 (PST)
Received: from glaroque-ThinkPad-T480.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o1sm33875961wrn.84.2020.01.17.05.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:34:24 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] arm64: dts: meson-sm1-sei610: add missing interrupt-names
Date:   Fri, 17 Jan 2020 14:34:23 +0100
Message-Id: <20200117133423.22602-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add missing "host-wakeup interrupt names

Fixes: 30388cc07572 ("arm64: dts: meson-sm1-sei610: add gpio bluetooth interrupt")

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index a8bb3fa9fec9..cb1b48f5b8b1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -593,6 +593,7 @@
 		compatible = "brcm,bcm43438-bt";
 		interrupt-parent = <&gpio_intc>;
 		interrupts = <95 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wakeup";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
 		max-speed = <2000000>;
 		clocks = <&wifi32k>;
-- 
2.17.1

