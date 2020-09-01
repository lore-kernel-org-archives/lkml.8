Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB1FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4292087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="i9QLmbfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgIAG6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgIAG6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:58:05 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9082FC0612B0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 23:58:03 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id a20so119790pls.20
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 23:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=R1RsPGwLgQ6M8GTAaaA8I5EBvM6vROOQRDTadyBN0fI=;
        b=i9QLmbfLyr4EJASj7o1W8s1hA1XT2OmxHDiSCtdHb80BlrgvCsewefgyU3u92gXTlZ
         VU/LgsJ6dU6yoqnRn5PjrdKEfgidgXnEOIz7vYXzsWTMtU0PSgmFPfVrVzL9R/Y/6Sav
         XQ64dZPcrFFIIzk3v3P141ze2+b/umxih7NHZKV5Kxjff3xbhfPRui8AMhynEMWxE8NE
         QDmwZlkjd+HQiCa5OxxgPK7bh6aaAS9aRYOnCJN6il0ql5FKD77fdOVNw7M3YBbqXHKn
         jkVduxS5FnPKJcfferWDE/YtX/1zRHKzmqQYvEyuaYOByKusGNmb1uuLY/9mb1c9af9R
         E3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=R1RsPGwLgQ6M8GTAaaA8I5EBvM6vROOQRDTadyBN0fI=;
        b=UhX/amL0l6k+ZTi8x9JrjGs6xyEA2HIcmsOnZcu4XCj1CecYIX/+ydTWguRcFrhk+k
         +t/yMg7DnOH0e+xEBhwdRfUDEVlBNbvLqxm2d007gnDXEn2LRSMTAE2Q+SRih7qigXAk
         M/3lAA764r0ta1m3hxC1zZeG+jY4AXBpVrr85/sQP/kEkB3PxIpjpK1GoQK2sIUE0sYK
         e8Qro9pJX1mh1W9Z8KdvToDboFlN9HpZ2yStcuUjUskwZ4yQ/jH6LsfUeyjBviXg9vNB
         CIk2hjgRjWzycfRvH7CEz+javKaRC/n5uZE0NY7T0C5pqy6NfgSfsm3tIoj1kAKqgpBg
         Q7Rg==
X-Gm-Message-State: AOAM5322K9ca4wuALZ3o9Cz1tZjzHVwkaRx+N1NiiQJsV1NdR6T1yKN+
        HHGcPp+4AWYElwTerAtlZ5OBCvY1vrHu
X-Google-Smtp-Source: ABdhPJy3PPx1infkahXw5FXVuR6+lobnCfGfXBH82a8cmkfqGXGxfmUG+T2E7GLKNm/b9DjWDC4Tsmu4agQs
X-Received: from brianvv.svl.corp.google.com ([2620:15c:2c4:201:a28c:fdff:fee1:c370])
 (user=brianvv job=sendgmr) by 2002:a17:90b:110a:: with SMTP id
 gi10mr236943pjb.206.1598943482728; Mon, 31 Aug 2020 23:58:02 -0700 (PDT)
Date:   Mon, 31 Aug 2020 23:57:58 -0700
Message-Id: <20200901065758.1141786-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH] net: ipv6: fix __rt6_purge_dflt_routers when forwarding is
 not set on all ifaces
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        David Ahern <dsa@cumulusnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is exposed when the system has multiple ifaces and
forwarding is enabled on a subset of them, __rt6_purge_dflt_routers will
clean the default route on all the ifaces which is not desired.

This patches fixes that by cleaning only the routes where the iface has
forwarding enabled.

Fixes: 830218c1add1 ("net: ipv6: Fix processing of RAs in presence of VRF")
Cc: David Ahern <dsa@cumulusnetworks.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 net/ipv6/route.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 5e7e25e2523a..41181cd489ea 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4283,6 +4283,7 @@ static void __rt6_purge_dflt_routers(struct net *net,
 				     struct fib6_table *table)
 {
 	struct fib6_info *rt;
+	bool deleted = false;
 
 restart:
 	rcu_read_lock();
@@ -4291,16 +4292,19 @@ static void __rt6_purge_dflt_routers(struct net *net,
 		struct inet6_dev *idev = dev ? __in6_dev_get(dev) : NULL;
 
 		if (rt->fib6_flags & (RTF_DEFAULT | RTF_ADDRCONF) &&
-		    (!idev || idev->cnf.accept_ra != 2) &&
+		    (!idev || (idev->cnf.forwarding == 1 &&
+			       idev->cnf.accept_ra != 2)) &&
 		    fib6_info_hold_safe(rt)) {
 			rcu_read_unlock();
 			ip6_del_rt(net, rt, false);
+			deleted = true;
 			goto restart;
 		}
 	}
 	rcu_read_unlock();
 
-	table->flags &= ~RT6_TABLE_HAS_DFLT_ROUTER;
+	if (deleted)
+		table->flags &= ~RT6_TABLE_HAS_DFLT_ROUTER;
 }
 
 void rt6_purge_dflt_routers(struct net *net)
-- 
2.28.0.402.g5ffc5be6b7-goog

