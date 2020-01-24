Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41724206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865182;
	bh=d6SmrSsZRvzU5AcjXbfQGmEHzMEihDgEyQkQRTpSdsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WpT5Ray50Wp2Pnr9ph5HDWiS78LbJ4MkLin+MgBBya6sIrZvdofzUdscda9KxGUJo
	 7hFnrRMQ7iJrQCffJyA1FdTl1iQTFKQ7q8iYhK6m6KvxJJfsy3DSDf+IEWVkoFN3Rt
	 SFYa+H5XTf4u988N76x8hE7eaW57Uf+tCnY8yhNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbgAXL0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:26:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732638AbgAXL0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:26:17 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CA9B214DB;
        Fri, 24 Jan 2020 11:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865176;
        bh=d6SmrSsZRvzU5AcjXbfQGmEHzMEihDgEyQkQRTpSdsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nV08pYTDUODMMNQLHSnKZzK/gVwZd7Ee7wzmzyEd662ZMz7wl2XE3QBszg2/UDtEp
         hQztbubBlxg4Rgge5uCDl10dXK3mRxPcOEn944ZXENej7IzLLBO4d6vNFOBJMH+FdL
         pxCHm9FqvWXINNUE3yrjVTXYqyTmnpbMV+VYtp/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 474/639] net/tls: fix socket wmem accounting on fallback with netem
Date:   Fri, 24 Jan 2020 10:30:44 +0100
Message-Id: <20200124093147.268555945@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 5c4b4608fe100838c62591877101128467e56c00 ]

netem runs skb_orphan_partial() which "disconnects" the skb
from normal TCP write memory accounting.  We should not adjust
sk->sk_wmem_alloc on the fallback path for such skbs.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_device_fallback.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 426dd97725e4a..6cf832891b53e 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -208,6 +208,10 @@ static void complete_skb(struct sk_buff *nskb, struct sk_buff *skb, int headln)
 
 	update_chksum(nskb, headln);
 
+	/* sock_efree means skb must gone through skb_orphan_partial() */
+	if (nskb->destructor == sock_efree)
+		return;
+
 	delta = nskb->truesize - skb->truesize;
 	if (likely(delta < 0))
 		WARN_ON_ONCE(refcount_sub_and_test(-delta, &sk->sk_wmem_alloc));
-- 
2.20.1



