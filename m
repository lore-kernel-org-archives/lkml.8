Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C36C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B56214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAORHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:07:13 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:38822 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728928AbgAORHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:07:12 -0500
X-Greylist: delayed 2606 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jan 2020 12:07:11 EST
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 00FGN3te021572;
        Wed, 15 Jan 2020 18:23:03 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id DB60D60328; Wed, 15 Jan 2020 18:23:02 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/4] spi: npcm-pspi: improve preformance modify reset and fix issue
Date:   Wed, 15 Jan 2020 18:22:57 +0200
Message-Id: <20200115162301.235926-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set modify Perphiral SPI NPCM driver as follow:
	
	- Improve transfer performance.
	- Fix 16 bit send and receive support.
	- Modify dt-binding documentation to support reset controller driver.
	- Modify reset support to use reset controller driver
	  NPCM reset driver: https://lkml.org/lkml/2019/11/7/429.

Tomer Maimon (4):
  spi: npcm-pspi: fix 16 bit send and receive support
  spi: npcm-pspi: improve spi transfer performance
  dt-binding: spi: add NPCM PSPI reset binding
  spi: npcm-pspi: modify reset support

 .../bindings/spi/nuvoton,npcm-pspi.txt        | 12 +---
 drivers/spi/spi-npcm-pspi.c                   | 57 +++++++++----------
 2 files changed, 29 insertions(+), 40 deletions(-)

-- 
2.22.0

