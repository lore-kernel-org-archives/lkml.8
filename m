Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0297BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB14520657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824146;
	bh=pd5YWyWFz+tsihJlMqRKZ21NLXrKyDUcvfBo3PqQ9Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jtuj/bZgTXOm1kEvc9lzDuzn3zl13czihBKJGnfSJyA4Qwx2Q0vvrkM+dU8cB3HZD
	 LkX0zeD9XMVAgk6MT+eP2T1W0vxTNe5xw2X37N83lKtIX/2oCfSWbx6KKV3Xh/8Xn0
	 htcAa4ADQV1hCyWzf0Ey6xFEzOL4tmGYw1BfHKZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgERRtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730010AbgERRtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:49:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14DE020657;
        Mon, 18 May 2020 17:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824142;
        bh=pd5YWyWFz+tsihJlMqRKZ21NLXrKyDUcvfBo3PqQ9Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WrdN0ehFoOA7fRHjgtNn5DFeA0Y4fQCSRh9Rwp0u6yJy3dDeKuIFMKLl9jJYJyHdg
         eRvEoLdgay/7s04ZO+YPvk0d7Kj0zC1ChCE3fXzyxPfS2EPlJnm7tBLt5q05rRmRup
         vR3qtruRGP2qnl/gffikCBLh0dybStNL+N1HFM9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Iris Liu <iris@onechronos.com>,
        Kelly Littlepage <kelly@onechronos.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.14 089/114] net: tcp: fix rx timestamp behavior for tcp_recvmsg
Date:   Mon, 18 May 2020 19:37:01 +0200
Message-Id: <20200518173518.386266386@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kelly Littlepage <kelly@onechronos.com>

[ Upstream commit cc4de047b33be247f9c8150d3e496743a49642b8 ]

The stated intent of the original commit is to is to "return the timestamp
corresponding to the highest sequence number data returned." The current
implementation returns the timestamp for the last byte of the last fully
read skb, which is not necessarily the last byte in the recv buffer. This
patch converts behavior to the original definition, and to the behavior of
the previous draft versions of commit 98aaa913b4ed ("tcp: Extend
SOF_TIMESTAMPING_RX_SOFTWARE to TCP recvmsg") which also match this
behavior.

Fixes: 98aaa913b4ed ("tcp: Extend SOF_TIMESTAMPING_RX_SOFTWARE to TCP recvmsg")
Co-developed-by: Iris Liu <iris@onechronos.com>
Signed-off-by: Iris Liu <iris@onechronos.com>
Signed-off-by: Kelly Littlepage <kelly@onechronos.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1977,13 +1977,15 @@ skip_copy:
 			tp->urg_data = 0;
 			tcp_fast_path_check(sk);
 		}
-		if (used + offset < skb->len)
-			continue;
 
 		if (TCP_SKB_CB(skb)->has_rxtstamp) {
 			tcp_update_recv_tstamps(skb, &tss);
 			has_tss = true;
 		}
+
+		if (used + offset < skb->len)
+			continue;
+
 		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
 			goto found_fin_ok;
 		if (!(flags & MSG_PEEK))


