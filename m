Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4FAC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 02:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B33E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 02:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LF7uD0Yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHZCrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 22:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgHZCrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 22:47:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C36DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 19:47:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 67so288827pgd.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 19:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=86P25dc8M78uQGYbOQ5ml86T4VEo9bys5i/SwJ/LbYw=;
        b=LF7uD0YyINCvnZ5gc8It2mRUwkRYtaiNOxNYHb+KBxbZrHd6JN6fRR84dLvrMJV8yL
         X6JGIL8i5XL0IuCQ2+bg9J22/ynNl42KiTz/GosZh6Bs2d3X90r59iD2YdZHQys13Au0
         xnkaHNFHpU6nhtk3ZJpyRFBw0yjhF98Geekdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=86P25dc8M78uQGYbOQ5ml86T4VEo9bys5i/SwJ/LbYw=;
        b=ob5Ubi1FDNX7ywSyrnJA9/ShEOa9ksSmNny1uePsyvG3aZbRo4XvIXZBnvwzUXMnaD
         w8C19R/eUz70awJADZ8Wsuace9093FbOcESx5XOjEHQYwZ0UDX94nhE7trRfTsDzF8JM
         8IZW9NswX9PbaHtxDt6hPkuyXHcG7/ljDeJeMmhcuzewd1c0oEw73Epl58BE1AdwOrIl
         s2qfhLtd0E/+WuD8sYIzeF9p33DwnHL92rbg972BPuOqcQn01jRpaQ4svC47eEqv1Suj
         ZGWmOUgpG3rzm3ibu60qIeM9AnUoCxZa8Qiw3Lc4XIzazBXgFvM21y3jNQiQy9ZBFgCp
         +/LA==
X-Gm-Message-State: AOAM530LoT1zWNz7OTxwLIRp9PoKeZM3CYWGgwdpkDm08SMhUX5f2VYO
        SeSA5KHDT+6MrEiGHp9pNABWoQ==
X-Google-Smtp-Source: ABdhPJxxubdCAWSJc6KDf0OvM1irs6Nwgg0uICeVlTgRnBzhdpe7kDBBzkegmuVYmScyZxCpS/yy2Q==
X-Received: by 2002:a62:1b0e:: with SMTP id b14mr10493740pfb.281.1598410033606;
        Tue, 25 Aug 2020 19:47:13 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id u65sm684381pfb.102.2020.08.25.19.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 19:47:12 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@chromium.org>
Subject: [PATCH v1 0/9]  Support qcom USB3+DP combo phy (or type-c phy)
Date:   Tue, 25 Aug 2020 19:47:02 -0700
Message-Id: <20200826024711.220080-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is based on v11 of the msm DP driver submission[1]
plus a compliance patch[2]. In the v5 patch series review I suggested
that the DP PHY and PLL be split out of the drm driver and moved to the
qmp phy driver. This patch series does that, but it is still marked as
an RFC because there are a couple more things to do, mostly updating the
DT binding and getting agreement on how to structure the code.

Eventually I believe the qmp phy driver will need to listen for type-c
notifiers or somehow know the type-c pinout being used so this driver
can program things slightly differently. Right now, I don't have any way
to test it though, so I've left it as future work. For some more
details, the DP phy and the USB3 phy share the same physical pins on the
SoC and those pins pretty much line up with a type-c pinout modulo some
CC pins for cable orientation detection logic that lives on the PMIC. So
the DP phy can use all four lanes or it can use two lanes and the USB3
phy can use two lanes. In the hardware designs that I have access to it
is always two lanes for USB3 and two lanes for DP going through what
looks like a type-c pinout so this just hard codes that configuration in
the driver.

Here's the example node that I'm using on sc7180:

	usb_1_qmpphy: phy-wrapper@88e9000 {
		compatible = "qcom,sc7180-qmp-usb3-dp-phy";
		reg = <0 0x088e9000 0 0x18c>, // usb pll (or serdes)
		      <0 0x088e8000 0 0x38>, // dp com
		      <0 0x088ea000 0 0x40>;  // dp pll (or serdes)
		status = "disabled";
		#address-cells = <2>;
		#size-cells = <2>;
		ranges;

		clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
			 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
			 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
			 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
		clock-names = "aux", "cfg_ahb", "ref", "com_aux";

		resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
			 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
		reset-names = "phy", "common";

		usb_1_ssphy: usb3-phy@88e9200 {
			reg = <0 0x088e9200 0 0x128>, // tx0
			      <0 0x088e9400 0 0x200>, // rx0
			      <0 0x088e9c00 0 0x218>, // pcs
			      <0 0x088e9600 0 0x128>, // tx1
			      <0 0x088e9800 0 0x200>, // rx1
			      <0 0x088e9a00 0 0x18>;  // pcs misc
			#clock-cells = <0>;
			#phy-cells = <0>;
			clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
			clock-names = "pipe0";
			clock-output-names = "usb3_phy_pipe_clk_src";
		};

		dp_phy: dp-phy@88ea200 {
			reg = <0 0x088ea200 0 0x200>, // tx0
			      <0 0x088ea400 0 0x200>, // rx0
			      <0 0x088eaa00 0 0x200>, // dp phy
			      <0 0x088ea600 0 0x200>, // tx1
			      <0 0x088ea800 0 0x200>; // rx1
			#clock-cells = <1>;
			#phy-cells = <0>;
		};
	};

I had to put the serdes register region in the wrapper node and jam the
common area (dp_com) in the middle. Sort of a mess but it was the best I
could do to make the driver changes minimially invasive. I also had to
change the node names to 'usb3-phy' and 'dp-phy' from 'phy' so that I
could differentiate the different phys in the driver. Otherwise the qmp
driver was already mostly prepared for two different phys to sit next to
each other inside the phy wrapper so it was mostly just a chore of
moving code from one place to another.

I'll also point out that I found out the DP controller driver is
resetting the aux phy settings right after it configures it. The last
patch in this series rips out the DP PHY and PLL code from the drm
driver and wires in the phy API calls instead. In that same patch I also
fixed this aux reset behavior by removing the bit that resets the aux
phy. I believe that the aux configuration is broken in the DP driver
but I fixed it now I think.

Changes from RFC (https://lore.kernel.org/r/20200611091919.108018-1-swboyd@chromium.org)
 * New patch for DT binding
 * Rebased onto latest DP patch series

TODO:
 * Clean up phy power on sequence a bit so that it is done in one place
   instead of two
 * Allow link rate to change after phy is powered on?
 * Make the runtime PM logic detect combo phy and power down both?


Stephen Boyd (9):
  dt-bindings: phy: qcom,qmp-usb3-dp: Add DP phy information
  phy: qcom-qmp: Move phy mode into struct qmp_phy
  phy: qcom-qmp: Remove 'initialized' in favor of 'init_count'
  phy: qcom-qmp: Move 'serdes' and 'cfg' into 'struct qcom_phy'
  phy: qcom-qmp: Get dp_com I/O resource by index
  phy: qcom-qmp: Add support for DP in USB3+DP combo phy
  phy: qcom-qmp: Add support for sc7180 DP phy
  clk: qcom: dispcc: Update DP clk ops for phy design
  drm/msm/dp: Use qmp phy for DP PLL and PHY

 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml    |   91 +-
 drivers/clk/qcom/clk-rcg2.c                   |   19 +-
 drivers/clk/qcom/dispcc-sc7180.c              |    3 -
 drivers/gpu/drm/msm/Makefile                  |    4 +-
 drivers/gpu/drm/msm/dp/dp_aux.c               |    7 +-
 drivers/gpu/drm/msm/dp/dp_catalog.c           |  253 +---
 drivers/gpu/drm/msm/dp/dp_catalog.h           |    7 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c              |   47 +-
 drivers/gpu/drm/msm/dp/dp_display.c           |   17 -
 drivers/gpu/drm/msm/dp/dp_display.h           |    3 -
 drivers/gpu/drm/msm/dp/dp_link.c              |    2 +
 drivers/gpu/drm/msm/dp/dp_panel.c             |    1 +
 drivers/gpu/drm/msm/dp/dp_parser.c            |   12 +-
 drivers/gpu/drm/msm/dp/dp_parser.h            |   12 +-
 drivers/gpu/drm/msm/dp/dp_pll.c               |   99 --
 drivers/gpu/drm/msm/dp/dp_pll.h               |   61 -
 drivers/gpu/drm/msm/dp/dp_pll_10nm.c          |  930 --------------
 drivers/gpu/drm/msm/dp/dp_pll_private.h       |   89 --
 drivers/gpu/drm/msm/dp/dp_power.c             |   39 +-
 drivers/gpu/drm/msm/dp/dp_power.h             |    9 -
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 1114 ++++++++++++++---
 drivers/phy/qualcomm/phy-qcom-qmp.h           |   80 ++
 22 files changed, 1207 insertions(+), 1692 deletions(-)
 delete mode 100644 drivers/gpu/drm/msm/dp/dp_pll.c
 delete mode 100644 drivers/gpu/drm/msm/dp/dp_pll.h
 delete mode 100644 drivers/gpu/drm/msm/dp/dp_pll_10nm.c
 delete mode 100644 drivers/gpu/drm/msm/dp/dp_pll_private.h

Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Cc: Chandan Uddaraju <chandanu@codeaurora.org>
Cc: Vara Reddy <varar@codeaurora.org>
Cc: Tanmay Shah <tanmay@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Manu Gautam <mgautam@codeaurora.org>
Cc: Sandeep Maheswaram <sanm@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Rob Clark <robdclark@chromium.org>

[1] https://lore.kernel.org/r/20200818051137.21478-1-tanmay@codeaurora.org
[2] https://lore.kernel.org/r/20200818230900.29294-1-khsieh@codeaurora.org

base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
prerequisite-patch-id: aa650e8353e003be0075deea0dee92a82e321432
prerequisite-patch-id: aa08019ebd00b502b4b76337dcef12939b5ed27d
prerequisite-patch-id: 87e6b1a10063ca350cacd64408024714599a14f4
prerequisite-patch-id: ac467cb99ea60ee186ab9bbe47a3e4d9c13a1313
prerequisite-patch-id: 48e1faa902cf53f64914f5a18e7a4296fa6a7bdd
prerequisite-patch-id: 6b2fb441138a10db425c5302638ea99ca00bf81d
-- 
Sent by a computer, using git, on the internet

