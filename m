Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8E3C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1135E2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OkpOrPJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIDQCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIDQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:02:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E68CC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:02:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v4so6537872wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WPWs6+bNAsvF0rvAc3yDkiD79Fr0V6X4UpT2H9wqL9w=;
        b=OkpOrPJZjs2Y0PihfJ7PKAOhPKi+QXL4WLgx95wnrgwebxFXuZPO471OqXLrfRoYPw
         W88jgdiC3dytG8y7rSPSpp+QNgisq043YZXmCVQ9dBEcxIN9ABSt5YaSUwE/K0puhnZ4
         CjEXXPkmqV9ZhBsRr/uZvM9BAmbPYn54nsjTtrqnRA0v9oBqkuCyGS8+D3cz5nub6xIo
         gURl08C/czURvIgKQ9TOxjZbmJ/xgAyJ/75NW3bXcO9xX6el1jKLTxNRAaH8F4XFcPlS
         l+Z8a+Hy7DpKDllQBV4TVm4MXt4XfwcwCSmg7/jR7/k+LHRQ/52KMId1KfaVH9M5MHWl
         qkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WPWs6+bNAsvF0rvAc3yDkiD79Fr0V6X4UpT2H9wqL9w=;
        b=PQzm2Yfj0gzB8AduCwTKP73N4Wl5EIhNmmRDjxgkgKPdcvWSeTEQBNkAJ2wZJiCQm/
         yH9TyMmaoU5zJfH8hSb27LnqQ9+/BwZScBFhZOoQfaESVIqTA4rXcV9GJ/52lzhtcDhp
         gIJLdEWnqaogtl8iyVw54evWOA+NdLF3Tm7hIuspaxTjebGICT/+kcCaLvezEoey0AyP
         XSYbR5kBaYzF1muv/GAJfLPkRlxJb+rkotjH0AO5kOcPOIrba+fuHo5/ItuIqzxtJUGg
         tFj4IdNjCnM4qBdA9+y5vas3O9uCxwcAucBcS3oJE7JFCLkznOyrG76zl81/jKbbBW+R
         JYPw==
X-Gm-Message-State: AOAM531S9Fjle2hkLNuj9wEfq4wpI5seC3x56KI4RptLc+haYs6ykFtc
        jACQs6QEpAV8TWwo8jaN9onixQ==
X-Google-Smtp-Source: ABdhPJxqrPj4FqwNvFmd29r1spI/ZIQGafj/o4jzYrlvzXdLjkT+3k5breq2rCLBzbh5/WkV2rdDrQ==
X-Received: by 2002:a1c:ab55:: with SMTP id u82mr8388426wme.139.1599235328834;
        Fri, 04 Sep 2020 09:02:08 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id i3sm11938627wrs.4.2020.09.04.09.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:02:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] soc: amlogic: add support for the Meson AXG Power Controller
Date:   Fri,  4 Sep 2020 18:02:04 +0200
Message-Id: <20200904160206.22570-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the bindings and support for the Power Controller found in the
Amlogic AXG SoCs.

The Power Controller in the Amlogic AXG SoCs is similar to the GXL one
but with less VPU memory domains to enable and a supplementary Audio
memory power domain.

Neil Armstrong (2):
  dt-bindings: power: amlogic,meson-ee-pwrc: add Amlogic AXG power
    controller bindings
  soc: amlogic: meson-ee-pwrc: add support for the Meson AXG SoCs

 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 23 ++++++++++++++--
 drivers/soc/amlogic/meson-ee-pwrc.c           | 26 +++++++++++++++++++
 include/dt-bindings/power/meson-axg-power.h   | 14 ++++++++++
 3 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/power/meson-axg-power.h

-- 
2.22.0

