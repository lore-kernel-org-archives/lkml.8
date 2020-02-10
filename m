Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25985C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80B82070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341839;
	bh=A7nZ49z92KKAewOXnW82/NVd8FusS93K/tBXDnbDalM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hHjRMJ0yRL4zE07rnMgeMreoeJlgJo2l4SDrVjdDh9N+2ByOzdslp/VLL10weocuV
	 ymnJsxOEBBXaSk7atC5ECVnEh1sIBx3ISjzbGSasFqNK+MO2EYqFHYow59AwJ9oxT+
	 YBSCwnEvAbvdUNHCwsMZMEomEZI1qdXQ1+5wTsSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbgBJNhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:37:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbgBJMfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:03 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 831B320661;
        Mon, 10 Feb 2020 12:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338101;
        bh=A7nZ49z92KKAewOXnW82/NVd8FusS93K/tBXDnbDalM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgwtKR8VwoNFWP6L+om7xVjPVyWRCHXgH3UzYb35sV4OfYeWjrDajiUlME0FR4E3p
         F/WpDCjBhUyvbCu1ygA1sMIqmtHs0lQprFKi4Q2GL1LrsSGSdGspabZeH+GvQihZTB
         o5WoWnHB5zZ1lItVJQWi9g5iwpjyUrLCbzB45atg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19 019/195] tcp: clear tp->delivered in tcp_disconnect()
Date:   Mon, 10 Feb 2020 04:31:17 -0800
Message-Id: <20200210122307.623320776@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 2fbdd56251b5c62f96589f39eded277260de7267 ]

tp->delivered needs to be cleared in tcp_disconnect().

tcp_disconnect() is rarely used, but it is worth fixing it.

Fixes: ddf1af6fa00e ("tcp: new delivery accounting")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2588,6 +2588,7 @@ int tcp_disconnect(struct sock *sk, int
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	tp->snd_cwnd_cnt = 0;
 	tp->window_clamp = 0;
+	tp->delivered = 0;
 	tp->delivered_ce = 0;
 	tcp_set_ca_state(sk, TCP_CA_Open);
 	tp->is_sack_reneg = 0;


