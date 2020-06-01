Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C14C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3734D206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037017;
	bh=E7aDakkuZGWWh4pMJFm3LJZ8+eRDuhH2vX43lxxfKk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xyz6kscUlj4ATZOy6/9vY8tnvY4rKkbOAl1M6ieJ7PIBkVH4Xv8n21mlg9xNy56zc
	 1egfT+2oJzpc7uj8y6eNTNZjf2mY3+lqE1hxZVETJ+Xg2rq1gbQdOccsInMnhnNFlY
	 kEfK21CTCnlDpdfo2sQJDsHxKd2NSbWqeSt3FuaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbgFASL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731083AbgFASLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:11:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4192065C;
        Mon,  1 Jun 2020 18:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035073;
        bh=E7aDakkuZGWWh4pMJFm3LJZ8+eRDuhH2vX43lxxfKk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQX60g8GEgdYpNzt+p4hKY0hYGBBsc5DA3FTOqUHwKbIxQiprRmTDPp8MZfan6TC1
         kiLqRovoDTJjvs8SFXl+7TZvlAWutzDU9ol2PWTFJ3H4xIWYv18nmCFR+F8E/LFkT4
         12oQ7NWJl07cvnskb26hi6e2uU9pQG0JRJrb9yf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 139/142] netfilter: conntrack: comparison of unsigned in cthelper confirmation
Date:   Mon,  1 Jun 2020 19:54:57 +0200
Message-Id: <20200601174052.099624774@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 94945ad2b330207cded0fd8d4abebde43a776dfb upstream.

net/netfilter/nf_conntrack_core.c: In function nf_confirm_cthelper:
net/netfilter/nf_conntrack_core.c:2117:15: warning: comparison of unsigned expression in < 0 is always false [-Wtype-limits]
 2117 |   if (protoff < 0 || (frag_off & htons(~0x7)) != 0)
      |               ^

ipv6_skip_exthdr() returns a signed integer.

Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: 703acd70f249 ("netfilter: nfnetlink_cthelper: unbreak userspace helper support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conntrack_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1955,7 +1955,7 @@ static int nf_confirm_cthelper(struct sk
 {
 	const struct nf_conntrack_helper *helper;
 	const struct nf_conn_help *help;
-	unsigned int protoff;
+	int protoff;
 
 	help = nfct_help(ct);
 	if (!help)


