Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930A8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7585E20674
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460600;
	bh=HfZiEGyAU4+9OTJfIbM4lsIBBzpqkTQDxAY0fLZh2EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UZUF8zz+klrfWXAAZX+0/M8EUhY980zzCAeLgCN9loCz2dQvogbN7dwt3IO02DZ1V
	 LKQ94wRnHENlSFbvLBy1Rk3P6zixxR0kYnoxpsejk1wYOUFSysuQ6BnYHlRbDL6rvb
	 UAbvJz/KNGVWmDPzaSjcAoH94YjCNy1ajvabDnfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbgF2T4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387639AbgF2TkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEE0824885;
        Mon, 29 Jun 2020 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444384;
        bh=HfZiEGyAU4+9OTJfIbM4lsIBBzpqkTQDxAY0fLZh2EA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLB+hVjhKjxQJlOACGtD1QUwShZKee7Vs+L6o2fAVU2RzHXl4dNwjGehuiKEpYhy8
         afcf0QyrCf5OvxrzmdZSnIqU0aWg0FH0ee8YjrpDPuFNwc6efAHgjARx4UzxEkOoPM
         zcSSZDrok0nfuB1E1XUgkXyl9DgcPbGX+R5b53pU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 061/178] bus: ti-sysc: Flush posted write on enable and disable
Date:   Mon, 29 Jun 2020 11:23:26 -0400
Message-Id: <20200629152523.2494198-62-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 5ce8aee81be6c8bc19051d7c7b0d3cbb7ac5fc3f ]

Looks like we're missing flush of posted write after module enable and
disable. I've seen occasional errors accessing various modules, and it
is suspected that the lack of posted writes can also cause random reboots.

The errors we can see are similar to the one below from spi for example:

44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4CFG (Read): Data Access
in User mode during Functional access
...
mcspi_wait_for_reg_bit
omap2_mcspi_transfer_one
spi_transfer_one_message
...

We also want to also flush posted write for disable. The clkctrl clock
disable happens after module disable, and we don't want to have the
module potentially stay active while we're trying to disable the clock.

Fixes: d59b60564cbf ("bus: ti-sysc: Add generic enable/disable functions")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index f0bc0841cbc40..c088c6f4adcff 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -938,6 +938,9 @@ static int sysc_enable_module(struct device *dev)
 		sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
 	}
 
+	/* Flush posted write */
+	sysc_read(ddata, ddata->offsets[SYSC_SYSCONFIG]);
+
 	if (ddata->module_enable_quirk)
 		ddata->module_enable_quirk(ddata);
 
@@ -1018,6 +1021,9 @@ static int sysc_disable_module(struct device *dev)
 		reg |= 1 << regbits->autoidle_shift;
 	sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
 
+	/* Flush posted write */
+	sysc_read(ddata, ddata->offsets[SYSC_SYSCONFIG]);
+
 	return 0;
 }
 
-- 
2.25.1

