Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA396C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEA920724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623744;
	bh=AkPlYqCA7S2+lqhUQkKt7MYM0xyiKSGyeIxF4h7I9vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dlqOc9rzrhpjBPsDBj6H7FfPEwQjyHgRd6llex0M22hCBORx0lUrGRIAzMPT2nUIm
	 brk3cdtCG92/A03e1hFV4wIool6/K1IeECndfXB7/3+dskLa0x1lT7FMovVjH9t7Fk
	 UFFs7Rej9Xp9+Z4kUdAd4YUKMhJcp7DE+qXottgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgCSNPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:15:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbgCSNPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:15:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8466F20787;
        Thu, 19 Mar 2020 13:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623738;
        bh=AkPlYqCA7S2+lqhUQkKt7MYM0xyiKSGyeIxF4h7I9vU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKIDIcAqQAjuUPThgmhNwPpM8zYjuQuAajCLE004LkrEHTVQPeHN/Lap7z4+qdW8c
         2JBLVXhV+xChKLrh4iDVW2alDMNmx1USZcHRFrDj0+vZ59q3QVMpwxDsw2c7jH8zIz
         nshSvjeIWRPd6rlamgG6SyYcJCAo79doy/cKuJYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 05/99] ipv6/addrconf: call ipv6_mc_up() for non-Ethernet interface
Date:   Thu, 19 Mar 2020 14:02:43 +0100
Message-Id: <20200319123943.155391079@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 60380488e4e0b95e9e82aa68aa9705baa86de84c ]

Rafał found an issue that for non-Ethernet interface, if we down and up
frequently, the memory will be consumed slowly.

The reason is we add allnodes/allrouters addressed in multicast list in
ipv6_add_dev(). When link down, we call ipv6_mc_down(), store all multicast
addresses via mld_add_delrec(). But when link up, we don't call ipv6_mc_up()
for non-Ethernet interface to remove the addresses. This makes idev->mc_tomb
getting bigger and bigger. The call stack looks like:

addrconf_notify(NETDEV_REGISTER)
	ipv6_add_dev
		ipv6_dev_mc_inc(ff01::1)
		ipv6_dev_mc_inc(ff02::1)
		ipv6_dev_mc_inc(ff02::2)

addrconf_notify(NETDEV_UP)
	addrconf_dev_config
		/* Alas, we support only Ethernet autoconfiguration. */
		return;

addrconf_notify(NETDEV_DOWN)
	addrconf_ifdown
		ipv6_mc_down
			igmp6_group_dropped(ff02::2)
				mld_add_delrec(ff02::2)
			igmp6_group_dropped(ff02::1)
			igmp6_group_dropped(ff01::1)

After investigating, I can't found a rule to disable multicast on
non-Ethernet interface. In RFC2460, the link could be Ethernet, PPP, ATM,
tunnels, etc. In IPv4, it doesn't check the dev type when calls ip_mc_up()
in inetdev_event(). Even for IPv6, we don't check the dev type and call
ipv6_add_dev(), ipv6_dev_mc_inc() after register device.

So I think it's OK to fix this memory consumer by calling ipv6_mc_up() for
non-Ethernet interface.

v2: Also check IFF_MULTICAST flag to make sure the interface supports
    multicast

Reported-by: Rafał Miłecki <zajec5@gmail.com>
Tested-by: Rafał Miłecki <zajec5@gmail.com>
Fixes: 74235a25c673 ("[IPV6] addrconf: Fix IPv6 on tuntap tunnels")
Fixes: 1666d49e1d41 ("mld: do not remove mld souce list info when set link down")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/addrconf.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3223,6 +3223,10 @@ static void addrconf_dev_config(struct n
 	    (dev->type != ARPHRD_TUNNEL) &&
 	    (dev->type != ARPHRD_NONE)) {
 		/* Alas, we support only Ethernet autoconfiguration. */
+		idev = __in6_dev_get(dev);
+		if (!IS_ERR_OR_NULL(idev) && dev->flags & IFF_UP &&
+		    dev->flags & IFF_MULTICAST)
+			ipv6_mc_up(idev);
 		return;
 	}
 


