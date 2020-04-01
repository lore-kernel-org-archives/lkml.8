Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16907C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2FC212CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758286;
	bh=uCCBnvAmoM6CXoiE31srDPDYHRKuIFtQnwp9kkaKSDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Md3GICXmZlrKfHn1ii4Xkg0YTdNyMkaUfqP+NIuXMv2oI0kSPihTPSve+bszVCnOL
	 Acai/WJEBbwu+HsXeUZEvVDVi/XkkO6CL9An5JEeyE4HEAQovERauliZNU+5JKkGGt
	 TcQW9O2VZVpITsllU0tT73mTuPmXFv/e+dClF28I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbgDAQYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:24:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387726AbgDAQYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:24:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B840D20857;
        Wed,  1 Apr 2020 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758283;
        bh=uCCBnvAmoM6CXoiE31srDPDYHRKuIFtQnwp9kkaKSDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tAv+9D7Mo8IQ+mzQhX8mGBVJmvH6m0xdEtsWDRU0PgEfiA9u1DgHfX2ao9tkk58Xw
         6tGYc5VHsgP2+xzCWR7cpiTVCa5f5U4CMt1hOSpFkDrTQp6i8QjILmjN0B6PrDjSP4
         B508Klt90PwUC+VGo5YIFOvsmvvSpGM7dP33UafQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+68a8ed58e3d17c700de5@syzkaller.appspotmail.com
Subject: [PATCH 4.19 007/116] geneve: move debug check after netdev unregister
Date:   Wed,  1 Apr 2020 18:16:23 +0200
Message-Id: <20200401161543.245711159@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 0fda7600c2e174fe27e9cf02e78e345226e441fa ]

The debug check must be done after unregister_netdevice_many() call --
the list_del() for this is done inside .ndo_stop.

Fixes: 2843a25348f8 ("geneve: speedup geneve tunnels dismantle")
Reported-and-tested-by: <syzbot+68a8ed58e3d17c700de5@syzkaller.appspotmail.com>
Cc: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/geneve.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1725,8 +1725,6 @@ static void geneve_destroy_tunnels(struc
 		if (!net_eq(dev_net(geneve->dev), net))
 			unregister_netdevice_queue(geneve->dev, head);
 	}
-
-	WARN_ON_ONCE(!list_empty(&gn->sock_list));
 }
 
 static void __net_exit geneve_exit_batch_net(struct list_head *net_list)
@@ -1741,6 +1739,12 @@ static void __net_exit geneve_exit_batch
 	/* unregister the devices gathered above */
 	unregister_netdevice_many(&list);
 	rtnl_unlock();
+
+	list_for_each_entry(net, net_list, exit_list) {
+		const struct geneve_net *gn = net_generic(net, geneve_net_id);
+
+		WARN_ON_ONCE(!list_empty(&gn->sock_list));
+	}
 }
 
 static struct pernet_operations geneve_net_ops = {


