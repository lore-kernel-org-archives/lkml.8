Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E08C433E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C543206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034689;
	bh=M1Fe7yGsnThBEbaLs1mNNRD4/sdQ9gHFLRjOaS6lX5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MmIJDKxdhmMZglInIZqDvyXIVbNKRPf3dmmED7dW9I3KeqVOuXIq28zqR4W8ZXVES
	 jYPcuLisPVgB/FSVSsLKs4GaExLg3A1l28g+TICW894klLMwbJz23EID6CGC0LDr47
	 J8xIDKEtU8KYyV9PtVwQ4RRyOQXhpKB6Zs/PQtRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgFASEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730177AbgFASE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:04:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 805B9207D0;
        Mon,  1 Jun 2020 18:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034667;
        bh=M1Fe7yGsnThBEbaLs1mNNRD4/sdQ9gHFLRjOaS6lX5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4pG9Aqq8SvGnFn5fiqch5XLN6ToltUl+pFZNefHGGaKBSRgow+jRsSRL3dDeG1mB
         TXr1ZNBhlp9dJK+8B64Q8HF5XAkSOGCb6Gj2PYCNDEkhtubS1Ny/OnosJHNPTICzHT
         ilSmUTtq/K5Djv2LyyQ2r4q94TAQ9IvCHw/3Oa9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Hao <richard.peng@oppo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 55/95] mmc: block: Fix use-after-free issue for rpmb
Date:   Mon,  1 Jun 2020 19:53:55 +0200
Message-Id: <20200601174029.980447276@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
References: <20200601174020.759151073@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Hao <richard.peng@oppo.com>

[ Upstream commit 202500d21654874aa03243e91f96de153ec61860 ]

The data structure member “rpmb->md” was passed to a call of the function
“mmc_blk_put” after a call of the function “put_device”. Reorder these
function calls to keep the data accesses consistent.

Fixes: 1c87f7357849 ("mmc: block: Fix bug when removing RPMB chardev ")
Signed-off-by: Peng Hao <richard.peng@oppo.com>
Cc: stable@vger.kernel.org
[Uffe: Fixed up mangled patch and updated commit message]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 23bcdbba0cab..c723a1e54b18 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2485,8 +2485,8 @@ static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *filp)
 	struct mmc_rpmb_data *rpmb = container_of(inode->i_cdev,
 						  struct mmc_rpmb_data, chrdev);
 
-	put_device(&rpmb->dev);
 	mmc_blk_put(rpmb->md);
+	put_device(&rpmb->dev);
 
 	return 0;
 }
-- 
2.25.1



