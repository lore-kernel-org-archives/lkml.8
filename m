Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AF5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A1472075A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mJi1fSz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgIGJi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgIGJiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:38:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0444BC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 02:38:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so15024101wrl.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 02:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9bP/xoJ+T6gS3ooO5y+uznagdOfHkS2kkQH3P/gVPE=;
        b=mJi1fSz7M5Lr031HrqOc2vIpZdQEGkG0kniFjTC+Efro5LjGWBiFhbr/W8/CfaGgUL
         8VC2+kZcZjCsAHUtHRfzdynmLK99Gk68kAUZdqRNt6F/VrUlfhgxBv5sdYZRa1Ok+YxG
         70oVXdN2vUs7vNwy2fdxiogKZHzniD9lVkijsf8hKWD+2GfEhgS4TuOY3Cnx1HX9riz8
         kKm4O1vkqHDJSb8/WanZi8DOeK2ALLKVuF0tjKVl9lcmOgS7nA0+TCk4EAKwPHiZaIJ/
         AP81EU26AHAgVP68NhyrEWf62ZfW5jZ3kxvOvXIEXOK1idHlX74cCb28DF2HAGt3GhK8
         E3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9bP/xoJ+T6gS3ooO5y+uznagdOfHkS2kkQH3P/gVPE=;
        b=SEPrG1CPIf5rYncALDCTCcjr/l3IAvdkp115vbQEp2I+9weF6nDKnE3PAy0nZcvX6i
         mg3H3ZlM254YJibktXRCnsOHw8NxQnF4cLF5YsRvULSO0uQ8VYIHNz8f7GX96W9siBa4
         ZR1WpnI74ZEhrmOpMdMQQIF3cglwz+YtjCWLEGAp/yHBcefY0O38nNfL2pzZDGSdMI2V
         2kcHGpZhWpv5xX9ZbGkZ+4loCJo9i8qnysW6WMgCMV/+EzxsDtlMUH8IKhe8GlZlHP3n
         PpZVF/UGfeHcg9yFqDFMlGzsQui2vAQCQY1+QGoXYmRiJz8Np8cRpOCGKQ+FiIUsSg3f
         cXAA==
X-Gm-Message-State: AOAM5303Y6W7Fzkq7D3T9fHDXgTE0qnsR4gbTJogkftJP3AiGh6WMnob
        okDHie5VyGHe9W5vf3qP++mSnA==
X-Google-Smtp-Source: ABdhPJwanebMcJF3b2wK++MK94YD9JrWiXeqBZFXJwRJfjn+8khXs/yrtoWZ3SVcFI6GcFsVI4vi/w==
X-Received: by 2002:a5d:570b:: with SMTP id a11mr17548904wrv.139.1599471493555;
        Mon, 07 Sep 2020 02:38:13 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id n17sm25170687wrw.0.2020.09.07.02.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 02:38:12 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/4] clk: meson: axg: add clocks for MIPI-DSI support
Date:   Mon,  7 Sep 2020 11:38:06 +0200
Message-Id: <20200907093810.6585-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the VPU & VAPB clocks along the MIPI DSI Host clock.

The clock scheme is based on the GXBB & G12A VPU clocks, with a different CTS
clock output used for MIPI-DSI.

Neil Armstrong (4):
  dt-bindings: clk: axg-clkc: add Video Clocks
  dt-bindings: clk: axg-clkc: add MIPI DSI Host clock binding
  clk: meson: axg: add Video Clocks
  clk: meson: axg: add MIPI DSI Host clock

 drivers/clk/meson/axg.c              | 840 +++++++++++++++++++++++++++
 drivers/clk/meson/axg.h              |  23 +-
 include/dt-bindings/clock/axg-clkc.h |  25 +
 3 files changed, 887 insertions(+), 1 deletion(-)

-- 
2.22.0

