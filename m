Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FAEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91F824654
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697029;
	bh=HhQ4HBxToqOlP2WfNDtZs5pT2ABW7zoq0eEpp6vCOrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KLp47tJMfOB9VdfczA2aDpfSl+z0BMXvTxdh1wGQi1MFo8Gq9y2c1dh2dxiu+XMe2
	 MshzHhRdpm84B/utsAogSvyaKzc2bJiw6Kff+eXdpn1ag5ElGS0SGbwuHTJFB3PrQU
	 X0GxfRnugZMyPGcY5ojW7CE20UwC3TMh9L/wGBKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404140AbgBNQRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:17:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392272AbgBNQQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:16:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEAA724682;
        Fri, 14 Feb 2020 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696974;
        bh=HhQ4HBxToqOlP2WfNDtZs5pT2ABW7zoq0eEpp6vCOrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OaUB5xaSsYhWBWrmP2rS6oMk5PihM8O4/oZ2Es7Xjx4KtvDk/mHfljMYtd3D5zABY
         MuoOF3F4wwYrMB+HZ+jusUDr5Y32HzRxlVUCSV4k2toGYR9/5zWiDSesBpfdl9Dwx6
         zOVMObgFPVDVQJcQAeMqW/wbdLDpyRVl+gK8Lmc4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liang Chen <liangchen.linux@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 212/252] bcache: cached_dev_free needs to put the sb page
Date:   Fri, 14 Feb 2020 11:11:07 -0500
Message-Id: <20200214161147.15842-212-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <liangchen.linux@gmail.com>

[ Upstream commit e8547d42095e58bee658f00fef8e33d2a185c927 ]

Same as cache device, the buffer page needs to be put while
freeing cached_dev.  Otherwise a page would be leaked every
time a cached_dev is stopped.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index c45d9ad010770..5b5cbfadd003d 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1226,6 +1226,9 @@ static void cached_dev_free(struct closure *cl)
 
 	mutex_unlock(&bch_register_lock);
 
+	if (dc->sb_bio.bi_inline_vecs[0].bv_page)
+		put_page(bio_first_page_all(&dc->sb_bio));
+
 	if (!IS_ERR_OR_NULL(dc->bdev))
 		blkdev_put(dc->bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
 
-- 
2.20.1

