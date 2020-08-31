Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FA0C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C65E2098B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NcnQx+gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgHaI3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgHaI3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:29:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC2AC061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 01:29:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ls14so2590231pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t6A3T3U5sg4xL1HitgiJe+Mzl2G7Jnk/XQSObf5ZPYs=;
        b=NcnQx+gcvea+q7x2gF4i9HH52VjX5QYP3dhOG6QAqqnGluW5VrDzjPn3+Y3NrEnsGM
         OJvBk6gd2stHL6vuDbxWOj+0l9LX6UaDNfgBN4CCrhQmeoNnCWNSyBIQkX6PGsvL2yfy
         FSsCEA3fd0TGQLCUnCgyj8TRD0h/x12kaCaow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t6A3T3U5sg4xL1HitgiJe+Mzl2G7Jnk/XQSObf5ZPYs=;
        b=l9C7Nia6bX2MkebP5NjlLXUJtjZ4DgSMCa0h2Fr4fdM8SGcRwxG7Y6ay4hKy81n5mO
         gBb0lBpf3SPGk+W4ATS7+zXK9R42He7MFIVWJe0DSOqolg1IetQVVVGJzRn0SATajYxX
         uRxY0XwVcmXOkBk114ZX7CLQ4OdwvO8gWJuLrgwm61UH25cwO9IId+wZJdohB6blOlry
         w31U+LyA0Y3JHTbL2YvGEosO+Fs6sRA8nbRpbzSNQtVucKNxj06GbpAi5fmfHSFTz9mb
         AGe4TB9KoQloSe5mpy4YtOzroOBxmbAicGnsfzNW7+3Na4UY3XeBzePP5gwkoB7WwIEm
         wShA==
X-Gm-Message-State: AOAM532kM+VRoHgPJE/x1bwawGlVfGf8tSKXMJP11aCQrDv+ihJkEeJ0
        08chLGAfnq5iBhBrjcBtBNME3Q==
X-Google-Smtp-Source: ABdhPJzgmKs58w58u0Z3ZJSaXlgQqY+sNHsP4FQFmMe51tjTSRqPyk5BEGr1hbZE83+xRZkAU5bwYA==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr283058plc.284.1598862570169;
        Mon, 31 Aug 2020 01:29:30 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:d50:45fe:aaf3:66ee])
        by smtp.gmail.com with ESMTPSA id b5sm6411335pgi.83.2020.08.31.01.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 01:29:29 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 0/7] arm64: dts: rockchip: Add Engicam PX30.Core
Date:   Mon, 31 Aug 2020 13:59:10 +0530
Message-Id: <20200831082917.17117-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.

PX30.Core needs to mount on top of Engicam baseboards for creating
complete platform boards.

Possible baseboards are,
- EDIMM2.2 Starter Kit
- C.TOUCH 2.0 Carrier Board

Changes for v3:
- resolved Johan comments about sorting node properties
- add copyright to Amarula Solutions
- update px30 dtsi author
Changes for v2:
- collect Rob A-b
- include C.TOUCH 2.0 carrier board
- skip 10" OF LCD as it requires separate dts with panel support.

Note: These baseboards can be used for i.MX8 SOM's as well. So having
baseboard on respective SoC seems to be easy rather than making it
common across all.

Any inputs?
Jagan.

Jagan Teki (6):
  dt-bindings: arm: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
  arm64: dts: rockchip: px30: Add Engicam EDIMM2.2 Starter Kit
  arm64: dts: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
  dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
  arm64: dts: rockchip: px30: Add Engicam C.TOUCH 2.0
  arm64: dts: rockchip: Add Engicam PX30.Core C.TOUCH 2.0

Michael Trimarchi (1):
  arm64: dts: rockchip: Add Engicam PX30.Core SOM

 .../devicetree/bindings/arm/rockchip.yaml     |  12 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../dts/rockchip/px30-engicam-common.dtsi     |  39 +++
 .../dts/rockchip/px30-engicam-ctouch2.dtsi    |   8 +
 .../dts/rockchip/px30-engicam-edimm2.2.dtsi   |   7 +
 .../dts/rockchip/px30-px30-core-ctouch2.dts   |  22 ++
 .../dts/rockchip/px30-px30-core-edimm2.2.dts  |  21 ++
 .../boot/dts/rockchip/px30-px30-core.dtsi     | 232 ++++++++++++++++++
 8 files changed, 343 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi

-- 
2.25.1

