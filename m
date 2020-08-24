Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620F9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4612071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262116;
	bh=GUcQ59NfnXbMNVFyQ/W0frB3t2MHlmxFmSsrO9JQPPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WSA2C74uykulMTSN2SMWHqKJNTrifwLBtpDtvmr6QGYyZNk0+22scwOpeOB2Bn2wq
	 F02c9uItYNWVxLqbF7yAMJadJMkhP7OJgS9TTgApwhsKSxSWHCeprVXcqpOFc/tNaV
	 Q9RIzBx4J0MdPn6Hx8B6osnJnfGjim+jXFNEGyOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgHXJlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbgHXIpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:45:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF4D42075B;
        Mon, 24 Aug 2020 08:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258703;
        bh=GUcQ59NfnXbMNVFyQ/W0frB3t2MHlmxFmSsrO9JQPPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NADHID1xNl2yg5qPU6kp5H7+rleFSktAS4YSqg197ynh5Jd0/YAeD4KBf9VcGb/rt
         enwVg6SkJxF+rSmIAUxFVfAFwj2yB6cOMHAyoZzGJ0ta1FukQp0Nhw29+w3DqKpFkS
         x82q3vwoKOyTdQWmJeI6OunbCMeeY7oDLRoFLHg8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        Ken Raeburn <raeburn@redhat.com>
Subject: [PATCH 5.4 016/107] bcache: avoid nr_stripes overflow in bcache_device_init()
Date:   Mon, 24 Aug 2020 10:29:42 +0200
Message-Id: <20200824082405.873298452@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

[ Upstream commit 65f0f017e7be8c70330372df23bcb2a407ecf02d ]

For some block devices which large capacity (e.g. 8TB) but small io_opt
size (e.g. 8 sectors), in bcache_device_init() the stripes number calcu-
lated by,
	DIV_ROUND_UP_ULL(sectors, d->stripe_size);
might be overflow to the unsigned int bcache_device->nr_stripes.

This patch uses the uint64_t variable to store DIV_ROUND_UP_ULL()
and after the value is checked to be available in unsigned int range,
sets it to bache_device->nr_stripes. Then the overflow is avoided.

Reported-and-tested-by: Ken Raeburn <raeburn@redhat.com>
Signed-off-by: Coly Li <colyli@suse.de>
Cc: stable@vger.kernel.org
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1783075
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/super.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 25ad64a3919f6..2cbfcd99b7ee7 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -816,19 +816,19 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 	struct request_queue *q;
 	const size_t max_stripes = min_t(size_t, INT_MAX,
 					 SIZE_MAX / sizeof(atomic_t));
-	size_t n;
+	uint64_t n;
 	int idx;
 
 	if (!d->stripe_size)
 		d->stripe_size = 1 << 31;
 
-	d->nr_stripes = DIV_ROUND_UP_ULL(sectors, d->stripe_size);
-
-	if (!d->nr_stripes || d->nr_stripes > max_stripes) {
-		pr_err("nr_stripes too large or invalid: %u (start sector beyond end of disk?)",
-			(unsigned int)d->nr_stripes);
+	n = DIV_ROUND_UP_ULL(sectors, d->stripe_size);
+	if (!n || n > max_stripes) {
+		pr_err("nr_stripes too large or invalid: %llu (start sector beyond end of disk?)\n",
+			n);
 		return -ENOMEM;
 	}
+	d->nr_stripes = n;
 
 	n = d->nr_stripes * sizeof(atomic_t);
 	d->stripe_sectors_dirty = kvzalloc(n, GFP_KERNEL);
-- 
2.25.1



