Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB6FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C57207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596097270;
	bh=PWOXS3zO0M0ruj0VjGy3cwmNjPBT6MXLJjYCnw74PFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PjAr7ghgebI5Y38nT1kkVX8F1EHabkVpj1+p9mdNQT6qfcFz7VuMlbgxn1dSn1F3P
	 KVE98Vu7m3cd9XFIai85q2s0BM3l6tLJ9cLetX966MWDyjbpAyDC9Rnu9/Cy//1YKi
	 y8oJ1Be7R9K2mRIySjvn7qx0DCibWM3VGJqIzOvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgG3IVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbgG3IFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:05:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D8DE20656;
        Thu, 30 Jul 2020 08:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096319;
        bh=PWOXS3zO0M0ruj0VjGy3cwmNjPBT6MXLJjYCnw74PFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+z2/DbNFZr09OzYhEB3RmL88seEInwIeIiUiS+Lj2NpkSKbNc10H2wbaVf5Nlubv
         F7srPfxNoFcqj6QwHuej7c05EHedS65QjsIuLqhjLvqz3DmLNNQ4mok9GoZWSPO+zD
         MM9Xpa/f6iyUOG5OkL1eSD+IcpH/Htxli4wxrIqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 05/20] ip6_gre: fix null-ptr-deref in ip6gre_init_net()
Date:   Thu, 30 Jul 2020 10:03:55 +0200
Message-Id: <20200730074420.797915804@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.533211699@linuxfoundation.org>
References: <20200730074420.533211699@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 46ef5b89ec0ecf290d74c4aee844f063933c4da4 ]

KASAN report null-ptr-deref error when register_netdev() failed:

KASAN: null-ptr-deref in range [0x00000000000003c0-0x00000000000003c7]
CPU: 2 PID: 422 Comm: ip Not tainted 5.8.0-rc4+ #12
Call Trace:
 ip6gre_init_net+0x4ab/0x580
 ? ip6gre_tunnel_uninit+0x3f0/0x3f0
 ops_init+0xa8/0x3c0
 setup_net+0x2de/0x7e0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? ops_init+0x3c0/0x3c0
 ? kasan_unpoison_shadow+0x33/0x40
 ? __kasan_kmalloc.constprop.0+0xc2/0xd0
 copy_net_ns+0x27d/0x530
 create_new_namespaces+0x382/0xa30
 unshare_nsproxy_namespaces+0xa1/0x1d0
 ksys_unshare+0x39c/0x780
 ? walk_process_tree+0x2a0/0x2a0
 ? trace_hardirqs_on+0x4a/0x1b0
 ? _raw_spin_unlock_irq+0x1f/0x30
 ? syscall_trace_enter+0x1a7/0x330
 ? do_syscall_64+0x1c/0xa0
 __x64_sys_unshare+0x2d/0x40
 do_syscall_64+0x56/0xa0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

ip6gre_tunnel_uninit() has set 'ign->fb_tunnel_dev' to NULL, later
access to ign->fb_tunnel_dev cause null-ptr-deref. Fix it by saving
'ign->fb_tunnel_dev' to local variable ndev.

Fixes: dafabb6590cb ("ip6_gre: fix use-after-free in ip6gre_tunnel_lookup()")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1562,17 +1562,18 @@ static void ip6gre_destroy_tunnels(struc
 static int __net_init ip6gre_init_net(struct net *net)
 {
 	struct ip6gre_net *ign = net_generic(net, ip6gre_net_id);
+	struct net_device *ndev;
 	int err;
 
 	if (!net_has_fallback_tunnels(net))
 		return 0;
-	ign->fb_tunnel_dev = alloc_netdev(sizeof(struct ip6_tnl), "ip6gre0",
-					  NET_NAME_UNKNOWN,
-					  ip6gre_tunnel_setup);
-	if (!ign->fb_tunnel_dev) {
+	ndev = alloc_netdev(sizeof(struct ip6_tnl), "ip6gre0",
+			    NET_NAME_UNKNOWN, ip6gre_tunnel_setup);
+	if (!ndev) {
 		err = -ENOMEM;
 		goto err_alloc_dev;
 	}
+	ign->fb_tunnel_dev = ndev;
 	dev_net_set(ign->fb_tunnel_dev, net);
 	/* FB netdevice is special: we have one, and only one per netns.
 	 * Allowing to move it to another netns is clearly unsafe.
@@ -1592,7 +1593,7 @@ static int __net_init ip6gre_init_net(st
 	return 0;
 
 err_reg_dev:
-	free_netdev(ign->fb_tunnel_dev);
+	free_netdev(ndev);
 err_alloc_dev:
 	return err;
 }


