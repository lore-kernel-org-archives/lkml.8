Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FE5C54FCE
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 10:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523C820781
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 10:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgCVKCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 06:02:22 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:48781 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726866AbgCVKCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 06:02:22 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=||false|;DS=CONTINUE|ham_system_inform|0.204865-0.000659831-0.794475;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.H3OdMSK_1584871227;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.H3OdMSK_1584871227)
          by smtp.aliyun-inc.com(10.147.41.120);
          Sun, 22 Mar 2020 18:00:29 +0800
Subject: Re: [PATCH v2 02/11] blkoops: add blkoops, a warpper for pstore/blk
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1581078355-19647-3-git-send-email-liaoweixiong@allwinnertech.com>
 <202003181025.20B6978@keescook>
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
Message-ID: <11f3dcbf-dba5-8fdc-6b2c-43dbe4e478c8@allwinnertech.com>
Date:   Sun, 22 Mar 2020 18:00:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <202003181025.20B6978@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Kees Cook,

On 2020/3/19 AM2:06, Kees Cook wrote:
> On Fri, Feb 07, 2020 at 08:25:46PM +0800, WeiXiong Liao wrote:
>> blkoops is a better wrapper for pstore/blk, which provides efficient
>> configuration mothod. It divides all configurations of pstore/blk into
> 
> typo: method
> 

I will fix it.

>> 2 parts, configurations for user and configurations for driver.
>>
>> Configurations for user detemine how pstore/blk work, such as
>> dump_oops and dmesg_size. They can be set by Kconfig and module
>> parameters.
> 
> I'd like to keep blkoops as close to ramoops as possible on the user
> configuration side. Notes below...
> 

Is your question why not use device-tree on the user configuration
side? Here are my answer about it.

There is an important difference between blkoops and ramoops.
The ramoops can be initialized at any time since ram already be
ready. However, blkoops must waits for block_dev registering.

If blkoops use device-tree like ramoops do, it sometimes fails to
open block device because of block device not ready even though
it is initialized later by using late_initcall(). Take MMC as am example.
Block devices of MMC will not register until a few seconds after
MMC driver initialization. During waiting MMC block device, blkoops
has already been called and fails to initialize. Instead of using
device-tree and waiting for block device for several seconds, I
prefer to not initialize until block driver call it.

How about just getting the user configurations from device-tree but not
do initialize until block driver calls it? It seems illogical.

>> Configurations for driver are all about block/non-block device, such as
>> total_size of device and read/write operations. They should be provided
>> by device drivers, calling blkoops_register_device() for non-block
>> device and blkoops_register_blkdev() for block device.
> 
> By non-block do you mean nvme etc? What is the right term for spinning
> disk and nvme collectively? (I always considered them all to be "block"
> devices.)
> 

No, non-block here means devices such as MTD device which is not a block
device and do not use generic block layer.

Notes of non-block here seems too early. I will make a separate patch to
support non-block.

>> If device driver support for panic records, @panic_write must be valid.
>> If panic occurs and pstore/blk does not recover yet, the first zone
>> of dmesg will be used.
> 
> I'd like to maintain pstore terminology here: there is the "front end"
> (dmesg, console, pmsg, etc) and there is the "back end" (ramoops,
> blkoops, efi, etc). Since the block layer is a behind blkoops, I'd like
> to come up with a term for this since "device driver" is, I think, too
> general. You call it later "block device driver", so let's use that
> everywhere you say "device driver".
> 
> Then we have the layers: pstore front end, pstore core, pstore back end,
> and block device driver.
> 

The device driver here means block device driver and non-block device
driver.
It is loose to just name it as "block device driver".

Somethings about layer as below...

>> Besides, Block device driver has no need to verify which partition is
>> used and provides generic read/write operations. Because blkoops has
>> done it. It also means that if users do not care panic records but
>> records for oops/console/pmsg/ftrace, block device driver should do
>> nothing.
>>
>> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
>> ---
>>  MAINTAINERS             |   2 +-
>>  fs/pstore/Kconfig       |  61 ++++++++
>>  fs/pstore/Makefile      |   2 +
>>  fs/pstore/blkoops.c     | 402 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/blkoops.h |  58 +++++++
>>  5 files changed, 524 insertions(+), 1 deletion(-)
>>  create mode 100644 fs/pstore/blkoops.c
>>  create mode 100644 include/linux/blkoops.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cc0a4a8ae06a..e4ba97130560 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13381,7 +13381,7 @@ F:	drivers/firmware/efi/efi-pstore.c
>>  F:	drivers/acpi/apei/erst.c
>>  F:	Documentation/admin-guide/ramoops.rst
>>  F:	Documentation/devicetree/bindings/reserved-memory/ramoops.txt
>> -K:	\b(pstore|ramoops)
>> +K:	\b(pstore|ramoops|blkoops)
>>  
>>  PTP HARDWARE CLOCK SUPPORT
>>  M:	Richard Cochran <richardcochran@gmail.com>
>> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
>> index 536fde9e13e8..7a57a8edb612 100644
>> --- a/fs/pstore/Kconfig
>> +++ b/fs/pstore/Kconfig
>> @@ -163,3 +163,64 @@ config PSTORE_BLK
>>  	  where it can be read back at some later point.
>>  
>>  	  If unsure, say N.
>> +
>> +config PSTORE_BLKOOPS
>> +	tristate "pstore block with oops logger"
>> +	depends on PSTORE_BLK
>> +	help
>> +	  This is a wrapper for pstore/blk.
> 
> Is there a reason to keep this separate from PSTORE_BLK? (i.e. why a
> separate Kconfig?)
> 

Well, I think it's time to explain my design ideas.

Before blkoops, I read through the code of ramoops.
How similar blkoops is to ramoops and their management of storage
space is completely repetitive. The only difference between of them,
I think, is just different storage media.

So, why not extract a common layer from ramoops and blkoops to allocate
and manager storage sapce? That is what psotre/blk (blkzone.c) do. The
ramoops and the blkoops do not care about the use of storage.

I don't know whether the common layer is good enough to ramoops and
whether is good time to rename the common layer from pstore/blk to
psotre/zone?

How about Makefile and Kconfig as follow?

	<Kconfig>
	config PSOTRE_ZONE
		# NOTE.
		# the configuration is hidden from users and selected by
		# pstore/blk.
		help
		  The common layer for pstore/blk (and pstore/ram in the future)
		  to manager storage as zones.
	config PSTORE_BLK
		tristate "Log panic/oops to a block device"
		select PSOTRE_ZONE
		help
		  ......
	config PSTORE_BLK_DMESG_SIZE
		......

	<Makefile>
	#  Note: rename blkzone.c to pstore_zone.c
	obj-$(CONFIG_PSTORE_ZONE) += pstore_zone.c

	# Note: rename blkoops.c to pstore_blk.c
	obj-$(CONFIG_PSTORE_BLK) += pstore_blk.c

>> +
>> +	  NOTE that, both kconfig and module parameters can configure blkoops,
>> +	  but module parameters have priority over kconfig.
>> +
>> +	  If unsure, say N.
>> +
>> +config PSTORE_BLKOOPS_DMESG_SIZE
>> +	int "dmesg size in kbytes for blkoops"
> 
> How about "Size in Kbytes of dmesg to store"? (It will already show up
> under the parent config, so no need to repeat "blkoops" here.
> 

That's good idea.

>> +	depends on PSTORE_BLKOOPS
>> +	default 64
>> +	help
>> +	  This just sets size of dmesg (dmesg_size) for pstore/blk. The size is
>> +	  in KB and must be a multiple of 4.
>> +
>> +	  NOTE that, both kconfig and module parameters can configure blkoops,
> 
> nit: "Kconfig" instead of "kconfig"
> 

Fixed.

>> +	  but module parameters have priority over kconfig.
>>
>> +config PSTORE_BLKOOPS_BLKDEV
>> +	string "block device for blkoops"
> 
> Maybe clarify with as "block device identifier for blkoops" ? Also, I'd
> put this before the DMESG_SIZE.
> 

OK.

>> +	depends on PSTORE_BLKOOPS
>> +	default ""
>> +	help
>> +	  Which block device should be used for pstore/blk.
>> +
>> +	  It accept the following variants:
>> +	  1) <hex_major><hex_minor> device number in hexadecimal represents
>> +	     itself no leading 0x, for example b302.
>> +	  2) /dev/<disk_name> represents the device number of disk
>> +	  3) /dev/<disk_name><decimal> represents the device number
>> +	     of partition - device number of disk plus the partition number
>> +	  4) /dev/<disk_name>p<decimal> - same as the above, this form is
>> +	     used when disk name of partitioned disk ends with a digit.
>> +	  5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
>> +	     unique id of a partition if the partition table provides it.
>> +	     The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
>> +	     partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
>> +	     filled hex representation of the 32-bit "NT disk signature", and PP
>> +	     is a zero-filled hex representation of the 1-based partition number.
>> +	  6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation
>> +	     to a partition with a known unique id.
>> +	  7) <major>:<minor> major and minor number of the device separated by
>> +	     a colon.
>> +
>> +	  NOTE that, both kconfig and module parameters can configure blkoops,
>> +	  but module parameters have priority over kconfig.
>> +
>> +config PSTORE_BLKOOPS_DUMP_OOPS
>> +	bool "dump oops"
> 
> Why is this a Kconfig at all? Isn't the whole point to always catch
> oopses? :) Let's leave this default to 1 (as ramoops does).
> 

You can see as bellow, it's default 'y'.

>> +	depends on PSTORE_BLKOOPS
>> +	default y
>> +	help
>> +	  Whether blkoops dumps oops or not.
>> +
>> +	  NOTE that, both kconfig and module parameters can configure blkoops,
>> +	  but module parameters have priority over kconfig.
>> diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
>> index 0ee2fc8d1bfb..24b3d488d2f0 100644
>> --- a/fs/pstore/Makefile
>> +++ b/fs/pstore/Makefile
>> @@ -15,3 +15,5 @@ obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
>>  
>>  obj-$(CONFIG_PSTORE_BLK) += pstore_blk.o
>>  pstore_blk-y += blkzone.o
>> +
>> +obj-$(CONFIG_PSTORE_BLKOOPS) += blkoops.o
>> diff --git a/fs/pstore/blkoops.c b/fs/pstore/blkoops.c
>> new file mode 100644
>> index 000000000000..8027c3af8c8d
>> --- /dev/null
>> +++ b/fs/pstore/blkoops.c
>> @@ -0,0 +1,402 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#define pr_fmt(fmt) "blkoops : " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/string.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/blkoops.h>
>> +#include <linux/mount.h>
>> +#include <linux/uio.h>
>> +
>> +static long dmesg_size = -1;
>> +module_param(dmesg_size, long, 0400);
>> +MODULE_PARM_DESC(dmesg_size, "demsg size in kbytes");
> 
> Can this be named "record_size" to match ramoops?
> 

To be honest, I named it dmesg_size on purpose since I think
record_size is ambiguous. It describes the size of dmesg recorder
rather than size of all recorder.

>> +static int dump_oops = -1;
> 
> I'd default this to 1 as mentioned in the Kconfig.
> 

dump_oops defaults to -1 means using configuration on Kconfig,
while the default value on Kconfig is 1, which means default to
catch oopses.

Module parameters have priority over Kconfig. If we defualt module
parameter dump_oops to 1 at here, configuration on Kconfig will run
out  of work.

>> +module_param(dump_oops, int, 0400);
>> +MODULE_PARM_DESC(total_size, "whether dump oops");
>> +
>> +/**
>> + * The block device to use. Most of the time, it is a partition of block
>> + * device. It's fine to ignore it if you are not block device and register
>> + * to blkoops by blkoops_register_device(). In this case, @blkdev is
>> + * useless and @read, @write and @total_size must be supplied.
>> + *
>> + * @blkdev accepts the following variants:
>> + * 1) <hex_major><hex_minor> device number in hexadecimal represents itself
>> + *    no leading 0x, for example b302.
>> + * 2) /dev/<disk_name> represents the device number of disk
>> + * 3) /dev/<disk_name><decimal> represents the device number
>> + *    of partition - device number of disk plus the partition number
>> + * 4) /dev/<disk_name>p<decimal> - same as the above, that form is
>> + *    used when disk name of partitioned disk ends on a digit.
>> + * 5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
>> + *    unique id of a partition if the partition table provides it.
>> + *    The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
>> + *    partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
>> + *    filled hex representation of the 32-bit "NT disk signature", and PP
>> + *    is a zero-filled hex representation of the 1-based partition number.
>> + * 6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to
>> + *    a partition with a known unique id.
>> + * 7) <major>:<minor> major and minor number of the device separated by
>> + *    a colon.
>> + */
>> +static char blkdev[80];
> 
> static char blkdev[80] = CONFIG_PSTORE_BLKOOPS_BLKDEV;
> 

That's good idea.

>> +module_param_string(blkdev, blkdev, 80, 0400);
>> +MODULE_PARM_DESC(blkdev, "the block device for general read/write");
>> +
>> +static DEFINE_MUTEX(blkz_lock);
>> +static struct block_device *blkoops_bdev;
>> +static struct blkz_info *bzinfo;
>> +static blkoops_blk_panic_write_op blkdev_panic_write;
>> +
>> +#ifdef CONFIG_PSTORE_BLKOOPS_DMESG_SIZE
> 
> This (and all the others below) will always be defined, so no need to
> test it -- just use it as needed below.
> 

It's fine to dmesg_size and dump_oops but not pmsg_size, ftrace_size
and console_size, because they will be not available sometimes.

I disagree to use "default 64 if PSTORE_PMSG" instead of
"depends on PSTORE_PMSG", and explain in patch 3.

>> +#define DEFAULT_DMESG_SIZE CONFIG_PSTORE_BLKOOPS_DMESG_SIZE
>> +#else
>> +#define DEFAULT_DMESG_SIZE 0
>> +#endif
>> +
>> +#ifdef CONFIG_PSTORE_BLKOOPS_DUMP_OOPS
>> +#define DEFAULT_DUMP_OOPS CONFIG_PSTORE_BLKOOPS_DUMP_OOPS
>> +#else
>> +#define DEFAULT_DUMP_OOPS 1
>> +#endif
>> +
>> +#ifdef CONFIG_PSTORE_BLKOOPS_BLKDEV
>> +#define DEFAULT_BLKDEV CONFIG_PSTORE_BLKOOPS_BLKDEV
>> +#else
>> +#define DEFAULT_BLKDEV ""
>> +#endif
>> +
>> +/**
>> + * register device to blkoops
>> + *
>> + * Drivers, not only block drivers but also non-block drivers can call this
>> + * function to register to blkoops. It will pack for blkzone and pstore.
>> + */
>> +int blkoops_register_device(struct blkoops_device *bo_dev)
>> +{
>> +	int ret;
>> +
>> +	if (!bo_dev || !bo_dev->total_size || !bo_dev->read || !bo_dev->write)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&blkz_lock);
>> +
>> +	/* someone already registered before */
>> +	if (bzinfo) {
>> +		mutex_unlock(&blkz_lock);
>> +		return -EBUSY;
>> +	}
>> +	bzinfo = kzalloc(sizeof(struct blkz_info), GFP_KERNEL);
>> +	if (!bzinfo) {
>> +		mutex_unlock(&blkz_lock);
>> +		return -ENOMEM;
>> +	}
>> +
>> +#define verify_size(name, defsize, alignsize) {				\
>> +		long _##name_ = (name);					\
>> +		if (_##name_ < 0)					\
>> +			_##name_ = (defsize);				\
>> +		_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
>> +		if (_##name_ & ((alignsize) - 1)) {			\
>> +			pr_info(#name " must align to %d\n",		\
>> +					(alignsize));			\
>> +			_##name_ = ALIGN(name, (alignsize));		\
>> +		}							\
>> +		name = _##name_ / 1024;					\
>> +		bzinfo->name = _##name_;				\
>> +	}
>> +
>> +	verify_size(dmesg_size, DEFAULT_DMESG_SIZE, 4096);
>> +#undef verify_size
> 
> As mentioned, can this be named "record_size"?
> 

See above. Thanks.

>> +	dump_oops = !!(dump_oops < 0 ? DEFAULT_DUMP_OOPS : dump_oops);
>> +
>> +	bzinfo->total_size = bo_dev->total_size;
>> +	bzinfo->dump_oops = dump_oops;
>> +	bzinfo->read = bo_dev->read;
>> +	bzinfo->write = bo_dev->write;
> 
> Why copy these separate functions? Shouldn't bzinfo just keep a pointer
> to bo_dev?
> 

bo_dev is a structure defined in blkoops and not available to bzinfo.

At the very beginning of my design, the pstore/blk is a common layer
for  blkoops and ramoops. So, it's not suitable for bzinfo to keep a
pointer to structure of blkoops.

>> +	bzinfo->panic_write = bo_dev->panic_write;
>> +	bzinfo->name = "blkoops";
>> +	bzinfo->owner = THIS_MODULE;
>> +
>> +	ret = blkz_register(bzinfo);
>> +	if (ret) {
>> +		kfree(bzinfo);
>> +		bzinfo = NULL;
>> +	}
>> +	mutex_unlock(&blkz_lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(blkoops_register_device);
>> +
>> +void blkoops_unregister_device(struct blkoops_device *bo_dev)
>> +{
>> +	mutex_lock(&blkz_lock);
>> +	if (bzinfo && bzinfo->read == bo_dev->read) {
> 
> Why this read equality test?
> 

To identify the driver avoiding illegal unregister.

>> +		blkz_unregister(bzinfo);
>> +		kfree(bzinfo);
>> +		bzinfo = NULL;
>> +	}
>> +	mutex_unlock(&blkz_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(blkoops_unregister_device);
>> +
>> +/**
>> + * get block_device of @blkdev
>> + * @holder: exclusive holder identifier
>> + *
>> + * On success, @blkoops_bdev will save the block_device and the returned
>> + * block_device has reference count of one.
>> + */
>> +static struct block_device *blkoops_get_bdev(void *holder)
>> +{
>> +	struct block_device *bdev = ERR_PTR(-ENODEV);
>> +	fmode_t mode = FMODE_READ | FMODE_WRITE;
>> +
>> +	if (!blkdev[0] && strlen(DEFAULT_BLKDEV))
>> +		snprintf(blkdev, 80, "%s", DEFAULT_BLKDEV);
>> +	if (!blkdev[0])
>> +		return ERR_PTR(-ENODEV);
> 
> I'd drop these tests -- and the snprintf isn't needed with the change
> above on initialization.
> 

OK.

>> +
>> +	mutex_lock(&blkz_lock);
>> +	if (bzinfo)
>> +		goto out;
>> +	if (holder)
>> +		mode |= FMODE_EXCL;
>> +	bdev = blkdev_get_by_path(blkdev, mode, holder);
>> +	if (IS_ERR(bdev)) {
>> +		dev_t devt;
>> +
>> +		devt = name_to_dev_t(blkdev);
>> +		if (devt == 0) {
>> +			bdev = ERR_PTR(-ENODEV);
>> +			goto out;
>> +		}
>> +		bdev = blkdev_get_by_dev(devt, mode, holder);
>> +	}
>> +out:
>> +	mutex_unlock(&blkz_lock);
>> +	return bdev;
>> +}
>> +
>> +static void blkoops_put_bdev(struct block_device *bdev, void *holder)
>> +{
>> +	fmode_t mode = FMODE_READ | FMODE_WRITE;
>> +
>> +	if (!bdev)
>> +		return;
>> +
>> +	mutex_lock(&blkz_lock);
>> +	if (holder)
>> +		mode |= FMODE_EXCL;
>> +	blkdev_put(bdev, mode);
>> +	mutex_unlock(&blkz_lock);
>> +}
>> +
>> +static ssize_t blkoops_generic_blk_read(char *buf, size_t bytes, loff_t pos)
>> +{
>> +	ssize_t ret;
>> +	struct block_device *bdev = blkoops_bdev;
>> +	struct file filp;
>> +	mm_segment_t ofs;
>> +	struct kiocb kiocb;
>> +	struct iov_iter iter;
>> +	struct iovec iov = {
>> +		.iov_base = (void __user *)buf,
>> +		.iov_len = bytes
>> +	};
>> +
>> +	if (!bdev)
>> +		return -ENODEV;
>> +
>> +	memset(&filp, 0, sizeof(struct file));
>> +	filp.f_mapping = bdev->bd_inode->i_mapping;
>> +	filp.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
>> +	filp.f_inode = bdev->bd_inode;
>> +
>> +	init_sync_kiocb(&kiocb, &filp);
>> +	kiocb.ki_pos = pos;
>> +	iov_iter_init(&iter, READ, &iov, 1, bytes);
>> +
>> +	ofs = get_fs();
>> +	set_fs(KERNEL_DS);
>> +	ret = generic_file_read_iter(&kiocb, &iter);
>> +	set_fs(ofs);
> 
> Please don't use "set_fs". I think you want ITER_KVEC and to use
> vfs_iter_read()? A lot of work went into removing set_fs() uses; we
> should not add more. :)
> https://lwn.net/Articles/722267/
> 

You are right. I will change to use ITER_KVEC to remove set_fs().

I will keep generic_file_read_iter() rather than vfs_iter_read().
Blkoops fails to read/write with vfs_iter_read/write() since it
does not have a valid 'struct file' to block device. It's so ugly
to vfs_open() block_device to get 'struct file'. Why not just use
interfaces on generic block layer because we have got
struct block_dev already.

Besides, SELinux reports error if we open, read, and write to
a block directly.

>> +	return ret;
>> +}
>> +
>> +static ssize_t blkoops_generic_blk_write(const char *buf, size_t bytes,
>> +		loff_t pos)
>> +{
>> +	struct block_device *bdev = blkoops_bdev;
>> +	struct iov_iter iter;
>> +	struct kiocb kiocb;
>> +	struct file filp;
>> +	mm_segment_t ofs;
>> +	ssize_t ret;
>> +	struct iovec iov = {
>> +		.iov_base = (void __user *)buf,
>> +		.iov_len = bytes
>> +	};
>> +
>> +	if (!bdev)
>> +		return -ENODEV;
>> +
>> +	/* Console/Ftrace recorder may handle buffer until flush dirty zones */
>> +	if (in_interrupt() || irqs_disabled())
>> +		return -EBUSY;
>> +
>> +	memset(&filp, 0, sizeof(struct file));
>> +	filp.f_mapping = bdev->bd_inode->i_mapping;
>> +	filp.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
>> +	filp.f_inode = bdev->bd_inode;
>> +
>> +	init_sync_kiocb(&kiocb, &filp);
>> +	kiocb.ki_pos = pos;
>> +	iov_iter_init(&iter, WRITE, &iov, 1, bytes);
>> +
>> +	ofs = get_fs();
>> +	set_fs(KERNEL_DS);
> 
> Same.
> 

Done.

>> +
>> +	inode_lock(bdev->bd_inode);
>> +	ret = generic_write_checks(&kiocb, &iter);
>> +	if (ret > 0)
>> +		ret = generic_perform_write(&filp, &iter, pos);
>> +	inode_unlock(bdev->bd_inode);
>> +
>> +	if (likely(ret > 0)) {
>> +		const struct file_operations f_op = {.fsync = blkdev_fsync};
>> +
>> +		filp.f_op = &f_op;
>> +		kiocb.ki_pos += ret;
>> +		ret = generic_write_sync(&kiocb, ret);
>> +	}
>> +	set_fs(ofs);
>> +	return ret;
>> +}
>> +
>> +static inline unsigned long blkoops_bdev_size(struct block_device *bdev)
>> +{
>> +	return (unsigned long)part_nr_sects_read(bdev->bd_part) << SECTOR_SHIFT;
>> +}
>> +
>> +static ssize_t blkoops_blk_panic_write(const char *buf, size_t size,
>> +		loff_t off)
>> +{
>> +	int ret;
>> +
>> +	if (!blkdev_panic_write)
>> +		return -EOPNOTSUPP;
>> +
>> +	/* size and off must align to SECTOR_SIZE for block device */
>> +	ret = blkdev_panic_write(buf, off >> SECTOR_SHIFT,
>> +			size >> SECTOR_SHIFT);
>> +	return ret ? -EIO : size;
>> +}
>> +
>> +/**
>> + * register block device to blkoops
>> + * @major: the major device number of registering device
>> + * @panic_write: the write interface for panic case.
>> + *
>> + * It is ONLY used for block device to register to blkoops. In this case,
>> + * the module parameter @blkdev must be valid. Generic read/write interfaces
>> + * will be used.
>> + *
>> + * Block driver has no need to verify which partition is used. Block driver
>> + * should only tell me what major number is, so blkoops can get the matching
>> + * driver for @blkdev.
>> + *
>> + * If block driver support for panic records, @panic_write must be valid. If
>> + * panic occurs but pstore/blk does not recover yet, the first zone of dmesg
>> + * will be used.
>> + */
>> +int blkoops_register_blkdev(unsigned int major,
>> +		blkoops_blk_panic_write_op panic_write)
>> +{
>> +	struct block_device *bdev;
>> +	struct blkoops_device bo_dev = {0};
>> +	int ret = -ENODEV;
>> +	void *holder = blkdev;
>> +
>> +	bdev = blkoops_get_bdev(holder);
>> +	if (IS_ERR(bdev))
>> +		return PTR_ERR(bdev);
> 
> This seems like a good place to report getting or failing to get the
> named block device.
> 
> 	bdev = blkoops_get_bdev(holder);
> 	if (IS_ERR(bdev)) {
> 		pr_err("failed to open '%s'!\n", blkdev);
> 		return PTR_ERR(bdev);
> 	}
> 

OK.

>> +
>> +	blkoops_bdev = bdev;
>> +	blkdev_panic_write = panic_write;
>> +
>> +	/* only allow driver matching the @blkdev */
>> +	if (!bdev->bd_dev || MAJOR(bdev->bd_dev) != major)
> 
> And add similar error reports here.
> 

I'd  use pr_debug rather than pr_err. Because we allow mulitiple
devices to attempt to register to blkoops. It's not an error.

pr_debug("invalid major %u (expect %u)\n", major, MAJOR(bdev->bd_dev));

>> +		goto err_put_bdev;
>> +
>> +	bo_dev.total_size = blkoops_bdev_size(bdev);
>> +	if (bo_dev.total_size == 0)
>> +		goto err_put_bdev;
> 
> And here. We want to make failures as discoverable as possible.
> 

You are right.

>> +	bo_dev.panic_write = panic_write ? blkoops_blk_panic_write : NULL;
>> +	bo_dev.read = blkoops_generic_blk_read;
>> +	bo_dev.write = blkoops_generic_blk_write;
>> +
>> +	ret = blkoops_register_device(&bo_dev);
>> +	if (ret)
>> +		goto err_put_bdev;
> 
> 	pr_info("using '%s'\n", blkdev);
> 

OK.

>> +	return 0;
>> +
>> +err_put_bdev:
>> +	blkdev_panic_write = NULL;
>> +	blkoops_bdev = NULL;
>> +	blkoops_put_bdev(bdev, holder);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(blkoops_register_blkdev);
>> +
>> +void blkoops_unregister_blkdev(unsigned int major)
>> +{
>> +	struct blkoops_device bo_dev = {.read = blkoops_generic_blk_read};
>> +	void *holder = blkdev;
>> +
>> +	if (blkoops_bdev && MAJOR(blkoops_bdev->bd_dev) == major) {
>> +		blkoops_unregister_device(&bo_dev);
>> +		blkoops_put_bdev(blkoops_bdev, holder);
>> +		blkdev_panic_write = NULL;
>> +		blkoops_bdev = NULL;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(blkoops_unregister_blkdev);
>> +
>> +/**
>> + * get information of @blkdev
>> + * @devt: the block device num of @blkdev
>> + * @nr_sectors: the sector count of @blkdev
>> + * @start_sect: the start sector of @blkdev
>> + *
>> + * Block driver needs the follow information for @panic_write.
>> + */
>> +int blkoops_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect)
>> +{
>> +	struct block_device *bdev;
>> +
>> +	bdev = blkoops_get_bdev(NULL);
>> +	if (IS_ERR(bdev))
>> +		return PTR_ERR(bdev);
>> +
>> +	if (devt)
>> +		*devt = bdev->bd_dev;
>> +	if (nr_sects)
>> +		*nr_sects = part_nr_sects_read(bdev->bd_part);
>> +	if (start_sect)
>> +		*start_sect = get_start_sect(bdev);
>> +
>> +	blkoops_put_bdev(bdev, NULL);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(blkoops_blkdev_info);
> 
> I don't see this function getting used anywhere. Can it be removed? I
> see the notes in the Documentation. Could these values just be cached at
> open time instead of reopening the device?
> 

This function is reserved for block driver to get information about the
using
block device. So it can't be removed.

Sure, a new structrue is created to cached these values.

>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
>> +MODULE_DESCRIPTION("Wrapper for Pstore BLK with Oops logger");
>> diff --git a/include/linux/blkoops.h b/include/linux/blkoops.h
>> new file mode 100644
>> index 000000000000..fe63739309aa
>> --- /dev/null
>> +++ b/include/linux/blkoops.h
>> @@ -0,0 +1,58 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __BLKOOPS_H_
>> +#define __BLKOOPS_H_
>> +
>> +#include <linux/types.h>
>> +#include <linux/blkdev.h>
>> +#include <linux/pstore_blk.h>
>> +
>> +/**
>> + * struct blkoops_device - backend blkoops driver structure.
>> + *
>> + * This structure is ONLY used for non-block device by
>> + * blkoops_register_device(). If block device, you are strongly recommended
>> + * to use blkoops_register_blkdev().
>> + *
>> + * @total_size:
>> + *	The total size in bytes pstore/blk can use. It must be greater than
>> + *	4096 and be multiple of 4096.
>> + * @read, @write:
>> + *	The general (not panic) read/write operation.
>> + *
>> + *	Both of the @size and @offset parameters on this interface are
>> + *	the relative size of the space provided, not the whole disk/flash.
>> + *
>> + *	On success, the number of bytes read should be returned.
>> + *	On error, negative number should be returned.
>> + * @panic_write:
>> + *	The write operation only used for panic.
>> + *
>> + *	Both of the @size and @offset parameters on this interface are
>> + *	the relative size of the space provided, not the whole disk/flash.
>> + *
>> + *	On success, the number of bytes read should be returned.
>> + *	On error, negative number should be returned.
>> + */
>> +struct blkoops_device {
>> +	unsigned long total_size;
>> +	blkz_read_op read;
>> +	blkz_write_op write;
>> +	blkz_write_op panic_write;
>> +};
>> +
>> +/*
>> + * Panic write for block device who should write alignmemt to SECTOR_SIZE.
>> + * On success, zero should be returned. Others mean error.
>> + */
>> +typedef int (*blkoops_blk_panic_write_op)(const char *buf, sector_t start_sect,
>> +		sector_t sects);
>> +
>> +int  blkoops_register_device(struct blkoops_device *bo_dev);
>> +void blkoops_unregister_device(struct blkoops_device *bo_dev);
>> +int  blkoops_register_blkdev(unsigned int major,
>> +		blkoops_blk_panic_write_op panic_write);
>> +void blkoops_unregister_blkdev(unsigned int major);
>> +int  blkoops_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect);
>> +
>> +#endif
>> -- 
>> 1.9.1
>>
> 

-- 
WeiXiong Liao
