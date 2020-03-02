Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6026C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8585D222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCBQzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:55:38 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33482 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727117AbgCBQzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:55:38 -0500
Received: from Internal Mail-Server by MTLPINE2 (envelope-from asmaa@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 2 Mar 2020 18:55:35 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 022GtYIO004584;
        Mon, 2 Mar 2020 11:55:34 -0500
Received: (from asmaa@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 022GtX3F009468;
        Mon, 2 Mar 2020 11:55:33 -0500
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] gpio: add driver for Mellanox BlueField 2 GPIO controller
Date:   Mon,  2 Mar 2020 11:55:30 -0500
Message-Id: <cover.1583167849.git.Asmaa@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the GPIO controller used by Mellanox BlueFIeld
2 SOCs.
This patch addresses the following issues:
1) Merge bgpio lock acquisition into mlbx2_gpio_lock_acquire()
2) Replace devm_ioremap_nocache with devm_ioremap since it is no
longer supported in the latest linux version.

Asmaa Mnebhi (1):
  gpio: add driver for Mellanox BlueField 2 GPIO controller

 drivers/gpio/Kconfig       |   7 +
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-mlxbf2.c | 342 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 350 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf2.c

-- 
2.1.2

