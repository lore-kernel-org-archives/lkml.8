Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED06C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 15:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8642620BED
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 15:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ljhum2dL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgH2P7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 11:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgH2P6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:58:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88263C06123B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:58:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so1923186pgh.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MZ+O4LsEt26/bO1S7FmN8cAqvXJ4Tlfs0jPsv8jKi+U=;
        b=ljhum2dLbF4VvYtN4qJIDmyalFKBqIXbGRX8hWQjDkXZtk5Yys+EqKTUH6kOrdvXvN
         3q58FRB62zhVR1EOdb/TIVC1sNymiWuw8i7EAq6KnMf5Cm85KhjvWGRDlbnlkPUtIhMh
         PbB5aJkSvsXvstNGV3jGzNEqCMz79Oy8IuKXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MZ+O4LsEt26/bO1S7FmN8cAqvXJ4Tlfs0jPsv8jKi+U=;
        b=iZwlDVL5oXtIQuagYsA+5989FzpLxvGx+uPSy1rCwpQJ/yniwC5hwHwaqaDO2ptW32
         lTRZ7IVFTIErrFwHYa+N3nGJm3pTmSfwSUkNx+HpXJjw+ijRj4fym/UU8g5xy6qtbjuO
         hULI9iVnEMantTHR/j9zDy5rbLiLPJRbjfvLS7kUvfHTBCC3j/+OZkDoashk5GjS03pg
         7QYnL9+gwTUfVQANr5XxTC3vrQhOzUdwseNzn/XugvrmW7BvjHqAvuqDlD4juZd/BR4L
         a8HhiZWyJaPENc2s5YEWJ9R5u5sNfPndg+Rpkr5EwFCi5YKv5Z9Pw6WNjQ1lSRCNxk7p
         3TWQ==
X-Gm-Message-State: AOAM532L/SrKy/Zo0QLX/wojtjkCvmIApLfDI787+N7qsAefF4SkQGgs
        UtE/l8kz5jzdyKE3hq4JeQQ+nA==
X-Google-Smtp-Source: ABdhPJzEcB+o7wItuxgbQQLsj33yMDZo2V1Gtq8/mqoiG4pegOIOA2BEG59zkXuSYUTV8HwcvYNIEw==
X-Received: by 2002:a62:2bcc:: with SMTP id r195mr3481135pfr.123.1598716715401;
        Sat, 29 Aug 2020 08:58:35 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9460:cfb8:90a:fedd])
        by smtp.gmail.com with ESMTPSA id j20sm3131714pfi.122.2020.08.29.08.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 08:58:34 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 0/7] arm64: dts: rockchip: Add Engicam PX30.Core
Date:   Sat, 29 Aug 2020 21:28:16 +0530
Message-Id: <20200829155823.247360-1-jagan@amarulasolutions.com>
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

Changes for v2:
- collect Rob A-b
- include C.TOUCH 2.0 carrier board
- skip 10" OF LCD as it requires separate dts with panel support.

Note: These baseboards can be used for i.MX8 SOM's as well. So having
baseboard on respective SoC seems to be easy rather than making it
common across all.

Any inputs?
Jagan.

Jagan Teki (7):
  dt-bindings: arm: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
  arm64: dts: rockchip: px30: Add Engicam EDIMM2.2 Starter Kit
  arm64: dts: rockchip: Add Engicam PX30.Core SOM
  arm64: dts: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
  dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
  arm64: dts: rockchip: px30: Add Engicam C.TOUCH 2.0
  arm64: dts: rockchip: Add Engicam PX30.Core C.TOUCH 2.0

 .../devicetree/bindings/arm/rockchip.yaml     |  12 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../dts/rockchip/px30-engicam-common.dtsi     |  39 +++
 .../dts/rockchip/px30-engicam-ctouch2.dtsi    |   7 +
 .../dts/rockchip/px30-engicam-edimm2.2.dtsi   |   7 +
 .../dts/rockchip/px30-px30-core-ctouch2.dts   |  21 ++
 .../dts/rockchip/px30-px30-core-edimm2.2.dts  |  21 ++
 .../boot/dts/rockchip/px30-px30-core.dtsi     | 231 ++++++++++++++++++
 8 files changed, 340 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi

-- 
2.25.1

