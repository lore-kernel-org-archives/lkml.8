Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E310C54E4A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46ADC218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943825;
	bh=zleLaBM0XPingcVsYTc+5kLlHBiQnOAVwWkAMGN0/Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LJHM8TZFbUNkYQR1O/E0xNhOPEd51T88EkJxmMmF31NYtJzd2iyfhquBlDkAFoymG
	 8H6HAglg6EgnVxPGgm+DW59A7sBDzp6Nwv8lHujBQOO8MUNSuR34TrUW7/qEdRkSCC
	 qWnHIlFs3dRR8WqgR1RJVTbcVkpkAAYqqIYZiljM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgEHMoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbgEHMoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:44:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFD5B206B8;
        Fri,  8 May 2020 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941852;
        bh=zleLaBM0XPingcVsYTc+5kLlHBiQnOAVwWkAMGN0/Pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qy3BiNyv5icMfm6+daafLmlETh3dyntaxnmAbMuFWtlZWx1wm+ELGzmA9B8ELwEz/
         QWi/B2z+2CR+84vFyOhVPbO9iv7TfHZiqsWZGUCAyXhjeelLJtKOnlXhZp0CbvbXB/
         Y3bQf4Kj0mSLdL33rGFdRHx65HwxqmqTscIp6KVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.4 199/312] netfilter: nf_tables: destroy the set if fail to add transaction
Date:   Fri,  8 May 2020 14:33:10 +0200
Message-Id: <20200508123138.434155611@linuxfoundation.org>
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

From: Liping Zhang <zlpnobody@gmail.com>

commit c17c3cdff10b9f59ef1244a14604f10949f17117 upstream.

When the memory is exhausted, then we will fail to add the NFT_MSG_NEWSET
transaction. In such case, we should destroy the set before we free it.

Fixes: 958bee14d071 ("netfilter: nf_tables: use new transaction infrastructure to handle sets")
Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_tables_api.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2849,12 +2849,14 @@ static int nf_tables_newset(struct net *
 
 	err = nft_trans_set_add(&ctx, NFT_MSG_NEWSET, set);
 	if (err < 0)
-		goto err2;
+		goto err3;
 
 	list_add_tail_rcu(&set->list, &table->sets);
 	table->use++;
 	return 0;
 
+err3:
+	ops->destroy(set);
 err2:
 	kfree(set);
 err1:


