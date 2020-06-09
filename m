Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EA7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2043320774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725135;
	bh=0foFwzisUG185/MwUcmwS+UCvDzqnsQZStEes7pYQK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lmdxq6kbZJUy4cnBs+EFAvBqGTijWHDhIKeBAMcTyisBu6RclvigVxDVjRHKdX7xR
	 gWY6Y67tVudQouqlqyaUHQbN5odPDZHvro9YCaQ7CBGFZiybCDqn9ApTYSsIbgAJJk
	 atXxYVCc1McjAump4rDKp1Sls6mFI7Ny1areXmBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgFIRwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732772AbgFIRvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:51:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60E2820734;
        Tue,  9 Jun 2020 17:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725063;
        bh=0foFwzisUG185/MwUcmwS+UCvDzqnsQZStEes7pYQK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHOWwLffKorIKrufpZGfk2byM7sQIxWojfz3gGBacPiUNJAZSxxwhYaFfGmOKx+Wa
         8KQB9TXBN5pMI+lu0WyLRSO7EpcuVBd1uy1lHarUPjmTPxsuDXIiTOCsZuWomTOZKL
         vZ/owbcxd0XTbPtrEWfwNjH0qU2CMsWIo1AN8thE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 01/25] devinet: fix memleak in inetdev_init()
Date:   Tue,  9 Jun 2020 19:44:51 +0200
Message-Id: <20200609174048.722161626@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174048.576094775@linuxfoundation.org>
References: <20200609174048.576094775@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 1b49cd71b52403822731dc9f283185d1da355f97 ]

When devinet_sysctl_register() failed, the memory allocated
in neigh_parms_alloc() should be freed.

Fixes: 20e61da7ffcf ("ipv4: fail early when creating netdev named all or default")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/devinet.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -269,6 +269,7 @@ static struct in_device *inetdev_init(st
 	err = devinet_sysctl_register(in_dev);
 	if (err) {
 		in_dev->dead = 1;
+		neigh_parms_release(&arp_tbl, in_dev->arp_parms);
 		in_dev_put(in_dev);
 		in_dev = NULL;
 		goto out;


