Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BEDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F079E2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864774;
	bh=lc0hlubxHETebF9OyeRum32SufPpiqXaOtcFVkU6qiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AENhFHub9oHOh9VAi4rVLLJGXrGrfehtRQky7gc8bn+8Eleptb5agINbdUXMmDskn
	 GiZmK3LVebQdNSEtsdwrp1NXWLNWfb2MrjaGHyA0ySzZk9wk16DX3HryAj3pUTfThf
	 R9xjHlSS7s1ohrXY/L8N+KQhl3NRpuMgutBcdTJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390812AbgAXLTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:19:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390788AbgAXLT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:19:27 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28A7B20704;
        Fri, 24 Jan 2020 11:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864767;
        bh=lc0hlubxHETebF9OyeRum32SufPpiqXaOtcFVkU6qiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N40WeKtIe+yjxa2JeViRNZOD/0AlqOckJPDGeSR3TG0PIyl+sQZP2t8aCPcOV5DNq
         W1XKTFtRG5kYEtmwZa/+evPXmsg/i2LOIaBz0LJir1YdYDcacS8AaiJwJ9XVrjxWQ0
         yK+AxH7TXNVlv9enxUQucpTBdysIg6NhqMigIG/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arthur Kiyanovski <akiyano@amazon.com>,
        Sameeh Jubran <sameehj@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 347/639] net: ena: fix incorrect test of supported hash function
Date:   Fri, 24 Jan 2020 10:28:37 +0100
Message-Id: <20200124093130.606159181@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sameeh Jubran <sameehj@amazon.com>

[ Upstream commit d3cfe7ddbc3dfbb9b201615b7fef8fd66d1b5fe8 ]

ena_com_set_hash_function() tests if a hash function is supported
by the device before setting it.
The test returns the opposite result than needed.
Reverse the condition to return the correct value.
Also use the BIT macro instead of inline shift.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 7635c38e77dd0..005882c402625 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -2008,7 +2008,7 @@ int ena_com_set_hash_function(struct ena_com_dev *ena_dev)
 	if (unlikely(ret))
 		return ret;
 
-	if (get_resp.u.flow_hash_func.supported_func & (1 << rss->hash_func)) {
+	if (!(get_resp.u.flow_hash_func.supported_func & BIT(rss->hash_func))) {
 		pr_err("Func hash %d isn't supported by device, abort\n",
 		       rss->hash_func);
 		return -EOPNOTSUPP;
-- 
2.20.1



