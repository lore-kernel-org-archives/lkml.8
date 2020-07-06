Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97933C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E5520656
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VObl7bdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgGFRhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729664AbgGFRhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:37:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AC6C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 10:37:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so30766376wrl.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ywc94FIaRPO4JeU4K3lQ0cL9XN8cMYmJQ0Geq/1V8ls=;
        b=VObl7bdGP2LQk0NxPQJZohPRM0/JsUT0pSJDgr+vg2fggFophBuBUzpVZ/4FPOrBE/
         74mYw3FDJk2gm5Ut+PSEHZQePk9grkeNKr+SD6FonBPvLS0Zy8wDzvheG9jsfm04rG6T
         8ft+cAvf/EXgSj5cT4DKGClS3IgBHhiE8Q6ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ywc94FIaRPO4JeU4K3lQ0cL9XN8cMYmJQ0Geq/1V8ls=;
        b=B63+8fgPX98FXO/js9+CIwKKrmT9VdLzOPrIFgxXzNW+Gv0Xqg7CxU9sCFqgEguT4j
         MxzY1K2AC6A1Y36/GA8ZZD4IKVaQ6C6LYL1PeSjPzSTkldxqihCFa0m95HoiSiovxr1P
         FTTZ/6JC7eokt7L5uH2GAdvzKWoqu8V7yMl/rngQZ+J5ctTRjliUqtY5K0ALPUX7/Ntt
         gc6a/iRoviEtWLrU2ChT22p9ysH8UKcMMhUoY0vMSnDTgMOjHNmC32xcOtB6drtyrKPR
         qCMlOIMExVIgxDfTSRo8qh1/WpZE+7d31EGffdciR+3GvcU2Uy2CFE12XGEzzxxHsXiY
         grOg==
X-Gm-Message-State: AOAM532WyIaeY4DE58QJshhkKvya9fsPZJ1ybdFVNxjp8pWTsekmeaMo
        bDWGry2BNZdf3gCV0zNU/hfM0A==
X-Google-Smtp-Source: ABdhPJwfoh4vKO10FZo9PkLQ4wYJ+AxF8uopDJoMP+GbbXrCYNSn451efWNplLpO/962WZfN9PlEKQ==
X-Received: by 2002:a5d:4d0b:: with SMTP id z11mr20382495wrt.24.1594057065821;
        Mon, 06 Jul 2020 10:37:45 -0700 (PDT)
Received: from localhost.localdomain (88-144-169-139.host.pobb.as13285.net. [88.144.169.139])
        by smtp.gmail.com with ESMTPSA id 59sm25875414wrj.37.2020.07.06.10.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:37:45 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        dm-crypt@saout.de, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, ebiggers@kernel.org,
        Damien.LeMoal@wdc.com, mpatocka@redhat.com,
        herbert@gondor.apana.org.au, kernel-team@cloudflare.com,
        nobuto.murata@canonical.com, bob.liu@oracle.com
Subject: [PATCH v3] dm crypt: add flags to optionally bypass dm-crypt workqueues
Date:   Mon,  6 Jul 2020 18:37:31 +0100
Message-Id: <20200706173731.3734-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v2:
  * dropped nobacklog boolean - ciphers are OK to backlog requests
  * moved some conditionals inline dropping the extra local variables
  * renamed "noresched" -> "atomic"

This is a follow up from [1]. Consider the following script:

sudo modprobe brd rd_nr=1 rd_size=4194304

echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0' | \
sudo dmsetup create eram0

echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0 1 no_write_workqueue' | \
sudo dmsetup create eram0-inline-write

echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0 1 no_read_workqueue' | \
sudo dmsetup create eram0-inline-read

devices="/dev/ram0 /dev/mapper/eram0 /dev/mapper/eram0-inline-read "
devices+="/dev/mapper/eram0-inline-write"

for dev in $devices; do
  echo "reading from $dev"
  sudo fio --filename=$dev --readwrite=read --bs=4k --direct=1 \
  --loops=1000000 --runtime=3m --name=plain | grep READ
done

for dev in $devices; do
  echo "writing to $dev"
  sudo fio --filename=$dev --readwrite=write --bs=4k --direct=1 \
  --loops=1000000 --runtime=3m --name=plain | grep WRITE
done

This script creates a ramdisk (to eliminate hardware bias in the benchmark) and
three dm-crypt instances on top. All dm-crypt instances use the NULL cipher
to eliminate potentially expensive crypto bias (the NULL cipher just uses memcpy
for "encyption"). The first instance is the current dm-crypt implementation from
5.8-rc2, the two others have new optional flags enabled, which bypass kcryptd
workqueues for reads and writes respectively and write sorting for writes. On
my VM (Debian in VirtualBox with 4 cores on 2.8 GHz Quad-Core Intel Core i7) I
get the following output (formatted for better readability):

reading from /dev/ram0
   READ: bw=508MiB/s (533MB/s), 508MiB/s-508MiB/s (533MB/s-533MB/s), io=89.3GiB (95.9GB), run=180000-180000msec

reading from /dev/mapper/eram0
   READ: bw=80.6MiB/s (84.5MB/s), 80.6MiB/s-80.6MiB/s (84.5MB/s-84.5MB/s), io=14.2GiB (15.2GB), run=180000-180000msec

reading from /dev/mapper/eram0-inline-read
   READ: bw=295MiB/s (309MB/s), 295MiB/s-295MiB/s (309MB/s-309MB/s), io=51.8GiB (55.6GB), run=180000-180000msec

reading from /dev/mapper/eram0-inline-write
   READ: bw=114MiB/s (120MB/s), 114MiB/s-114MiB/s (120MB/s-120MB/s), io=20.1GiB (21.5GB), run=180000-180000msec

writing to /dev/ram0
  WRITE: bw=516MiB/s (541MB/s), 516MiB/s-516MiB/s (541MB/s-541MB/s), io=90.7GiB (97.4GB), run=180001-180001msec

writing to /dev/mapper/eram0
  WRITE: bw=40.4MiB/s (42.4MB/s), 40.4MiB/s-40.4MiB/s (42.4MB/s-42.4MB/s), io=7271MiB (7624MB), run=180001-180001msec

writing to /dev/mapper/eram0-inline-read
  WRITE: bw=38.9MiB/s (40.8MB/s), 38.9MiB/s-38.9MiB/s (40.8MB/s-40.8MB/s), io=7000MiB (7340MB), run=180001-180001msec

writing to /dev/mapper/eram0-inline-write
  WRITE: bw=277MiB/s (290MB/s), 277MiB/s-277MiB/s (290MB/s-290MB/s), io=48.6GiB (52.2GB), run=180000-180000msec

Current dm-crypt implementation creates a significant IO performance overhead
(at least on small IO block sizes) for both latency and throughput. We suspect
offloading IO request processing into workqueues and async threads is more
harmful these days with the modern fast storage. I also did some digging into
the dm-crypt git history and much of this async processing is not needed
anymore, because the reasons it was added are mostly gone from the kernel. More
details can be found in [2] (see "Git archeology" section).

This change adds no_(read|write)_workqueue flags separately for read and write
BIOs, which direct dm-crypt not to offload crypto operations into kcryptd
workqueues and process everything inline. In addition, writes are not buffered
to be sorted in the dm-crypt red-black tree, but dispatched immediately. For
cases, where crypto operations cannot happen inline (hard interrupt context,
for example the read path of some NVME drivers), we offload the work to a
tasklet rather than a workqueue.

These flags ensure inline BIO processing in the dm-crypt module only. It is
worth noting that some Crypto API implementations may offload encryption into
their own workqueues, which are independent of the dm-crypt and its
configuration. However upon enabling no_(read|write)_workqueue flags dm-crypt
will instruct Crypto API not to backlog crypto requests.

[1]: https://www.spinics.net/lists/dm-crypt/msg07516.html
[2]: https://blog.cloudflare.com/speeding-up-linux-disk-encryption/

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 drivers/md/dm-crypt.c | 50 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 000ddfab5ba0..7536ecb2c95d 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -69,6 +69,7 @@ struct dm_crypt_io {
 	u8 *integrity_metadata;
 	bool integrity_metadata_from_pool;
 	struct work_struct work;
+	struct tasklet_struct tasklet;
 
 	struct convert_context ctx;
 
@@ -127,7 +128,8 @@ struct iv_elephant_private {
  * and encrypts / decrypts at the same time.
  */
 enum flags { DM_CRYPT_SUSPENDED, DM_CRYPT_KEY_VALID,
-	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD };
+	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD,
+	     DM_CRYPT_NO_READ_WORKQUEUE, DM_CRYPT_NO_WRITE_WORKQUEUE };
 
 enum cipher_flags {
 	CRYPT_MODE_INTEGRITY_AEAD,	/* Use authenticated mode for cihper */
@@ -1523,7 +1525,7 @@ static void crypt_free_req(struct crypt_config *cc, void *req, struct bio *base_
  * Encrypt / decrypt data from one bio to another one (can be the same one)
  */
 static blk_status_t crypt_convert(struct crypt_config *cc,
-			 struct convert_context *ctx)
+			 struct convert_context *ctx, bool atomic)
 {
 	unsigned int tag_offset = 0;
 	unsigned int sector_step = cc->sector_size >> SECTOR_SHIFT;
@@ -1566,7 +1568,8 @@ static blk_status_t crypt_convert(struct crypt_config *cc,
 			atomic_dec(&ctx->cc_pending);
 			ctx->cc_sector += sector_step;
 			tag_offset++;
-			cond_resched();
+			if (!atomic)
+				cond_resched();
 			continue;
 		/*
 		 * There was a data integrity error.
@@ -1892,7 +1895,8 @@ static void kcryptd_crypt_write_io_submit(struct dm_crypt_io *io, int async)
 
 	clone->bi_iter.bi_sector = cc->start + io->sector;
 
-	if (likely(!async) && test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags)) {
+	if ((likely(!async) && test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags)) ||
+	    test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags)) {
 		generic_make_request(clone);
 		return;
 	}
@@ -1941,7 +1945,8 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 	sector += bio_sectors(clone);
 
 	crypt_inc_pending(io);
-	r = crypt_convert(cc, &io->ctx);
+	r = crypt_convert(cc, &io->ctx,
+			  test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags));
 	if (r)
 		io->error = r;
 	crypt_finished = atomic_dec_and_test(&io->ctx.cc_pending);
@@ -1971,7 +1976,8 @@ static void kcryptd_crypt_read_convert(struct dm_crypt_io *io)
 	crypt_convert_init(cc, &io->ctx, io->base_bio, io->base_bio,
 			   io->sector);
 
-	r = crypt_convert(cc, &io->ctx);
+	r = crypt_convert(cc, &io->ctx,
+			  test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags));
 	if (r)
 		io->error = r;
 
@@ -2031,10 +2037,28 @@ static void kcryptd_crypt(struct work_struct *work)
 		kcryptd_crypt_write_convert(io);
 }
 
+static void kcryptd_crypt_tasklet(unsigned long work)
+{
+	kcryptd_crypt((struct work_struct *)work);
+}
+
 static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 {
 	struct crypt_config *cc = io->cc;
 
+	if ((bio_data_dir(io->base_bio) == READ && test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags)) ||
+	    (bio_data_dir(io->base_bio) == WRITE && test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))) {
+		if (in_irq()) {
+			/* Crypto API's "skcipher_walk_first() refuses to work in hard IRQ context */
+			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
+			tasklet_schedule(&io->tasklet);
+			return;
+		}
+
+		kcryptd_crypt(&io->work);
+		return;
+	}
+
 	INIT_WORK(&io->work, kcryptd_crypt);
 	queue_work(cc->crypt_queue, &io->work);
 }
@@ -2838,7 +2862,7 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
 	struct crypt_config *cc = ti->private;
 	struct dm_arg_set as;
 	static const struct dm_arg _args[] = {
-		{0, 6, "Invalid number of feature args"},
+		{0, 8, "Invalid number of feature args"},
 	};
 	unsigned int opt_params, val;
 	const char *opt_string, *sval;
@@ -2868,6 +2892,10 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
 
 		else if (!strcasecmp(opt_string, "submit_from_crypt_cpus"))
 			set_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags);
+		else if (!strcasecmp(opt_string, "no_read_workqueue"))
+			set_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags);
+		else if (!strcasecmp(opt_string, "no_write_workqueue"))
+			set_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);
 		else if (sscanf(opt_string, "integrity:%u:", &val) == 1) {
 			if (val == 0 || val > MAX_TAG_SIZE) {
 				ti->error = "Invalid integrity arguments";
@@ -3196,6 +3224,8 @@ static void crypt_status(struct dm_target *ti, status_type_t type,
 		num_feature_args += !!ti->num_discard_bios;
 		num_feature_args += test_bit(DM_CRYPT_SAME_CPU, &cc->flags);
 		num_feature_args += test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags);
+		num_feature_args += test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags);
+		num_feature_args += test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);
 		num_feature_args += cc->sector_size != (1 << SECTOR_SHIFT);
 		num_feature_args += test_bit(CRYPT_IV_LARGE_SECTORS, &cc->cipher_flags);
 		if (cc->on_disk_tag_size)
@@ -3208,6 +3238,10 @@ static void crypt_status(struct dm_target *ti, status_type_t type,
 				DMEMIT(" same_cpu_crypt");
 			if (test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags))
 				DMEMIT(" submit_from_crypt_cpus");
+			if (test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags))
+				DMEMIT(" no_read_workqueue");
+			if (test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))
+				DMEMIT(" no_write_workqueue");
 			if (cc->on_disk_tag_size)
 				DMEMIT(" integrity:%u:%s", cc->on_disk_tag_size, cc->cipher_auth);
 			if (cc->sector_size != (1 << SECTOR_SHIFT))
@@ -3320,7 +3354,7 @@ static void crypt_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 static struct target_type crypt_target = {
 	.name   = "crypt",
-	.version = {1, 21, 0},
+	.version = {1, 22, 0},
 	.module = THIS_MODULE,
 	.ctr    = crypt_ctr,
 	.dtr    = crypt_dtr,
-- 
2.20.1

