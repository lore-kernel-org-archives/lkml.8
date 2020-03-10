Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4A5C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C7324691
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845590;
	bh=/VWnBrb88bZfoa2jzLM0+U4/QMNa4LpqynxHm8gInQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zw5gKq9xBVZvcqR3dGbiogNDEM4tJQIiDoJOVSyqDkdxJGg+d714+09/RoghEx2Iw
	 G1KAiDmMqsstXTPIWRj5YASU97rKA2cM+ttlF78IcTnftniuoc5khzsMaiskFFk4KT
	 QkhKvSOurl+F9t7lAjavobFGMqnrJQdxJR0EGL6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgCJNG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbgCJNGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:06:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2556A20409;
        Tue, 10 Mar 2020 13:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845577;
        bh=/VWnBrb88bZfoa2jzLM0+U4/QMNa4LpqynxHm8gInQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFngzy02zS0wilBqAk4yeWD1wrHnS9pKVxcSYZOHiw32127nGKragCFk88MpUMOdg
         y4LmTzOEDCrrRuNgFtMvBzeQaLIk3erH1YnWRVHesDONZnFQ5TFtxotcayRyqmHghr
         +KM8EoY/+siPYR2WjJxQ51pkrUNzcRd12/XzSwj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jethro Beekman <jethro@fortanix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 026/126] net: fib_rules: Correctly set table field when table number exceeds 8 bits
Date:   Tue, 10 Mar 2020 13:40:47 +0100
Message-Id: <20200310124206.160219813@linuxfoundation.org>
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
@@ -799,7 +799,7 @@ static int fib_nl_fill_rule(struct sk_bu
 
 	frh = nlmsg_data(nlh);
 	frh->family = ops->family;
-	frh->table = rule->table;
+	frh->table = rule->table < 256 ? rule->table : RT_TABLE_COMPAT;
 	if (nla_put_u32(skb, FRA_TABLE, rule->table))
 		goto nla_put_failure;
 	if (nla_put_u32(skb, FRA_SUPPRESS_PREFIXLEN, rule->suppress_prefixlen))


