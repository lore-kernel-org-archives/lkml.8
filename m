Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC896C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABFA920738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947144;
	bh=MUfnL6/sr/TawQi32RX12iNttQvk7p08cXinlCl/o7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ym2ZS/IFIPZDzcp9SMZv/Hmeu80Y2moO+tQgcPuvjzA4N9RdSGMgRvQh5kNoTlb25
	 t0NOwLhYJJ1ElL+w+dfG993w4wvQBV2zs8PuPi7LQzZ/Jaa4z5+KmNgU5R+60FrOed
	 k+KU3A6Bc8fUyxPEqS8/FGnz7XIxJ2qOaYxcVOvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389561AbgFWUZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390497AbgFWUZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:25:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5130420723;
        Tue, 23 Jun 2020 20:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943914;
        bh=MUfnL6/sr/TawQi32RX12iNttQvk7p08cXinlCl/o7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jGy5CcPpXff94/pLIjQJACmv7XCSwMg5Gc6aVVTzXboi+jnD8swfv1T0JKFHHTVnn
         UvHlrc9jysqwBChXw/TmrbVNXluzv4HNXy1sbdrKk5wdoezLdbnvnyuoPDTgXAFyFj
         ibs5mw8t6/azpQ7QLupt9qqEMebtN8+YpOk42VTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wang Hai <wanghai38@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 070/314] yam: fix possible memory leak in yam_init_driver
Date:   Tue, 23 Jun 2020 21:54:25 +0200
Message-Id: <20200623195342.181990267@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

[ Upstream commit 98749b7188affbf2900c2aab704a8853901d1139 ]

If register_netdev(dev) fails, free_netdev(dev) needs
to be called, otherwise a memory leak will occur.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hamradio/yam.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/hamradio/yam.c b/drivers/net/hamradio/yam.c
index 71cdef9fb56bc..5ab53e9942f30 100644
--- a/drivers/net/hamradio/yam.c
+++ b/drivers/net/hamradio/yam.c
@@ -1133,6 +1133,7 @@ static int __init yam_init_driver(void)
 		err = register_netdev(dev);
 		if (err) {
 			printk(KERN_WARNING "yam: cannot register net device %s\n", dev->name);
+			free_netdev(dev);
 			goto error;
 		}
 		yam_devs[i] = dev;
-- 
2.25.1



