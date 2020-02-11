Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5947BC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB1C20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="MBRvBX8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgBKKfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:35:03 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:26389 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgBKKfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:35:03 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48Gzg90fyZz6x;
        Tue, 11 Feb 2020 11:35:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1581417301; bh=vQXfboMzSuI7E1x57jf2aEN96A5Gr8vG74E+9+CiSm0=;
        h=Date:From:Subject:To:Cc:From;
        b=MBRvBX8Fkrrv0txLhfyeRIEqzhVmhKd1/ouHdqiqlI1mv+AV3VLLcJA18//vhbGCo
         jjrxtF1GxurPrEGCYRDPnM9rodDiNG6k/S8Az9GyN2IOv5hnGjbQq2OCBapyFwcA5e
         b7q/JbPDRX7tU14jeOkWU8B1+V403V17S6EkiikTsjQ7gYKiLHnF+XIHZCF9UTBisr
         SxTx9dVns4T+wjSWIs6Gu+iBBYFJxvgaG2QWvoQ4/sQBmGMhXEEe961qu7E2rX5Ol1
         R5NkPE30Wy2vEmcjDnJOlpXQ2Gp4rI5epDkvf/QBj4Y6A9NF6RlsOs17XdCOSBji08
         2RXMvIVQCyCOg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at mail
Date:   Tue, 11 Feb 2020 11:34:59 +0100
Message-Id: <cover.1581416843.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 0/6] staging: WF200 driver fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A set of fixes for WF200 WiFi module driver. Three are bug fixes,
all the rest: cleanups and optimizations.

v2:
  use devres for fixing init/interrupt race, as suggested by Dan Carpenter
  add Fixes: tags dropped by accident
  remove 8-bit SPI fall-back patch

Michał Mirosław (6):
  staging: wfx: fix init/remove vs IRQ race
  staging: wfx: annotate nested gc_list vs tx queue locking
  staging: wfx: add proper "compatible" string
  staging: wfx: follow compatible = vendor,chip format
  staging: wfx: use sleeping gpio accessors
  staging: wfx: use more power-efficient sleep for reset

 .../bindings/net/wireless/siliabs,wfx.txt     | 11 ++---
 drivers/staging/wfx/bh.c                      |  8 ++--
 drivers/staging/wfx/bus_sdio.c                | 16 +++----
 drivers/staging/wfx/bus_spi.c                 | 45 +++++++++++--------
 drivers/staging/wfx/hwio.c                    |  2 +-
 drivers/staging/wfx/main.c                    | 23 ++++++----
 drivers/staging/wfx/main.h                    |  1 -
 drivers/staging/wfx/queue.c                   | 16 +++----
 8 files changed, 66 insertions(+), 56 deletions(-)

-- 
2.20.1


From 08a65da2e2ce94be8a7d00cc692166404ea3e08d Mon Sep 17 00:00:00 2001
Message-Id: <cover.1581416380.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Tue, 11 Feb 2020 11:19:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:	=?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org

Michał Mirosław (7):
  staging: wfx: fix init/remove vs IRQ race
  staging: wfx: annotate nested gc_list vs tx queue locking
  staging: wfx: add proper "compatible" string
  staging: wfx: follow compatible = vendor,chip format
  staging: wfx: try 16-bit word mode first
  staging: wfx: use sleeping gpio accessors
  staging: wfx: use more power-efficient sleep for reset

 .../bindings/net/wireless/siliabs,wfx.txt     | 11 ++--
 drivers/staging/wfx/bh.c                      |  8 +--
 drivers/staging/wfx/bus_sdio.c                | 16 +++---
 drivers/staging/wfx/bus_spi.c                 | 52 +++++++++++--------
 drivers/staging/wfx/hwio.c                    |  2 +-
 drivers/staging/wfx/main.c                    | 23 ++++----
 drivers/staging/wfx/main.h                    |  1 -
 drivers/staging/wfx/queue.c                   | 16 +++---
 8 files changed, 71 insertions(+), 58 deletions(-)

-- 
2.20.1

