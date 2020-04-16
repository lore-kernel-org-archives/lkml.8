Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A84C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8ACE2223D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051098;
	bh=iryEKzf2hO9H4jsbyGgbgdA/v/MMTMlVjJvsGOanEFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C8FFRUWZEpRJLlCUYAnT0ZquKg/+xNrNXHzceww/yh2F+HcFmh015BG9FbM6dCumx
	 WpdwnqE7XCSEKTqiGJujZZF56ldAfgvC5DYGRwFPD98kaYQlpQAyHKkPFJoy4xG2Ds
	 1x8g5kJVh5YO7KK9qgGjg00uFf/oxXvo4ZTLH824=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505954AbgDPPbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392152AbgDPNmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:42:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43033214D8;
        Thu, 16 Apr 2020 13:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044574;
        bh=iryEKzf2hO9H4jsbyGgbgdA/v/MMTMlVjJvsGOanEFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TX8iHy9BvEHXfB9fu9fITcic5DWdD9vprV8M0TKnzQM0N8UY10QFK2M7Gme59IlCn
         HlZjtjo04MvPmdJw4xiwPGuZ5zgtkxyYjdTVKKNrgKbQ4uhUHy7CpcjHrZGqsK8ori
         4oCXCOviSqJBp4F3KqKKOo66Clq4mT07+e4Xolmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luo bin <luobin9@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 016/232] hinic: fix wrong value of MIN_SKB_LEN
Date:   Thu, 16 Apr 2020 15:21:50 +0200
Message-Id: <20200416131318.392451766@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo bin <luobin9@huawei.com>

[ Upstream commit 7296695fc16dd1761dbba8b68a9181c71cef0633 ]

the minimum value of skb len that hw supports is 32 rather than 17

Signed-off-by: Luo bin <luobin9@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/huawei/hinic/hinic_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
index 375d81d03e866..365016450bdbe 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -45,7 +45,7 @@
 
 #define HW_CONS_IDX(sq)                 be16_to_cpu(*(u16 *)((sq)->hw_ci_addr))
 
-#define MIN_SKB_LEN                     17
+#define MIN_SKB_LEN			32
 
 #define	MAX_PAYLOAD_OFFSET	        221
 #define TRANSPORT_OFFSET(l4_hdr, skb)	((u32)((l4_hdr) - (skb)->data))
-- 
2.20.1



