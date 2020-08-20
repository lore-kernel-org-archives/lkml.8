Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF50C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55B92067C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918710;
	bh=QG+9dxGsIKi3If5pONGdBxr2CB5gnvr30BE7fpx6EuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S9ek1hAeMh3y/ONgbeW5Uz1fm9wVdUWpp5bjHESI6nFRcb7BnmgoB9cE4HlYEJ8Dn
	 +xCbW3waXQ7sTis39Vloi5sfNz994NYiiNGCpWeN26RweJy+WWrPASfN0eooJ78YiS
	 oi5dfaNmgo/AbrI/cKdWLJL/FPAXimzjmLs/UFJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHTKS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731021AbgHTKR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:17:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD24E208E4;
        Thu, 20 Aug 2020 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918645;
        bh=QG+9dxGsIKi3If5pONGdBxr2CB5gnvr30BE7fpx6EuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rSoGie0pqKm+gx3YR8jRgMWto/pHDD60bwOYq875wPS/ybMYox+M4YDPKxWvfa1Tz
         Oy7PoiRgO/9yof1HlWnuggb788l82eSaZ4VzEQRiCcLbMdYc+forcDcMggkaPbBcYK
         N5eaXa3FRmQTo/TcM0hIeDA7QWlBkTyUgvF35rOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6db548b615e5aeefdce2@syzkaller.appspotmail.com,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 016/149] net/x25: Fix null-ptr-deref in x25_disconnect
Date:   Thu, 20 Aug 2020 11:21:33 +0200
Message-Id: <20200820092126.483903460@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

commit 8999dc89497ab1c80d0718828e838c7cd5f6bffe upstream.

We should check null before do x25_neigh_put in x25_disconnect,
otherwise may cause null-ptr-deref like this:

 #include <sys/socket.h>
 #include <linux/x25.h>

 int main() {
    int sck_x25;
    sck_x25 = socket(AF_X25, SOCK_SEQPACKET, 0);
    close(sck_x25);
    return 0;
 }

BUG: kernel NULL pointer dereference, address: 00000000000000d8
CPU: 0 PID: 4817 Comm: t2 Not tainted 5.7.0-rc3+ #159
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.3-
RIP: 0010:x25_disconnect+0x91/0xe0
Call Trace:
 x25_release+0x18a/0x1b0
 __sock_release+0x3d/0xc0
 sock_close+0x13/0x20
 __fput+0x107/0x270
 ____fput+0x9/0x10
 task_work_run+0x6d/0xb0
 exit_to_usermode_loop+0x102/0x110
 do_syscall_64+0x23c/0x260
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Reported-by: syzbot+6db548b615e5aeefdce2@syzkaller.appspotmail.com
Fixes: 4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when x25 disconnect")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/x25/x25_subr.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/net/x25/x25_subr.c
+++ b/net/x25/x25_subr.c
@@ -368,10 +368,12 @@ void x25_disconnect(struct sock *sk, int
 		sk->sk_state_change(sk);
 		sock_set_flag(sk, SOCK_DEAD);
 	}
-	read_lock_bh(&x25_list_lock);
-	x25_neigh_put(x25->neighbour);
-	x25->neighbour = NULL;
-	read_unlock_bh(&x25_list_lock);
+	if (x25->neighbour) {
+		read_lock_bh(&x25_list_lock);
+		x25_neigh_put(x25->neighbour);
+		x25->neighbour = NULL;
+		read_unlock_bh(&x25_list_lock);
+	}
 }
 
 /*


