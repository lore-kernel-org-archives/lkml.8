Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B021C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0379121D7E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580746890;
	bh=RMVr5lbZNUQ5PLSw+ZOShgdvCLUUmzfmSdmzJ+42/WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ri/glSi5fdKtx9w3Kb7Xi+FXYu4o7Un7bEvgm+HdRNEfHXutDo2rw6lMD5L0BBZoh
	 Nbn4tu7EchpdDdgBPG1uIOa+aEt09zXaS7s+ViDgc+UVEzoevqDp4Reo8aX0Rnhlar
	 JUX6SicawjmdOYSPEhVK4kDl9HZrwocLl/kpd9z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgBCQV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:21:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbgBCQV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:21:28 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C64C21582;
        Mon,  3 Feb 2020 16:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746886;
        bh=RMVr5lbZNUQ5PLSw+ZOShgdvCLUUmzfmSdmzJ+42/WY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qq/RoDU11s0knQ1pydk6WeTyiTloeZeB3PQN1ntjhmgGZXJrULJ82rUWufcyPmOeS
         lQPtQIMZ+xD5ezzLo1Ph6MqrDiZCynRbkWzFvO8kqBy/5rAtpyQ/LVObdtT0OYBthy
         rOmVBlltZd4rqdqOXZXoICFG5ok/32YCyKEqpmNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 48/53] net/sonic: Use MMIO accessors
Date:   Mon,  3 Feb 2020 16:19:40 +0000
Message-Id: <20200203161911.342192414@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit e3885f576196ddfc670b3d53e745de96ffcb49ab ]

The driver accesses descriptor memory which is simultaneously accessed by
the chip, so the compiler must not be allowed to re-order CPU accesses.
sonic_buf_get() used 'volatile' to prevent that. sonic_buf_put() should
have done so too but was overlooked.

Fixes: efcce839360f ("[PATCH] macsonic/jazzsonic network drivers update")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/natsemi/sonic.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/sonic.h b/drivers/net/ethernet/natsemi/sonic.h
index 1fd61d7f79bcb..a009a99c0e544 100644
--- a/drivers/net/ethernet/natsemi/sonic.h
+++ b/drivers/net/ethernet/natsemi/sonic.h
@@ -342,30 +342,30 @@ static void sonic_tx_timeout(struct net_device *dev);
    as far as we can tell. */
 /* OpenBSD calls this "SWO".  I'd like to think that sonic_buf_put()
    is a much better name. */
-static inline void sonic_buf_put(void* base, int bitmode,
+static inline void sonic_buf_put(u16 *base, int bitmode,
 				 int offset, __u16 val)
 {
 	if (bitmode)
 #ifdef __BIG_ENDIAN
-		((__u16 *) base + (offset*2))[1] = val;
+		__raw_writew(val, base + (offset * 2) + 1);
 #else
-		((__u16 *) base + (offset*2))[0] = val;
+		__raw_writew(val, base + (offset * 2) + 0);
 #endif
 	else
-	 	((__u16 *) base)[offset] = val;
+		__raw_writew(val, base + (offset * 1) + 0);
 }
 
-static inline __u16 sonic_buf_get(void* base, int bitmode,
+static inline __u16 sonic_buf_get(u16 *base, int bitmode,
 				  int offset)
 {
 	if (bitmode)
 #ifdef __BIG_ENDIAN
-		return ((volatile __u16 *) base + (offset*2))[1];
+		return __raw_readw(base + (offset * 2) + 1);
 #else
-		return ((volatile __u16 *) base + (offset*2))[0];
+		return __raw_readw(base + (offset * 2) + 0);
 #endif
 	else
-		return ((volatile __u16 *) base)[offset];
+		return __raw_readw(base + (offset * 1) + 0);
 }
 
 /* Inlines that you should actually use for reading/writing DMA buffers */
-- 
2.20.1



