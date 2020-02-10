Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8046BC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDAA20842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341860;
	bh=QBJKuD6NoRo2RqXBcUV+KHBPUQ/3R+OAVYKH+qXQslg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hMc7GbF7MbT+9VXweI0AGZo7QbtTaJFWcAAoHYYaFx0rCv2q7C8O1acCyUhuvkmQT
	 E1gBfN2LB6boDVdprU7sT6noLsFRYTowY9OKxjBT2vMu8IfbPF9vNjnlKUOZNbw0q3
	 BW5h3TWldBM9vvIuL7KfnxogPvsiSLrWuXDaEsJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgBJNhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:37:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbgBJMfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:01 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05D7A2173E;
        Mon, 10 Feb 2020 12:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338101;
        bh=QBJKuD6NoRo2RqXBcUV+KHBPUQ/3R+OAVYKH+qXQslg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sF3cPayrPlG2ge1jFfziqurdN+LjvzfEA3ZYRe2eSyTwci7AXJR0GnFzI1lVij7cZ
         NkSB0Gs2/KuGcsBED04Jppbel0JQ8sccEmpGajGTB4iVGpe0CUgSjUWs6HCakuhuvM
         zb4SEDZ1SnmYXETMYofhbCY3755gsDD2y9Nfu84Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        SeongJae Park <sjpark@amazon.de>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19 018/195] tcp: clear tp->total_retrans in tcp_disconnect()
Date:   Mon, 10 Feb 2020 04:31:16 -0800
Message-Id: <20200210122307.533336169@linuxfoundation.org>
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

[ Upstream commit c13c48c00a6bc1febc73902505bdec0967bd7095 ]

total_retrans needs to be cleared in tcp_disconnect().

tcp_disconnect() is rarely used, but it is worth fixing it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2592,6 +2592,7 @@ int tcp_disconnect(struct sock *sk, int
 	tcp_set_ca_state(sk, TCP_CA_Open);
 	tp->is_sack_reneg = 0;
 	tcp_clear_retrans(tp);
+	tp->total_retrans = 0;
 	inet_csk_delack_init(sk);
 	/* Initialize rcv_mss to TCP_MIN_MSS to avoid division by 0
 	 * issue in __tcp_select_window()


