Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A959AC3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8192168B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgBKTBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:01:06 -0500
Received: from mailoutvs8.siol.net ([185.57.226.199]:37338 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729303AbgBKTBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:01:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 4F0835251A6;
        Tue, 11 Feb 2020 20:01:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9Oh5r2s8Blr6; Tue, 11 Feb 2020 20:01:02 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 092D4525187;
        Tue, 11 Feb 2020 20:01:02 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id DB442525125;
        Tue, 11 Feb 2020 20:01:00 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, icenowy@aosc.io,
        jernej.skrabec@siol.net, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] clk: sunxi-ng: sun8i-de2: Multiple fixes
Date:   Tue, 11 Feb 2020 19:59:29 +0100
Message-Id: <20200211185936.245174-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current sun8i-de2 clock driver, rotation core related clocks and
reset weren't considered properly. All SoC which have that core don't
have those definitions. Even worse, the only SoC which have rotation
core related definitions doesn't have that core at all.

This series fixes this mess.

Please take a look.

Best regards,
Jernej

Changes from v1:
- fix "fixes" tags
- move sort patch at the end
- update several commit logs

Jernej Skrabec (7):
  clk: sunxi-ng: sun8i-de2: Split out H5 definitions
  clk: sunxi-ng: sun8i-de2: Add rotation core clocks and reset for A64
  clk: sunxi-ng: sun8i-de2: H6 doesn't have rotate core
  clk: sunxi-ng: sun8i-de2: Don't reuse A83T resets
  clk: sunxi-ng: sun8i-de2: Add rotation core clocks and reset for A83T
  clk: sunxi-ng: sun8i-de2: Add R40 specific quirks
  clk: sunxi-ng: sun8i-de2: Sort structures

 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 127 +++++++++++++++++----------
 1 file changed, 80 insertions(+), 47 deletions(-)

--=20
2.25.0

