Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E03EC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 10:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30DF2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 10:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgBVK1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 05:27:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38782 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgBVK1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 05:27:22 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 650D82711FF;
        Sat, 22 Feb 2020 10:27:20 +0000 (GMT)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        =?UTF-8?q?Przemys=C5=82aw=20Gaj?= <pgaj@cadence.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        linux-i3c@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 0/3] i3c: Address i3c_device_id related issues
Date:   Sat, 22 Feb 2020 11:27:08 +0100
Message-Id: <20200222102711.1352006-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When the I3C subsystem was introduced part of the modalias generation
logic was missing (modalias generation based on i3c_device_id tables).
This patch series addresses that limitation and simplifies our match
function along the way.

Regards,

Boris

Boris Brezillon (3):
  i3c: Fix MODALIAS uevents
  i3c: Generate aliases for i3c modules
  i3c: Simplify i3c_device_match_id()

 drivers/i3c/device.c              | 50 ++++++++++++++-----------------
 drivers/i3c/master.c              |  2 +-
 scripts/mod/devicetable-offsets.c |  7 +++++
 scripts/mod/file2alias.c          | 19 ++++++++++++
 4 files changed, 49 insertions(+), 29 deletions(-)

-- 
2.24.1

