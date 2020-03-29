Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A53C2D0ED
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D6920714
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 08:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgC2IuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 04:50:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48330 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgC2IuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 04:50:15 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3514B29054B;
        Sun, 29 Mar 2020 09:50:14 +0100 (BST)
Date:   Sun, 29 Mar 2020 10:50:07 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [GIT PULL] i3c: Changes for 5.7
Message-ID: <20200329104816.5cbdb74f@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the I3C PR for 5.7.

Best Regards,

Boris

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.7

for you to fetch changes up to c4b9de11d0101792c4d5458b18581f4f527862d1:

  i3c: convert to use i2c_new_client_device() (2020-03-29 10:35:50 +0200)

----------------------------------------------------------------
* Fix driver auto-probing related issues
* Stop using the deprecated i2c_new_device() function
* Replace zero-length array with flexible-array member

----------------------------------------------------------------
Boris Brezillon (4):
      i3c: Fix MODALIAS uevents
      i3c: Add a modalias sysfs attribute
      i3c: Generate aliases for i3c modules
      i3c: Simplify i3c_device_match_id()

Gustavo A. R. Silva (1):
      i3c: master: Replace zero-length array with flexible-array member

Wolfram Sang (2):
      i3c: master: no need to iterate master device twice
      i3c: convert to use i2c_new_client_device()

 drivers/i3c/device.c                 | 50 ++++++++++++++++++++++----------------------------
 drivers/i3c/master.c                 | 28 +++++++++++++++++++++++++---
 drivers/i3c/master/dw-i3c-master.c   |  2 +-
 drivers/i3c/master/i3c-master-cdns.c |  2 +-
 scripts/mod/devicetable-offsets.c    |  7 +++++++
 scripts/mod/file2alias.c             | 19 +++++++++++++++++++
 6 files changed, 75 insertions(+), 33 deletions(-)
