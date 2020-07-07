Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDDEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A713820674
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594134974;
	bh=wliWpRz2WySThTwUaygASKjo7TrqNJ9D0qchoiYARrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jn4enz543RC31cjc5rBQlrZ5j/yQpnpEn6QnEocnbdY88GW24kPgBjbCNK8VDBBC4
	 Xv1xtJe/pam9hr0HBQEI4+uY869h1FwZenhqVa8wKzcOg5K2Y6RRFa8Bisk/95MLNt
	 lP5MUg/e/9dA2rpkG7x5bSTc1hBBd3sdhYCvHwb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgGGPQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbgGGPQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:16:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 450052065D;
        Tue,  7 Jul 2020 15:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594134969;
        bh=wliWpRz2WySThTwUaygASKjo7TrqNJ9D0qchoiYARrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2d6MgjCAhJjsDNyDeBtjmxTdZhG1b1wkagdAeq7/F3xMF/2hzpiBzyq3LRI97bLzl
         SC5bHMB8Ic1LRO9MYbCTptjtv4r/DsEQcyMVUE91oNaCJRtHdLV8IEKqDuZO+lc26E
         3zbbh30BVhcRw7uecY5wPrv55RX8FfB8VfZFKX6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/27] cxgb4: use unaligned conversion for fetching timestamp
Date:   Tue,  7 Jul 2020 17:15:39 +0200
Message-Id: <20200707145749.557175038@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145748.944863698@linuxfoundation.org>
References: <20200707145748.944863698@linuxfoundation.org>
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
index 4ef68f69b58c4..0a5c4c7da5052 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -2088,7 +2088,7 @@ static noinline int t4_systim_to_hwstamp(struct adapter *adapter,
 
 	hwtstamps = skb_hwtstamps(skb);
 	memset(hwtstamps, 0, sizeof(*hwtstamps));
-	hwtstamps->hwtstamp = ns_to_ktime(be64_to_cpu(*((u64 *)data)));
+	hwtstamps->hwtstamp = ns_to_ktime(get_unaligned_be64(data));
 
 	return RX_PTP_PKT_SUC;
 }
-- 
2.25.1



