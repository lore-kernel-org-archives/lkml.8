Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F011C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D990222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cL0AUTWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgBSIti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:49:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53148 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBSIti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:49:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so5522939wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 00:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OjifpqqKo8DYjh9Op+2jQZP+EdT+EofXUxP9wt2jCM=;
        b=cL0AUTWKkL3rtprOF9RpLDm5fmboSeErTyBaUrZyTXIVwyjd2UZbhz7UXzd41KXKSu
         GtzArdjwHOOlaTPmYly86hCsUAO6Kiuo4+qkiRbTbhiXW6L98n3m+KB4Ov2b8ZZ/W00t
         tS1+dbs8cLorG4nJKCTUZE9NB6Zfv79l+EmzFTRSeO4gHTa8YaF2vuKVRwTtMvXZQGXw
         NnbXs9vgvD9UcuqO+woNRCzj9Axf6ce7Qm1Ezd60IqfbNXGky78jEKUE0CkOiIcodjuk
         yjSpSbGXIh8/W2H31lwVaVjGWQ+ABciWuEJJ7JWtBu1yIuE9wd+gbzEAjgIja/YR0Cl+
         t+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OjifpqqKo8DYjh9Op+2jQZP+EdT+EofXUxP9wt2jCM=;
        b=iq7wVCF9huAoFwLeT3cZBq5AsIuKtSm52+XXp4W8ipuYQDR1WoKiYfviqqk3tWMDNh
         xxG5di/Mo681lG0yhdN5reu5WO+4Gstp5Fy7/wZDYt3h13tstyh6XCHFM4kQQxhEYT+T
         U48Hxr9akw9ot6RA2t3hzP0QnsufIqT20tMGHTrwUTD1Qy3svRMJ/TyJKZSxwFoqJ9ME
         qfi0wM12Wz7ABClANjC2VcTCVFyw2mKOG/QkoGSzwiNuHfh0E+NFEP3M96CyUjxy55AI
         WGI3mSwSUfmaP1BXXYAG8gH+3c8BkKTtYbMdldewEkPMzZFS/94sNYZCFGwjH+0WesDX
         VUgg==
X-Gm-Message-State: APjAAAVTYDu6nV6KlVmLNbMkasun4r/h216fYPw3DgDh5MwHeSdK78wd
        yVCsKJmJeHL0yiOHA3fVwNd4SrOckVjQDw==
X-Google-Smtp-Source: APXvYqyL5YkCPYRHLJKYfuh+lPCFN7xEaXE4fRNEWpjsiEPxFXo/1CgZlKkY9CP7IToKY/NzXjDeCQ==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr9278562wmg.16.1582102176198;
        Wed, 19 Feb 2020 00:49:36 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t13sm2021673wrw.19.2020.02.19.00.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 00:49:35 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] clk: meson: g12a: add support for the SPICC SCLK Source clocks
Date:   Wed, 19 Feb 2020 09:49:26 +0100
Message-Id: <20200219084928.28707-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like on the AXG SoCs, the SPICC controllers can make use of an external clock
source instead of it's internal divider over xtal to provide a better SCLK
clock frequency.

This serie adds the new clock IDs and the associated clocks in the g12a driver.

Neil Armstrong (2):
  dt-bindings: clk: g12a-clkc: add SPICC SCLK Source clock IDs
  clk: meson: g12a: add support for the SPICC SCLK Source clocks

 drivers/clk/meson/g12a.c              | 129 ++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h              |   6 +-
 include/dt-bindings/clock/g12a-clkc.h |   2 +
 3 files changed, 136 insertions(+), 1 deletion(-)

-- 
2.22.0

