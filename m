Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29964C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CDB2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgG0N25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:28:57 -0400
Received: from verein.lst.de ([213.95.11.211]:43507 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgG0N25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:28:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96A6F68C4E; Mon, 27 Jul 2020 15:28:55 +0200 (CEST)
Date:   Mon, 27 Jul 2020 15:28:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: bpfilter logging write errors in dmesg
Message-ID: <20200727132855.GA28165@lst.de>
References: <20200727104636.nuz3u4xb7ba7ue5a@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727104636.nuz3u4xb7ba7ue5a@wittgenstein>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 12:46:36PM +0200, Christian Brauner wrote:
> Hey Christoph,
> 
> Seems that commit
> 6955a76fbcd5 ("bpfilter: switch to kernel_write")
> causes bpfilter to spew these useless messages in dmesg?
> 
> [   26.356824] Started bpfilter
> [   26.357059] bpfilter: write fail -22
> [   26.396244] Started bpfilter
> [   26.396325] bpfilter: Loaded bpfilter_umh pid 637
> [   26.396542] bpfilter: write fail -22
> [   26.409588] bpfilter: Loaded bpfilter_umh pid 638
> [   26.410790] Started bpfilter
> [   26.410960] bpfilter: write fail -22
> [   26.445718] Started bpfilter
> [   26.445799] bpfilter: Loaded bpfilter_umh pid 640
> [   26.445983] bpfilter: write fail -22
> [   26.451122] bpfilter: read fail 0
> [   26.496497] bpfilter: Loaded bpfilter_umh pid 648
> [   26.497889] Started bpfilter
> [   26.750028] bpfilter: write fail -22
> [   26.768400] Started bpfilter
> [   26.768496] bpfilter: Loaded bpfilter_umh pid 661
> [   26.768699] bpfilter: write fail -22
> [   26.806550] Started bpfilter
> [   26.806616] bpfilter: Loaded bpfilter_umh pid 663
> [   26.864708] bpfilter: write fail -22
> [   26.872345] bpfilter: Loaded bpfilter_umh pid 666
> [   26.873072] Started bpfilter
> [   26.873194] bpfilter: write fail -22
> [   27.295514] kauditd_printk_skb: 22 callbacks suppressed
> 
> This is on a pure v5.8-rc7 via make bindep-pkg. I'm not using bpfilter
> in any shape or form afaict and haven't seen those messages before and
> this seems to be the last change I see.

I don't see any of those on 5.8-rc, just:

root@testvm:~# dmesg | grep bpf
[    6.692550] bpfilter: Loaded bpfilter_umh pid 1849

That debug patch below should help to pintpoint what is going on for
you:


diff --git a/fs/read_write.c b/fs/read_write.c
index 4fb797822567a6..15232ddea197b2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -516,8 +516,10 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_WRITE)))
 		return -EBADF;
-	if (!(file->f_mode & FMODE_CAN_WRITE))
+	if (!(file->f_mode & FMODE_CAN_WRITE)) {
+		pr_info_ratelimited("file can't write\n");
 		return -EINVAL;
+	}
 
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
@@ -528,8 +530,10 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 		ret = file->f_op->write(file, p, count, pos);
 	else if (file->f_op->write_iter)
 		ret = new_sync_write(file, p, count, pos);
-	else
+	else {
+		pr_info_ratelimited("file has no write method\n");
 		ret = -EINVAL;
+	}
 	set_fs(old_fs);
 	if (ret > 0) {
 		fsnotify_modify(file);
@@ -545,8 +549,10 @@ ssize_t kernel_write(struct file *file, const void *buf, size_t count,
 	ssize_t ret;
 
 	ret = rw_verify_area(WRITE, file, pos, count);
-	if (ret)
+	if (ret) {
+		pr_info_ratelimited("rw_verify_area\n");
 		return ret;
+	}
 
 	file_start_write(file);
 	ret =  __kernel_write(file, buf, count, pos);
