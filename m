Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7658C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48D024695
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844278;
	bh=JnxO00KRWh6HTLd5dyxWlQssitdufeTK2bB+WzCikpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ksJPs4ml2FFM0gp6DRKuXric5uj540RvcAbNOojNoNmTRdFEJNBIoFh2QW5Yh7ozk
	 PYu27mJjY1x7eZbAXEzIApppzXnrrpjoXaUFhsLjDC7k2gSb4oAZ8LdvGEBJMRkBDM
	 GeFT2JtHnsAL/PpzZsFa2Dks6lFn10scMg9xq+eA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgCJMog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbgCJMod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:44:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E41AE246A6;
        Tue, 10 Mar 2020 12:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844273;
        bh=JnxO00KRWh6HTLd5dyxWlQssitdufeTK2bB+WzCikpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3ChUM4ewLaHWfHAHX7C8LhZ5AlcNYFZ73caZ1j6uCeCWORE7kAYVFPutTTfN2dwg
         Z8vUiVjUW3ZLdnFH78WaYf39uPuHc1/O2L6HmBdVu4lnsjoP7qy+LE9sQg1Kk0Ul0R
         GFnLvAnW2m4SJLxU40bz8DXer+I0qEx8plzPWCPQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jethro Beekman <jethro@fortanix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 21/88] net: fib_rules: Correctly set table field when table number exceeds 8 bits
Date:   Tue, 10 Mar 2020 13:38:29 +0100
Message-Id: <20200310123611.276846968@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
References: <20200310123606.543939933@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jethro Beekman <jethro@fortanix.com>

[ Upstream commit 540e585a79e9d643ede077b73bcc7aa2d7b4d919 ]

In 709772e6e06564ed94ba740de70185ac3d792773, RT_TABLE_COMPAT was added to
allow legacy software to deal with routing table numbers >= 256, but the
same change to FIB rule queries was overlooked.

Signed-off-by: Jethro Beekman <jethro@fortanix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/fib_rules.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -640,7 +640,7 @@ static int fib_nl_fill_rule(struct sk_bu
 
 	frh = nlmsg_data(nlh);
 	frh->family = ops->family;
-	frh->table = rule->table;
+	frh->table = rule->table < 256 ? rule->table : RT_TABLE_COMPAT;
 	if (nla_put_u32(skb, FRA_TABLE, rule->table))
 		goto nla_put_failure;
 	if (nla_put_u32(skb, FRA_SUPPRESS_PREFIXLEN, rule->suppress_prefixlen))


