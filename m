Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9F2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0FE622B43
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258414;
	bh=3Lblky5qdJxW2bTod3JWKV1FyqeA2Uw3AKWhieYVlac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=chQTRxajZbNSClAKMndzt2GN0tT1pzte7o4uZGZHxCDo1Xz1QOb+UvtIq87B1I+aR
	 8RhfgbJq1pn4UmK2/WzXegBS532W5uyExBxQ2bbOWhkdM/WJi1HEFrOKyFoo1inkUh
	 tVq8Lm2W/YQFmICfLQipFQOXY/OFqM327tsaI9EI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgHXIkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbgHXIkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:40:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2DF022B43;
        Mon, 24 Aug 2020 08:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258402;
        bh=3Lblky5qdJxW2bTod3JWKV1FyqeA2Uw3AKWhieYVlac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hy+StDCkoPlVL2rXCROCdzsucy/10xvk9nk3y1IAxd7vVNQB8cyig/pCwWIu3fyZN
         HUKFrZFdd6HGewECbRKor6ftuMmmg2136x/gk0a4ppyog8NMPAqaVewzWFb82S58px
         uS2Waqqsd6Qw8pocndwmAv2mqdcv+Pjz1VJ/ExqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        Ken Raeburn <raeburn@redhat.com>
Subject: [PATCH 5.7 005/124] bcache: avoid nr_stripes overflow in bcache_device_init()
Date:   Mon, 24 Aug 2020 10:28:59 +0200
Message-Id: <20200824082409.656708838@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
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
index b4d23d9f30f9b..d5477faa14edd 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -825,19 +825,19 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
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



