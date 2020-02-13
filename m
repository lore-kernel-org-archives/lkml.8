Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDBEC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2F724690
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607351;
	bh=iKkF4Zgp5sijlwm9Zs8L9gBFzpXfEG5kjg4D6f2fOpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xVWXCcoGvjomJAkFgthbExig3F/U7LnNjpr3Aj7s6Lg/eMlv99OrKGilmQrRkbk2J
	 BdDTm4PDVxK1SAjh0xDYTfC2Qds91LifMdGCUS8TBMqoBjzYaLvmTC6Bq+6ziqfyVA
	 tc8DR65iGiCsR/GX4XqLWzqKqp1hihTtL1jxrJ4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgBMPWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:22:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbgBMPW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:28 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46DD246C0;
        Thu, 13 Feb 2020 15:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607347;
        bh=iKkF4Zgp5sijlwm9Zs8L9gBFzpXfEG5kjg4D6f2fOpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itzSjE4L2L8Z3pC80UQO3nSKQdXNKirAHrTY856mCDrEebVQpno45O8xVkbYx23we
         EMW5bTMOKJcUeEsWE4efB6yYIFMUmHsP2F6Gm/r77q5EYDUgv8u/JzXDjNRLqAhIJ4
         h6abm3fjyEljS9XpmldGwpcVBAD36ArYQqIgLFQ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        SeongJae Park <sjpark@amazon.de>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.4 08/91] tcp: clear tp->total_retrans in tcp_disconnect()
Date:   Thu, 13 Feb 2020 07:19:25 -0800
Message-Id: <20200213151824.663369407@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
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
@@ -2261,6 +2261,7 @@ int tcp_disconnect(struct sock *sk, int
 	tp->window_clamp = 0;
 	tcp_set_ca_state(sk, TCP_CA_Open);
 	tcp_clear_retrans(tp);
+	tp->total_retrans = 0;
 	inet_csk_delack_init(sk);
 	/* Initialize rcv_mss to TCP_MIN_MSS to avoid division by 0
 	 * issue in __tcp_select_window()


