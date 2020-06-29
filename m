Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CFFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308AB2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459870;
	bh=NbIIanRtOQq4orleKOc5/qazWwvR7o3ndILm16qvPZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PCs4DaE3sg02WgfXZWF8N0taw6yJGb1AJ8Snb7mi6U9b1pZ6xKVw0M9sFcTo3K1+R
	 3Du1EeNaYWpT34teVuU00NEOTkKKOI3n68doLsywPXbYMSGd+aO1fhxnayHp/GI0QE
	 PldSzkhvCdsYjJ3wnqjP6Z18DBEqeOfrXe88zp80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbgF2To2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387842AbgF2Tkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40C0A24801;
        Mon, 29 Jun 2020 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444327;
        bh=NbIIanRtOQq4orleKOc5/qazWwvR7o3ndILm16qvPZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ilP09Z4xeKf6zQt/Kzs6SQYpSA6iiCNtLvk9gc1onS2BlBOOXkSgh96XU7EP0NhLa
         bNxoZe9i1G9XrxRs2FqNnvNEaM7lKVun7sq0LIC2bc1DV7KVSn14OcpYftf0Ukwxa3
         fqz6PDZGdybJge8aAJAlF4cE/5LlST9Eeq4ey8Sc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yu kuai <yukuai3@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        Bob Liu <bob.liu@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4 001/178] block/bio-integrity: don't free 'buf' if bio_integrity_add_page() failed
Date:   Mon, 29 Jun 2020 11:22:26 -0400
Message-Id: <20200629152523.2494198-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yu kuai <yukuai3@huawei.com>

commit a75ca9303175d36af93c0937dd9b1a6422908b8d upstream.

commit e7bf90e5afe3 ("block/bio-integrity: fix a memory leak bug") added
a kfree() for 'buf' if bio_integrity_add_page() returns '0'. However,
the object will be freed in bio_integrity_free() since 'bio->bi_opf' and
'bio->bi_integrity' were set previousy in bio_integrity_alloc().

Fixes: commit e7bf90e5afe3 ("block/bio-integrity: fix a memory leak bug")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Bob Liu <bob.liu@oracle.com>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/bio-integrity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index bf62c25cde8f4..ae07dd78e9518 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -278,7 +278,6 @@ bool bio_integrity_prep(struct bio *bio)
 
 		if (ret == 0) {
 			printk(KERN_ERR "could not attach integrity payload\n");
-			kfree(buf);
 			status = BLK_STS_RESOURCE;
 			goto err_end_io;
 		}
-- 
2.25.1

