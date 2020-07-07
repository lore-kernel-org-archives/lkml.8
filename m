Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57029C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228B420663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135244;
	bh=lcAk/MdYca1FSQV397hRvZG7gSl/5f02OBNcFf7j7Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HOCrhseh7A4qH6Gp/wwo+P3dT+4mFFC0pt/k/AKUMcYKX6MSVhVkh2BjrhMWa5kEM
	 5tju+Ki6Z+D8eDi8tj9UaLGURGT1TS15GSc7eEQX0qMnUAVBGCvvpV9ltjYBtOOS+m
	 jtCx5c/80b75nlpRaBJmoAEqn/Q3egX6RLB+eMQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgGGPUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728598AbgGGPUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:20:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87A812065D;
        Tue,  7 Jul 2020 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135233;
        bh=lcAk/MdYca1FSQV397hRvZG7gSl/5f02OBNcFf7j7Qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZbqWiiYJ9nMcjZeZBtnB87CLYwJCZKQ1Z2Ie1Db5h3dCFuRetk+wqq2xzrQy4ZHxO
         brsQ4b9n12m6AuV25Q8fqp6iGGFgju9BfauqvRYIzmNqBvABxG52A65yrHOUU//LRE
         K2Tq0Rrb1uXrb+QS1AMh7Sri0uKMNVBtFX9eTjBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 25/65] cxgb4: use unaligned conversion for fetching timestamp
Date:   Tue,  7 Jul 2020 17:17:04 +0200
Message-Id: <20200707145753.702366107@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145752.417212219@linuxfoundation.org>
References: <20200707145752.417212219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>

[ Upstream commit 589b1c9c166dce120e27b32a83a78f55464a7ef9 ]

Use get_unaligned_be64() to fetch the timestamp needed for ns_to_ktime()
conversion.

Fixes following sparse warning:
sge.c:3282:43: warning: cast to restricted __be64

Fixes: a456950445a0 ("cxgb4: time stamping interface for PTP")
Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/sge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 3a45ac8f0e011..506170fe3a8b7 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -2816,7 +2816,7 @@ static noinline int t4_systim_to_hwstamp(struct adapter *adapter,
 
 	hwtstamps = skb_hwtstamps(skb);
 	memset(hwtstamps, 0, sizeof(*hwtstamps));
-	hwtstamps->hwtstamp = ns_to_ktime(be64_to_cpu(*((u64 *)data)));
+	hwtstamps->hwtstamp = ns_to_ktime(get_unaligned_be64(data));
 
 	return RX_PTP_PKT_SUC;
 }
-- 
2.25.1



