Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDA1C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E326520730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099198;
	bh=a7WLY2vyVTy/LLORuijc1xT8Cr1/9sL3V1qrgS6OCfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MQWrucN6DgPaxnHVIYX8sppTjQqK4i+aVvgpkfG56aCeiTodyFU7KL/8mNAXzTcip
	 aOux3e/jqS/jV/6Fk0YMXhfQWTjU9/l2/nY2l+tm1IhlSErK6yJwzdhoFi+bqrnoLP
	 GvcI4ytTm1TQJyCh54fGA3D/R4Iq0JN6I4LaoGMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgD1Sj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:39:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730125AbgD1Sjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:39:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF2A92085B;
        Tue, 28 Apr 2020 18:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099195;
        bh=a7WLY2vyVTy/LLORuijc1xT8Cr1/9sL3V1qrgS6OCfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sV5x0Vb3v0Ee3S0o9XMSAgJVKpuqVJhzGngxUbuvaq6mK4MT/hdkJCipFTQ2dpzJE
         BQlRm7t/3dkSzrjrTpUasSgMqgcw1YktAqC2YB+ni0T0sQLkvzDEAZxtX3xDpP2Cln
         sYKbSAqwdLpzS2J5xGPlS57L6AX7C4/T3XjQ93Ic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 071/168] tcp: cache line align MAX_TCP_HEADER
Date:   Tue, 28 Apr 2020 20:24:05 +0200
Message-Id: <20200428182240.965775655@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9bacd256f1354883d3c1402655153367982bba49 ]

TCP stack is dumb in how it cooks its output packets.

Depending on MAX_HEADER value, we might chose a bad ending point
for the headers.

If we align the end of TCP headers to cache line boundary, we
make sure to always use the smallest number of cache lines,
which always help.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -50,7 +50,7 @@ extern struct inet_hashinfo tcp_hashinfo
 extern struct percpu_counter tcp_orphan_count;
 void tcp_time_wait(struct sock *sk, int state, int timeo);
 
-#define MAX_TCP_HEADER	(128 + MAX_HEADER)
+#define MAX_TCP_HEADER	L1_CACHE_ALIGN(128 + MAX_HEADER)
 #define MAX_TCP_OPTION_SPACE 40
 #define TCP_MIN_SND_MSS		48
 #define TCP_MIN_GSO_SIZE	(TCP_MIN_SND_MSS - MAX_TCP_OPTION_SPACE)


