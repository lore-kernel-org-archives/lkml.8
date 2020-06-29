Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14886C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB69B2065D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461733;
	bh=aHJvosfP7d43KJpeh6puslOWNdY/vjt/a2wFCH5S5XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dK/tSVIehBQ/+nsl7RwyNz9HQZFlxvO5a24jORkOWjlkZZyib8Q3KFbXB3Z4OAl4C
	 YNHRL0ABJN/Q7VsJYs2KclVguAfcYoaJHp3iYzO8kkJDEeGFklk1379SjJqamxyHFq
	 hVnCVYbA2plJ0vSmXUNUcHnHOyAU0lOIxewFDk6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbgF2UPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732829AbgF2TaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE7F25279;
        Mon, 29 Jun 2020 15:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444986;
        bh=aHJvosfP7d43KJpeh6puslOWNdY/vjt/a2wFCH5S5XQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pn1ZGXT2iE4RAPytg64WWr3pnDeRP4ZPwQmiVTnf3gLfSuMpooFi3UyNxmmsWG3Dz
         79lZmh/uyNg1rt19tosd8aDLlcfBDmHKPDWpBMLgmGAl0jC/mBWAcwljbsBhTZhWZs
         9cfjCtIIox6ZSTkjBFyMQPsU49cokNNc0wS5Hlwo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 086/131] i2c: fsi: Fix the port number field in status register
Date:   Mon, 29 Jun 2020 11:34:17 -0400
Message-Id: <20200629153502.2494656-87-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
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
index 1e2be2219a602..46aef609fb708 100644
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

