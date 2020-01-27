Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED9BC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC708214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgA0Ies (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:34:48 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56204 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgA0Ieq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 03:34:46 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A5524292E13;
        Mon, 27 Jan 2020 08:34:45 +0000 (GMT)
Date:   Mon, 27 Jan 2020 09:34:43 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-i3c <linux-i3c@lists.infradead.org>
Subject: [GIT PULL] i3c: Changes for 5.6
Message-ID: <20200127093443.0f52c6b3@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the I3C PR for 5.6.

Best Regards,

Boris

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git i3c/for-5.6

for you to fetch changes up to 3952cf8ff2f7751ee2f9d6cc6140df4667853250:

  i3c: master: dw: reattach device on first available location of address table (2020-01-13 10:00:05 +0100)

----------------------------------------------------------------
* Core changes:
  - Make i3c_bus_set_mode() static

* Driver changes:
  - Add a per-SoC data_hold_delay property to the Cadence driver
  - Fix formatting issues in the 'CADENCE I3C MASTER IP' MAINTAINERS entry
  - Use devm_platform_ioremap_resource() where appropriate
  - Adjust DesignWare reattach logic

----------------------------------------------------------------
Benjamin Gaignard (1):
      i3c: master: make i3c_bus_set_mode static

Lukas Bulwahn (1):
      MAINTAINERS: fix style in CADENCE I3C MASTER IP entry

Przemyslaw Gaj (1):
      i3c: master: cdns: add data hold delay support

Vitor Soares (1):
      i3c: master: dw: reattach device on first available location of address table

Yangtao Li (2):
      i3c: master: dw: convert to devm_platform_ioremap_resource
      i3c: master: cdns: convert to devm_platform_ioremap_resource

 MAINTAINERS                          |  8 ++++----
 drivers/i3c/master.c                 |  4 ++--
 drivers/i3c/master/dw-i3c-master.c   | 20 +++++++++++++++++---
 drivers/i3c/master/i3c-master-cdns.c | 53 +++++++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 68 insertions(+), 17 deletions(-)
