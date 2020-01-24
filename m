Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6E9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29CC2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865581;
	bh=+PLm243HIZcGaw76QdwXknC3Hs7Cyszu2YZInqtQJMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SXeJVounU/9brNO2umi5wwlbpPc+llhKV47w+hqd4Vo2wJL8xBUqwRDXrG7ocyLgW
	 79iHkIqCyzeLSSl2FjNQF6keGFEzWQc7qo6tLj5/bZo8XCQ87WtP9/X3t0mHp+iSSE
	 iYJbJ42urpByQtx++3YhuYOjY5iD74UPx0iks3rU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404534AbgAXLdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:33:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404513AbgAXLcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:32:55 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C941F20704;
        Fri, 24 Jan 2020 11:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865574;
        bh=+PLm243HIZcGaw76QdwXknC3Hs7Cyszu2YZInqtQJMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EF49mgCFpnbuqw1qFQtS71/ule0a8CJWUgqPFb1qQPOxR5ex4i1NMS0nrxJGgd19f
         9+QaefQnqRpiYTYuKV+A6psG9HflMGkHnJurwO0zvM26LfCr/bvv7caVU9JII1mFFa
         JbuoLqDVf5D5/gLYCk3v8fMw9B+d16pvADFe4YUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 575/639] cxgb4: Signedness bug in init_one()
Date:   Fri, 24 Jan 2020 10:32:25 +0100
Message-Id: <20200124093201.482169642@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 286183147666fb76c057836c57d86e9e6f508bca ]

The "chip" variable is an enum, and it's treated as unsigned int by GCC
in this context so the error handling isn't triggered.

Fixes: e8d452923ae6 ("cxgb4: clean up init_one")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index bb04c695ab9fd..c81d6c330548d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5452,7 +5452,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	whoami = t4_read_reg(adapter, PL_WHOAMI_A);
 	pci_read_config_word(pdev, PCI_DEVICE_ID, &device_id);
 	chip = t4_get_chip_type(adapter, CHELSIO_PCI_ID_VER(device_id));
-	if (chip < 0) {
+	if ((int)chip < 0) {
 		dev_err(&pdev->dev, "Device %d is not supported\n", device_id);
 		err = chip;
 		goto out_free_adapter;
-- 
2.20.1



