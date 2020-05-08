Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38CDC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870BE20736
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m2YIKgPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgEHH1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgEHH1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:27:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C652C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 00:27:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id q124so469034pgq.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 00:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0eDRJhDdXEyJ4k8o9rxXKO4qTxW18novqGE2BWki1LE=;
        b=m2YIKgPM0b2WmcYJPsYM2wGs0xjLHunZK0VunuEeSoQune0sz1ruZb22SQNpjPcpWK
         U+GQrn7cbNuuFYowJ8Ky4I3qVEMfhvzDlohxmO1O6yucgZHCqSOKBnYainUr7MhEv3xO
         z1G8FK6AMWz1Uz7ISpHL/KL2FbaBmVFLDg5LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0eDRJhDdXEyJ4k8o9rxXKO4qTxW18novqGE2BWki1LE=;
        b=imhsO4uCx37n9sig+/x6X/AwNmAeS62+FiOfd32IRqZaGNUkkk6cS2l0O/rNloKBPd
         7Tm3BI3CavP9t4yVNirje6cU7eLWJl4oBDMtEH0d33qZ/qCqMqMzZQ1wuqfxgPfDiaHh
         uVyoCjAfhMthfVBf7vTHG/9LkuZt36n7IQRMVtGgflVmWSY5dSZf2AC0+GVeNFpQon8l
         vt/cAqIfri0NK7h9cW5pkrYlRvy59wdNKiIj7CcLPJyOvPKR5BWVCgBHWlMMOo+znT5N
         0e496umaUlkZvUbsndM5uTUw5kXu2kUvkjn3rp8vrL57Ok023dNbZYdIQaSyhXzT5Wc+
         Xi5A==
X-Gm-Message-State: AGi0PuYBo6CTzXul5eFnP4qZjOkBjP99eMuzHFIEouGjFvkxmf3zzcya
        9enmVME/ELS6B415DIXLN/Yn9g==
X-Google-Smtp-Source: APiQypK9+XDNQjZa9i5WiAs7yehEj+1TLNclficOKaL6MtjPkOpW00BQpAPrSOWcWyipV1AhdWYbhg==
X-Received: by 2002:a62:14a:: with SMTP id 71mr1372603pfb.33.1588922868472;
        Fri, 08 May 2020 00:27:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c15sm841519pfo.188.2020.05.08.00.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 00:27:47 -0700 (PDT)
Date:   Fri, 8 May 2020 00:27:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/12] pstore: mtd: support crash log to block and mtd
 device
Message-ID: <202005080020.41C33738@keescook>
References: <20200508064004.57898-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508064004.57898-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 11:39:52PM -0700, Kees Cook wrote:
> So far, I've identified the following stuff left to do:
> [...]
>         - implement ramoops-like probe feature for pstore/blk

With the following hack, I'm able to start testing the series:

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index a736555e1ed3..7145da079267 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -373,12 +373,14 @@ int psblk_register_blkdev(unsigned int major, unsigned int flags,
 	if (IS_ERR(binfo))
 		return PTR_ERR(binfo);
 
+#if 0
 	/* only allow driver matching the @blkdev */
 	if (!binfo->devt || MAJOR(binfo->devt) != major) {
 		pr_debug("invalid major %u (expect %u)\n",
 				major, MAJOR(binfo->devt));
 		return -ENODEV;
 	}
+#endif
 
 	/* hold bdev exclusively */
 	bdev = psblk_get_bdev(holder);
@@ -423,7 +425,7 @@ void psblk_unregister_blkdev(unsigned int major)
 	struct psblk_device dev = {.read = psblk_generic_blk_read};
 	void *holder = blkdev;
 
-	if (psblk_bdev && MAJOR(psblk_bdev->bd_dev) == major) {
+	if (psblk_bdev/* && MAJOR(psblk_bdev->bd_dev) == major*/) {
 		psblk_unregister_device(&dev);
 		psblk_put_bdev(psblk_bdev, holder);
 		blkdev_panic_write = NULL;
@@ -476,6 +478,24 @@ int pstore_blk_usr_info(struct pstore_blk_info *info)
 }
 EXPORT_SYMBOL_GPL(pstore_blk_usr_info);
 
+static int __init pstore_blk_init(void)
+{
+	int ret = 0;
+
+	if (blkdev[0])
+		ret = psblk_register_blkdev(0, 0, NULL);
+
+	return ret;
+}
+postcore_initcall(pstore_blk_init);
+
+static void __exit pstore_blk_exit(void)
+{
+	psblk_unregister_blkdev(0);
+}
+module_exit(pstore_blk_exit);
+
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
 MODULE_DESCRIPTION("pstore backend for block devices");


Then I can get things up and running with:

# insmod pstore.ko compress=off
# insmod pstore_zone.ko
# truncate pstore-blk.raw --size 100M
# losetup -f --show pstore-blk.raw
/dev/loop0
# insmod pstore_blk.ko blkdev=/dev/loop0 kmsg_size=16 console_size=64

So far, I've hit a few bugs. The most obvious is that "rmmod" causes a
fault, so I think locking and other things need to be fixed up further.
After that, it looked like all the compressed files were failing to
decompress, which implies some kind of buffer offset problem. When I
loaded with pstore.compress=off I got readable logs, but there is a span
of garbage between the header and the body in
/sys/fs/pstore/dmesg-pstore-zone-1 etc.

Cool so far! It just needs a bit more testing a polish. :)

-- 
Kees Cook
