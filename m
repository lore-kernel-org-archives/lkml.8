Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E45C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63A62495E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339506;
	bh=J51ut0py80iYLO8JyVkUcyGi84N9dcBYHNXepTQWFJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l1WZ3K1yfSiHpZ7aVYut6bqJRUWNKElTdi/AtDmHQ6LoJ1xj1i7oFLCSxHpc85dGd
	 Q1qfzrlD/Yvw7y0Fh7KKFzmpXjMzsP1QJTVZCOpOlwRrgteM3NPKXkD55AvppQ73YJ
	 /gZbOw0wWrofq+hk3x9ofWatxM8jKPLDp9B8pBgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgEANZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbgEANZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:25:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C1EC24954;
        Fri,  1 May 2020 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339504;
        bh=J51ut0py80iYLO8JyVkUcyGi84N9dcBYHNXepTQWFJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+142DuYoCbtRdVgEj4BxLo52/7lV9pRsav8mTMTMJFVujauVkdGSDzaq6RutVmeb
         iTV+uA12bquwHc0L95R6BQhgOd/eOsDKRCOeutEZSh4jdQq9Y8/YW9GR4dg79q12CS
         3yTwWDVL53BKa40qFiTmQ9A8zF7K+gBK/thi5wic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Sowden <jeremy@azazel.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 06/70] vti4: removed duplicate log message.
Date:   Fri,  1 May 2020 15:20:54 +0200
Message-Id: <20200501131514.721733672@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.302599262@linuxfoundation.org>
References: <20200501131513.302599262@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Sowden <jeremy@azazel.net>

commit 01ce31c57b3f07c91c9d45bbaf126124cce83a5d upstream.

Removed info log-message if ipip tunnel registration fails during
module-initialization: it adds nothing to the error message that is
written on all failures.

Fixes: dd9ee3444014e ("vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel")
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/ip_vti.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -666,10 +666,8 @@ static int __init vti_init(void)
 
 	msg = "ipip tunnel";
 	err = xfrm4_tunnel_register(&ipip_handler, AF_INET);
-	if (err < 0) {
-		pr_info("%s: cant't register tunnel\n",__func__);
+	if (err < 0)
 		goto xfrm_tunnel_failed;
-	}
 
 	msg = "netlink interface";
 	err = rtnl_link_register(&vti_link_ops);


