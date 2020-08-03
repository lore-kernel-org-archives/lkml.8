Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508F9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F18204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457978;
	bh=bTEMXvdIvyE2iqBAS9NC+cQYJQ88tOHYymR7wqxovZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KZIeLu7xJ08oPL8yYuid1JGv0q5enSV5WjAYsVkbs+zwzRotcQNjkriARI3tGjmxu
	 ahuDz2kJmdXjRxIA14vvayNxPn4CWsouBJEJ806zeUTVDPjapERy+d5/Sc1EslQW6T
	 Z3NFxQcZEXHLIBK4uE3NaEv+6c3hO/iRH1qQz9ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgHCMc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbgHCMcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:32:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40591204EC;
        Mon,  3 Aug 2020 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457970;
        bh=bTEMXvdIvyE2iqBAS9NC+cQYJQ88tOHYymR7wqxovZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cX2kzR9B6OrAvVHDIHboceU4KZ0nRnsgfd5dzStnZrignYEkSgYqf5LgLUZ1GRd4h
         T220vK56lUyWBH1GCZ25koLngqsPwIAZGbyOGzFOQmlxAv5Lag/BTj/HKLZ2UD1v02
         mT9RGsREsEIpzcGfpFRPfAWy7qJX1G7GUAgGS7AY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 48/56] nfc: s3fwrn5: add missing release on skb in s3fwrn5_recv_frame
Date:   Mon,  3 Aug 2020 14:20:03 +0200
Message-Id: <20200803121852.668950531@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121850.306734207@linuxfoundation.org>
References: <20200803121850.306734207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 1e8fd3a97f2d83a7197876ceb4f37b4c2b00a0f3 ]

The implementation of s3fwrn5_recv_frame() is supposed to consume skb on
all execution paths. Release skb before returning -ENODEV.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/s3fwrn5/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nfc/s3fwrn5/core.c b/drivers/nfc/s3fwrn5/core.c
index 9d9c8d57a042d..64b58455e620b 100644
--- a/drivers/nfc/s3fwrn5/core.c
+++ b/drivers/nfc/s3fwrn5/core.c
@@ -209,6 +209,7 @@ int s3fwrn5_recv_frame(struct nci_dev *ndev, struct sk_buff *skb,
 	case S3FWRN5_MODE_FW:
 		return s3fwrn5_fw_recv_frame(ndev, skb);
 	default:
+		kfree_skb(skb);
 		return -ENODEV;
 	}
 }
-- 
2.25.1



