Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EBBC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041FB208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257507;
	bh=tM7Ij/63ha0ssvAkW5YMl1NTqh75zQLUxztYIdZ0FXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V3gllL1SX+Sjby4ToRZ+sL4ngYBmfwiZMHtH+QaPsKb2pCDuJB2EDhld6KeGPtwt/
	 CUEvuj5NQh2OT2jbimNo4cvFwPEzOoQT9XzYrtmfczHmiZ905OrAXWASzXJuUvVR8N
	 1njnt3Tm12iHuredcLjI/KtFADDAS6lrFIhJnRYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgCCRpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730855AbgCCRpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:45:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A350B208C3;
        Tue,  3 Mar 2020 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257503;
        bh=tM7Ij/63ha0ssvAkW5YMl1NTqh75zQLUxztYIdZ0FXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lN3XFWHZgVO2sqOeLMjx7RjnTQ+f6y3VKTyRpjGanXzcpeH0zKcml8yTZY5je9rZX
         7Z7COCScqKmXhSOAJmxNfbRd45kMro0zzdcNgMaEHzIrStjvryDBzef07doYbid1SI
         4ZrMI8uMDSbkXTJyZA11gV4grcn/nsmd/NZSHoTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Poirier <bpoirier@cumulusnetworks.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 020/176] ipv6: Fix nlmsg_flags when splitting a multipath route
Date:   Tue,  3 Mar 2020 18:41:24 +0100
Message-Id: <20200303174306.889596168@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Poirier <bpoirier@cumulusnetworks.com>

[ Upstream commit afecdb376bd81d7e16578f0cfe82a1aec7ae18f3 ]

When splitting an RTA_MULTIPATH request into multiple routes and adding the
second and later components, we must not simply remove NLM_F_REPLACE but
instead replace it by NLM_F_CREATE. Otherwise, it may look like the netlink
message was malformed.

For example,
	ip route add 2001:db8::1/128 dev dummy0
	ip route change 2001:db8::1/128 nexthop via fe80::30:1 dev dummy0 \
		nexthop via fe80::30:2 dev dummy0
results in the following warnings:
[ 1035.057019] IPv6: RTM_NEWROUTE with no NLM_F_CREATE or NLM_F_REPLACE
[ 1035.057517] IPv6: NLM_F_CREATE should be set when creating new route

This patch makes the nlmsg sequence look equivalent for __ip6_ins_rt() to
what it would get if the multipath route had been added in multiple netlink
operations:
	ip route add 2001:db8::1/128 dev dummy0
	ip route change 2001:db8::1/128 nexthop via fe80::30:1 dev dummy0
	ip route append 2001:db8::1/128 nexthop via fe80::30:2 dev dummy0

Fixes: 27596472473a ("ipv6: fix ECMP route replacement")
Signed-off-by: Benjamin Poirier <bpoirier@cumulusnetworks.com>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5152,6 +5152,7 @@ static int ip6_route_multipath_add(struc
 		 */
 		cfg->fc_nlinfo.nlh->nlmsg_flags &= ~(NLM_F_EXCL |
 						     NLM_F_REPLACE);
+		cfg->fc_nlinfo.nlh->nlmsg_flags |= NLM_F_CREATE;
 		nhn++;
 	}
 


