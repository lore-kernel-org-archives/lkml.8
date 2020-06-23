Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45213C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198C62078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948566;
	bh=MUfnL6/sr/TawQi32RX12iNttQvk7p08cXinlCl/o7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ckvHDuw/Kk6tMIO0h+y3ja5G7evcifa8dHiAmM+9HfUacmdT6dUHeOlh+UDmlW5IU
	 7ZVvokyoi582J/8aPh/GsQHoDJUqG/IMMYNo+IahPzJouZ6gR2aR9/VHd+ZbOeLRfU
	 0UYqkzedZjXAP823X2zwvBb9bkjMUpNPZ3dhOaAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbgFWVmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388233AbgFWUEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:04:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C81F206C3;
        Tue, 23 Jun 2020 20:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942675;
        bh=MUfnL6/sr/TawQi32RX12iNttQvk7p08cXinlCl/o7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yvFOFXPxKFLDj4ka0CJ0pdYOjLUSxv1xN2ldFdi5523pdyaUpgNuKCe0swe/DGFir
         5ZZJOrI/0+yDnJMdM2QsP4i+cGxQuNuHQkBtxn9iSlPdHl6sdg5ipk8KSE36RIJ/k4
         V80ZEFsmSt6ONplVr66DWDXwNDcWjsrgcecAabmE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wang Hai <wanghai38@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 091/477] yam: fix possible memory leak in yam_init_driver
Date:   Tue, 23 Jun 2020 21:51:28 +0200
Message-Id: <20200623195411.908988598@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
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



