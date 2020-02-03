Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D96C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8452086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgBCSsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:48:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:39862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbgBCSsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:48:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14DE3ABB3;
        Mon,  3 Feb 2020 18:48:38 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, f.fainelli@gmail.com,
        yamada.masahiro@socionext.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM: Introduce multi_v7_lpae_defconfig
Date:   Mon,  3 Feb 2020 19:48:17 +0100
Message-Id: <20200203184820.4433-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a new configuration target,
multi_v7_lpae_defconfig, built by merging the config fragment
lpae.config with mult_v7_defconfig. Ultimately needed in order for
Raspberry Pi 4's PCIe bus to work on arm builds, but which may benefit
other boards out there.

---

Changes since RFC:
 - Move merge function into the scripts directory.

Nicolas Saenz Julienne (2):
  kbuild: Add config fragment merge functionality
  ARM: add multi_v7_lpae_defconfig

 arch/arm/Makefile            |  4 ++++
 arch/arm/configs/lpae.config |  1 +
 arch/powerpc/Makefile        | 12 +-----------
 scripts/Makefile.defconf     | 15 +++++++++++++++
 4 files changed, 21 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/configs/lpae.config
 create mode 100644 scripts/Makefile.defconf

-- 
2.25.0

