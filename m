Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA01C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE4620736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgDXNNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:13:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726301AbgDXNNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:13:46 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C3E10EBEFB3E2EFFA5E7;
        Fri, 24 Apr 2020 21:13:41 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 24 Apr 2020
 21:13:35 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gerrit@erg.abdn.ac.uk>, <davem@davemloft.net>, <kuba@kernel.org>,
        <tglx@linutronix.de>
CC:     <dccp@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] dccp: remove unused inline function dccp_set_seqno
Date:   Fri, 24 Apr 2020 21:13:34 +0800
Message-ID: <20200424131334.37532-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no callers in-tree since commit 792b48780e8b ("dccp: Implement
both feature-local and feature-remote Sequence Window feature")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/dccp/dccp.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/dccp/dccp.h b/net/dccp/dccp.h
index 9c3b27c257bb..7dce4f6c7025 100644
--- a/net/dccp/dccp.h
+++ b/net/dccp/dccp.h
@@ -108,11 +108,6 @@ extern int  sysctl_dccp_sync_ratelimit;
 #define ADD48(a, b)	 (((a) + (b)) & UINT48_MAX)
 #define SUB48(a, b)	 ADD48((a), COMPLEMENT48(b))
 
-static inline void dccp_set_seqno(u64 *seqno, u64 value)
-{
-	*seqno = value & UINT48_MAX;
-}
-
 static inline void dccp_inc_seqno(u64 *seqno)
 {
 	*seqno = ADD48(*seqno, 1);
-- 
2.17.1


