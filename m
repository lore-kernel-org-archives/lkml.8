Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E82C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095F224689
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="g0A0bJhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgBZOdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:33:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39324 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgBZOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:33:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so3294469wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 06:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zlZyK3svN4WBZKEOPHCSggdPRdTBurhSqa9+zLUZBzs=;
        b=g0A0bJhBhkX0HoST7bDkms4BVbZ6uw0t+zDPrWtG5s9fvzviAZAx24pvQFm+c4Ydri
         weN0d3ghPwndlSDWzGF34jUm7esyVBfKUH1nY69vY8cy5YuPRkwVuRD+Gznxk5+hLfF0
         hwU/cBvK/mENqL3Wd2IYVybWA2u9e9NISQ9HhN9FL9OkXUEsJHeNb78shv/YpV57bXTT
         oviTbv+1R5I+CAwPY0JPPIRucAkbKNRX+FP+5FsipVal4uwAlkyRvoC4nSIROTn0uHi1
         YEtwOJ31y5VMFux/k2iqbak7/bRx/lLFKOvvaWB8UinfBfrQSOuDpD3wzWVB/eVbv9qp
         0Pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zlZyK3svN4WBZKEOPHCSggdPRdTBurhSqa9+zLUZBzs=;
        b=Fd9PDix/AxR19K7wPLHdWVaKTyzA1k6a7+leK5peSsQtxlAJX7PDTtDTGWOQ5OyUk/
         Ca/WNHYxigXctoqOLegtWNJJewJ2ebI/QsxjjqixtH/zZoEuhZUsNOOrSXq70S2FLb7Y
         gYKpXbOo989noAQSIg0jSW1ntLQH21IVwnmTRDowjJtSepLd1/wa51KtgdxRoEgJ84Eo
         noLKDe3DSOrB/K630/P0igxM/83inE/Vmm94cdwnQBRd8L14iAmUZ7bE7L6GZH56gcmN
         9b7dobaaFGEuwgDrp+2u0iKqwXPm+mBPLvWp9aR2bUJWXqvAOZX04V18lGf5oavzCxdN
         tKNw==
X-Gm-Message-State: APjAAAXcgH+uzG6Bf18Fa28S3/5Y3K4WJq+wGPHXphHTj7P0xM3p8g5i
        oclNt5TzQBjov1SjhUV4WyvomYwFxAg=
X-Google-Smtp-Source: APXvYqzoa1aSdZQU0DPuoUSUZIdqy4ht2oFqWEkDi4IRjOwzpFDAmZ4HCqS1k5yoVlbtQ6fA8k4/Mw==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr6118603wrv.358.1582727614391;
        Wed, 26 Feb 2020 06:33:34 -0800 (PST)
Received: from nbelin-ThinkPad-T470p.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h10sm3204198wml.18.2020.02.26.06.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 06:33:33 -0800 (PST)
From:   Nicolas Belin <nbelin@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com,
        devicetree@vger.kernel.org
Cc:     baylibre-upstreaming@groups.io, Nicolas Belin <nbelin@baylibre.com>
Subject: [PATCH RFC v2 0/3] leds: add support for apa102c leds
Date:   Wed, 26 Feb 2020 15:33:09 +0100
Message-Id: <1582727592-4510-1-git-send-email-nbelin@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the driver and its related documentation 
for the APA102C RGB Leds. It is based on the Multicolor Framework and
must be applied on top of the Multicolor framework patches located at
https://lore.kernel.org/patchwork/project/lkml/list/?series=427513 .

Patch 1 adds the APA102C led manufacturer to the vendor-prefixes list.

Patch 2 Documents the APA102C led driver.

Patch 3 contains the actual driver code and modifications in the Kconfig 
and the Makefile.

Updates since v1:
- Moved the apa102c line in the Makefile to the LED SPI Drivers part
- The driver is now based on the Multicolor Framework.

Nicolas Belin (3):
  dt-bindings: Document shiji vendor-prefix
  dt-bindings: leds: Shiji Lighting APA102C LED driver
  drivers: leds: add support for apa102c leds

 .../devicetree/bindings/leds/leds-apa102c.yaml     | 154 +++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/leds/Kconfig                               |   7 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-apa102c.c                        | 291 +++++++++++++++++++++
 5 files changed, 455 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-apa102c.yaml
 create mode 100644 drivers/leds/leds-apa102c.c

-- 
2.7.4

