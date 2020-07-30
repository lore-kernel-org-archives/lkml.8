Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D6822074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596097228;
	bh=LKGNT2qVhcOAafZ2dGb9zKN9EZp306o8SFySeGT4rD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XCSun35nlSSqr3UcoLNSdH7wAz7Q/AClLbfHmutH8ghpzmxijg2XHFTBCX6wHZMd3
	 WN+XVBp+mRG1MRzJTtOhS9MUE07VCmf+gjHYUprpmpymH4KBG0NRY2xK/V26NF9BpK
	 K0ILZZVdXRP8iK689nGq6zS05/7MyoUvjIJXYEWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgG3IU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgG3IGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:06:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 500CE206C0;
        Thu, 30 Jul 2020 08:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096364;
        bh=LKGNT2qVhcOAafZ2dGb9zKN9EZp306o8SFySeGT4rD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2vIrl6dUKVd1ONs/F+uJVCw62+FKtsZPxjLeAwMD0TLBjUDhUQ5JBROt/E8JI4xs
         JcnLkJXdkLuFGZo7BhS6OCYxKRfWDz4F9F8sQecgPUXgYa9TeUxaYslqsx4WGAbru8
         H7xyarOYGvxjuML5fgbqyF3RBEkXvRnhxxcPTZY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+6720d64f31c081c2f708@syzkaller.appspotmail.com
Subject: [PATCH 5.4 08/19] qrtr: orphan socket in qrtr_release()
Date:   Thu, 30 Jul 2020 10:04:10 +0200
Message-Id: <20200730074420.924420214@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.502923740@linuxfoundation.org>
References: <20200730074420.502923740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit af9f691f0f5bdd1ade65a7b84927639882d7c3e5 ]

We have to detach sock from socket in qrtr_release(),
otherwise skb->sk may still reference to this socket
when the skb is released in tun->queue, particularly
sk->sk_wq still points to &sock->wq, which leads to
a UAF.

Reported-and-tested-by: syzbot+6720d64f31c081c2f708@syzkaller.appspotmail.com
Fixes: 28fb4e59a47d ("net: qrtr: Expose tunneling endpoint to user space")
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/qrtr/qrtr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -1004,6 +1004,7 @@ static int qrtr_release(struct socket *s
 		sk->sk_state_change(sk);
 
 	sock_set_flag(sk, SOCK_DEAD);
+	sock_orphan(sk);
 	sock->sk = NULL;
 
 	if (!sock_flag(sk, SOCK_ZAPPED))


