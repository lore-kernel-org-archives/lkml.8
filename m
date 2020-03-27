Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5FEC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4AA206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgC0VQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:16:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:42848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbgC0VQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:16:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 99DA0AC50;
        Fri, 27 Mar 2020 21:16:36 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 2/3] bcm2835-dt-next-2020-03-27
Date:   Fri, 27 Mar 2020 22:16:31 +0100
Message-Id: <20200327211632.32346-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327211632.32346-1-nsaenzjulienne@suse.de>
References: <20200327211632.32346-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 14e1eb5a91a96d9e1ce8051f752b7b6645bc8e10:

  dt-bindings: arm: Document Broadcom SoCs 'secondary-boot-reg' (2020-03-10 12:43:15 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2020-03-27

for you to fetch changes up to 3ac395a5b3f3b678663fbb58381fdae2b1b57588:

  ARM: dts: bcm283x: Use firmware PM driver for V3D (2020-03-27 21:25:35 +0100)

----------------------------------------------------------------
- First patch updates RPi4's expgpio's GPIO labels, adding the SD power rail.

- Second patch adds a fixed regulator that controls the SD power and
hooks it up with emmc2.

- Third patch rolls back to the firmware based power driver as the MMIO
version is unstable.

----------------------------------------------------------------
Nicolas Saenz Julienne (3):
      ARM: dts: bcm2711: Update expgpio's GPIO labels
      ARM: dts: bcm2711: Add vmmc regulator in emmc2
      ARM: dts: bcm283x: Use firmware PM driver for V3D

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts     | 13 ++++++++++++-
 arch/arm/boot/dts/bcm2835-common.dtsi     |  1 -
 arch/arm/boot/dts/bcm2835-rpi-common.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/bcm2835.dtsi            |  1 +
 arch/arm/boot/dts/bcm2836.dtsi            |  1 +
 arch/arm/boot/dts/bcm2837.dtsi            |  1 +
 6 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-common.dtsi
