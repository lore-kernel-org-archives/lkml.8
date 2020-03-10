Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7044C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDAE24649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583847340;
	bh=ZSiJGuWgxzz7UdiyaHP8cOuIVyiHlTqmuX6Y/Goe6AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mrVqkkN2NCUjG6hUEFPwuzvsLDB/p6tF0KWoXUOfVuci/0bxAlNS2Oo2rby3ORwnD
	 xPylHu8SULEVod6H+GmjmLKDEg3Wbwf4zVxJ8EIqXKrHit09p1Od75SJnzWd6OXJ7W
	 YyuogrUJ4OPPV89k2I0oRRBVL6A0FUplSwC8/QgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgCJNfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbgCJMoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:44:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F30246E5;
        Tue, 10 Mar 2020 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844251;
        bh=ZSiJGuWgxzz7UdiyaHP8cOuIVyiHlTqmuX6Y/Goe6AE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBET4S0LL49u2D98g3Cqsmy/1xOFazyvzqYPT2i2d4oYy2pQhMwY6XxHC1DjMzDNi
         eK1+0Lp+PevMsvYCWou9maaJNzgl974VsMNZcJcwGpHpbOr4nPGQMrpCHK2vQ7yD9g
         WQDfy/vZdBnbqqVotYhiFqilufPyw5+iWRsG2HcI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sameeh Jubran <sameehj@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 14/88] net: ena: rss: store hash function as values and not bits
Date:   Tue, 10 Mar 2020 13:38:22 +0100
Message-Id: <20200310123609.786056496@linuxfoundation.org>
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

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit 4844470d472d660c26149ad764da2406adb13423 ]

The device receives, stores and retrieves the hash function value as bits
and not as their enum value.

The bug:
* In ena_com_set_hash_function() we set
  cmd.u.flow_hash_func.selected_func to the bit value of rss->hash_func.
 (1 << rss->hash_func)
* In ena_com_get_hash_function() we retrieve the hash function and store
  it's bit value in rss->hash_func. (Now the bit value of rss->hash_func
  is stored in rss->hash_func instead of it's enum value)

The fix:
This commit fixes the issue by converting the retrieved hash function
values from the device to the matching enum value of the set bit using
ffs(). ffs() finds the first set bit's index in a word. Since the function
returns 1 for the LSB's index, we need to subtract 1 from the returned
value (note that BIT(0) is 1).

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index be8a2d48c98f2..e1f694322e41a 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -2093,7 +2093,11 @@ int ena_com_get_hash_function(struct ena_com_dev *ena_dev,
 	if (unlikely(rc))
 		return rc;
 
-	rss->hash_func = get_resp.u.flow_hash_func.selected_func;
+	/* ffs() returns 1 in case the lsb is set */
+	rss->hash_func = ffs(get_resp.u.flow_hash_func.selected_func);
+	if (rss->hash_func)
+		rss->hash_func--;
+
 	if (func)
 		*func = rss->hash_func;
 
-- 
2.20.1



