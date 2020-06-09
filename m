Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26206C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA4220774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725116;
	bh=3VhzeYCfyFo9o7fz5Vi6e9lrLzkvJTjzxHdMTZtg2QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ofPmGOGirTfQzUTWtzwkmCF1RkgrDPYrurKIYgm/Z+fTtlAqevYlMfp8X/n4AWq/i
	 vPXKfP9+0D5pvVbFch9kYnbdgNtJVjFedXwPCCVsoAwEWNiBnLQSpNW/jEbxqd2EKU
	 Dzd7VUWFBtZlAZ/mjMYTYv9utQrywtLwqWsYe45o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732882AbgFIRvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732735AbgFIRuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:50:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66BF420734;
        Tue,  9 Jun 2020 17:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725049;
        bh=3VhzeYCfyFo9o7fz5Vi6e9lrLzkvJTjzxHdMTZtg2QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uN0MLnAtoDBsoD0V/BXzPYkRNAWgtWzGt4B0u9ZvP1aw22LLOuerHUu+/sVXxaPFO
         l2nJcF7aSjPiyieIYqxZefQy+Rw/YtXBEzSbHo0+30AaObP8woV1ydOz/x2U/ici//
         nKjCdc/6rRz3FKfnR1Rhrsh4d2GPJ5kJ0mvXZqRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 23/46] devinet: fix memleak in inetdev_init()
Date:   Tue,  9 Jun 2020 19:44:39 +0200
Message-Id: <20200609174026.336557949@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174022.938987501@linuxfoundation.org>
References: <20200609174022.938987501@linuxfoundation.org>
User-Agent: quilt/0.66
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
@@ -262,6 +262,7 @@ static struct in_device *inetdev_init(st
 	err = devinet_sysctl_register(in_dev);
 	if (err) {
 		in_dev->dead = 1;
+		neigh_parms_release(&arp_tbl, in_dev->arp_parms);
 		in_dev_put(in_dev);
 		in_dev = NULL;
 		goto out;


