Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D728C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00735206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fp14o64Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgERLr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgERLrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:47:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944BCC061A0C;
        Mon, 18 May 2020 04:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ztGaRGjmnfTDhAKwb1uAT+sXQk1EV/hKojrYxDtc3CE=; b=Fp14o64Z/CJWKLmMlRtEC3HPc9
        T77pwgekM0h9mdHlFmziuIfO9LP+RsgT+EPPPO1VhagZIUfFuaBYsei7fsLcgZhag39354IxAQziD
        JDV12RNE4MB0Tur/wheuBhEV/j5o/QyK6tdN99YaLu/VtDBf25u9Qwlg2DVRzYZk+dozaIHPx7vhO
        jWsxBLoTzfMpwHlZBKqRV2eN7IiUZxg6UuB/T6TJmaaS/hBoHiSAiduGZcj7fM9J/uL43WIhPEXT5
        qGBv+BCveSAKhjZeB4jeVsunjjKud7r3hhUvgSpVxu25TvIvvZkPZ++rOpfA9opC+cMRkfMct1Flk
        9iguvSPA==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaeEm-0004P2-6i; Mon, 18 May 2020 11:47:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] ipv6: stub out even more of addrconf_set_dstaddr if SIT is disabled
Date:   Mon, 18 May 2020 13:46:53 +0200
Message-Id: <20200518114655.987760-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518114655.987760-1-hch@lst.de>
References: <20200518114655.987760-1-hch@lst.de>
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

