Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CAFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17C6207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860232;
	bh=qrLmXgZbIEcHIp+0WI3P3rg3unMUaFsDnDu4Pd2+yeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u6ZyU6eCVx0fOpgMYbgbEB8lWMT5L9Q5RhF25hTxi/OeCBorPcMRqhWfei8GpST5b
	 X9IYDZyWx0lIdMfXKPwvvkOg0UBNit3bJVtUtA7M/Z6Y7eyGrecDghpAeZ9pjyYRqS
	 gslMzUJAsPLZ0z8ZzXVW72N8GmAKwOyiwE5w43mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbgG0Oaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731797AbgG0OVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:21:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A0452070A;
        Mon, 27 Jul 2020 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859711;
        bh=qrLmXgZbIEcHIp+0WI3P3rg3unMUaFsDnDu4Pd2+yeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SuEfUiTdxsNjr3Rr8FIDp2kSau+Bq7BWD4Uwo4rnhqDSCKoRW8vm25/6wC+XXOehz
         YRRnSTMWINP8u8nR8c8rJvm0WEaYQKHh+l52Mgduc1amgg/ayjKaJUr5CgoKyxw5eL
         dsrzf5FMGyBpe5Lc10cOPfNnsBFyqNkkhUT3JBNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 075/179] crypto/chtls: fix tls alert messages corrupted by tls data
Date:   Mon, 27 Jul 2020 16:04:10 +0200
Message-Id: <20200727134936.334859651@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinay Kumar Yadav <vinay.yadav@chelsio.com>

[ Upstream commit c271042eb6a031d1333cf57422ec1d20726901ab ]

When tls data skb is pending for Tx and tls alert comes , It
is wrongly overwrite the record type of tls data to tls alert
record type. fix the issue correcting it.

v1->v2:
- Correct submission tree.
- Add fixes tag.

Fixes: 6919a8264a32 ("Crypto/chtls: add/delete TLS header in driver")
Signed-off-by: Vinay Kumar Yadav <vinay.yadav@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/chelsio/chtls/chtls_io.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/chelsio/chtls/chtls_io.c b/drivers/crypto/chelsio/chtls/chtls_io.c
index e1401d9cc756c..2e9acae1cba3b 100644
--- a/drivers/crypto/chelsio/chtls/chtls_io.c
+++ b/drivers/crypto/chelsio/chtls/chtls_io.c
@@ -1052,14 +1052,15 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 							  &record_type);
 				if (err)
 					goto out_err;
+
+				/* Avoid appending tls handshake, alert to tls data */
+				if (skb)
+					tx_skb_finalize(skb);
 			}
 
 			recordsz = size;
 			csk->tlshws.txleft = recordsz;
 			csk->tlshws.type = record_type;
-
-			if (skb)
-				ULP_SKB_CB(skb)->ulp.tls.type = record_type;
 		}
 
 		if (!skb || (ULP_SKB_CB(skb)->flags & ULPCB_FLAG_NO_APPEND) ||
-- 
2.25.1



