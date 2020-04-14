Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D758AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B235620656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="usV8Cm+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505424AbgDNUB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505367AbgDNUA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:00:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5271C061A10;
        Tue, 14 Apr 2020 13:00:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d77so14474921wmd.3;
        Tue, 14 Apr 2020 13:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MbzRA+liOSzspvRs73OjMhTVcZqxUfZ8JGqRb1at2eo=;
        b=usV8Cm+MW1Z553yH7mGfuCKt4JU0Fhq3xzICPmxArO3E+urQeBT1EyrZWPC5ZBDm/g
         R/MvcnhU5fUc6mVz4zsAjdiEWv8wCeJnrOeThXvKyO2jYb9TC0ropp/VHimX8zhadP5N
         fHaHB/Q4ksh0GbpSQdY3kmeMGWzzifgG2v3V+5G89DAmT2jFRvEXNEBMq6ulr9H/SIwX
         FC7WLLlB/BmPFrTtCUtpzWSguI3s4UclTDRm2RwvYVjrxPGrr5Q1h/9pW66K6Cxz0KLC
         uW5Lw1+SIUHqcYEaf0pDNdVoVO4+jeqIz5K5tYn9K0jjO2HEywhQi7JwLag6Bu0m9hCw
         KAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MbzRA+liOSzspvRs73OjMhTVcZqxUfZ8JGqRb1at2eo=;
        b=C78XCC79Y1K5fr65XipGQf8jR8wbm6xXq/S3KyeoTQkghnm7RCNtJLm3KtC1rUKPOF
         5zK+w4maCDt8hCIgElnPmyCwSk1tFbDsKGlJJubViuvNr32z+jrCnDdaCw+JiqnIc21p
         zClEmvm7DL5llaiId2X0SDl98UteVXWu45gt2f3Rc2PjcjOtclI0hWqnwnjHttz8usIi
         g78eOoTx6QisKBSUtE6Zsih+JdSB3iyTMcNRrTgBSUoHPteum1XTcITuKGW4okdeeZoO
         M9jxcVxAHzq4hplvh7K9FLYgpEvSPFs8G1h9N8/JxgLahaF90HSbvANfCy/bZwDP9i9u
         i85g==
X-Gm-Message-State: AGi0PuY1HjtQdbW3rOQafGkisxHiuWCbFDKMXYVjWoacC5EYLYpVBfl+
        Wn9Gw2G2XoCmtAU3BnC9ShUf8HcB/Zg=
X-Google-Smtp-Source: APiQypJeEMY/H6VtUp7hGwSmUSJjjoRxaD3Z9HIbNZuaQuy98pOr+YMQ2RGA7ApjNpibPM4CdxN5QQ==
X-Received: by 2002:a1c:dc0a:: with SMTP id t10mr1400936wmg.113.1586894427232;
        Tue, 14 Apr 2020 13:00:27 -0700 (PDT)
Received: from localhost.localdomain (p200300F13717DF00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3717:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b4sm15540253wrv.42.2020.04.14.13.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:00:26 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/4] clk: meson8b: updates for video clocks / resets
Date:   Tue, 14 Apr 2020 22:00:13 +0200
Message-Id: <20200414200017.226136-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first batch of fixes and updates for the Meson8/8b/8m2
clock controller driver.

The first patch fixes the video clock hierarchy. Special thanks to
Neil for providing a lot of details about the video clock tree!

The second and third came up while testing video output on my EC-100
(Endless Mini). This board is special because u-boot does not enable
the video outputs like most other u-boot versions do. However, this
is very useful for development because it shows (the hard way ;))
where the existing code is buggy.

The last patch is a small improvement for the VPU clock so we
utilize the glitch-free mux (on SoCs which support it) and avoid
problems by changing the "live" clock tree at runtime (with the mali
clock this resulted in system hangs/freezes).

In my opinion all of these patches - including the fixes - can go to
"next" because the relevant clock trees are still read-only.


Martin Blumenstingl (4):
  clk: meson: meson8b: Fix the first parent of vid_pll_in_sel
  clk: meson: meson8b: Fix the polarity of the RESET_N lines
  clk: meson: meson8b: Fix the vclk_div{1,2,4,6,12}_en gate bits
  clk: meson: meson8b: Make the CCF use the glitch-free VPU mux

 drivers/clk/meson/meson8b.c | 107 +++++++++++++++++++++++++-----------
 1 file changed, 75 insertions(+), 32 deletions(-)

-- 
2.26.0

