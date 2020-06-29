Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F615C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4FE20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593458748;
	bh=igXIQ9KhOPwaPpl0b/JdivR6aj4//a+EAr8lZskRhz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BBpIGT5ZH0uuALsMdzNjh6KUltTjTQRZiWbmUBqXX43up9epDFXfk6UaodVJHhCf5
	 INgeXpsB3Gy0UEcdRWIhgukQb86aVlz53ZV1Q/rKsKSHxBXArqwgzemxE5bY1XWi3s
	 UyU0+nQvVPyiY4MAY94snIlxHd2p9Xqum63UYqQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbgF2TZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731759AbgF2TZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B0C42543C;
        Mon, 29 Jun 2020 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445389;
        bh=igXIQ9KhOPwaPpl0b/JdivR6aj4//a+EAr8lZskRhz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sWHVvkh9j89ol+aCa/e1cJ1b8tsWdelSfe8Ph0xOuQZdpSsBIeOlbnJnincHLN5rk
         EjSfLAciiokUgADnPQqOtHL+S6+w1gvpD/3ZjlsgDyII1Hu67TiSd6zwveWWJ1ojol
         WkbXcu1ElyiBmBH54Om5wKQEesEzrH+8cXwaGHOg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     guodeqing <geffrey.guo@huawei.com>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.9 143/191] net: Fix the arp error in some cases
Date:   Mon, 29 Jun 2020 11:39:19 -0400
Message-Id: <20200629154007.2495120-144-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: guodeqing <geffrey.guo@huawei.com>

[ Upstream commit 5eea3a63ff4aba6a26002e657a6d21934b7e2b96 ]

ie.,
$ ifconfig eth0 6.6.6.6 netmask 255.255.255.0

$ ip rule add from 6.6.6.6 table 6666

$ ip route add 9.9.9.9 via 6.6.6.6

$ ping -I 6.6.6.6 9.9.9.9
PING 9.9.9.9 (9.9.9.9) from 6.6.6.6 : 56(84) bytes of data.

3 packets transmitted, 0 received, 100% packet loss, time 2079ms

$ arp
Address     HWtype  HWaddress           Flags Mask            Iface
6.6.6.6             (incomplete)                              eth0

The arp request address is error, this is because fib_table_lookup in
fib_check_nh lookup the destnation 9.9.9.9 nexthop, the scope of
the fib result is RT_SCOPE_LINK,the correct scope is RT_SCOPE_HOST.
Here I add a check of whether this is RT_TABLE_MAIN to solve this problem.

Fixes: 3bfd847203c6 ("net: Use passed in table for nexthop lookups")
Signed-off-by: guodeqing <geffrey.guo@huawei.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/fib_semantics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 6aec95e1fc134..305104d116d62 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -776,7 +776,7 @@ static int fib_check_nh(struct fib_config *cfg, struct fib_info *fi,
 			if (fl4.flowi4_scope < RT_SCOPE_LINK)
 				fl4.flowi4_scope = RT_SCOPE_LINK;
 
-			if (cfg->fc_table)
+			if (cfg->fc_table && cfg->fc_table != RT_TABLE_MAIN)
 				tbl = fib_get_table(net, cfg->fc_table);
 
 			if (tbl)
-- 
2.25.1

