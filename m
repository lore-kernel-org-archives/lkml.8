Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F91C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822F4204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976469;
	bh=bA9PSwe91VjezbPzPnYwKlcb18F3WiJas0TfmzVOtX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OkEtlgzI1itcLWJ7q39CTkH6ZuoNzXPN+gq9XGpbq80Kn1OCAcmBOrIRmnxZFiVyV
	 7eirkmRlqYn1QQageF4YbFpgLrRLTbDRcYUvIX4ecW4uSjeAL6fZoUHn0MxnG4GEZw
	 PO3/HpQJF19mKWiySfjZP/jvEnNwdVdcc4G7ECcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgIAQHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbgIAPjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:39:55 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF66A21534;
        Tue,  1 Sep 2020 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974795;
        bh=bA9PSwe91VjezbPzPnYwKlcb18F3WiJas0TfmzVOtX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEQTJQcGpuWnv32ufYrkRmQsRkE/ewnpy1cnImAM4m2P2lWvorHFEhsU/8z3M/ctz
         g50Aj/Q424NMDMJFikqRxIlVIF/BRICaEeF5Xzm+Gz0JQnFQ8z+Evn122/ep//ghuM
         +Jk19M+3Uy69riMiTlsdbrDrISI4BORgVMVPr7Jw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 094/255] nvmet: fix a memory leak
Date:   Tue,  1 Sep 2020 17:09:10 +0200
Message-Id: <20200901151005.230702290@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 382fee1a8b623e2546a3e15e80517389e0e0673e ]

We forgot to free new_model_number

Fixes: 013b7ebe5a0d ("nvmet: make ctrl model configurable")
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/configfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 419e0d4ce79b1..d84b935704a3d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1035,6 +1035,7 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
 	up_write(&nvmet_config_sem);
 
 	kfree_rcu(new_model, rcuhead);
+	kfree(new_model_number);
 
 	return count;
 }
-- 
2.25.1



