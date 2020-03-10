Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131DAC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB46A2071B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845706;
	bh=MssbFzVM8wHJST/MuhBvHAIOuQyMU4VQfLFQ9W1nvNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lHN4QSOSFe9NDRGZE6HWasicLZDXCWVKfS+hwDfz5GiyYLACa8nmWlZm2JlUGtfKd
	 v1UIwzs5UJ0PpksHg6spiuP4dmWim8r+a/SMsO40F4CS4xAsNjVZ51EouOwq8Cxa74
	 MR2cWCFXAQIFdKhKqxUD1ocP274Qb3gieyRHxagY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbgCJNIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731105AbgCJNIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:08:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B339208E4;
        Tue, 10 Mar 2020 13:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845701;
        bh=MssbFzVM8wHJST/MuhBvHAIOuQyMU4VQfLFQ9W1nvNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGEOo0CuLgu68ahC/8YqvVjCqBa7ZCwMAXMiWiuhGqH3iAQUQoxpTFtxbSady4zLC
         tABRKWAxXTilMyWawZXY3FVkU6VndLkRQcJQV2TaWhMdSp0vxP9E1cyykewpDdgk8a
         1BZ7f6bX/bk1h6Lb1ZEZdIC3d0GDQxUDFHKYAAT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Erhard F." <erhard_f@mailbox.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 052/126] net: netlink: cap max groups which will be considered in netlink_bind()
Date:   Tue, 10 Mar 2020 13:41:13 +0100
Message-Id: <20200310124207.551126300@linuxfoundation.org>
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

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

commit 3a20773beeeeadec41477a5ba872175b778ff752 upstream.

Since nl_groups is a u32 we can't bind more groups via ->bind
(netlink_bind) call, but netlink has supported more groups via
setsockopt() for a long time and thus nlk->ngroups could be over 32.
Recently I added support for per-vlan notifications and increased the
groups to 33 for NETLINK_ROUTE which exposed an old bug in the
netlink_bind() code causing out-of-bounds access on archs where unsigned
long is 32 bits via test_bit() on a local variable. Fix this by capping the
maximum groups in netlink_bind() to BITS_PER_TYPE(u32), effectively
capping them at 32 which is the minimum of allocated groups and the
maximum groups which can be bound via netlink_bind().

CC: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Richard Guy Briggs <rgb@redhat.com>
Fixes: 4f520900522f ("netlink: have netlink per-protocol bind function return an error code.")
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netlink/af_netlink.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -997,7 +997,8 @@ static int netlink_bind(struct socket *s
 	if (nlk->netlink_bind && groups) {
 		int group;
 
-		for (group = 0; group < nlk->ngroups; group++) {
+		/* nl_groups is a u32, so cap the maximum groups we can bind */
+		for (group = 0; group < BITS_PER_TYPE(u32); group++) {
 			if (!test_bit(group, &groups))
 				continue;
 			err = nlk->netlink_bind(net, group + 1);
@@ -1016,7 +1017,7 @@ static int netlink_bind(struct socket *s
 			netlink_insert(sk, nladdr->nl_pid) :
 			netlink_autobind(sock);
 		if (err) {
-			netlink_undo_bind(nlk->ngroups, groups, sk);
+			netlink_undo_bind(BITS_PER_TYPE(u32), groups, sk);
 			goto unlock;
 		}
 	}


