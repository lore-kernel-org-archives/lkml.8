Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62609C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E39F2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947628;
	bh=7t6CfnVzOeadJbe0Kdv99c49zQUwFDZsr9J9sUyQwFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gjkQ5VHq+S2tBwncqaLunfunee5Zhlotcyr/qgjqzygx5sqEfRvEZnflPrG298ppk
	 Q5ruV0cGaS45OHQGIn3m3ThcEWN6dpGuaEzDGkD+gof5Z+MPJmgVcugt+9L/VpRycX
	 I8dxHqF6VlGWxJPO8fuuqT8GLWlAapgaO7DC5U9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389532AbgFWURT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387797AbgFWURM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:17:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B059920E65;
        Tue, 23 Jun 2020 20:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943432;
        bh=7t6CfnVzOeadJbe0Kdv99c49zQUwFDZsr9J9sUyQwFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wxiZVt2X2oxtsiWGVgxx36A8+9VwEeYOYlntFHQuYsxre/rjsMH/A6LT7BXRJSSwE
         TRL1oRfUaeRaGwmf/JNuiPCTIpCKIKH3K9b2Lrh0ulzim5DXc5t7rguXDEcLytdW4Q
         gW7L4iXprG7Muz7Hqmc66pnRGPFi5YT0yf4MhREA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 389/477] crypto: hisilicon - Cap block size at 2^31
Date:   Tue, 23 Jun 2020 21:56:26 +0200
Message-Id: <20200623195425.918956155@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit c61e5644c69775ae9d54b86018fca238aca64a9b ]

The function hisi_acc_create_sg_pool may allocate a block of
memory of size PAGE_SIZE * 2^(MAX_ORDER - 1).  This value may
exceed 2^31 on ia64, which would overflow the u32.

This patch caps it at 2^31.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: d8ac7b85236b ("crypto: hisilicon - fix large sgl memory...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/sgl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index 0e8c7e324fb46..725a739800b0a 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -66,7 +66,8 @@ struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(struct device *dev,
 
 	sgl_size = sizeof(struct acc_hw_sge) * sge_nr +
 		   sizeof(struct hisi_acc_hw_sgl);
-	block_size = PAGE_SIZE * (1 << (MAX_ORDER - 1));
+	block_size = 1 << (PAGE_SHIFT + MAX_ORDER <= 32 ?
+			   PAGE_SHIFT + MAX_ORDER - 1 : 31);
 	sgl_num_per_block = block_size / sgl_size;
 	block_num = count / sgl_num_per_block;
 	remain_sgl = count % sgl_num_per_block;
-- 
2.25.1



