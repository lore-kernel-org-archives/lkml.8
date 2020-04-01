Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2CEC2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FE8206F8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759079;
	bh=M1yKdC1PMPoCU3jcC9N0KAwktw1FvUgurSJb8673bKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a4GeoRihPj9W1erwGcAP1hmK16xG4bG2HSibzHnwgZNOhc+v1mXI9bqHKDjIhJz0Q
	 QbaIJlUaao1ETmS1E8A2P1tOmACkQvql+4PDEUtdEYnHlmih4+cXsdC57QVs2uFovJ
	 vM4HHqpyMun8yQhWgKf2DHNHc8OnNCKlOMI2VENs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389036AbgDAQh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389024AbgDAQhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:37:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44CC1206F8;
        Wed,  1 Apr 2020 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759071;
        bh=M1yKdC1PMPoCU3jcC9N0KAwktw1FvUgurSJb8673bKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VE/X+JoR24h2jeNcfy3z20lipGtIZdeyANf1zbmdhS6sdelG+a1cgnECPRg8hz2Cn
         PB38UDNA63mjpW3FxIkMYkg56VvmYv4bszBBj5L8vPMrX6wS2ZGqILCfWtMYVuZtGL
         4yX8jsEXHA7Bnjpay+sD8NjRaYIO/8dsd7mFmVdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.9 067/102] xfrm: add the missing verify_sec_ctx_len check in xfrm_add_acquire
Date:   Wed,  1 Apr 2020 18:18:10 +0200
Message-Id: <20200401161544.014427547@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

commit a1a7e3a36e01ca6e67014f8cf673cb8e47be5550 upstream.

Without doing verify_sec_ctx_len() check in xfrm_add_acquire(), it may be
out-of-bounds to access uctx->ctx_str with uctx->ctx_len, as noticed by
syz:

  BUG: KASAN: slab-out-of-bounds in selinux_xfrm_alloc_user+0x237/0x430
  Read of size 768 at addr ffff8880123be9b4 by task syz-executor.1/11650

  Call Trace:
   dump_stack+0xe8/0x16e
   print_address_description.cold.3+0x9/0x23b
   kasan_report.cold.4+0x64/0x95
   memcpy+0x1f/0x50
   selinux_xfrm_alloc_user+0x237/0x430
   security_xfrm_policy_alloc+0x5c/0xb0
   xfrm_policy_construct+0x2b1/0x650
   xfrm_add_acquire+0x21d/0xa10
   xfrm_user_rcv_msg+0x431/0x6f0
   netlink_rcv_skb+0x15a/0x410
   xfrm_netlink_rcv+0x6d/0x90
   netlink_unicast+0x50e/0x6a0
   netlink_sendmsg+0x8ae/0xd40
   sock_sendmsg+0x133/0x170
   ___sys_sendmsg+0x834/0x9a0
   __sys_sendmsg+0x100/0x1e0
   do_syscall_64+0xe5/0x660
   entry_SYSCALL_64_after_hwframe+0x6a/0xdf

So fix it by adding the missing verify_sec_ctx_len check there.

Fixes: 980ebd25794f ("[IPSEC]: Sync series - acquire insert")
Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_user.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2178,6 +2178,9 @@ static int xfrm_add_acquire(struct sk_bu
 	err = verify_newpolicy_info(&ua->policy);
 	if (err)
 		goto free_state;
+	err = verify_sec_ctx_len(attrs);
+	if (err)
+		goto free_state;
 
 	/*   build an XP */
 	xp = xfrm_policy_construct(net, &ua->policy, attrs, &err);


