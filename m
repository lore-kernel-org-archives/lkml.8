Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AB7C3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523D8217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203966;
	bh=9B8Qnr631MfRuBnxFI5I6OfrDDH6d19nhO8jBXeyet0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WgneIG2Kvl3lTBfMnMqDNSv9zkvWJAoBeEK33qBNrGwLIze5itAA4LGIFPTTlCr24
	 GobQvHemY5CtR4iLUPB482D0ImZlhwhpTOXHrfSQq2xtImw3VZ608B+2sGylzmb5gK
	 RtTCOx+0CuoRH1gEnN7gH45T627G4H52odXJy8F8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgCCCty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgCCCtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:49:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 500A02468D;
        Tue,  3 Mar 2020 02:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203787;
        bh=9B8Qnr631MfRuBnxFI5I6OfrDDH6d19nhO8jBXeyet0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vOFC01svzdwOwPN1AdUhwB5CIomimHpG8JpAyP9SLFoJKJNEGB69PwZQEc6Vaj4nJ
         ccFxO8Edxo3LChRJXaZrzKE+awk/uUeyT5nQGaf1OR/8UQLrJUoujZnM1Rysig/1RN
         b6+mYtcnq6TFR4kXrqLL8QLSuFXQXZdLN5IfCLjo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Belous <pbelous@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Dmitry Bogdanov <dbogdanov@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 10/22] net: atlantic: fix potential error handling
Date:   Mon,  2 Mar 2020 21:49:21 -0500
Message-Id: <20200303024933.10371-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024933.10371-1-sashal@kernel.org>
References: <20200303024933.10371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Belous <pbelous@marvell.com>

[ Upstream commit 380ec5b9af7f0d57dbf6ac067fd9f33cff2fef71 ]

Code inspection found that in case of mapping error we do return current
'ret' value. But beside error, it is used to count number of descriptors
allocated for the packet. In that case map_skb function could return '1'.

Changing it to return zero (number of mapped descriptors for skb)

Fixes: 018423e90bee ("net: ethernet: aquantia: Add ring support code")
Signed-off-by: Pavel Belous <pbelous@marvell.com>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Dmitry Bogdanov <dbogdanov@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index a69f5f1ad32a8..7a900f76c9ac3 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -519,8 +519,10 @@ static unsigned int aq_nic_map_skb(struct aq_nic_s *self,
 				     dx_buff->len,
 				     DMA_TO_DEVICE);
 
-	if (unlikely(dma_mapping_error(aq_nic_get_dev(self), dx_buff->pa)))
+	if (unlikely(dma_mapping_error(aq_nic_get_dev(self), dx_buff->pa))) {
+		ret = 0;
 		goto exit;
+	}
 
 	first = dx_buff;
 	dx_buff->len_pkt = skb->len;
-- 
2.20.1

