Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5570AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8A520855
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597917424;
	bh=pZOtxjNjinvQ+Xpqra3fbMQc09FWVo9+DFkPcY/6nzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Afmoih2Slc55VNUy6f858qlOJlXUDVEFEs9pivK9f4LkfG0+FAoU8GOGf3AxxSp6h
	 58xRgesn2/lOK8TqL/01rrfuEoiS2eld4uEQ7WaS8q/Gqe0ri6lvgiTm76rrOy/g40
	 ipQ211JRx2TwTl5MFSJL7ti3JKmSh4LEAyqkzqN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgHTJ5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730165AbgHTJ47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:56:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D816208DB;
        Thu, 20 Aug 2020 09:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917419;
        bh=pZOtxjNjinvQ+Xpqra3fbMQc09FWVo9+DFkPcY/6nzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yDEsje+OcETQV+t9q/IMPUJV9K+nMwKgPu2VZ7Y3Rrq7yLN21rxH+B8gMFTf/hCba
         N78swdHB3SxFOt6Kr4JlZzsBJOyLG5xfxoHBIEZapukjtFDT80SUw4fzDzoO7VYwXU
         Jjd4azTXDVHdUIPLOsu8Gaj5lgY6tI1hhC/9x0kA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 024/212] net/x25: Fix x25_neigh refcnt leak when x25 disconnect
Date:   Thu, 20 Aug 2020 11:19:57 +0200
Message-Id: <20200820091603.560996853@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

commit 4becb7ee5b3d2829ed7b9261a245a77d5b7de902 upstream.

x25_connect() invokes x25_get_neigh(), which returns a reference of the
specified x25_neigh object to "x25->neighbour" with increased refcnt.

When x25 connect success and returns, the reference still be hold by
"x25->neighbour", so the refcount should be decreased in
x25_disconnect() to keep refcount balanced.

The reference counting issue happens in x25_disconnect(), which forgets
to decrease the refcnt increased by x25_get_neigh() in x25_connect(),
causing a refcnt leak.

Fix this issue by calling x25_neigh_put() before x25_disconnect()
returns.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/x25/x25_subr.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/x25/x25_subr.c
+++ b/net/x25/x25_subr.c
@@ -368,6 +368,10 @@ void x25_disconnect(struct sock *sk, int
 		sk->sk_state_change(sk);
 		sock_set_flag(sk, SOCK_DEAD);
 	}
+	read_lock_bh(&x25_list_lock);
+	x25_neigh_put(x25->neighbour);
+	x25->neighbour = NULL;
+	read_unlock_bh(&x25_list_lock);
 }
 
 /*


