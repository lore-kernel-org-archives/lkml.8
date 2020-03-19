Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DB4C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC09B20732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623131;
	bh=Pae+19dx7OPP2Ye/jo1nnKgsIBS++jsBKiRmq6BlY8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iiziwfwIVq029nD/byZPApPqRcenpL14NyjuOrtZpnxCAHOly2zYUX26hRZZrIms/
	 6nRNRBMWq9D2p8jZRg4mcM4i0hq1i7uUHeSkaZZccqvK4DKcrSWr30EtSmkDGmderV
	 xvgQEvJTvhj6Q/ZgoVtpC5eK1GTV0LoF7mEQMKRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCSNFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgCSNF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:05:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B51D920732;
        Thu, 19 Mar 2020 13:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623128;
        bh=Pae+19dx7OPP2Ye/jo1nnKgsIBS++jsBKiRmq6BlY8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADEWN+JYQnvLW4l8tCk6xaFN6T/2tWoSyLC5NEKNZfkNUp9l2uCqbb5/jElOvCjB1
         W7ahL1yqw/Jl7osBj55NGRXQWYTzWPkS669H7NvVUYlXFBkcdUyPpLr8bWpkN75Lba
         psELR9AvwlFYTvjVaWa6cZ6ZYmijL7YyGfwqB050=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 05/93] fib: add missing attribute validation for tun_id
Date:   Thu, 19 Mar 2020 13:59:09 +0100
Message-Id: <20200319123926.662121218@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
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
@@ -85,6 +85,7 @@ struct fib_rules_ops {
 	[FRA_OIFNAME]	= { .type = NLA_STRING, .len = IFNAMSIZ - 1 }, \
 	[FRA_PRIORITY]	= { .type = NLA_U32 }, \
 	[FRA_FWMARK]	= { .type = NLA_U32 }, \
+	[FRA_TUN_ID]	= { .type = NLA_U64 }, \
 	[FRA_FWMASK]	= { .type = NLA_U32 }, \
 	[FRA_TABLE]     = { .type = NLA_U32 }, \
 	[FRA_SUPPRESS_PREFIXLEN] = { .type = NLA_U32 }, \


