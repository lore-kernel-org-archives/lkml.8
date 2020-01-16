Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9321C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B9D2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201104;
	bh=PNyrjtKhsh5j0ZJI7dAt5m/4ZFrkwxjsk9guXqwkz88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=of99P9RW7QPCE9o6v/Hv3rG3itj/vbRCj4cmB39ix8KLwuMRp5jJvJFOciW1gLhT5
	 OG1qc0q7X/Tcxfv4TpoUdT398KDpkNpTiJLwo778sgCsNgTLktHagjTEJwBNe2Udnq
	 L7PSFd9otzm5hR+A+FN+1KvsC3AAvUF+RbDUkPEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389523AbgAPS6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:58:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389001AbgAPRGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 813C121582;
        Thu, 16 Jan 2020 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194409;
        bh=PNyrjtKhsh5j0ZJI7dAt5m/4ZFrkwxjsk9guXqwkz88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLgQKF8yx0dfZQP1eTtYQytkfFOrhJrZ3Kr5soTIgw/n81PPEd0aY07mfzH6vCZ2u
         cgbVk0LxC/3tSN4Zv4T+uxpJAPuuDmot2l5IV9WPHUII3cNAm6bQgYHTO+yX2qnUOn
         ZXZkzvngZTBHX6H2+j6GSz/h9ur5iDSEbj0rdamc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sameeh Jubran <sameehj@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 332/671] net: ena: fix incorrect test of supported hash function
Date:   Thu, 16 Jan 2020 11:59:30 -0500
Message-Id: <20200116170509.12787-69-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 7635c38e77dd..005882c40262 100644
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

