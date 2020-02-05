Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B641CC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC15217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBEOax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:30:53 -0500
Received: from comms.puri.sm ([159.203.221.185]:48758 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgBEOaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:30:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 91956E0346;
        Wed,  5 Feb 2020 06:30:51 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ns3qqi5_L7qs; Wed,  5 Feb 2020 06:30:50 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 00/12] arm64: dts: librem5-devkit: description updates
Date:   Wed,  5 Feb 2020 15:29:51 +0100
Message-Id: <20200205143003.28408-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are additions to the imx8mq-librem5-devkit devicetree description
we are running for quite some time. All users should have them:

Angus Ainslie (Purism) (11):
  arm64: dts: librem5-devkit: add sai2 and sai6 pinctrl definitions
  arm64: dts: librem5-devkit: add the simcom 7100 modem and audio
  arm64: dts: librem5-devkit: allow modem to wake the system from
    suspend
  arm64: dts: librem5-devkit: enable sai2 audio interface
  arm64: dts: librem5-devkit: add the sgtl5000 i2c audio codec
  arm64: dts: librem5-devkit: add a vbus supply to usb0
  arm64: dts: librem5-devkit: add the regulators for DVFS
  arm64: dts: librem5-devkit: add a battery for the bq25896 to monitor
  arm64: dts: librem5-devkit: allow the redpine card to be removed
  arm64: dts: librem5-devkit: configure VSELECT
  arm64: dts: librem5-devkit: increase the VBUS current in the kernel

Martin Kepplinger (1):
  arm64: dts: librem5-devkit: add lsm9ds1 mount matrix

 .../dts/freescale/imx8mq-librem5-devkit.dts   | 173 +++++++++++++++++-
 1 file changed, 165 insertions(+), 8 deletions(-)

-- 
2.20.1

