Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474DBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1756F20663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135239;
	bh=8HfJxiaBhyuUcN47TRW9Cdd12Anjqh3d9fdQtGgxGGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LS8jmDPHHcD3GxlMf/XFeH5O/P+N6/MJMtrgmZTa44d7OXOHFHib1OvZplpNqYDNz
	 7mUFTS6tKRSmTK8W+NijdcNiG3zDg0JOWqjb2Wg0X4DaNisG2xrX8bQeqThfsaD13P
	 gLz0SdkonTFpPbYUGiELDLp/nmApdJN64bolIU9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgGGPUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728614AbgGGPU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:20:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 381312065D;
        Tue,  7 Jul 2020 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135227;
        bh=8HfJxiaBhyuUcN47TRW9Cdd12Anjqh3d9fdQtGgxGGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7eHKK/2x5/7mKoLV6FX4VBf2cTaImOgLJBf8+fG1jnovofEQHq8YBAB/rfm1YLmr
         WtEap3uTfrz3wK2AZPno0QDvdGZgGBPpiuxfXI3H+C3qV9A2dHS6jD5le6UzsF249T
         QOZwVucupNPQ1QJVK3KIbvt7cuQeLPyB8u6EDnuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 23/65] rxrpc: Fix afs large storage transmission performance drop
Date:   Tue,  7 Jul 2020 17:17:02 +0200
Message-Id: <20200707145753.606109506@linuxfoundation.org>
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

From: David Howells <dhowells@redhat.com>

[ Upstream commit 02c28dffb13abbaaedece1e4a6493b48ad3f913a ]

Commit 2ad6691d988c, which moved the modification of the status annotation
for a packet in the Tx buffer prior to the retransmission moved the state
clearance, but managed to lose the bit that set it to UNACK.

Consequently, if a retransmission occurs, the packet is accidentally
changed to the ACK state (ie. 0) by masking it off, which means that the
packet isn't counted towards the tally of newly-ACK'd packets if it gets
hard-ACK'd.  This then prevents the congestion control algorithm from
recovering properly.

Fix by reinstating the change of state to UNACK.

Spotted by the generic/460 xfstest.

Fixes: 2ad6691d988c ("rxrpc: Fix race between incoming ACK parser and retransmitter")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/call_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 985fb89202d0c..9ff85ee8337cd 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -253,7 +253,7 @@ static void rxrpc_resend(struct rxrpc_call *call, unsigned long now_j)
 		 * confuse things
 		 */
 		annotation &= ~RXRPC_TX_ANNO_MASK;
-		annotation |= RXRPC_TX_ANNO_RESENT;
+		annotation |= RXRPC_TX_ANNO_UNACK | RXRPC_TX_ANNO_RESENT;
 		call->rxtx_annotations[ix] = annotation;
 
 		skb = call->rxtx_buffer[ix];
-- 
2.25.1



