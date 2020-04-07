Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7DAC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB6520768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586217924;
	bh=lkt+7S1Ws1ROwt9EaaZvt6jC5ZwlXMV5tjkHz4O490Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YO+4DPWgYULKrCBbBfPPpffx30hK/H/zC81Ni+021aGVlbszSyGr5FVSNmiyNP1Tx
	 ZZiQdcWTgbBQDK49AHPace6nCisRlBQsv6DP/o6THrHEd7BVM7rKSk7Z9IXW8Vu8Hs
	 7TAGlxT0svt4GphFLSCqkR7oYBv+rixfLaYduUDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgDGAFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbgDGACa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:02:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94614207FF;
        Tue,  7 Apr 2020 00:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586217750;
        bh=lkt+7S1Ws1ROwt9EaaZvt6jC5ZwlXMV5tjkHz4O490Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPEnUL4Bd4kYn/YIpGU1hRx7occSLTT7v0WH0fdUZw/O+p1MlFXgkCEKhPIQl1+gP
         16TwBcDkaf9xdPWFLl/28y+h9pXhbKorwyfY4PdrasASnDnsYoPzuIuFXV/BIHSt2n
         Er6mjxerIivFhYLxSZX00tMAy5b6Z5KFTQ2xn4A8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alain Volmat <avolmat@me.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 31/32] i2c: st: fix missing struct parameter description
Date:   Mon,  6 Apr 2020 20:01:49 -0400
Message-Id: <20200407000151.16768-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407000151.16768-1-sashal@kernel.org>
References: <20200407000151.16768-1-sashal@kernel.org>
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
index 54e1fc8a495e7..f7f7b5b64720e 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -434,6 +434,7 @@ static void st_i2c_wr_fill_tx_fifo(struct st_i2c_dev *i2c_dev)
 /**
  * st_i2c_rd_fill_tx_fifo() - Fill the Tx FIFO in read mode
  * @i2c_dev: Controller's private data
+ * @max: Maximum amount of data to fill into the Tx FIFO
  *
  * This functions fills the Tx FIFO with fixed pattern when
  * in read mode to trigger clock.
-- 
2.20.1

