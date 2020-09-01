Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8740AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57CF320FC3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598973934;
	bh=UOtZjuljHBr0vFhBKp/fHjfYQa6YVxhQd7vR8X2cHLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SB09Wsnop+i7ARa6E6S91ExM8iEbmz5mC5ZEwzQ5ZfBM8Ep4E0krwQn6advClwGWy
	 +B8X5LSxZ6UnfqlGegE8/WWfJvHWoNJvpQaqrmERE+RcOMFKYwR6IhxCd4sqD/SFsG
	 vHKKyoA6sgElFZqsVupiUaMiXoJ7DkONfjpDExEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgIAPZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgIAPWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:22:31 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A992078B;
        Tue,  1 Sep 2020 15:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973750;
        bh=UOtZjuljHBr0vFhBKp/fHjfYQa6YVxhQd7vR8X2cHLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5O6/sutUqbaF+7opLPlvYMhzlFKSkzHoxddjzx2NCyAhYWJjx/+bozc0qI70Khls
         9d6iBx4OMil+aJgPQaYtl+1R9LdLTNzVHTDNKimfYj8TwNxuIs/HioKfmC35RWw2kc
         Bp0KRt6oLUlHhLuVhvfPwa8D/5mDHdY0oq41KdjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>,
        Richard Alpe <richard.alpe@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+0e7181deafa7e0b79923@syzkaller.appspotmail.com
Subject: [PATCH 4.19 006/125] tipc: fix uninit skb->data in tipc_nl_compat_dumpit()
Date:   Tue,  1 Sep 2020 17:09:21 +0200
Message-Id: <20200901150934.898610362@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
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


