Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD88C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382F020787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645440;
	bh=a1HpEXRZ/5jojKy5rJX68A60mq6WMRfNlUiyOa9yo+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1xoaB/MpNYPI8Lc1ZlZf1MPRlSGu1up7reibEwWtw44GAm8T5CTkQoObcyZE2nq6u
	 4z9sA+fQOjdV06GuuQYYsBTbDUoCqkXmVWLbF/9GcimUCptOiP8SMVEt+CfkGyFlxm
	 Fpd/LWIsdN4FuaKVClweHLEJQgFNh2TdZgu2wJHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgCaJD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730391AbgCaJDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:03:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA69E20848;
        Tue, 31 Mar 2020 09:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645434;
        bh=a1HpEXRZ/5jojKy5rJX68A60mq6WMRfNlUiyOa9yo+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKEzAhIwLi3reu3Ky5H7XSHRNSSpelb87Wn4txoYxgEQk2fhmkZmrQkJq/IgLyYO6
         kjhYpQv3+WhjbTOVP2p0x8uZss5VTJKv0vuoyaurHkJdaD3CVimMrneisIi8twGjBY
         1+GRsr/PyQTOw6QNQcnEcvFYO/RvmHrF8m1ILToU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+1b4ebf4dae4e510dd219@syzkaller.appspotmail.com,
        Petr Machata <petrm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 052/170] net: ip_gre: Accept IFLA_INFO_DATA-less configuration
Date:   Tue, 31 Mar 2020 10:57:46 +0200
Message-Id: <20200331085429.946718195@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit 32ca98feab8c9076c89c0697c5a85e46fece809d ]

The fix referenced below causes a crash when an ERSPAN tunnel is created
without passing IFLA_INFO_DATA. Fix by validating passed-in data in the
same way as ipgre does.

Fixes: e1f8f78ffe98 ("net: ip_gre: Separate ERSPAN newlink / changelink callbacks")
Reported-by: syzbot+1b4ebf4dae4e510dd219@syzkaller.appspotmail.com
Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_gre.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1168,6 +1168,8 @@ static int erspan_netlink_parms(struct n
 	err = ipgre_netlink_parms(dev, data, tb, parms, fwmark);
 	if (err)
 		return err;
+	if (!data)
+		return 0;
 
 	if (data[IFLA_GRE_ERSPAN_VER]) {
 		t->erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER]);


