Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABCAC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C0B208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nLZL0E5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgIGIdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgIGIdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:33:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD369C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 01:33:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x23so3591173wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J3RS9JG1OFuUivBOq0Q65DrLfYNaGRyuTeLPnUpa9OE=;
        b=nLZL0E5hTXbyG5Wr8LBDWOmTdFRZZtA8/BLOG6JyhATD05wafj69x9oiWzVXqyuk+u
         vvLGSwqGEbua3i8Fd7A3AX7qdbMYw2b/04anJjoE98LdKdCIxzlc3bjbqpCOH48qjlPN
         yueP2aJafvw+VvIKjvgQWKX6n2IGLSElvtn56ngJ1+59h8gWR7h3AiK4Ile5stZbBn9f
         1msB9efl7hBfcVVjM1+jpC+0rahMh+ErjtGnBsMuVYKmWyn4r36kIeBP/nu30Y1Ux/RS
         fnOtci2SbsFIywnscGhNV49UzzyuxMY+6Kt87MGpFFcjt8ytwLiDBRASmkOPMtSDJeKd
         326g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J3RS9JG1OFuUivBOq0Q65DrLfYNaGRyuTeLPnUpa9OE=;
        b=lg+XWc9h7hcZMb+IlPOA2992n0tc7y1qJ3WGWueFv3lV+tB6IroLYj9kAt6DrYTnEb
         gF1A6Ptl8a3YyI/4TwyYV8EsSvfk6MonXKhvc3aS3qubCdc2UnDOLogm9PM4uU+l0rv3
         Qk5S56YJRNaTtg4wwSNEQBPTpoxSbqq3OOb5LDsiE5waa6vpfCq/NgiCt0diKo37/isb
         UMLwZlWT2UZgwRmGQPere8cVJ+N0tpsKaskmqXQh+1JfKEhfr5SewjdnbIvUq902kGBp
         7pIumrMae43hXWDzRRmUCWiqcbi0iLeeExuGHzeHwBKkxoeUheq21kZ/aeO9oUpiv2H1
         et8A==
X-Gm-Message-State: AOAM533RMjSzdDnY6TR24nrqQvlawmWzGKeeo2O07b/wpYSVmiEZ3kqL
        yiD16BNEEUvfMJ6yq0RBCFhfFQ==
X-Google-Smtp-Source: ABdhPJyqB1K44mhhek2pT1S0CFys7w5knzWvgfFdI9JtDO5OyEnsnRKYOx3MO5H4yDczNykPtM/tpw==
X-Received: by 2002:a05:600c:21c4:: with SMTP id x4mr20084365wmj.107.1599467585384;
        Mon, 07 Sep 2020 01:33:05 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id o5sm25205111wmc.33.2020.09.07.01.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 01:33:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/3] arm64: dts: meson-axg-s400: add support for MIPI-DSI Panel
Date:   Mon,  7 Sep 2020 10:32:57 +0200
Message-Id: <20200907083300.14412-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the nodes to AXG and S400 board to enabled MIPI-DSI display support with
the 1024*600 tl070wsh30 DSI panel.

Dependencies:
- Patch 1: [1] & [2]
- Patch 2: [1], [3] & [4]
- Patch 3: [5]

[1] https://lore.kernel.org/r/20200907081825.1654-1-narmstrong@baylibre.com
[2] https://lore.kernel.org/r/20200904161654.24141-1-narmstrong@baylibre.com
[3] https://lore.kernel.org/r/20200907072708.26043-1-narmstrong@baylibre.com
[4] https://lore.kernel.org/r/20200907073402.26674-1-narmstrong@baylibre.com
[5] https://lore.kernel.org/r/20200904161504.23915-1-narmstrong@baylibre.com

Neil Armstrong (3):
  arm64: dts: meson-axg: add VPU and PWRC nodes
  arm64: dts: meson-axg: add MIPI DSI Nodes
  arm64: dts: meson-axg-s400: add MIPI DSI panel nodes

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts |  49 +++++++-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 118 ++++++++++++++++++
 2 files changed, 166 insertions(+), 1 deletion(-)

-- 
2.22.0

