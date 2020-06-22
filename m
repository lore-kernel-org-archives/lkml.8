Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BE4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B69206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592826017;
	bh=OfXqXCVd92Xtq6lHyy/fx52Nkcw37JZs2wd4lVKT2FQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KH3xkMhgmwZvD6DR4nKfM4Arn1Ii4ISlTXcs1vlrnk0P54XeK+H/JQ/VcIKYjCxM0
	 sKqtssD3sb/w8UEy6ca6jmULynvDvnHfIwituVDK08ijJn9awtEtat9zlRihEl8mcq
	 jCDXGUvyHWbXtJzpc+guh6BeemvjCOSBrilQqRKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgFVLkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgFVLkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:40:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60DD1206BE;
        Mon, 22 Jun 2020 11:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592826015;
        bh=OfXqXCVd92Xtq6lHyy/fx52Nkcw37JZs2wd4lVKT2FQ=;
        h=From:To:Cc:Subject:Date:From;
        b=EZOKroobDDuFerfhNfbJfoFrs7nemaGy9EaGl4IfBKmsy0TzbE8w6K29wZSTxNbe3
         bCB5DEIyGn/QEbfqw/yVxGAomlx/Lz9PljeNHAMGYc+/ma5YyWGXBw0/UKJL1Kf5h2
         R5MCyEez8nE0aNvIvRROnFNZCIRyEylXmgpyAD48=
From:   broonie@kernel.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v5.8-rc2
Date:   Mon, 22 Jun 2020 12:39:14 +0100
Message-Id: <20200622114015.60DD1206BE@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 93b929922dba3a42b0439ef13144c6032b7733c8:

  Merge series "regmap: provide simple bitops and use them in a driver" from Bartosz Golaszewski <brgl@bgdev.pl> Bartosz Golaszewski <bgolaszewski@baylibre.com>: (2020-05-29 14:00:44 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.8-rc2

for you to fetch changes up to 95b2c3ec4cb1689db2389c251d39f64490ba641c:

  regmap: Fix memory leak from regmap_register_patch (2020-06-17 17:12:11 +0100)

----------------------------------------------------------------
regmap: Fixes for v5.8

A few small fixes, none of which are likely to have any substantial
impact here - the most substantial one is a fix for a long standing
memory leak on devices that use register patching which will only have
an impact if the device is removed and re-added.

----------------------------------------------------------------
Bartosz Golaszewski (1):
      regmap: fix the kerneldoc for regmap_test_bits()

Charles Keepax (1):
      regmap: Fix memory leak from regmap_register_patch

Jens Thoms Toerring (1):
      regmap: fix alignment issue

 drivers/base/regmap/regmap.c | 106 ++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 56 deletions(-)
