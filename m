Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3860EC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104CF2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgB0NRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:17:48 -0500
Received: from comms.puri.sm ([159.203.221.185]:39658 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbgB0NRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:17:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 9391DDFC6D;
        Thu, 27 Feb 2020 05:17:46 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hF7L33L-A4PS; Thu, 27 Feb 2020 05:17:45 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 0/8] arm64: dts: librem5-devkit: description updates
Date:   Thu, 27 Feb 2020 14:17:25 +0100
Message-Id: <20200227131733.4228-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Shawn, I included Fabio's feedback despite you've taken the changes already.
I don't know how "far out there" they are already, but in case you want to
rebase / force-push this again, here is v4: It basically only adds one Fixes
tag.


These are additions to the imx8mq-librem5-devkit devicetree description
we are running for quite some time. All users should have them:

revision history
----------------
v4: review by Fabio: add Fixes tag and reorder a bit. thanks.
v3: review by Shawn: newline / hyphen issues; squashed related ones.
    thanks a lot.
    https://lore.kernel.org/linux-arm-kernel/20200224062917.4895-1-martin.kepplinger@puri.sm/
v2: review by Shawn and Guido: remove a battery description
    add SoB tags, coding style fixes, squash and reorder audio
    descritions, remove redundant and unneeded changes.
    https://lore.kernel.org/linux-arm-kernel/20200218084942.4884-1-martin.kepplinger@puri.sm/
v1: https://lore.kernel.org/linux-arm-kernel/20200205143003.28408-1-martin.kepplinger@puri.sm/


Angus Ainslie (Purism) (7):
  arm64: dts: librem5-devkit: add a vbus supply to usb0
  arm64: dts: librem5-devkit: add the sgtl5000 i2c audio codec
  arm64: dts: librem5-devkit: add the simcom 7100 modem and audio
  arm64: dts: librem5-devkit: allow modem to wake the system from
    suspend
  arm64: dts: librem5-devkit: add the regulators for DVFS
  arm64: dts: librem5-devkit: allow the redpine card to be removed
  arm64: dts: librem5-devkit: increase the VBUS current in the kernel

Martin Kepplinger (1):
  arm64: dts: librem5-devkit: add lsm9ds1 mount matrix

 .../dts/freescale/imx8mq-librem5-devkit.dts   | 136 +++++++++++++++++-
 1 file changed, 133 insertions(+), 3 deletions(-)

-- 
2.20.1

