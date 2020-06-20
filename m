Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B72C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95BAA2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgFVO0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:26:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:44836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbgFVO0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:26:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7EEB9C1C6;
        Mon, 22 Jun 2020 14:26:13 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        James Tai <james.tai@realtek.com>
Subject: [PATCH v4 0/3] arm64: dts: realtek: Initial RTD1319 and Pym Particles support
Date:   Sun, 21 Jun 2020 01:32:24 +0200
Message-Id: <20200620233227.31585-1-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series adds initial Device Trees for Realtek RTD1319 SoC and
Realtek Pym Particles EVB.

This v4 is an update of James' v3, incorporating pending review comments.

Upstreaming progress being tracked at:
https://en.opensuse.org/HCL:Realtek_DHC

Latest experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

v3 -> v4:
* Updated Realtek copyright for files changed in v3
* Updated PMU compatible (Robin)
* Changed compatible, renamed .dts
* Updated bindings schema and prepended refactoring

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: James Tai <james.tai@realtek.com>

Andreas Färber (1):
  dt-bindings: arm: realtek: Convert comments to descriptions

James Tai (2):
  dt-bindings: arm: realtek: Document RTD1319 and Realtek Pym Particles
    EVB
  arm64: dts: realtek: Add RTD1319 SoC and Realtek Pym Particles EVB

 .../devicetree/bindings/arm/realtek.yaml      |  30 ++-
 arch/arm64/boot/dts/realtek/Makefile          |   2 +
 .../boot/dts/realtek/rtd1319-pymparticles.dts |  43 ++++
 arch/arm64/boot/dts/realtek/rtd1319.dtsi      |  12 +
 arch/arm64/boot/dts/realtek/rtd13xx.dtsi      | 213 ++++++++++++++++++
 5 files changed, 288 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1319-pymparticles.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1319.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd13xx.dtsi

-- 
2.26.2

