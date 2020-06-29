Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E99C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438B2206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593457829;
	bh=jyMPnnl8aflQgArorbOcPERLj5N9lJz/zKxlrgPdh2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uSPzI798LhldXRSXQn3cjMewPw9Yk9v8g8GnurrSm9vnrJQy8gwyg97IffuHEcVzf
	 lP+5/q9D3sd7djvTeSh1phPSyk3mAGGo34Jaf5w1KawijcRbGjYoolWPxquFzTpvOJ
	 YM3ZYASq7Z0SqUtXL1bz86v9jNNHF3K3NLQqC5Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgF2TK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730961AbgF2TKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:10:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEC86254A3;
        Mon, 29 Jun 2020 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445999;
        bh=jyMPnnl8aflQgArorbOcPERLj5N9lJz/zKxlrgPdh2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNozmLiWn1ZHTZZF00Jmf7yM4XcQlT5FJw4bwA73Ezf6h3q+7SDLCD3Mbq/1qseLR
         szk4zLvx0JdC4ZF+5Qn/M6V1VL6ga9MhR3XQB88dfxMRB3X31HiBtPh/12zVaxr/Iz
         PWj5D4Htwq/rK35k2VLfAIwtOJzNDZonMuurt9l0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 007/135] i2c: pxa: clear all master action bits in i2c_pxa_stop_message()
Date:   Mon, 29 Jun 2020 11:51:01 -0400
Message-Id: <20200629155309.2495516-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit e81c979f4e071d516aa27cf5a0c3939da00dc1ca ]

If we timeout during a message transfer, the control register may
contain bits that cause an action to be set. Read-modify-writing the
register leaving these bits set may trigger the hardware to attempt
one of these actions unintentionally.

Always clear these bits when cleaning up after a message or after
a timeout.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-pxa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 0d351954db02b..3264b50311ff0 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -691,11 +691,9 @@ static inline void i2c_pxa_stop_message(struct pxa_i2c *i2c)
 {
 	u32 icr;
 
-	/*
-	 * Clear the STOP and ACK flags
-	 */
+	/* Clear the START, STOP, ACK, TB and MA flags */
 	icr = readl(_ICR(i2c));
-	icr &= ~(ICR_STOP | ICR_ACKNAK);
+	icr &= ~(ICR_START | ICR_STOP | ICR_ACKNAK | ICR_TB | ICR_MA);
 	writel(icr, _ICR(i2c));
 }
 
-- 
2.25.1

