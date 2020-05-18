Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D886C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334EC2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825001;
	bh=/vUl9F/NYMf2c7sOBI/8G/mLuRaIToq3VCuuxiOWLDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=in/drNo86RIAaVc4vK+V/0/ZPdXpZuQarvbqxCXjL+d3whVqIZo1GvsfadUihZH2A
	 ofFkqfoVqMwUVj8IeP1bHhN5ZtmatUCCKMYsvmw5tuNVf8Fetxjpu97gpbgsFu6LBA
	 UTyBrKlDL8GZoB6ajm7Kvcju6cfarbar25kaD1QA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbgERSDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732614AbgERSDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:03:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A3C207D3;
        Mon, 18 May 2020 18:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824988;
        bh=/vUl9F/NYMf2c7sOBI/8G/mLuRaIToq3VCuuxiOWLDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pi8RXUyy2BM5W+CBxUNMNKjJpf+8PocWzc8MaruPJVMeA9hA57CQ1ZEl9My5n5XzE
         6rWxyoIL7MNRA915IymEIOr1io4jCa62nR7GT44YepqGg1g+H93o892svwEwqzbMEi
         DN/kLMC0Wa9sQkoWdMdhqgYm88elr8l0RfiJG27I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Iris Liu <iris@onechronos.com>,
        Kelly Littlepage <kelly@onechronos.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.6 046/194] net: tcp: fix rx timestamp behavior for tcp_recvmsg
Date:   Mon, 18 May 2020 19:35:36 +0200
Message-Id: <20200518173535.657718381@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
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
@@ -2163,13 +2163,15 @@ skip_copy:
 			tp->urg_data = 0;
 			tcp_fast_path_check(sk);
 		}
-		if (used + offset < skb->len)
-			continue;
 
 		if (TCP_SKB_CB(skb)->has_rxtstamp) {
 			tcp_update_recv_tstamps(skb, &tss);
 			cmsg_flags |= 2;
 		}
+
+		if (used + offset < skb->len)
+			continue;
+
 		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
 			goto found_fin_ok;
 		if (!(flags & MSG_PEEK))


