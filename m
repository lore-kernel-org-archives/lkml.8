Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB03C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E2C2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442627;
	bh=XiC+WgFo/UWdzwe6rREz0eI81wE9hr4wO10hxtUyxko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yjBUUmyFSFf1KKYr6Sow6NvA9oB1u0/M+U6HPsc4RnFRz/vT9v4qrVjafaFSrgHvD
	 wEw0/kt4BAGDBzJt2Talb/1Bc4w/p9uPc7ruSB54RuZVixC8VvwrCtMb1jq8aEGwWR
	 MDnzJUJYWaTPRFyTT0y0UwAp1UPEEvz3rTRdRDCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCQK5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgCQK5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:57:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 475D720736;
        Tue, 17 Mar 2020 10:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442621;
        bh=XiC+WgFo/UWdzwe6rREz0eI81wE9hr4wO10hxtUyxko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V//pfY9ovGOKlgLfMZ9Eo7/E0Fm3Qn86QTbiRhUgj5U5Xidzovxe+t46VzmfG2AwU
         tN80wy5nXgrjzG9NAgb0ySMtOU5gb4VU97JZod0O3ccMMt6Zd2B7rtAn5uRBA7IcBI
         Ic32jAA1whiTVkP8xddFs4nz0Amu6k4W9WMo0WC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 25/89] fib: add missing attribute validation for tun_id
Date:   Tue, 17 Mar 2020 11:54:34 +0100
Message-Id: <20200317103302.815247024@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 4c16d64ea04056f1b1b324ab6916019f6a064114 ]

Add missing netlink policy entry for FRA_TUN_ID.

Fixes: e7030878fc84 ("fib: Add fib rule match on tunnel id")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/fib_rules.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/net/fib_rules.h
+++ b/include/net/fib_rules.h
@@ -107,6 +107,7 @@ struct fib_rule_notifier_info {
 	[FRA_OIFNAME]	= { .type = NLA_STRING, .len = IFNAMSIZ - 1 }, \
 	[FRA_PRIORITY]	= { .type = NLA_U32 }, \
 	[FRA_FWMARK]	= { .type = NLA_U32 }, \
+	[FRA_TUN_ID]	= { .type = NLA_U64 }, \
 	[FRA_FWMASK]	= { .type = NLA_U32 }, \
 	[FRA_TABLE]     = { .type = NLA_U32 }, \
 	[FRA_SUPPRESS_PREFIXLEN] = { .type = NLA_U32 }, \


