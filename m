Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07947C433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4C9206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860542;
	bh=XQDfGytVTpKeb+agTuSXemU8hW+k5+3VzA9zL6czwig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c5PN2LJHEnoDRZJBAOTXlbtfqFdxWlF2+CnUo1yv+JRwrvKP1OIMMZIYiCZ1uzOgw
	 r9FS0sZ3zr6MWg8iOMW2/LD+eKQPSxz+HxwofqkQd6gjithoF4idR6donOgukh4MSi
	 7wBs5Z1xLvoq3AGwNS9qj/VJIdWructZ+mi9FB5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgG0OOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730562AbgG0OOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:14:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1AD721883;
        Mon, 27 Jul 2020 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859276;
        bh=XQDfGytVTpKeb+agTuSXemU8hW+k5+3VzA9zL6czwig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RvCn3OZPhDRhIazH7veEXW/5xE1iRMyO3hReXW5VNbmHUbkk6YzaSGZeEooIwMRQk
         Oa8j1SoXca39bVAhq/66s3M/2u/4QpprAinOp460xpf5qRXwzyOn8WUpVW1oSS8LSs
         99KpGhLgXMe9GVAITBPsCw5eaqqt4bSNUVZqIPno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Jian <liujian56@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 046/138] ieee802154: fix one possible memleak in adf7242_probe
Date:   Mon, 27 Jul 2020 16:04:01 +0200
Message-Id: <20200727134927.663862553@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Jian <liujian56@huawei.com>

[ Upstream commit 66673f96f0f968b991dc38be06102246919c663c ]

When probe fail, we should destroy the workqueue.

Fixes: 2795e8c25161 ("net: ieee802154: fix a potential NULL pointer dereference")
Signed-off-by: Liu Jian <liujian56@huawei.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Link: https://lore.kernel.org/r/20200717090121.2143-1-liujian56@huawei.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/adf7242.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 5a37514e42347..8dbccec6ac866 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1262,7 +1262,7 @@ static int adf7242_probe(struct spi_device *spi)
 					     WQ_MEM_RECLAIM);
 	if (unlikely(!lp->wqueue)) {
 		ret = -ENOMEM;
-		goto err_hw_init;
+		goto err_alloc_wq;
 	}
 
 	ret = adf7242_hw_init(lp);
@@ -1294,6 +1294,8 @@ static int adf7242_probe(struct spi_device *spi)
 	return ret;
 
 err_hw_init:
+	destroy_workqueue(lp->wqueue);
+err_alloc_wq:
 	mutex_destroy(&lp->bmux);
 	ieee802154_free_hw(lp->hw);
 
-- 
2.25.1



