Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04681C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3F72070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oIYuKmUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbgEVTCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 15:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbgEVTCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 15:02:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804F1C061A0E;
        Fri, 22 May 2020 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3WYApwMQHv/jK2wjKkDG3PzXHTttraCjB18s9qs0m9Q=; b=oIYuKmUbm7Iz4mLUIgxRg3v4+Y
        9+sgh7Vf4L1vzyqBwRTlR1wbayzhVg6R9cnCs/3GzWiZJQd/P1+JDdE9OVKyU0B+pKi4tPTXJoIrH
        zb/MdevVMWFu9zsAKEr0VWCkVdxJQDRbhJcfWYdVRdVXOmo8L6176IF0hDGq4Y3KEWH3CDYUhLGSV
        UGGHjWqVcmnxY6aLEzqGR03IlwjP8H58HZoZP9MzS9pcfHlXFRMyUxFS+wcTohEemt78oCR8V+YFp
        rdM9EmTxzpefGAlduTvKUqvZILzsKaNMKCMOJfCa7fZ/JxW15/9q+pDafuLHgHpILYHn7omdFChq/
        fQzqkwLA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcCvy-0005AK-8C; Fri, 22 May 2020 19:02:18 +0000
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Yotam Gigi <yotam.gi@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -net-next] net: psample: depends on INET
Message-ID: <3c51bea5-b7f5-f64d-eaf2-b4dcba82ce16@infradead.org>
Date:   Fri, 22 May 2020 12:02:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix psample build error when CONFIG_INET is not set/enabled.
PSAMPLE should depend on INET instead of NET since
ip_tunnel_info_opts() is only present for CONFIG_INET.

../net/psample/psample.c: In function ‘__psample_ip_tun_to_nlattr’:
../net/psample/psample.c:216:25: error: implicit declaration of function ‘ip_tunnel_info_opts’; did you mean ‘ip_tunnel_info_opts_set’? [-Werror=implicit-function-declaration]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yotam Gigi <yotam.gi@gmail.com>
---
This might be too stringent...

 net/psample/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200522.orig/net/psample/Kconfig
+++ linux-next-20200522/net/psample/Kconfig
@@ -4,7 +4,7 @@
 #
 
 menuconfig PSAMPLE
-	depends on NET
+	depends on INET
 	tristate "Packet-sampling netlink channel"
 	default n
 	help

