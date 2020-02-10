Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0314C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803F12070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341845;
	bh=J4gWkJ7fJgBSOB9ORdcuuB4prfh5UOX/fdoUfJkTYkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=naY88uiFtfxMIL2DA0vPyt0sdq60JbgxHH8bUg5QJhTVaIlPP15QR1G0sNu/oyrMg
	 imVPCod6aXWKUIRHSlo6HV0mdziOGrM/vaLjH6yi2qcW4Hx1x3MD7DHdz+jX9LlDyq
	 MP6c8ltVwcAZEefNF5o9LCHsd2fCg2pP2+nNddv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgBJNhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgBJMfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:03 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 037B6215A4;
        Mon, 10 Feb 2020 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338103;
        bh=J4gWkJ7fJgBSOB9ORdcuuB4prfh5UOX/fdoUfJkTYkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJ0wYJcK/PfqN4hJwMQI/4iF11W6c+S6VvxLnDDsinjPpT0Ayn3aj8blqC+3/p0cM
         QnMgpCNb8FHGIg0y2ovs5M0UlwiFiMLMAtR8oaKmpE7v1QuO8J0tPTsak3e3PwKzYl
         u65/vI2TqMeIh+ox5Yucsfa0UE8yBU8LnMNwF2dU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19 021/195] tcp: clear tp->segs_{in|out} in tcp_disconnect()
Date:   Mon, 10 Feb 2020 04:31:19 -0800
Message-Id: <20200210122307.938284811@linuxfoundation.org>
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

[ Upstream commit 784f8344de750a41344f4bbbebb8507a730fc99c ]

tp->segs_in and tp->segs_out need to be cleared in tcp_disconnect().

tcp_disconnect() is rarely used, but it is worth fixing it.

Fixes: 2efd055c53c0 ("tcp: add tcpi_segs_in and tcpi_segs_out to tcp_info")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2605,6 +2605,8 @@ int tcp_disconnect(struct sock *sk, int
 	sk->sk_rx_dst = NULL;
 	tcp_saved_syn_free(tp);
 	tp->compressed_ack = 0;
+	tp->segs_in = 0;
+	tp->segs_out = 0;
 	tp->bytes_sent = 0;
 	tp->bytes_acked = 0;
 	tp->bytes_received = 0;


