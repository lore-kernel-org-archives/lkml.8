Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7779C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3996206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592826076;
	bh=Gr89xbMKpVKYKTs/A/yFnhV+HBs9OuUAZRVKIIgaxFA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SbwNhqDlDeIhtn3cAIvzLBQBuDsgIYRZhUCoNr3ME7yomU7lMnyQfbgRxQ/Qs21jI
	 lSnooB8kjqCHmZZUqiJaAh5nlDJBJzMP8bm/JY6zgCKGOCuj8DHjR8kvrOnFlOnzZh
	 xaal62ClTm+aG5nsb3NcG4llA+X5tqR38dTntNC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgFVLlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgFVLlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:41:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 606FD206BE;
        Mon, 22 Jun 2020 11:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592826074;
        bh=Gr89xbMKpVKYKTs/A/yFnhV+HBs9OuUAZRVKIIgaxFA=;
        h=From:To:Cc:Subject:Date:From;
        b=a0kz93zgmDacOIYDBcjfWbeSNn9T0y3xinmF4FD/Rw3qfSDq1ZA9UZE56ChRDQahY
         gbfFypcDMCyqJQxRAHACYzXnFIgKcOaeUodEOqgWc1xC9lhV05uWrZXtKMRdBnlzFD
         MOZbPp/z2aC7UQ5uYdRmfDmONXzIh0DhZGBECHeo=
From:   broonie@kernel.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.8-rc2
Date:   Mon, 22 Jun 2020 12:40:20 +0100
Message-Id: <20200622114114.606FD206BE@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.8-rc2

for you to fetch changes up to 1b3bcca2085865c1facfbea9baf2f5cde5dc15e4:

  regulator: mt6358: Remove BROKEN dependency (2020-06-17 13:01:19 +0100)

----------------------------------------------------------------
regulator: Fixes for v5.8

This has a fix for the refactoring out of the pickable ranges
functionality, plus the removal of a BROKEN dependency on mt6358 now
that the dependencies were merged in -rc1 and a couple of device
specific fixes.

----------------------------------------------------------------
Axel Lin (1):
      regulator: mt6358: Remove BROKEN dependency

Mark Brown (1):
      Merge tag 'v5.8-rc1' into regulator-5.8

Martin Fuzzey (1):
      regulator: da9063: fix LDO9 suspend and warning.

Matti Vaittinen (1):
      regulator: Fix pickable ranges mapping

Robin Gong (1):
      regualtor: pfuze100: correct sw1a/sw2 on pfuze3000

 drivers/regulator/Kconfig              |  2 +-
 drivers/regulator/da9063-regulator.c   |  1 -
 drivers/regulator/helpers.c            |  2 +-
 drivers/regulator/pfuze100-regulator.c | 60 ++++++++++++++++++++++------------
 4 files changed, 41 insertions(+), 24 deletions(-)
