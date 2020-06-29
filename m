Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41935C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DED1206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467426;
	bh=wcQcA47lG8JO3J8wMkcFyxnxenbxyubQuyfqn2fKReY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ol6Vh7ah7cDvxp9d4I/AQ8KDvUvbdxj1ORYvWNVmrHl0VWNcj6mfScEz4LHeN3uym
	 cpQRsP7gANau4GXtZLtoXL1ynjL7j9yMnhh6DLr02T+ERU1Z4XUOV0TpNsjmzrHbfa
	 qoOAJK7wZgtJ5gcDNADgemsaAJuxDpMVjYVcMM1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404176AbgF2VuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgF2Sfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83AF02468C;
        Mon, 29 Jun 2020 15:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443989;
        bh=wcQcA47lG8JO3J8wMkcFyxnxenbxyubQuyfqn2fKReY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EntbLoIQmj52KqixuMUqSvyp0w+KUj94pfcllsrdNmPm2S//qbzhxHhMPuzpx/DWB
         MeZistJ0FeUC+EVW2tG7/wdK5UcQGdTIu9N0K16zD5vaiH9hmi/HuCsrKPbY03bLFC
         4C4bJfHvAMPRR33peK/efvPv1VGqOXvyC03MGfXE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 093/265] bus: ti-sysc: Flush posted write on enable and disable
Date:   Mon, 29 Jun 2020 11:15:26 -0400
Message-Id: <20200629151818.2493727-94-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
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
index e5f5f48d69d2f..369c97c3e0c0b 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -991,6 +991,9 @@ set_autoidle:
 		sysc_write_sysconfig(ddata, reg);
 	}
 
+	/* Flush posted write */
+	sysc_read(ddata, ddata->offsets[SYSC_SYSCONFIG]);
+
 	if (ddata->module_enable_quirk)
 		ddata->module_enable_quirk(ddata);
 
@@ -1071,6 +1074,9 @@ set_sidle:
 		reg |= 1 << regbits->autoidle_shift;
 	sysc_write_sysconfig(ddata, reg);
 
+	/* Flush posted write */
+	sysc_read(ddata, ddata->offsets[SYSC_SYSCONFIG]);
+
 	return 0;
 }
 
-- 
2.25.1

