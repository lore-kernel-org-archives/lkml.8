Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE94C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6407520768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586217806;
	bh=1Lqk+doDrlT/SrI8d8AftpDemtX1pC+rrvgWeYNetTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GVCs6mSov7BR9xD1oSNx1O0HKDiO7GgZU4mrwIb0DqKiJ5wZYdnzTQpQRKjeKhe1m
	 GxZx7CJlUxpHqERDHpxxVlK07iOYCp5dgVdRX5DNs4rZ/vZUMwwyq7uZzs5zxudGId
	 O9m5bOEUiEVJmeyAKo4+ySpwYf3OY53vG+o8iS2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgDGADY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgDGADS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:03:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84C0B2080C;
        Tue,  7 Apr 2020 00:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586217798;
        bh=1Lqk+doDrlT/SrI8d8AftpDemtX1pC+rrvgWeYNetTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9f/Zkbr7Kgu6gnRTNs3OKHc39jlGjWPUTV1TJ24Eww3EHmN1mvOUKPjCIzEEKuUw
         mQv4z10/9RYFEfyMDmCB9au5Y+KHBsiwwSv/D35qnKwZQ0H9a4yrZgtMUFPyA4lctI
         /dE2JZHZ6rT8gbAAwJFX1bcW3WNdMoJKQ0wTGWOk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alain Volmat <avolmat@me.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 4/4] i2c: st: fix missing struct parameter description
Date:   Mon,  6 Apr 2020 20:03:12 -0400
Message-Id: <20200407000312.17447-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407000312.17447-1-sashal@kernel.org>
References: <20200407000312.17447-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <avolmat@me.com>

[ Upstream commit f491c6687332920e296d0209e366fe2ca7eab1c6 ]

Fix a missing struct parameter description to allow
warning free W=1 compilation.

Signed-off-by: Alain Volmat <avolmat@me.com>
Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-st.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 25020ec777c97..ee0a7d3dd0c65 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -399,6 +399,7 @@ static void st_i2c_wr_fill_tx_fifo(struct st_i2c_dev *i2c_dev)
 /**
  * st_i2c_rd_fill_tx_fifo() - Fill the Tx FIFO in read mode
  * @i2c_dev: Controller's private data
+ * @max: Maximum amount of data to fill into the Tx FIFO
  *
  * This functions fills the Tx FIFO with fixed pattern when
  * in read mode to trigger clock.
-- 
2.20.1

