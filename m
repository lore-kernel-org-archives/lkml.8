Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5993C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADA2206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgGFRMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:12:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:35804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbgGFRMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:12:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73B2DAEF3;
        Mon,  6 Jul 2020 17:12:02 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/1] bcm2835-dt-next-2020-07-06
Date:   Mon,  6 Jul 2020 19:11:40 +0200
Message-Id: <20200706171140.13514-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2020-07-06

for you to fetch changes up to 25c6f3960764b266a609281341f889a06d045039:

  ARM: dts: bcm2711: Add HDMI DVP (2020-07-06 18:52:01 +0200)

----------------------------------------------------------------
Maxime Ripard introduces two new clock providers into RPi4's device-tree:

- The first one based on the enhancements made to clk-raspberrypi, which
  is now registered trough DT and provides control over the whole range
  of firmware based clocks.

- The second one based on the new clk-bcm2711-dvp driver, which gates
  the clocks and reset signals that feed into RPi4's HDMI0/1 blocks.

----------------------------------------------------------------
Maxime Ripard (2):
      ARM: dts: bcm2711: Add firmware clocks node
      ARM: dts: bcm2711: Add HDMI DVP

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts |  5 +++++
 arch/arm/boot/dts/bcm2711.dtsi        | 15 +++++++++++++++
 2 files changed, 20 insertions(+)
