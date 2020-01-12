Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DC6C33CA7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 01:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A4D2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 01:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbgALBzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 20:55:12 -0500
Received: from foss.arm.com ([217.140.110.172]:57766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731897AbgALBzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 20:55:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 883E3328;
        Sat, 11 Jan 2020 17:55:11 -0800 (PST)
Received: from DESKTOP-VLO843J.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D1A63F6C4;
        Sat, 11 Jan 2020 17:55:10 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, smoch@web.de
Subject: [PATCH v2 0/5] mfd: RK8xx tidyup
Date:   Sun, 12 Jan 2020 01:54:59 +0000
Message-Id: <cover.1578789410.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a second crack at my RK805-inspired cleanup. There was a bit
of debate around v1[1], but it seems like we're now all happy that this
is a reasonable way to go. For clarity I decided to include Soeren's
patch as #1/5, but since I've rewritten most of my patches I've not
included the tested-by tags.

Robin.

[1] https://lore.kernel.org/lkml/cover.1575932654.git.robin.murphy@arm.com/

Robin Murphy (4):
  mfd: rk808: Ensure suspend/resume hooks always work
  mfd: rk808: Stop using syscore ops
  mfd: rk808: Reduce shutdown duplication
  mfd: rk808: Convert RK805 to shutdown/suspend hooks

Soeren Moch (1):
  mfd: rk808: Always use poweroff when requested

 drivers/mfd/rk808.c       | 139 +++++++++++++-------------------------
 include/linux/mfd/rk808.h |   2 -
 2 files changed, 48 insertions(+), 93 deletions(-)

-- 
2.17.1

