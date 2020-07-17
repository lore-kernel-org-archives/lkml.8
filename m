Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D122C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED202076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595000580;
	bh=dvc0gy8O+owNFeCuQ/qyfa/C2w7ljCeygVA11Hhs1Rs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=exn53JEI0DLL+g8zpdhpHAlAwu0md6yKS/iayk5RX53kcDWFMxKrUBtNZn0cKs059
	 3mA4g7X2McWS6FbPquDGqrDvMXbCLGRlRI3ltuWFR3WnEf9doHZVKpHEbOsNKcPwOZ
	 UVpwZp1gV1TXeGIDKojy8qRVqLVzY+SaKNfv+Xh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGQPm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgGQPm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:42:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F8E02076A;
        Fri, 17 Jul 2020 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595000577;
        bh=dvc0gy8O+owNFeCuQ/qyfa/C2w7ljCeygVA11Hhs1Rs=;
        h=From:To:Cc:Subject:Date:From;
        b=19BLv+SBHyp+ueAM9b1lPFBMyvm6+g7MYVHa/2ZXuPiJ1j9Hw7q0bPCFo9cv26/xQ
         GskjSiQpYPk5oUUkYqK3zqtHMoeMRLLg0H6lUUO0XNLRLpFkfSiJTfvGyrDTYNNgjC
         wWTfkydeYvVSlah+zTNoMmDMg2fOl0rSNNZJzr58=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v5.8-rc5
Date:   Fri, 17 Jul 2020 16:42:44 +0100
Message-Id: <20200717154257.6F8E02076A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 95b2c3ec4cb1689db2389c251d39f64490ba641c:

  regmap: Fix memory leak from regmap_register_patch (2020-06-17 17:12:11 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.8-rc5

for you to fetch changes up to 299632e54b2e692d2830af84be51172480dc1e26:

  regmap: debugfs: Don't sleep while atomic for fast_io regmaps (2020-07-16 20:41:58 +0100)

----------------------------------------------------------------
regmap: Fixes for v5.8

A couple of substantial fixes here, one from Doug which fixes the
debugfs code for MMIO regmaps (fortunately not the common case) and one
from Marc fixing lookups of multiple regmaps for the same device (a very
unusual case).  There's also a fix for Kconfig to ensure we enable
SoundWire properly.

----------------------------------------------------------------
Douglas Anderson (1):
      regmap: debugfs: Don't sleep while atomic for fast_io regmaps

Marc Kleine-Budde (1):
      regmap: dev_get_regmap_match(): fix string comparison

Pierre-Louis Bossart (1):
      regmap: add missing dependency on SoundWire

 drivers/base/regmap/Kconfig          |  2 +-
 drivers/base/regmap/regmap-debugfs.c | 52 ++++++++++++++++++++----------------
 drivers/base/regmap/regmap.c         |  2 +-
 3 files changed, 31 insertions(+), 25 deletions(-)
