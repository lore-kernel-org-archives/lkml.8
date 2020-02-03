Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DB3C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778062086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748316;
	bh=Li8LrGSYb/x5zKMQjBqf/caqYNBfuICQvy7Z9Uro0Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WK7NQvv+2R54JG7nqgZ5XRbnQvOhuRbluz16U1BhZ8gEH6nZ20aaFbH0gZVLHV3pQ
	 suuvDpmzwFzSFutSX4w6PV+tJNrVLB/iQ9BVQrQPR9j7hZwQ6hbN+TL2UCyedXzBb8
	 CdgrxlACtv+PS1WBh1+jb5RznH4BSwe0jokv9AAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgBCQaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:30:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:42698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729966AbgBCQaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:30:18 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1300E20838;
        Mon,  3 Feb 2020 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747418;
        bh=Li8LrGSYb/x5zKMQjBqf/caqYNBfuICQvy7Z9Uro0Mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hMdLdac1IzlqYOKH24soGxd26INqG5bOnaD5QYdeZw4wPBIgGg1JyTtm/oHDgGm9W
         OQ37Fbo2Q7NJhQQQ60qaCQ8cI7HXp7KeMpqLtTZfUqEdD/9nlXKY4LBNJ8yceYmyan
         plYr75LAuRA93uF1EZpIOPKlo8V/Z2zSk4CAHde8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 68/89] bnxt_en: Fix ipv6 RFS filter matching logic.
Date:   Mon,  3 Feb 2020 16:19:53 +0000
Message-Id: <20200203161925.390427879@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161916.847439465@linuxfoundation.org>
References: <20200203161916.847439465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 6fc7caa84e713f7627e171ab1e7c4b5be0dc9b3d ]

Fix bnxt_fltr_match() to match ipv6 source and destination addresses.
The function currently only checks ipv4 addresses and will not work
corrently on ipv6 filters.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 38ee7692132c5..7461e7b9eaae5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7402,11 +7402,23 @@ static bool bnxt_fltr_match(struct bnxt_ntuple_filter *f1,
 	struct flow_keys *keys1 = &f1->fkeys;
 	struct flow_keys *keys2 = &f2->fkeys;
 
-	if (keys1->addrs.v4addrs.src == keys2->addrs.v4addrs.src &&
-	    keys1->addrs.v4addrs.dst == keys2->addrs.v4addrs.dst &&
-	    keys1->ports.ports == keys2->ports.ports &&
-	    keys1->basic.ip_proto == keys2->basic.ip_proto &&
-	    keys1->basic.n_proto == keys2->basic.n_proto &&
+	if (keys1->basic.n_proto != keys2->basic.n_proto ||
+	    keys1->basic.ip_proto != keys2->basic.ip_proto)
+		return false;
+
+	if (keys1->basic.n_proto == htons(ETH_P_IP)) {
+		if (keys1->addrs.v4addrs.src != keys2->addrs.v4addrs.src ||
+		    keys1->addrs.v4addrs.dst != keys2->addrs.v4addrs.dst)
+			return false;
+	} else {
+		if (memcmp(&keys1->addrs.v6addrs.src, &keys2->addrs.v6addrs.src,
+			   sizeof(keys1->addrs.v6addrs.src)) ||
+		    memcmp(&keys1->addrs.v6addrs.dst, &keys2->addrs.v6addrs.dst,
+			   sizeof(keys1->addrs.v6addrs.dst)))
+			return false;
+	}
+
+	if (keys1->ports.ports == keys2->ports.ports &&
 	    keys1->control.flags == keys2->control.flags &&
 	    ether_addr_equal(f1->src_mac_addr, f2->src_mac_addr) &&
 	    ether_addr_equal(f1->dst_mac_addr, f2->dst_mac_addr))
-- 
2.20.1



