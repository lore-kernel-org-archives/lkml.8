Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5304C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8297120767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978588;
	bh=UOtZjuljHBr0vFhBKp/fHjfYQa6YVxhQd7vR8X2cHLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W/0LifU3UJnIcmKe5520RnFuGcGFpOSYZTfNbsy62qt2JXCYXFr9YA48kOSSj7DoV
	 hCoimO/0BxxRvUczFf/syMhzZ3y/ZFkB1jRa5HoBMiSI3VLHQ3w7zNCm1Rpon6M6SR
	 Wh0vR2yel2tK3qg3Ivog+j2AY1vNv9Ocwv++Ka2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbgIAQnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbgIAP1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:27:51 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377682176B;
        Tue,  1 Sep 2020 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974070;
        bh=UOtZjuljHBr0vFhBKp/fHjfYQa6YVxhQd7vR8X2cHLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Cg4jl0XKt3yeQNtNcDJWav+Cu8Q6r4LzPbjTun4s24u9/xl791i0Uu67HW9Btl7Q
         8/gwzTUWKBCnKW34gRisWVTQRF0Q5ZQe/l8D1wb9iyl3hElJSPKLT3bDJ+gF7FEmO1
         ELQSGecS8QGfg3GdO4UMtDnN3aU7X1NSlhJcT8to=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>,
        Richard Alpe <richard.alpe@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+0e7181deafa7e0b79923@syzkaller.appspotmail.com
Subject: [PATCH 5.4 009/214] tipc: fix uninit skb->data in tipc_nl_compat_dumpit()
Date:   Tue,  1 Sep 2020 17:08:09 +0200
Message-Id: <20200901150953.407062619@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 47733f9daf4fe4f7e0eb9e273f21ad3a19130487 ]

__tipc_nl_compat_dumpit() has two callers, and it expects them to
pass a valid nlmsghdr via arg->data. This header is artificial and
crafted just for __tipc_nl_compat_dumpit().

tipc_nl_compat_publ_dump() does so by putting a genlmsghdr as well
as some nested attribute, TIPC_NLA_SOCK. But the other caller
tipc_nl_compat_dumpit() does not, this leaves arg->data uninitialized
on this call path.

Fix this by just adding a similar nlmsghdr without any payload in
tipc_nl_compat_dumpit().

This bug exists since day 1, but the recent commit 6ea67769ff33
("net: tipc: prepare attrs in __tipc_nl_compat_dumpit()") makes it
easier to appear.

Reported-and-tested-by: syzbot+0e7181deafa7e0b79923@syzkaller.appspotmail.com
Fixes: d0796d1ef63d ("tipc: convert legacy nl bearer dump to nl compat")
Cc: Jon Maloy <jmaloy@redhat.com>
Cc: Ying Xue <ying.xue@windriver.com>
Cc: Richard Alpe <richard.alpe@ericsson.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/netlink_compat.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -255,8 +255,9 @@ err_out:
 static int tipc_nl_compat_dumpit(struct tipc_nl_compat_cmd_dump *cmd,
 				 struct tipc_nl_compat_msg *msg)
 {
-	int err;
+	struct nlmsghdr *nlh;
 	struct sk_buff *arg;
+	int err;
 
 	if (msg->req_type && (!msg->req_size ||
 			      !TLV_CHECK_TYPE(msg->req, msg->req_type)))
@@ -285,6 +286,15 @@ static int tipc_nl_compat_dumpit(struct
 		return -ENOMEM;
 	}
 
+	nlh = nlmsg_put(arg, 0, 0, tipc_genl_family.id, 0, NLM_F_MULTI);
+	if (!nlh) {
+		kfree_skb(arg);
+		kfree_skb(msg->rep);
+		msg->rep = NULL;
+		return -EMSGSIZE;
+	}
+	nlmsg_end(arg, nlh);
+
 	err = __tipc_nl_compat_dumpit(cmd, msg, arg);
 	if (err) {
 		kfree_skb(msg->rep);


