Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD8EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4B820870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943759;
	bh=vZrATeGy2MPM3x6OJ+weUND1lMKETe0dUmLEuxDKKCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TczNncb8qNPSfjNO7SU5vKEGIp01aq8gE7T4jDlSyPRAC3ifCXm6eNVj4Gq5P40xI
	 QZoZi55kyB5VpjrlDLMt6+TFY3Lj8OPapjqUASTc3vHr83oWmKO9FS6cu7haINpz+Q
	 CurzVpXV9srVWdkhTaWVu57VJRTBPUA/DflWpN/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgEHNP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbgEHMpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:45:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF2C921473;
        Fri,  8 May 2020 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941943;
        bh=vZrATeGy2MPM3x6OJ+weUND1lMKETe0dUmLEuxDKKCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkG9u0MsRQCsFY0NKQdtY8de8GpZk3LwoeaP+CGEdsV+UW4QVZ4NEvwEIncHS13ci
         a+DP7ufopMYv+dS3zDGWHzoApU01AjK/ZF6MFwMkeAHqGXwRxpWJz/m3T6En0cwC68
         Em199+WcQGGipgUyFtJyLvPaMOqRjPYZl6Rnyh9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 195/312] ipv6: add missing netconf notif when all is updated
Date:   Fri,  8 May 2020 14:33:06 +0200
Message-Id: <20200508123138.159632987@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

commit d26c638c16cb54f6fb1507e27df93ede692db572 upstream.

The 'default' value was not advertised.

Fixes: f3a1bfb11ccb ("rtnl/ipv6: use netconf msg to advertise forwarding status")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/addrconf.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -771,7 +771,14 @@ static int addrconf_fixup_forwarding(str
 	}
 
 	if (p == &net->ipv6.devconf_all->forwarding) {
+		int old_dflt = net->ipv6.devconf_dflt->forwarding;
+
 		net->ipv6.devconf_dflt->forwarding = newf;
+		if ((!newf) ^ (!old_dflt))
+			inet6_netconf_notify_devconf(net, NETCONFA_FORWARDING,
+						     NETCONFA_IFINDEX_DEFAULT,
+						     net->ipv6.devconf_dflt);
+
 		addrconf_forward_change(net, newf);
 		if ((!newf) ^ (!old))
 			inet6_netconf_notify_devconf(net, NETCONFA_FORWARDING,


