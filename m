Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8A6C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F0B2051A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341712;
	bh=FIl5LxAo3sAnFk0EG7vW2iQiLwXy00fRa5v3cZeQbw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rDeLBRiAx7anL3rIMpuj8W/wFcJDnOg2H70UZ1xV/BoC6hFdk6FQxRdOM7bs0PpX4
	 lH6DB7Bmp83AF3lKVdpm68MzGDje3H9CrhCZFh0IhT3HvB5qLJjpGEn5JTbNPTX1xq
	 kwbEIqOu5Vp5Q0DJgky+MBc5ux/0qgdUZpNp1wUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgEAOBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbgEANZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:25:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D0542495E;
        Fri,  1 May 2020 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339519;
        bh=FIl5LxAo3sAnFk0EG7vW2iQiLwXy00fRa5v3cZeQbw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9HCxwMM7KTfm6JDv1eiyc0pKGBSAQ3ljJ2/JgRX9P19zJKBcowVlWdfskJNWEt9P
         5zygeIKArbCRLDqbPqoza/VQidKPNQCsI26HMo9XNuJQnQc7rICmVYHIzIDmvqEKTQ
         yPXZvxFi+fwe/N5ton//6e5C7tul3wI+YcPGovyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 22/70] tcp: cache line align MAX_TCP_HEADER
Date:   Fri,  1 May 2020 15:21:10 +0200
Message-Id: <20200501131521.123720775@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.302599262@linuxfoundation.org>
References: <20200501131513.302599262@linuxfoundation.org>
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
@@ -52,7 +52,7 @@ extern struct inet_hashinfo tcp_hashinfo
 extern struct percpu_counter tcp_orphan_count;
 void tcp_time_wait(struct sock *sk, int state, int timeo);
 
-#define MAX_TCP_HEADER	(128 + MAX_HEADER)
+#define MAX_TCP_HEADER	L1_CACHE_ALIGN(128 + MAX_HEADER)
 #define MAX_TCP_OPTION_SPACE 40
 #define TCP_MIN_SND_MSS		48
 #define TCP_MIN_GSO_SIZE	(TCP_MIN_SND_MSS - MAX_TCP_OPTION_SPACE)


