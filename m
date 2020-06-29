Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9420FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608292088E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459720;
	bh=JYx4yj8CzOUQClNd7aRJBUhlk4jct1WTIRIxB2hatyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m3rJp++kIMHk+AcRRlJhZM4cQLmzG8GFXggCHWCEtr1xoxrDhTQ7xciSA9mTqs1dd
	 Iwe9oCDAQZkIyYdcqWHFINJWkk2Dhw4YtdsHkrLh3n+9B888Y8DEp1Z7Leq+aE/VkZ
	 ocPJa8p+thRPz7svO46O2EnZuvL+mSuHZGfTGrkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387937AbgF2Tl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732679AbgF2Tkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45FCA248DF;
        Mon, 29 Jun 2020 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444434;
        bh=JYx4yj8CzOUQClNd7aRJBUhlk4jct1WTIRIxB2hatyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQ3GrkafEBazvzyS7Y16uxbvEuFxJyYrs03vUY2nZNoXeFZUAh3Vwm6RTp6L8t+la
         0hvKNIDixvmTgC0cbXlAKZm+kuN9L3FxWa+oFBfMBeB9s6re1hqINEtGhJVCAsmHxE
         IW3k0mGepb4WbwTu/CNgB4+RnuCWR8ceHs4+jttE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mans Rullgard <mans@mansr.com>, Wolfram Sang <wsa@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 113/178] i2c: core: check returned size of emulated smbus block read
Date:   Mon, 29 Jun 2020 11:24:18 -0400
Message-Id: <20200629152523.2494198-114-sashal@kernel.org>
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

From: Mans Rullgard <mans@mansr.com>

[ Upstream commit 40e05200593af06633f64ab0effff052eee6f076 ]

If the i2c bus driver ignores the I2C_M_RECV_LEN flag (as some of
them do), it is possible for an I2C_SMBUS_BLOCK_DATA read issued
on some random device to return an arbitrary value in the first
byte (and nothing else).  When this happens, i2c_smbus_xfer_emulated()
will happily write past the end of the supplied data buffer, thus
causing Bad Things to happen.  To prevent this, check the size
before copying the data block and return an error if it is too large.

Fixes: 209d27c3b167 ("i2c: Emulate SMBus block read over I2C")
Signed-off-by: Mans Rullgard <mans@mansr.com>
[wsa: use better errno]
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-smbus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 3ac426a8ab5ab..c2ae8c8cd4295 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -495,6 +495,13 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 			break;
 		case I2C_SMBUS_BLOCK_DATA:
 		case I2C_SMBUS_BLOCK_PROC_CALL:
+			if (msg[1].buf[0] > I2C_SMBUS_BLOCK_MAX) {
+				dev_err(&adapter->dev,
+					"Invalid block size returned: %d\n",
+					msg[1].buf[0]);
+				status = -EPROTO;
+				goto cleanup;
+			}
 			for (i = 0; i < msg[1].buf[0] + 1; i++)
 				data->block[i] = msg[1].buf[i];
 			break;
-- 
2.25.1

