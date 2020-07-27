Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4221DC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC872073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hm74B84F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgG0QIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730853AbgG0QH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:07:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2CCC061794;
        Mon, 27 Jul 2020 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ET8ge25B/3xdyn220GmjQpe18xhraMf83CX/rWioRr8=; b=hm74B84F3xA+4pL0lGJjlDcoe8
        ZiVUeAXBU4bI6JUlo6c8aU3xf8xS+ki3wrQZbYIMVIEh9ZPHDog12z++I+dky4hBBKrlFq8u86yHs
        zNxCVynvQxMDqgKoKAeqJinK1h3Yij34p/GEeFguxQQ4tQnfaHU13XSwKORjIPxGF9N+IEzl/37yS
        BBUHayA1uqlkiUVihsRBfBo6W6kJ+3/YGfDXioIl5KXdJQGjdi1Bjhd8undpR+USLMl5SIfomDhWl
        4SMrqUhzKoVrzfnvemfIttxsjmwLRIQLMv4nHPJdgrAGipFbJ4tlq/5IF2yBbw7YNF4dvCqc23Twg
        Qefdn8Xw==;
Received: from [2001:4bb8:18c:2acc:aa45:8411:1fb3:30ec] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k05fP-0002mn-Jh; Mon, 27 Jul 2020 16:07:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] initd: pass a non-f_pos offset to kernel_read/kernel_write
Date:   Mon, 27 Jul 2020 18:07:44 +0200
Message-Id: <20200727160744.329121-4-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727160744.329121-1-hch@lst.de>
References: <20200727160744.329121-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass an explicit offset instead of ->f_pos, and to make that easier use
file scope file structs and offsets everywhere except for
identify_ramdisk_image instead of the current strange mix.  This also
fixes the fact that identify_ramdisk_image fails to reset the file
position to the rd_image_start parameter instead of the default 0.

Fixes: 18468d879596 ("initrd: switch initrd loading to struct file based APIs")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts_rd.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 8307fdb5d136b8..d4255c10432a8b 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -14,6 +14,8 @@
 
 #include <linux/decompress/generic.h>
 
+static struct file *in_file, *out_file;
+static loff_t in_pos, out_pos;
 
 static int __init prompt_ramdisk(char *str)
 {
@@ -31,8 +33,7 @@ static int __init ramdisk_start_setup(char *str)
 }
 __setup("ramdisk_start=", ramdisk_start_setup);
 
-static int __init crd_load(struct file *in_file, struct file *out_file,
-		decompress_fn deco);
+static int __init crd_load(decompress_fn deco);
 
 /*
  * This routine tries to find a RAM disk image to load, and returns the
@@ -54,7 +55,7 @@ static int __init crd_load(struct file *in_file, struct file *out_file,
  *	lz4
  */
 static int __init
-identify_ramdisk_image(struct file *file, int start_block,
+identify_ramdisk_image(struct file *file, loff_t pos,
 		decompress_fn *decompressor)
 {
 	const int size = 512;
@@ -66,7 +67,7 @@ identify_ramdisk_image(struct file *file, int start_block,
 	unsigned char *buf;
 	const char *compress_name;
 	unsigned long n;
-	loff_t pos;
+	int start_block = rd_image_start;
 
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
@@ -185,7 +186,6 @@ static unsigned long nr_blocks(struct file *file)
 int __init rd_load_image(char *from)
 {
 	int res = 0;
-	struct file *in_file, *out_file;
 	unsigned long rd_blocks, devblocks;
 	int nblocks, i;
 	char *buf = NULL;
@@ -203,12 +203,13 @@ int __init rd_load_image(char *from)
 	if (IS_ERR(in_file))
 		goto noclose_input;
 
-	nblocks = identify_ramdisk_image(in_file, rd_image_start, &decompressor);
+	in_pos = rd_image_start * BLOCK_SIZE;
+	nblocks = identify_ramdisk_image(in_file, in_pos, &decompressor);
 	if (nblocks < 0)
 		goto done;
 
 	if (nblocks == 0) {
-		if (crd_load(in_file, out_file, decompressor) == 0)
+		if (crd_load(decompressor) == 0)
 			goto successful_load;
 		goto done;
 	}
@@ -252,8 +253,8 @@ int __init rd_load_image(char *from)
 			fput(in_file);
 			break;
 		}
-		kernel_read(in_file, buf, BLOCK_SIZE, &in_file->f_pos);
-		kernel_write(out_file, buf, BLOCK_SIZE, &out_file->f_pos);
+		kernel_read(in_file, buf, BLOCK_SIZE, &in_pos);
+		kernel_write(out_file, buf, BLOCK_SIZE, &out_pos);
 #if !defined(CONFIG_S390)
 		if (!(i % 16)) {
 			pr_cont("%c\b", rotator[rotate & 0x3]);
@@ -284,11 +285,10 @@ int __init rd_load_disk(int n)
 
 static int exit_code;
 static int decompress_error;
-static struct file *crd_infile, *crd_outfile;
 
 static long __init compr_fill(void *buf, unsigned long len)
 {
-	long r = kernel_read(crd_infile, buf, len, &crd_infile->f_pos);
+	long r = kernel_read(in_file, buf, len, &in_pos);
 	if (r < 0)
 		printk(KERN_ERR "RAMDISK: error while reading compressed data");
 	else if (r == 0)
@@ -298,7 +298,7 @@ static long __init compr_fill(void *buf, unsigned long len)
 
 static long __init compr_flush(void *window, unsigned long outcnt)
 {
-	long written = kernel_write(crd_outfile, window, outcnt, &crd_outfile->f_pos);
+	long written = kernel_write(out_file, window, outcnt, &out_pos);
 	if (written != outcnt) {
 		if (decompress_error == 0)
 			printk(KERN_ERR
@@ -317,12 +317,9 @@ static void __init error(char *x)
 	decompress_error = 1;
 }
 
-static int __init crd_load(struct file *in_file, struct file *out_file,
-		decompress_fn deco)
+static int __init crd_load(decompress_fn deco)
 {
 	int result;
-	crd_infile = in_file;
-	crd_outfile = out_file;
 
 	if (!deco) {
 		pr_emerg("Invalid ramdisk decompression routine.  "
-- 
2.27.0

