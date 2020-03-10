Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6DEC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC04208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846460;
	bh=tXedHrave03/djjKK4IkV0L4IAg1gcrgsCOHOyc8TsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mg+tmIay+CVojWmkCyiDXOIm2xV1kmJK6H1IHYKfS4HoFchNUtS4omUEbd3QxvHnr
	 iTZ4nqiO+InzJM+T0EDSnojOEo5hI/muwM3NjpsiySubAG/J/ziJGi1nf4OZjbqB3w
	 uaxe3jqaGhKqwAN6VzfFgmh+rbj0xGP2PBkz2jUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgCJNU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728891AbgCJNGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:06:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC96D20409;
        Tue, 10 Mar 2020 13:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845594;
        bh=tXedHrave03/djjKK4IkV0L4IAg1gcrgsCOHOyc8TsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cua6HE9G8853Jlf7H/kejj+CpSCTNvhWcRTeh1VmjTMgG4pqDPnRTEDkaaxuA0RxH
         ghzycMKkg/lxN+FeBq7iQf4yGEzHCSHDEm/YUA86UoB4w92OBwv87YQFb47+ETCw0R
         YlUNbTNrucn3WYxLFQwEzH7FBbwMD2D3RkpZZUp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Poirier <bpoirier@cumulusnetworks.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 031/126] ipv6: Fix route replacement with dev-only route
Date:   Tue, 10 Mar 2020 13:40:52 +0100
Message-Id: <20200310124206.419779637@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Poirier <bpoirier@cumulusnetworks.com>

[ Upstream commit e404b8c7cfb31654c9024d497cec58a501501692 ]

After commit 27596472473a ("ipv6: fix ECMP route replacement") it is no
longer possible to replace an ECMP-able route by a non ECMP-able route.
For example,
	ip route add 2001:db8::1/128 via fe80::1 dev dummy0
	ip route replace 2001:db8::1/128 dev dummy0
does not work as expected.

Tweak the replacement logic so that point 3 in the log of the above commit
becomes:
3. If the new route is not ECMP-able, and no matching non-ECMP-able route
exists, replace matching ECMP-able route (if any) or add the new route.

We can now summarize the entire replace semantics to:
When doing a replace, prefer replacing a matching route of the same
"ECMP-able-ness" as the replace argument. If there is no such candidate,
fallback to the first route found.

Fixes: 27596472473a ("ipv6: fix ECMP route replacement")
Signed-off-by: Benjamin Poirier <bpoirier@cumulusnetworks.com>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_fib.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -893,8 +893,7 @@ static int fib6_add_rt2node(struct fib6_
 					found++;
 					break;
 				}
-				if (rt_can_ecmp)
-					fallback_ins = fallback_ins ?: ins;
+				fallback_ins = fallback_ins ?: ins;
 				goto next_iter;
 			}
 
@@ -934,7 +933,9 @@ next_iter:
 	}
 
 	if (fallback_ins && !found) {
-		/* No ECMP-able route found, replace first non-ECMP one */
+		/* No matching route with same ecmp-able-ness found, replace
+		 * first matching route
+		 */
 		ins = fallback_ins;
 		iter = *ins;
 		found++;


