Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A7BC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1AE22522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgAUIsJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:48:09 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47177 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:48:09 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 60DA460007;
        Tue, 21 Jan 2020 08:48:03 +0000 (UTC)
Date:   Tue, 21 Jan 2020 09:48:02 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     liaoweixiong <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v1 11/11] mtd: new support oops logger based on
 pstore/blk
Message-ID: <20200121094802.61f8cb4d@xps13>
In-Reply-To: <27226590-379c-8784-f461-f5d701015611@allwinnertech.com>
References: <1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com>
        <1579482233-2672-12-git-send-email-liaoweixiong@allwinnertech.com>
        <20200120110306.32e53fd8@xps13>
        <27226590-379c-8784-f461-f5d701015611@allwinnertech.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

liaoweixiong <liaoweixiong@allwinnertech.com> wrote on Tue, 21 Jan 2020
11:36:00 +0800:

> hi Miquel Raynal,
> 
> On 2020/1/20 PM 6:03, Miquel Raynal wrote:
> > Hi WeiXiong,
> > 
> > WeiXiong Liao <liaoweixiong@allwinnertech.com> wrote on Mon, 20 Jan
> > 2020 09:03:53 +0800:
> >   
> >> It's the last one of a series of patches for adaptive to MTD device.
> >>
> >> The mtdpstore is similar to mtdoops but more powerful. It bases on
> >> pstore/blk, aims to store panic and oops log to a flash partition,  
> > 
> >                                            logs?
> >   
> 
> I will fix it. Thanks.
> 
> >> where it can be read back as files after mounting pstore filesystem.
> >>
> >> The pstore/blk and blkoops, a wrapper for pstore/blk, are designed for
> >> block device at the very beginning, but now, compatible to not only
> >> block device. After this series of patches, pstore/blk can also work
> >> for MTD device. To make it work, 'blkdev' on kconfig or module
> >> parameter of blkoops should be set as mtd device name or mtd number.
> >> See more about pstore/blk and blkoops on:
> >>     Documentation/admin-guide/pstore-block.rst
> >>
> >> Why do we need mtdpstore?
> >> 1. repetitive jobs between pstore and mtdoops
> >>    Both of pstore and mtdoops do the same jobs that store panic/oops log.
> >>    They have much similar logic that register to kmsg dumper and store
> >>    log to several chunks one by one.
> >> 2. do what a driver should do
> >>    To me, a driver should provide methods instead of policies. What MTD
> >>    should do is to provide read/write/erase operations, geting rid of codes
> >>    about chunk management, kmsg dumper and configuration.
> >> 3. enhanced feature
> >>    Not only store log, but also show it as files.
> >>    Not only log, but also trigger time and trigger count.
> >>    Not only panic/oops log, but also log recorder for pmsg, console and
> >>    ftrace in the future.
> >>
> >> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
> >> Reported-by: kbuild test robot <lkp@intel.com>  
> > 
> > I don't thing the test robot has a meaning here.
> >   
> 
> I do not know what meaning the test rebot tag has, but i was suggested
> from kbuild test rebot to do so. How should i do to it ? Drop the tag or
> keep the tag or other?
> The email from kbuild test rebot said that:
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

You probably pushed your work on a dedicated repository on which this
robot has run. It does not make any difference between upstream sources
and downstream contributions. You may add this tag when you are
fixing something reported by the robot against the upstream kernel.
Here, the driver is new, this is a feature you are adding, so please
drop the tag.

[...]

> >> +/*
> >> + * All zones will be read as pstore/blk will read zone one by one when do
> >> + * recover.
> >> + */
> >> +static ssize_t mtdpstore_read(char *buf, size_t size, loff_t off)
> >> +{
> >> +	struct mtdpstore_context *cxt = &oops_cxt;
> >> +	size_t retlen;
> >> +	int ret;
> >> +
> >> +	if (mtdpstore_block_isbad(cxt, off))
> >> +		return -ENEXT;
> >> +
> >> +	pr_debug("try to read off 0x%llx size %zu\n", off, size);
> >> +	ret = mtd_read(cxt->mtd, off, size, &retlen, (u_char *)buf);
> >> +	if ((ret < 0 && !mtd_is_bitflip(ret)) || size != retlen)  {  
> > 
> > IIRC size != retlen does not mean it failed, but that you should
> > continue reading after retlen bytes, no?
> >   
> 
> Yes, you are right. I will fix it. Thanks.
> 
> > Also, mtd_is_bitflip() does not mean that you are reading a false
> > buffer, but that the data has been corrected as it contained bitflips.
> > mtd_is_eccerr() however, would be meaningful.
> >   
> 
> Sure I know mtd_is_bitflip() does not mean failure, but I do not think
> mtd_is_eccerr() should be here since the codes are ret < 0 and NOT
> mtd_is_bitflip().

Yes, just drop this check, only keep ret < 0.

> 
> >> +		pr_err("read failure at %lld (%zu of %zu read), err %d\n",
> >> +				off, retlen, size, ret);
> >> +		return -EIO;
> >> +	}
> >> +
> >> +	if (mtdpstore_is_empty(cxt, buf, size))
> >> +		mtdpstore_mark_unused(cxt, off);
> >> +	else
> >> +		mtdpstore_mark_used(cxt, off);
> >> +
> >> +	mtdpstore_security(cxt, off);
> >> +	return retlen;
> >> +}
> >> +
> >> +static ssize_t mtdpstore_panic_write(const char *buf, size_t size, loff_t off)
> >> +{
> >> +	struct mtdpstore_context *cxt = &oops_cxt;
> >> +	size_t retlen;
> >> +	int ret;
> >> +
> >> +	if (mtdpstore_panic_block_isbad(cxt, off))
> >> +		return -ENEXT;
> >> +
> >> +	/* zone is used, please try next one */
> >> +	if (mtdpstore_is_used(cxt, off))
> >> +		return -ENEXT;
> >> +
> >> +	ret = mtd_panic_write(cxt->mtd, off, size, &retlen, (u_char *)buf);
> >> +	if (ret < 0 || size != retlen) {
> >> +		pr_err("panic write failure at %lld (%zu of %zu read), err %d\n",
> >> +				off, retlen, size, ret);
> >> +		return -EIO;
> >> +	}
> >> +	mtdpstore_mark_used(cxt, off);
> >> +
> >> +	return retlen;
> >> +}
> >> +
> >> +static void mtdpstore_notify_add(struct mtd_info *mtd)
> >> +{
> >> +	int ret;
> >> +	struct mtdpstore_context *cxt = &oops_cxt;
> >> +	struct blkoops_info *info = &cxt->bo_info;
> >> +	unsigned long longcnt;
> >> +
> >> +	if (!strcmp(mtd->name, info->device))
> >> +		cxt->index = mtd->index;
> >> +
> >> +	if (mtd->index != cxt->index || cxt->index < 0)
> >> +		return;
> >> +
> >> +	pr_debug("found matching MTD device %s\n", mtd->name);
> >> +
> >> +	if (mtd->size < info->dmesg_size * 2) {
> >> +		pr_err("MTD partition %d not big enough\n", mtd->index);
> >> +		return;
> >> +	}
> >> +	if (mtd->erasesize < info->dmesg_size) {
> >> +		pr_err("eraseblock size of MTD partition %d too small\n",
> >> +				mtd->index);  
> > 
> > What is the usual size of dmesg? Could this check be too limiting?
> >   
> 
> The size must be aligned to 4096, which is limited by blkoops. The
> default value is 64K. If it is larger than erasesize, some errors will occur
> since mtdpstore is designed on it.

Please add a comment with the above explanation.

> 
> >> +		return;
> >> +	}
> >> +	if (unlikely(info->dmesg_size % mtd->writesize)) {
> >> +		pr_err("record size %lu KB must align to write size %d KB\n",
> >> +				info->dmesg_size / 1024,
> >> +				mtd->writesize / 1024);  
> > 
> > This condition is weird, why would you check this?
> >   
> 
> pstore/blk will write 'record_size' dmesg log at one time.
> Since each write data must be aligned to 'writesize' for flash, I am not
> sure
> all flash drivers are compatible with misaligned data, that's why i
> check this.

I think you should enforce this alignment instead of checking it.

> 
> >> +		return;
> >> +	}
> >> +	if (unlikely(mtd->size > MTDPSTORE_MAX_MTD_SIZE)) {
> >> +		pr_err("mtd%d is too large (limit is %d MiB)\n",
> >> +				mtd->index,
> >> +				MTDPSTORE_MAX_MTD_SIZE / 1024 / 1024);  
> > 
> > Same question? I could understand that it is easier to manage blocks
> > knowing their maximum number though.
> >   
> 
> It refers to mtdoops.

What do you mean?

> 
> >> +		return;
> >> +	}
> >> +
> >> +	longcnt = BITS_TO_LONGS(div_u64(mtd->size, info->dmesg_size));
> >> +	cxt->rmmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
> >> +	cxt->usedmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
> >> +
> >> +	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
> >> +	cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
> >> +
> >> +	cxt->bo_dev.total_size = mtd->size;
> >> +	/* just support dmesg right now */
> >> +	cxt->bo_dev.flags = BLKOOPS_DEV_SUPPORT_DMESG;
> >> +	cxt->bo_dev.read = mtdpstore_read;
> >> +	cxt->bo_dev.write = mtdpstore_write;
> >> +	cxt->bo_dev.erase = mtdpstore_erase;
> >> +	cxt->bo_dev.panic_write = mtdpstore_panic_write;
> >> +
> >> +	ret = blkoops_register_device(&cxt->bo_dev);
> >> +	if (ret) {
> >> +		pr_err("mtd%d register to blkoops failed\n", mtd->index);
> >> +		return;
> >> +	}
> >> +	cxt->mtd = mtd;
> >> +	pr_info("Attached to MTD device %d\n", mtd->index);
> >> +}
> >> +
> >> +static int mtdpstore_flush_removed_do(struct mtdpstore_context *cxt,
> >> +		loff_t off, size_t size)
> >> +{
> >> +	struct mtd_info *mtd = cxt->mtd;
> >> +	u_char *buf;
> >> +	int ret;
> >> +	size_t retlen;
> >> +	struct erase_info erase;
> >> +
> >> +	buf = kmalloc(mtd->erasesize, GFP_KERNEL);
> >> +	if (!buf)
> >> +		return -ENOMEM;
> >> +
> >> +	/* 1st. read to cache */
> >> +	ret = mtd_read(mtd, off, mtd->erasesize, &retlen, buf);
> >> +	if (ret || retlen != mtd->erasesize)
> >> +		goto free;
> >> +
> >> +	/* 2nd. erase block */
> >> +	erase.len = mtd->erasesize;
> >> +	erase.addr = off;
> >> +	ret = mtd_erase(mtd, &erase);
> >> +	if (ret)
> >> +		goto free;
> >> +
> >> +	/* 3rd. write back */
> >> +	while (size) {
> >> +		unsigned int zonesize = cxt->bo_info.dmesg_size;
> >> +
> >> +		/* remove must clear used bit */
> >> +		if (mtdpstore_is_used(cxt, off))
> >> +			mtd_write(mtd, off, zonesize, &retlen, buf);  
> > 
> > Besides the fact that should definitely check the write return code, I
> > don't understand what you do in this function. What does
> > flush_removed_do mean?
> >   
> 
> When user remove one log file on pstore filesystem, mtdpstore should do
> something to ensure log file removed. If the whole block is no longer used,
> it is nice to erase the block. However, if the block still contains
> valid log,
> what mtdpstore can do is to erase and write the valid log back.
> That is what flush_removed_do() do.

Please explain with a comment.

> 
> In case of repeated erase when users remove several log files, mtdpstore
> do remove jobs when exit.
> 
> Besides, mtdpstore do not check the return code to ensure write back valid
> log as much as possible.

You are not in a critical path, I don't understand why you don't check
it? If it returns an error, it means the data is not written. IMHO it
is best to alert the user than to silently fail.

> 
> >> +
> >> +		off += zonesize;
> >> +		size -= min_t(unsigned int, zonesize, size);
> >> +	}
> >> +
> >> +free:
> >> +	kfree(buf);
> >> +	return ret;
> >> +}
> >> +


[...]

> > 
> > Thanks,
> > Miquèl
> >   
> 
> I will collect more suggestions and submit the new version at one time.
> 

Sure, no hurry.


Thanks,
Miquèl
