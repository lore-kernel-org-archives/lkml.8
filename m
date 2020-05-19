Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE68C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B527B20709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lwzn2rID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgESNEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgESNEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:04:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E753C08C5C3;
        Tue, 19 May 2020 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ztGaRGjmnfTDhAKwb1uAT+sXQk1EV/hKojrYxDtc3CE=; b=lwzn2rID1tguj1XlyFWT1MT166
        fhEPC3Df2l0Titlte6j/Yp9HUFvPFJ37gQ7nCxNrGGB7nSTnnb+6M7/AUA+6Cq+3TpEUCgx3f/qjq
        hMc3yDd9sWwkUUIPOvlfzHrnOThilQY9Dhod9/ICp21dVvvfWf07gE92Nk66OxzQA5AZAQSMFfQMo
        BccSDRqdVxnbX56gCPVnWTDal7WHvS4H677IiYfNlxDhBODeXcudfowAsBHuzdespgc6LX2YO1LgY
        hm5qjjHTpz06wvB7dVeWptep1VswcN6ZiVaBJvzKXjlY+eY750Lv9FEA1UqYKO+jvKAcQj1lD25Kb
        +gLsye4g==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb1uH-0004Ae-4w; Tue, 19 May 2020 13:03:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] ipv6: stub out even more of addrconf_set_dstaddr if SIT is disabled
Date:   Tue, 19 May 2020 15:03:17 +0200
Message-Id: <20200519130319.1464195-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519130319.1464195-1-hch@lst.de>
References: <20200519130319.1464195-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in copying the structure from userspace or looking up
a device if SIT support is not disabled and we'll eventually return
-ENODEV anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/ipv6/addrconf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ab7e839753aed..8300176f91e74 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2794,6 +2794,9 @@ int addrconf_set_dstaddr(struct net *net, void __user *arg)
 	struct net_device *dev;
 	int err = -EINVAL;
 
+	if (!IS_ENABLED(CONFIG_IPV6_SIT))
+		return -ENODEV;
+
 	rtnl_lock();
 
 	err = -EFAULT;
@@ -2806,7 +2809,6 @@ int addrconf_set_dstaddr(struct net *net, void __user *arg)
 	if (!dev)
 		goto err_exit;
 
-#if IS_ENABLED(CONFIG_IPV6_SIT)
 	if (dev->type == ARPHRD_SIT) {
 		const struct net_device_ops *ops = dev->netdev_ops;
 		struct ifreq ifr;
@@ -2842,7 +2844,6 @@ int addrconf_set_dstaddr(struct net *net, void __user *arg)
 			err = dev_open(dev, NULL);
 		}
 	}
-#endif
 
 err_exit:
 	rtnl_unlock();
-- 
2.26.2

