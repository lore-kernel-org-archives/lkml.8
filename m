Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83750C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDA12074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HaARYGte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgGIKIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgGIKIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:08:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F22C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:08:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so903840pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qzwj/JmFdVgdcqm2ibz/p78jn6V35kNjWHO4zvrYrZY=;
        b=HaARYGteoouFzhxDFLzieHwC0Q+65xb39uR1xapWdG2s35cV5PX7xDSxD59AMp4rgk
         wChRqiDAJ+FxR05mUa70r2YRC/0Ry+Jc8XGPQrO2twQ57Y8nDwbp2O4iMfVCQX1ZFD0Y
         /SeHIk3REiF9RZNM2JBnD3uT4iFcsoVUz8Qfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qzwj/JmFdVgdcqm2ibz/p78jn6V35kNjWHO4zvrYrZY=;
        b=HQJtDd/3pbvQTSHTA/fvrjAdR50fdlxoxWPfOq9JqKecUxXZak+4ibCZWoCdt6je7S
         dE32XXOKaSEc4OmnPvDhmr8yiKpoJ3RQBKg17V2F2tCud54A/0NlKm/GV8R4ShYqTXzu
         icDHU+/bmf3CI/6WOyswNNjwqHq953B1IRJlKFtaRS68YXNWVCHn+HP0Rms0utIDLZFG
         nKCOEXC/9rGJUsUo8oSouM7HnQCMUmcfmPiQZJEmqmuZII+ClydMLl/OoGGLarqyTXev
         W11llTEXhlEOdcim19Xqs0WmlHwVUNddtSIY0l2bvdidPOBL8Kw01kiag2P9S6zNhZ95
         DbiQ==
X-Gm-Message-State: AOAM533vo46+Z2ExWTsJMoIlBoJcxArOeTkPAgoekISZ8ZbrZZF+8gmq
        TILt4REQFPbxc3chQsNQa0SdEg==
X-Google-Smtp-Source: ABdhPJyhEse7q4vAlnFRFMy8/oFpg2TNLs2n2Y2ywc0fSw5LyRMfUw0z7GFeAkxJa74OlTTR3+Qh3w==
X-Received: by 2002:a17:902:a412:: with SMTP id p18mr52813839plq.341.1594289331194;
        Thu, 09 Jul 2020 03:08:51 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:24b9:69b0:e917:1d11])
        by smtp.gmail.com with ESMTPSA id ji2sm2076527pjb.1.2020.07.09.03.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 03:08:50 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 0/4] ARM: dts: rockchip: Radxa Rock Pi N8 initial support
Date:   Thu,  9 Jul 2020 15:37:52 +0530
Message-Id: <20200709100756.42384-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rock Pi N8 is a Rockchip RK3288 based SBC, which has
- VMARC RK3288 SOM (as per SMARC standard) from Vamrs.
- Compatible carrier board from Radxa.

VMARC RK3288 SOM need to mount on top of dalang carrier
board for making Rock PI N8 SBC.

This series moved i2c2 into rk3399pro dtsi and rest are
similar to v4.

Changes for v5:
- drop redundent hym8563_int pin in rk3399pro dtsi
Changes for v4:
- move i2c2 from carrier board to rk3399pro dtsi
Changes for v3:
- move hym8563_int pin to rk3399pro dtsi
Changes for v2:
- add more trivial cleanups
- update commit message

Jagan Teki (4):
  arm64: dts: rockchip: Trivial cleanups for RockPI N10
  dt-bindings: arm: rockchip: Add Rock Pi N8 binding
  ARM: dts: rockchip: Add VMARC RK3288 SOM initial support
  ARM: dts: rockchip: Add Radxa Rock Pi N8 initial support

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/rk3288-rock-pi-n8.dts       |  17 ++
 arch/arm/boot/dts/rk3288-vmarc-som.dtsi       | 270 ++++++++++++++++++
 .../dts/rockchip-radxa-dalang-carrier.dtsi    |  67 +++--
 .../dts/rockchip/rk3399pro-rock-pi-n10.dts    |   2 +-
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     |  93 +++---
 7 files changed, 374 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-rock-pi-n8.dts
 create mode 100644 arch/arm/boot/dts/rk3288-vmarc-som.dtsi

-- 
2.25.1

