Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2604AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012FE2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597931234;
	bh=WJtNSK4pv5uIhC9z3Z7nMGZZvveJHPS/F+plOYWvYQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YCELpQHDUwwDNGIRw1E6ictrjk9Ohrc2CdutXvcNtZRdGD+4GV6ilSQOGxRpLuNie
	 PKFAo5hkux0WY8AM0/SyzkQ1t11kxvHvzg8cjxZ/JYZPV5pHIh/YjX8KrYzoyZ94XG
	 8joqkr6X3wret4z/o81MEocH5+76aI2QBhru5740=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgHTNpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbgHTJ2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:28:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3287922D00;
        Thu, 20 Aug 2020 09:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915680;
        bh=WJtNSK4pv5uIhC9z3Z7nMGZZvveJHPS/F+plOYWvYQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mZ7nVARnfQkTSXK+Tng0faplPM5IHUZmckzoWy/sSVRbEf+eH0rPSHGiEkGszSDeL
         H82PAA24Z2XeFIBoVAqwsPdUaED5Zd4Zwg19/xRB1jbVuJfhRahIJnw/YJbb1Yjjd3
         65eoLvGP/tC0Q2kFgqzeOuJBfq+qG9oFA5dAid54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.8 068/232] bcache: fix bio_{start,end}_io_acct with proper device
Date:   Thu, 20 Aug 2020 11:18:39 +0200
Message-Id: <20200820091616.091480552@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

commit a2f32ee8fd853cec8860f883d98afc3a339546de upstream.

Commit 85750aeb748f ("bcache: use bio_{start,end}_io_acct") moves the
io account code to the location after bio_set_dev(bio, dc->bdev) in
cached_dev_make_request(). Then the account is performed incorrectly on
backing device, indeed the I/O should be counted to bcache device like
/dev/bcache0.

With the mistaken I/O account, iostat does not display I/O counts for
bcache device and all the numbers go to backing device. In writeback
mode, the hard drive may have 340K+ IOPS which is impossible and wrong
for spinning disk.

This patch introduces bch_bio_start_io_acct() and bch_bio_end_io_acct(),
which switches bio->bi_disk to bcache device before calling
bio_start_io_acct() or bio_end_io_acct(). Now the I/Os are counted to
bcache device, and bcache device, cache device and backing device have
their correct I/O count information back.

Fixes: 85750aeb748f ("bcache: use bio_{start,end}_io_acct")
Signed-off-by: Coly Li <colyli@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/request.c |   31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -617,6 +617,28 @@ static void cache_lookup(struct closure
 
 /* Common code for the make_request functions */
 
+static inline void bch_bio_start_io_acct(struct gendisk *acct_bi_disk,
+					 struct bio *bio,
+					 unsigned long *start_time)
+{
+	struct gendisk *saved_bi_disk = bio->bi_disk;
+
+	bio->bi_disk = acct_bi_disk;
+	*start_time = bio_start_io_acct(bio);
+	bio->bi_disk = saved_bi_disk;
+}
+
+static inline void bch_bio_end_io_acct(struct gendisk *acct_bi_disk,
+				       struct bio *bio,
+				       unsigned long start_time)
+{
+	struct gendisk *saved_bi_disk = bio->bi_disk;
+
+	bio->bi_disk = acct_bi_disk;
+	bio_end_io_acct(bio, start_time);
+	bio->bi_disk = saved_bi_disk;
+}
+
 static void request_endio(struct bio *bio)
 {
 	struct closure *cl = bio->bi_private;
@@ -668,7 +690,7 @@ static void backing_request_endio(struct
 static void bio_complete(struct search *s)
 {
 	if (s->orig_bio) {
-		bio_end_io_acct(s->orig_bio, s->start_time);
+		bch_bio_end_io_acct(s->d->disk, s->orig_bio, s->start_time);
 		trace_bcache_request_end(s->d, s->orig_bio);
 		s->orig_bio->bi_status = s->iop.status;
 		bio_endio(s->orig_bio);
@@ -728,7 +750,7 @@ static inline struct search *search_allo
 	s->recoverable		= 1;
 	s->write		= op_is_write(bio_op(bio));
 	s->read_dirty_data	= 0;
-	s->start_time		= bio_start_io_acct(bio);
+	bch_bio_start_io_acct(d->disk, bio, &s->start_time);
 
 	s->iop.c		= d->c;
 	s->iop.bio		= NULL;
@@ -1080,7 +1102,7 @@ static void detached_dev_end_io(struct b
 	bio->bi_end_io = ddip->bi_end_io;
 	bio->bi_private = ddip->bi_private;
 
-	bio_end_io_acct(bio, ddip->start_time);
+	bch_bio_end_io_acct(ddip->d->disk, bio, ddip->start_time);
 
 	if (bio->bi_status) {
 		struct cached_dev *dc = container_of(ddip->d,
@@ -1105,7 +1127,8 @@ static void detached_dev_do_request(stru
 	 */
 	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
 	ddip->d = d;
-	ddip->start_time = bio_start_io_acct(bio);
+	bch_bio_start_io_acct(d->disk, bio, &ddip->start_time);
+
 	ddip->bi_end_io = bio->bi_end_io;
 	ddip->bi_private = bio->bi_private;
 	bio->bi_end_io = detached_dev_end_io;


