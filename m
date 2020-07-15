Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241A3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F064120672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="g0dl2GAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgGOIej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbgGOIei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:34:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF128C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:34:37 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f16so2638287pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p3/g5pBdwctLUOCwSdPBoGPRKOqAUmY4r4AcqDeitio=;
        b=g0dl2GAQ7AbUARAnjHGrGX5sQyyoB5GtmWTM/fF7pnGl1QmW5qRvJFgJJVxF0lcgAf
         mLKfgE0i0ivFFqfgVjqd13+/RQV8/OEIQo1GbOzCrvdVT4T1UsUcXesuzXRmpwey7m1d
         oEccPkvbJkp6adxmtuROIyn1qf1ZtSEklEyhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p3/g5pBdwctLUOCwSdPBoGPRKOqAUmY4r4AcqDeitio=;
        b=AkZBAaof7yQXd45NhLdkG+uzQHhl0BZ/9fuQCupwwfV1a9vDOd4utjYsxAYl5McGj2
         L2pE5ewCyCPZqonfuWfONA7W0ZphzYiZxIYSx5seTzQttJ8esJfKiugyKSyL2l0B5iKV
         nv7Lv4dECHreqcoSZj7y6CqztgMF4E0fJF5A9DuKhJ9M9EkgX98h7VJuw8f/PhWP8Ktk
         XND3LXExlIcs2YkkwVK4UBUW1SCdrSv/CJ/+tOhrvKoph6OCPhCJBwt9e0YGvidcZKZf
         9uhB162N6Z/OkdmLgDRzvEBxZK4ynF1ojJl/7JmK66j6BE1RNqxs/4tey64OkpGNvXhs
         9dXw==
X-Gm-Message-State: AOAM532Ebfxqp0Uw/GDt/lw+3jLo/t44b1x480I/Wj2k7AAW4rzJnjBX
        +7tS7P8IuauuBepW/0ClZjVL7vF0XNo=
X-Google-Smtp-Source: ABdhPJzT/XPdHsngU3nPDlYS7eR0QDTsrvncjmFDFCOwrj+0ecRs7jcXs6QR+A7ljF/nryO44UM0Sg==
X-Received: by 2002:a17:902:fe0d:: with SMTP id g13mr7561561plj.326.1594802076265;
        Wed, 15 Jul 2020 01:34:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9887:56a8:c916:cfdb])
        by smtp.gmail.com with ESMTPSA id m92sm1467584pje.13.2020.07.15.01.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:34:35 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 0/7] ARM: dts: rockchip: Radxa Rock Pi N8 initial support
Date:   Wed, 15 Jul 2020 14:04:11 +0530
Message-Id: <20200715083418.112003-1-jagan@amarulasolutions.com>
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

Changes for v6:
- spilt the trivial patch into multiple patches
- collect Rob review tag
Changes for v5:
- drop redundent hym8563_int pin in rk3399pro dtsi
Changes for v4:
- move i2c2 from carrier board to rk3399pro dtsi
Changes for v3:
- move hym8563_int pin to rk3399pro dtsi
Changes for v2:
- add more trivial cleanups
- update commit message

Jagan Teki (7):
  ARM: dts: rockchip: dalang-carrier: Move i2c nodes into SOM
  arm64: dts: rk3399pro: vmarc-som: Fix sorting nodes, properties
  arm64: dts: rk3399pro: vmarc-som: Move supply regulators into Carrier
  arm64: dts: rk3399pro: vmarc-som: Move common properties into Carrier
  dt-bindings: arm: rockchip: Add Rock Pi N8 binding
  ARM: dts: rockchip: Add VMARC RK3288 SOM initial support
  ARM: dts: rockchip: Add Radxa Rock Pi N8 initial support

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/rk3288-rock-pi-n8.dts       |  17 ++
 arch/arm/boot/dts/rk3288-vmarc-som.dtsi       | 270 ++++++++++++++++++
 .../dts/rockchip-radxa-dalang-carrier.dtsi    |  67 +++--
 .../dts/rockchip/rk3399pro-rock-pi-n10.dts    |   6 +-
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     |  92 +++---
 7 files changed, 376 insertions(+), 83 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-rock-pi-n8.dts
 create mode 100644 arch/arm/boot/dts/rk3288-vmarc-som.dtsi

-- 
2.25.1

