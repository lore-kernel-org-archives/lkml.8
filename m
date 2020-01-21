Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB343C33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790022073D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgAUDf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 22:35:59 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:33908 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727009AbgAUDf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 22:35:59 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.257809-0.0171984-0.724993;DS=CONTINUE|ham_system_inform|0.041768-0.000336577-0.957895;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03299;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.GfZ0IwR_1579577749;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.GfZ0IwR_1579577749)
          by smtp.aliyun-inc.com(10.147.40.44);
          Tue, 21 Jan 2020 11:35:50 +0800
Subject: Re: [PATCH v1 11/11] mtd: new support oops logger based on pstore/blk
To:     Miquel Raynal <miquel.raynal@bootlin.com>
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
References: <1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1579482233-2672-12-git-send-email-liaoweixiong@allwinnertech.com>
 <20200120110306.32e53fd8@xps13>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <27226590-379c-8784-f461-f5d701015611@allwinnertech.com>
Date:   Tue, 21 Jan 2020 11:36:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200120110306.32e53fd8@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Miquel Raynal,

On 2020/1/20 PM 6:03, Miquel Raynal wrote:
> Hi WeiXiong,
> 
> WeiXiong Liao <liaoweixiong@allwinnertech.com> wrote on Mon, 20 Jan
> 2020 09:03:53 +0800:
> 
>> It's the last one of a series of patches for adaptive to MTD device.
>>
>> The mtdpstore is similar to mtdoops but more powerful. It bases on
>> pstore/blk, aims to store panic and oops log to a flash partition,
> 
>                                            logs?
> 

I will fix it. Thanks.

>> where it can be read back as files after mounting pstore filesystem.
>>
>> The pstore/blk and blkoops, a wrapper for pstore/blk, are designed for
>> block device at the very beginning, but now, compatible to not only
>> block device. After this series of patches, pstore/blk can also work
>> for MTD device. To make it work, 'blkdev' on kconfig or module
>> parameter of blkoops should be set as mtd device name or mtd number.
>> See more about pstore/blk and blkoops on:
>>     Documentation/admin-guide/pstore-block.rst
>>
>> Why do we need mtdpstore?
>> 1. repetitive jobs between pstore and mtdoops
>>    Both of pstore and mtdoops do the same jobs that store panic/oops log.
>>    They have much similar logic that register to kmsg dumper and store
>>    log to several chunks one by one.
>> 2. do what a driver should do
>>    To me, a driver should provide methods instead of policies. What MTD
>>    should do is to provide read/write/erase operations, geting rid of codes
>>    about chunk management, kmsg dumper and configuration.
>> 3. enhanced feature
>>    Not only store log, but also show it as files.
>>    Not only log, but also trigger time and trigger count.
>>    Not only panic/oops log, but also log recorder for pmsg, console and
>>    ftrace in the future.
>>
>> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
>> Reported-by: kbuild test robot <lkp@intel.com>
> 
> I don't thing the test robot has a meaning here.
> 

I do not know what meaning the test rebot tag has, but i was suggested
from kbuild test rebot to do so. How should i do to it ? Drop the tag or
keep the tag or other?
The email from kbuild test rebot said that:

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

>> ---
>>  drivers/mtd/Kconfig     |  10 +
>>  drivers/mtd/Makefile    |   1 +
>>  drivers/mtd/mtdpstore.c | 530 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 541 insertions(+)
>>  create mode 100644 drivers/mtd/mtdpstore.c
>>
>> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
>> index 42d401ea60ee..a6e59495a738 100644
>> --- a/drivers/mtd/Kconfig
>> +++ b/drivers/mtd/Kconfig
>> @@ -170,6 +170,16 @@ config MTD_OOPS
>>  	  buffer in a flash partition where it can be read back at some
>>  	  later point.
>>  
>> +config MTD_PSTORE
>> +	tristate "Log panic/oops to an MTD buffer base on pstore"
> 
>                                                   based
> 

I will fix it. Thanks.

>> +	depends on PSTORE_BLKOOPS
>> +	help
>> +	  This enables panic and oops messages to be logged to a circular
>> +	  buffer in a flash partition where it can be read back as files after
>> +	  mounting pstore filesystem.
>> +
>> +	  If unsure, say N.
>> +
>>  config MTD_SWAP
>>  	tristate "Swap on MTD device support"
>>  	depends on MTD && SWAP
>> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
>> index 56cc60ccc477..593d0593a038 100644
>> --- a/drivers/mtd/Makefile
>> +++ b/drivers/mtd/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_RFD_FTL)		+= rfd_ftl.o
>>  obj-$(CONFIG_SSFDC)		+= ssfdc.o
>>  obj-$(CONFIG_SM_FTL)		+= sm_ftl.o
>>  obj-$(CONFIG_MTD_OOPS)		+= mtdoops.o
>> +obj-$(CONFIG_MTD_PSTORE)	+= mtdpstore.o
>>  obj-$(CONFIG_MTD_SWAP)		+= mtdswap.o
>>  
>>  nftl-objs		:= nftlcore.o nftlmount.o
>> diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
>> new file mode 100644
>> index 000000000000..ab4acd3a9011
>> --- /dev/null
>> +++ b/drivers/mtd/mtdpstore.c
>> @@ -0,0 +1,530 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * MTD Oops/Panic loger for pstore/blk
>> + *
>> + * Copyright (C) 2019 WeiXiong Liao <liaoweixiong@gallwinnertech.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
> 
> The license text is not needed since you added SPDX tag.
> 

I will fix it. Thanks.

>> + *
>> + */
>> +#define pr_fmt(fmt) "mtdoops-pstore: " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/blkoops.h>
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/bitops.h>
>> +
>> +/* Maximum MTD partition size */
>> +#define MTDPSTORE_MAX_MTD_SIZE (8 * 1024 * 1024)
> 
>                                   SZ_8M
> 

I will fix it. Thanks.

>> +
>> +static struct mtdpstore_context {
>> +	int index;
>> +	struct blkoops_info bo_info;
>> +	struct blkoops_device bo_dev;
>> +	struct mtd_info *mtd;
>> +	unsigned long *rmmap;		/* removed bit map */
>> +	unsigned long *usedmap;		/* used bit map */
>> +	/*
>> +	 * used for panic write
>> +	 * As there are no block_isbad for panic case, we should keep this
>> +	 * status before panic to ensure panic_write not failed.
>> +	 */
>> +	unsigned long *badmap;		/* bad block bit map */
>> +} oops_cxt;
>> +
>> +static int mtdpstore_block_isbad(struct mtdpstore_context *cxt, loff_t off)
>> +{
>> +	int ret;
>> +	struct mtd_info *mtd = cxt->mtd;
>> +	u64 blknum = div_u64(off, mtd->erasesize);
>> +
>> +	if (test_bit(blknum, cxt->badmap))
>> +		return true;
>> +	ret = mtd_block_isbad(mtd, off);
>> +	if (ret < 0) {
>> +		pr_err("mtd_block_isbad failed, aborting\n");
>> +		return ret;
>> +	} else if (ret > 0) {
>> +		set_bit(blknum, cxt->badmap);
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +static inline int mtdpstore_panic_block_isbad(struct mtdpstore_context *cxt,
>> +		loff_t off)
>> +{
>> +	struct mtd_info *mtd = cxt->mtd;
>> +	u64 blknum = div_u64(off, mtd->erasesize);
>> +
>> +	return test_bit(blknum, cxt->badmap);
>> +}
>> +
>> +static inline void mtdpstore_mark_used(struct mtdpstore_context *cxt,
>> +		loff_t off)
>> +{
>> +	u64 zonenum = div_u64(off, cxt->bo_info.dmesg_size);
>> +
>> +	pr_debug("mark zone %llu used\n", zonenum);
>> +	set_bit(zonenum, cxt->usedmap);
>> +}
>> +
>> +static inline void mtdpstore_mark_unused(struct mtdpstore_context *cxt,
>> +		loff_t off)
>> +{
>> +	u64 zonenum = div_u64(off, cxt->bo_info.dmesg_size);
>> +
>> +	pr_debug("mark zone %llu unused\n", zonenum);
>> +	clear_bit(zonenum, cxt->usedmap);
>> +}
>> +
>> +static inline void mtdpstore_block_mark_unused(struct mtdpstore_context *cxt,
>> +		loff_t off)
>> +{
>> +	u64 zonenum = div_u64(off, cxt->bo_info.dmesg_size);
>> +	u32 zonecnt = cxt->mtd->erasesize / cxt->bo_info.dmesg_size;
>> +
>> +	while (zonecnt > 0) {
>> +		pr_debug("mark zone %llu unused\n", zonenum);
>> +		clear_bit(zonenum, cxt->usedmap);
>> +		zonenum++;
>> +		zonecnt--;
>> +	}
>> +}
>> +
>> +static inline int mtdpstore_is_used(struct mtdpstore_context *cxt, loff_t off)
>> +{
>> +	u64 zonenum = div_u64(off, cxt->bo_info.dmesg_size);
>> +	u64 blknum = div_u64(off, cxt->mtd->erasesize);
>> +
>> +	if (test_bit(blknum, cxt->badmap))
>> +		return true;
>> +	return test_bit(zonenum, cxt->usedmap);
>> +}
>> +
>> +static int mtdpstore_block_is_used(struct mtdpstore_context *cxt,
>> +		loff_t off)
>> +{
>> +	u64 zonenum = div_u64(off, cxt->bo_info.dmesg_size);
>> +	u32 zonecnt = cxt->mtd->erasesize / cxt->bo_info.dmesg_size;
>> +
>> +	while (zonecnt > 0) {
>> +		if (test_bit(zonenum, cxt->usedmap))
>> +			return true;
>> +		zonenum++;
>> +		zonecnt--;
>> +	}
>> +	return false;
>> +}
>> +
>> +static int mtdpstore_is_empty(struct mtdpstore_context *cxt, char *buf,
>> +		size_t size)
>> +{
>> +	struct mtd_info *mtd = cxt->mtd;
>> +	size_t sz;
>> +	int i;
>> +
>> +	sz = min_t(uint32_t, size, mtd->writesize / 4);
>> +	for (i = 0; i < sz; i++) {
>> +		if (buf[i] != (char)0xFF)
>> +			return false;
>> +	}
>> +	return true;
>> +}
>> +
>> +static void mtdpstore_mark_removed(struct mtdpstore_context *cxt, loff_t off)
>> +{
>> +	u64 zonenum = div_u64(off, cxt->bo_info.dmesg_size);
>> +
>> +	pr_debug("mark zone %llu removed\n", zonenum);
>> +	set_bit(zonenum, cxt->rmmap);
>> +}
>> +
>> +static void mtdpstore_block_clear_removed(struct mtdpstore_context *cxt,
>> +		loff_t off)
>> +{
>> +	u64 zonenum = div_u64(off, cxt->bo_info.dmesg_size);
>> +	u32 zonecnt = cxt->mtd->erasesize / cxt->bo_info.dmesg_size;
>> +
>> +	while (zonecnt > 0) {
>> +		clear_bit(zonenum, cxt->rmmap);
>> +		zonenum++;
>> +		zonecnt--;
>> +	}
>> +}
>> +
>> +static int mtdpstore_block_is_removed(struct mtdpstore_context *cxt,
>> +		loff_t off)
>> +{
>> +	u64 zonenum = div_u64(off, cxt->bo_info.dmesg_size);
>> +	u32 zonecnt = cxt->mtd->erasesize / cxt->bo_info.dmesg_size;
>> +
>> +	while (zonecnt > 0) {
>> +		if (test_bit(zonenum, cxt->rmmap))
>> +			return true;
>> +		zonenum++;
>> +		zonecnt--;
>> +	}
>> +	return false;
>> +}
>> +
>> +static int mtdpstore_erase_do(struct mtdpstore_context *cxt, loff_t off)
>> +{
>> +	struct erase_info erase;
>> +	int ret;
>> +
>> +	pr_debug("try to erase off 0x%llx\n", off);
>> +	erase.len = cxt->mtd->erasesize;
>> +	erase.addr = off;
>> +	ret = mtd_erase(cxt->mtd, &erase);
>> +	if (!ret)
>> +		mtdpstore_block_clear_removed(cxt, off);
>> +	else
>> +		pr_err("erase of region [0x%llx, 0x%llx] on \"%s\" failed\n",
>> +		       (unsigned long long)erase.addr,
>> +		       (unsigned long long)erase.len, cxt->bo_info.device);
>> +	return ret;
>> +}
>> +
>> +/*
>> + * called while removing file
>> + *
>> + * Avoiding over erasing, do erase only when all zones are removed or unused.
>> + * Ensure to remove when unregister by reading, erasing and wrtiing back.
>> + */
>> +static ssize_t mtdpstore_erase(size_t size, loff_t off)
>> +{
>> +	struct mtdpstore_context *cxt = &oops_cxt;
>> +
>> +	if (mtdpstore_block_isbad(cxt, off))
>> +		return -EIO;
>> +
>> +	mtdpstore_mark_unused(cxt, off);
>> +
>> +	if (likely(mtdpstore_block_is_used(cxt, off))) {
>> +		mtdpstore_mark_removed(cxt, off);
>> +		return 0;
>> +	}
>> +
>> +	/* all zones are unused, erase it */
>> +	off = ALIGN_DOWN(off, cxt->mtd->erasesize);
>> +	return mtdpstore_erase_do(cxt, off);
>> +}
>> +
>> +/*
>> + * What is securety for mtdpstore?
> 
>               security
> 

I will fix it. Thanks.

>> + * As there is no erase for panic case, we should ensure at least one zone
>> + * is writable. Otherwise, panic write will be failed.
> 
>                                           will fail.
> 
I will fix it. Thanks.

>> + * If zone is used, write operation will return -ENEXT, which means that
>> + * pstore/blk will try one by one until get a empty zone. So, it's no need
> 
>                                            it gets an empty zone. So it
>                                            is not needed to ...
>     

I will fix it. Thanks.

>> + * to ensure next zone is empty, but at least one.
> 
>                the
> 

I will fix it. Thanks.

>> + */
>> +static int mtdpstore_security(struct mtdpstore_context *cxt, loff_t off)
>> +{
>> +	int ret = 0, i;
>> +	u32 zonenum = (u32)div_u64(off, cxt->bo_info.dmesg_size);
>> +	u32 zonecnt = (u32)div_u64(cxt->mtd->size, cxt->bo_info.dmesg_size);
>> +	u32 blkcnt = (u32)div_u64(cxt->mtd->size, cxt->mtd->erasesize);
>> +	u32 erasesize = cxt->mtd->erasesize;
>> +
>> +	for (i = 0; i < zonecnt; i++) {
>> +		u32 num = (zonenum + i) % zonecnt;
>> +
>> +		/* found empty zone */
>> +		if (!test_bit(num, cxt->usedmap))
>> +			return 0;
>> +	}
>> +
>> +	/* If there is no any empty zone, we have no way but to do erase */
>> +	off = ALIGN_DOWN(off, erasesize);
>> +	while (blkcnt--) {
>> +		div64_u64_rem(off + erasesize, cxt->mtd->size, (u64 *)&off);
>> +
>> +		if (mtdpstore_block_isbad(cxt, off))
>> +			continue;
>> +
>> +		ret = mtdpstore_erase_do(cxt, off);
>> +		if (!ret) {
>> +			mtdpstore_block_mark_unused(cxt, off);
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (ret)
>> +		pr_err("all blocks bad!\n");
>> +	pr_debug("end security\n");
>> +	return ret;
>> +}
>> +
>> +static ssize_t mtdpstore_write(const char *buf, size_t size, loff_t off)
>> +{
>> +	struct mtdpstore_context *cxt = &oops_cxt;
>> +	size_t retlen;
>> +	int ret;
>> +
>> +	if (mtdpstore_block_isbad(cxt, off))
>> +		return -ENEXT;
>> +
>> +	/* zone is used, please try next one */
>> +	if (mtdpstore_is_used(cxt, off))
>> +		return -ENEXT;
>> +
>> +	pr_debug("try to write off 0x%llx size %zu\n", off, size);
>> +	ret = mtd_write(cxt->mtd, off, size, &retlen, (u_char *)buf);
>> +	if (ret < 0 || retlen != size) {
>> +		pr_err("write failure at %lld (%zu of %zu written), err %d\n",
>> +				off, retlen, size, ret);
>> +		return -EIO;
>> +	}
>> +	mtdpstore_mark_used(cxt, off);
>> +
>> +	mtdpstore_security(cxt, off);
>> +	return retlen;
>> +}
>> +
>> +/*
>> + * All zones will be read as pstore/blk will read zone one by one when do
>> + * recover.
>> + */
>> +static ssize_t mtdpstore_read(char *buf, size_t size, loff_t off)
>> +{
>> +	struct mtdpstore_context *cxt = &oops_cxt;
>> +	size_t retlen;
>> +	int ret;
>> +
>> +	if (mtdpstore_block_isbad(cxt, off))
>> +		return -ENEXT;
>> +
>> +	pr_debug("try to read off 0x%llx size %zu\n", off, size);
>> +	ret = mtd_read(cxt->mtd, off, size, &retlen, (u_char *)buf);
>> +	if ((ret < 0 && !mtd_is_bitflip(ret)) || size != retlen)  {
> 
> IIRC size != retlen does not mean it failed, but that you should
> continue reading after retlen bytes, no?
> 

Yes, you are right. I will fix it. Thanks.

> Also, mtd_is_bitflip() does not mean that you are reading a false
> buffer, but that the data has been corrected as it contained bitflips.
> mtd_is_eccerr() however, would be meaningful.
> 

Sure I know mtd_is_bitflip() does not mean failure, but I do not think
mtd_is_eccerr() should be here since the codes are ret < 0 and NOT
mtd_is_bitflip().

>> +		pr_err("read failure at %lld (%zu of %zu read), err %d\n",
>> +				off, retlen, size, ret);
>> +		return -EIO;
>> +	}
>> +
>> +	if (mtdpstore_is_empty(cxt, buf, size))
>> +		mtdpstore_mark_unused(cxt, off);
>> +	else
>> +		mtdpstore_mark_used(cxt, off);
>> +
>> +	mtdpstore_security(cxt, off);
>> +	return retlen;
>> +}
>> +
>> +static ssize_t mtdpstore_panic_write(const char *buf, size_t size, loff_t off)
>> +{
>> +	struct mtdpstore_context *cxt = &oops_cxt;
>> +	size_t retlen;
>> +	int ret;
>> +
>> +	if (mtdpstore_panic_block_isbad(cxt, off))
>> +		return -ENEXT;
>> +
>> +	/* zone is used, please try next one */
>> +	if (mtdpstore_is_used(cxt, off))
>> +		return -ENEXT;
>> +
>> +	ret = mtd_panic_write(cxt->mtd, off, size, &retlen, (u_char *)buf);
>> +	if (ret < 0 || size != retlen) {
>> +		pr_err("panic write failure at %lld (%zu of %zu read), err %d\n",
>> +				off, retlen, size, ret);
>> +		return -EIO;
>> +	}
>> +	mtdpstore_mark_used(cxt, off);
>> +
>> +	return retlen;
>> +}
>> +
>> +static void mtdpstore_notify_add(struct mtd_info *mtd)
>> +{
>> +	int ret;
>> +	struct mtdpstore_context *cxt = &oops_cxt;
>> +	struct blkoops_info *info = &cxt->bo_info;
>> +	unsigned long longcnt;
>> +
>> +	if (!strcmp(mtd->name, info->device))
>> +		cxt->index = mtd->index;
>> +
>> +	if (mtd->index != cxt->index || cxt->index < 0)
>> +		return;
>> +
>> +	pr_debug("found matching MTD device %s\n", mtd->name);
>> +
>> +	if (mtd->size < info->dmesg_size * 2) {
>> +		pr_err("MTD partition %d not big enough\n", mtd->index);
>> +		return;
>> +	}
>> +	if (mtd->erasesize < info->dmesg_size) {
>> +		pr_err("eraseblock size of MTD partition %d too small\n",
>> +				mtd->index);
> 
> What is the usual size of dmesg? Could this check be too limiting?
> 

The size must be aligned to 4096, which is limited by blkoops. The
default value is 64K. If it is larger than erasesize, some errors will occur
since mtdpstore is designed on it.

>> +		return;
>> +	}
>> +	if (unlikely(info->dmesg_size % mtd->writesize)) {
>> +		pr_err("record size %lu KB must align to write size %d KB\n",
>> +				info->dmesg_size / 1024,
>> +				mtd->writesize / 1024);
> 
> This condition is weird, why would you check this?
> 

pstore/blk will write 'record_size' dmesg log at one time.
Since each write data must be aligned to 'writesize' for flash, I am not
sure
all flash drivers are compatible with misaligned data, that's why i
check this.

>> +		return;
>> +	}
>> +	if (unlikely(mtd->size > MTDPSTORE_MAX_MTD_SIZE)) {
>> +		pr_err("mtd%d is too large (limit is %d MiB)\n",
>> +				mtd->index,
>> +				MTDPSTORE_MAX_MTD_SIZE / 1024 / 1024);
> 
> Same question? I could understand that it is easier to manage blocks
> knowing their maximum number though.
> 

It refers to mtdoops.

>> +		return;
>> +	}
>> +
>> +	longcnt = BITS_TO_LONGS(div_u64(mtd->size, info->dmesg_size));
>> +	cxt->rmmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
>> +	cxt->usedmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
>> +
>> +	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
>> +	cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
>> +
>> +	cxt->bo_dev.total_size = mtd->size;
>> +	/* just support dmesg right now */
>> +	cxt->bo_dev.flags = BLKOOPS_DEV_SUPPORT_DMESG;
>> +	cxt->bo_dev.read = mtdpstore_read;
>> +	cxt->bo_dev.write = mtdpstore_write;
>> +	cxt->bo_dev.erase = mtdpstore_erase;
>> +	cxt->bo_dev.panic_write = mtdpstore_panic_write;
>> +
>> +	ret = blkoops_register_device(&cxt->bo_dev);
>> +	if (ret) {
>> +		pr_err("mtd%d register to blkoops failed\n", mtd->index);
>> +		return;
>> +	}
>> +	cxt->mtd = mtd;
>> +	pr_info("Attached to MTD device %d\n", mtd->index);
>> +}
>> +
>> +static int mtdpstore_flush_removed_do(struct mtdpstore_context *cxt,
>> +		loff_t off, size_t size)
>> +{
>> +	struct mtd_info *mtd = cxt->mtd;
>> +	u_char *buf;
>> +	int ret;
>> +	size_t retlen;
>> +	struct erase_info erase;
>> +
>> +	buf = kmalloc(mtd->erasesize, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	/* 1st. read to cache */
>> +	ret = mtd_read(mtd, off, mtd->erasesize, &retlen, buf);
>> +	if (ret || retlen != mtd->erasesize)
>> +		goto free;
>> +
>> +	/* 2nd. erase block */
>> +	erase.len = mtd->erasesize;
>> +	erase.addr = off;
>> +	ret = mtd_erase(mtd, &erase);
>> +	if (ret)
>> +		goto free;
>> +
>> +	/* 3rd. write back */
>> +	while (size) {
>> +		unsigned int zonesize = cxt->bo_info.dmesg_size;
>> +
>> +		/* remove must clear used bit */
>> +		if (mtdpstore_is_used(cxt, off))
>> +			mtd_write(mtd, off, zonesize, &retlen, buf);
> 
> Besides the fact that should definitely check the write return code, I
> don't understand what you do in this function. What does
> flush_removed_do mean?
> 

When user remove one log file on pstore filesystem, mtdpstore should do
something to ensure log file removed. If the whole block is no longer used,
it is nice to erase the block. However, if the block still contains
valid log,
what mtdpstore can do is to erase and write the valid log back.
That is what flush_removed_do() do.

In case of repeated erase when users remove several log files, mtdpstore
do remove jobs when exit.

Besides, mtdpstore do not check the return code to ensure write back valid
log as much as possible.

>> +
>> +		off += zonesize;
>> +		size -= min_t(unsigned int, zonesize, size);
>> +	}
>> +
>> +free:
>> +	kfree(buf);
>> +	return ret;
>> +}
>> +
>> +static int mtdpstore_flush_removed(struct mtdpstore_context *cxt)
>> +{
>> +	struct mtd_info *mtd = cxt->mtd;
>> +	int ret;
>> +	loff_t off;
>> +	u32 blkcnt = (u32)div_u64(mtd->size, mtd->erasesize);
>> +
>> +	for (off = 0; blkcnt > 0; blkcnt--, off += mtd->erasesize) {
>> +		ret = mtdpstore_block_is_removed(cxt, off);
>> +		if (!ret) {
>> +			off += mtd->erasesize;
>> +			continue;
>> +		}
>> +
>> +		ret = mtdpstore_flush_removed_do(cxt, off, mtd->erasesize);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static void mtdpstore_notify_remove(struct mtd_info *mtd)
>> +{
>> +	struct mtdpstore_context *cxt = &oops_cxt;
>> +
>> +	if (mtd->index != cxt->index || cxt->index < 0)
>> +		return;
>> +
>> +	mtdpstore_flush_removed(cxt);
>> +
>> +	blkoops_unregister_device(&cxt->bo_dev);
>> +	kfree(cxt->badmap);
>> +	kfree(cxt->usedmap);
>> +	kfree(cxt->rmmap);
>> +	cxt->mtd = NULL;
>> +	cxt->index = -1;
>> +}
>> +
>> +static struct mtd_notifier mtdpstore_notifier = {
>> +	.add	= mtdpstore_notify_add,
>> +	.remove	= mtdpstore_notify_remove,
>> +};
>> +
>> +static int __init mtdpstore_init(void)
>> +{
>> +	int ret;
>> +	struct mtdpstore_context *cxt = &oops_cxt;
>> +	struct blkoops_info *info = &cxt->bo_info;
>> +
>> +	ret = blkoops_info(info);
>> +	if (unlikely(ret))
>> +		return ret;
>> +
>> +	if (strlen(info->device) == 0) {
>> +		pr_err("mtd device must be supplied\n");
>> +		return -EINVAL;
>> +	}
>> +	if (!info->dmesg_size) {
>> +		pr_err("no recorder enabled\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Setup the MTD device to use */
>> +	ret = kstrtoint((char *)info->device, 0, &cxt->index);
>> +	if (ret)
>> +		cxt->index = -1;
>> +
>> +	register_mtd_user(&mtdpstore_notifier);
>> +	return 0;
>> +}
>> +module_init(mtdpstore_init);
>> +
>> +static void __exit mtdpstore_exit(void)
>> +{
>> +	unregister_mtd_user(&mtdpstore_notifier);
>> +}
>> +module_exit(mtdpstore_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
>> +MODULE_DESCRIPTION("MTD Oops/Panic console logger/driver");
> 
> 
> 
> 
> Thanks,
> Miquèl
> 

I will collect more suggestions and submit the new version at one time.

-- 
liaoweixiong
