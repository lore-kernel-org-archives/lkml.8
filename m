Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C34C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC8822522
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194424;
	bh=rgGdzB4cVLt1R+ntLiKhZow3VesNrvHG1CWg4LPL2Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eOHNY3Rhfx95MY0xrSUXTyKAI6w97hZSduTF6EPOBvCnODg6FG04WXqmWRE+cXfkD
	 QmnRnQQxj0kEXdeyqai35wKnpHADUdiAV1/zpdWecAe+mv/bANJtDz2IZIfiM9/A7g
	 8rBIHaxACCEyYPbq68Pb0ZHBB0UbrEKm+Q6s4hkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbgAPRHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:07:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389006AbgAPRGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC6D3205F4;
        Thu, 16 Jan 2020 17:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194410;
        bh=rgGdzB4cVLt1R+ntLiKhZow3VesNrvHG1CWg4LPL2Ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FOAunnuQD5J4gPd/0OTS2WFyD2mcHJpeYti0cxU2VmQQDJjqoFn4/sVNWIcBzyKs8
         EwAYjSDgPG2uCS4UPpsCtG6fnRBpkhAQCx0OirKN13uv87fn6vJPUQ/7ksa6y+drHG
         dvf9CW2Y8rlT//7Pp3PYRFbNT4Q84oPBmm6wogkM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sameeh Jubran <sameehj@amazon.com>,
        Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 333/671] net: ena: fix ena_com_fill_hash_function() implementation
Date:   Thu, 16 Jan 2020 11:59:31 -0500
Message-Id: <20200116170509.12787-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sameeh Jubran <sameehj@amazon.com>

[ Upstream commit 11bd7a00c0d8ffe33d1e926f8e789b4aea787186 ]

ena_com_fill_hash_function() didn't configure the rss->hash_func.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 005882c40262..92261c946e2a 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -2093,6 +2093,7 @@ int ena_com_fill_hash_function(struct ena_com_dev *ena_dev,
 		return -EINVAL;
 	}
 
+	rss->hash_func = func;
 	rc = ena_com_set_hash_function(ena_dev);
 
 	/* Restore the old function */
-- 
2.20.1

