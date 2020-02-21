Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27285C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0F924689
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272979;
	bh=nO1lbYzeUI/0cN40Lb8FauXfvU/NcVzMBGSp7aObBl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jIcydlxvIDIjyNflFcpCXXgEVyNWWE9iYlpTNeo5q1WZT9vjLOlGfr/O7/4S/YbiL
	 RLcvEQHa46YBOZ7YX25LAnAciaiktAvk7FINn6fm9YCJoFOmMYCdWxzfviMwIMGy+F
	 WxWOVxpoTjPCOCKMJ7cmKSiCjlsvAxFM7lk3PuJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbgBUIQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387489AbgBUIQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:16:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34E9F2467B;
        Fri, 21 Feb 2020 08:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272969;
        bh=nO1lbYzeUI/0cN40Lb8FauXfvU/NcVzMBGSp7aObBl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zQxyDFZrMleRnfnuV4xF3jhMstt3Lc0MWV1h8X1bE6me0g/zcJnkMzSSAUmye6qr2
         7zjevxgEufcUbd8WdlVRKG1Ly1Jt0onyV2DISLSKcvZBtGtctKDTnixGFQ95uUsqR9
         pUiUxCnvufnYZMvRM2kQCzMhstLS7YQhN62sdUFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 344/344] bcache: properly initialize path and err in register_bcache()
Date:   Fri, 21 Feb 2020 08:42:23 +0100
Message-Id: <20200221072421.728892150@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

[ Upstream commit 29cda393bcaad160c4bf3676ddd99855adafc72f ]

Patch "bcache: rework error unwinding in register_bcache" from
Christoph Hellwig changes the local variables 'path' and 'err'
in undefined initial state. If the code in register_bcache() jumps
to label 'out:' or 'out_module_put:' by goto, these two variables
might be reference with undefined value by the following line,

	out_module_put:
	        module_put(THIS_MODULE);
	out:
	        pr_info("error %s: %s", path, err);
	        return ret;

Therefore this patch initializes these two local variables properly
in register_bcache() to avoid such issue.

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 485ebc2b2144c..658b0f4a01f56 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2373,18 +2373,20 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 			       const char *buffer, size_t size)
 {
 	const char *err;
-	char *path;
+	char *path = NULL;
 	struct cache_sb *sb;
 	struct block_device *bdev = NULL;
 	struct page *sb_page;
 	ssize_t ret;
 
 	ret = -EBUSY;
+	err = "failed to reference bcache module";
 	if (!try_module_get(THIS_MODULE))
 		goto out;
 
 	/* For latest state of bcache_is_reboot */
 	smp_mb();
+	err = "bcache is in reboot";
 	if (bcache_is_reboot)
 		goto out_module_put;
 
-- 
2.20.1



