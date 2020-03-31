Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880BEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BB720B80
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645300;
	bh=/2QCD0+YgDM7AxEBlkjagHGL94R+lRcfpdpM227IqLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eQmszP54tPSNF8ZP8ALzoPoF+1DcCEn5q+U3NUE857ThroJB+v8uQ/xdrM0vD8P+4
	 yg4IP2OxXrxx4da0ceWQjR/xtb3suMGx2NhAPpFrAjexnbyqeFx/21NE6+oNjq3Bdp
	 pW+EYBnJSTQvH2oE51XHic+aukKx18jKFj1WA3T0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbgCaJBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730294AbgCaJBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:01:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 397A820848;
        Tue, 31 Mar 2020 09:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645295;
        bh=/2QCD0+YgDM7AxEBlkjagHGL94R+lRcfpdpM227IqLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IpFm+mTQTvkhDiSpQbqWsRLMLr41fdSBNsoCzxU85dNp2BTDgvZIbG+T4GYA7PRAN
         omrlgqBZPFTYsn+7N/DY5kyAxQtWnrOZHY/i1wiD7pp5w6/nEOKvM1qOL5XIjuxesl
         qROTF27haODC+xIQ9bei8JdfZL/Sml6Qz7F6rYXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+68a8ed58e3d17c700de5@syzkaller.appspotmail.com
Subject: [PATCH 5.5 010/170] geneve: move debug check after netdev unregister
Date:   Tue, 31 Mar 2020 10:57:04 +0200
Message-Id: <20200331085425.244338540@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
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
@@ -1845,8 +1845,6 @@ static void geneve_destroy_tunnels(struc
 		if (!net_eq(dev_net(geneve->dev), net))
 			unregister_netdevice_queue(geneve->dev, head);
 	}
-
-	WARN_ON_ONCE(!list_empty(&gn->sock_list));
 }
 
 static void __net_exit geneve_exit_batch_net(struct list_head *net_list)
@@ -1861,6 +1859,12 @@ static void __net_exit geneve_exit_batch
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


