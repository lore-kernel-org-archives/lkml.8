Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98D7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFF82072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFBIHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgFBIHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:07:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4E7C061A0E;
        Tue,  2 Jun 2020 01:07:15 -0700 (PDT)
Received: from ni.home (unknown [IPv6:2a01:cb19:8092:cf00:aaa1:59ff:fe08:91d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: myjosserand)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AD7C52A0151;
        Tue,  2 Jun 2020 09:07:06 +0100 (BST)
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@collabora.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, heiko@sntech.de,
        robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mylene.josserand@collabora.com,
        kernel@collabora.com
Subject: [PATCH v4 0/2] ARM: Add Rockchip rk3288w support
Date:   Tue,  2 Jun 2020 10:06:42 +0200
Message-Id: <20200602080644.11333-1-mylene.josserand@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Context
-------

Here is my V4 of my patches that add the support for the Rockchip
RK3288w which is a revision of the RK3288. It is mostly the same SOC
except for, at least, one clock tree which is different.
This difference is only known by looking at the BSP kernel [1].

Currently, the mainline kernel will not hang on rk3288w but it is
probably by "chance" because we got an issue on a lower kernel version.

According to Rockchip's U-Boot [2], the rk3288w can be detected using
the HDMI revision number (= 0x1A) in this version of the SOC.

Changelog
---------

This V4 is pretty much the same than the V3. Added the dt-bindings
documentation in clock-controller dt-bindings and fixed some typos
according to Heiko's reviews.

Changes since v3:
   - Updated clock-controller's dt-bindings
   - Fixed indentation

Best regards,
Mylène Josserand

[1] https://github.com/rockchip-linux/kernel/blob/develop-4.4/drivers/clk/rockchip/clk-rk3288.c#L960..L964
[2] https://github.com/rockchip-linux/u-boot/blob/next-dev/arch/arm/mach-rockchip/rk3288/rk3288.c#L378..L388

Mylène Josserand (2):
  clk: rockchip: rk3288: Handle clock tree for rk3288w
  dt-bindings: clocks: rk3288: add possible rk3288w

 .../bindings/clock/rockchip,rk3288-cru.txt    |  8 +++++++-
 drivers/clk/rockchip/clk-rk3288.c             | 20 +++++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.26.2

