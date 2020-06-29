Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54625C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7062082F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459886;
	bh=WCjtbpjQ4nsvFwRlVNbbY7Rzz1MwGVeN88ApKGRWaO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HvxbzH2/AyVvQxG5h4AaWR/nxa2Fnt/4+NzZt2vka4QbIN2YI7jN2hVCkCI0+37jw
	 mNjz2P977V9N1m3D46f0byZtouwbWtoiGDK3v9o6QvjZLZZT+ZiJ10I5CL46LPy0Et
	 5LjbUFJ2S4SlJobHfKIJW4pguSTAGtHEWXVfdzao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbgF2Too (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:44:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387837AbgF2Tkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FF57248DC;
        Mon, 29 Jun 2020 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444434;
        bh=WCjtbpjQ4nsvFwRlVNbbY7Rzz1MwGVeN88ApKGRWaO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQh/8WH/jtM18lSaP5N5BSoWqCfCj4fxMOVvJWznAoSlKBozSl44Ssw8BaNAGXIUK
         MD+rF1/UuyDmyfseOZCBYQEMb1SnlbdY0p78cK41hLGFwnWt3M/85/PiDPkXa5hl17
         LluABOEUdiq/V0xw78Oo4yr2zAPFbDVZ/ilFKjZs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 112/178] i2c: fsi: Fix the port number field in status register
Date:   Mon, 29 Jun 2020 11:24:17 -0400
Message-Id: <20200629152523.2494198-113-sashal@kernel.org>
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

From: Eddie James <eajames@linux.ibm.com>

[ Upstream commit 502035e284cc7e9efef22b01771d822d49698ab9 ]

The port number field in the status register was not correct, so fix it.

Fixes: d6ffb6300116 ("i2c: Add FSI-attached I2C master algorithm")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-fsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index e0c256922d4f1..977d6f524649c 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -98,7 +98,7 @@
 #define I2C_STAT_DAT_REQ	BIT(25)
 #define I2C_STAT_CMD_COMP	BIT(24)
 #define I2C_STAT_STOP_ERR	BIT(23)
-#define I2C_STAT_MAX_PORT	GENMASK(19, 16)
+#define I2C_STAT_MAX_PORT	GENMASK(22, 16)
 #define I2C_STAT_ANY_INT	BIT(15)
 #define I2C_STAT_SCL_IN		BIT(11)
 #define I2C_STAT_SDA_IN		BIT(10)
-- 
2.25.1

