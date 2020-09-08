Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53D3C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9204E2068D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbgIHSzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:55:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:47736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgIHSyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:54:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 055DEABD5;
        Tue,  8 Sep 2020 18:54:35 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/1] bcm2835-dt-next-2020-09-08
Date:   Tue,  8 Sep 2020 20:54:27 +0200
Message-Id: <20200908185427.4196-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2020-09-08

for you to fetch changes up to 4564363351e2680e55edc23c7953aebd2acb4ab7:

  ARM: dts: bcm2711: Enable the display pipeline (2020-09-08 18:28:23 +0200)

----------------------------------------------------------------
Maxime Ripard enables vc4 on BCM2711 (RPi4), which among other things
adds HDMI functionality (no 4K yet).

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: dts: bcm2711: Enable the display pipeline

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts |  48 +++++++++++++
 arch/arm/boot/dts/bcm2711.dtsi        | 122 +++++++++++++++++++++++++++++++++-
 2 files changed, 169 insertions(+), 1 deletion(-)
