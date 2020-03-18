Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EC6C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FC720753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LvQR5aT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCRSGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:06:46 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55371 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgCRSGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:06:44 -0400
Received: by mail-pj1-f65.google.com with SMTP id mj6so1665742pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=StLuTsbAJNFgHj9ykAiO/YD+Gjl6VSt3gLGFM9EiX2w=;
        b=LvQR5aT2w9gZx1EAFZdbubKq7pspVbSKeabr+dBvRk/ASUYwz8S3Tww51MjYqse9UX
         91qU43PQhmoYMwrj9VlzioTYM5bMMy6ZDjD2zHibmkLZT0FVVPuVAnoA940QgJxFHy0Z
         poM2Nslr3Gj+yExmoucIxFPpg8yentrp2eDxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=StLuTsbAJNFgHj9ykAiO/YD+Gjl6VSt3gLGFM9EiX2w=;
        b=eATGno1tztX1WjDi9OR56diYndlJ+9DBtrWATbyMPPerxln98XNFf1QoRMr+qMQweM
         frfOh0RndcgbanYMrKukOL7m4hkax1mc8kfYKNnXXBuBsdELyjipMvwTawxHmufoH8Lb
         RFz1u7lzufPz0nS29kdn7UA2JjVoJZxPaqD1hDExNcXYBjGdpv322q3YCBiWAkXS+85p
         611ERMGWEVPdAj2zpiMdO4eLrHzG0ElKjHolBSkJg/VsxdEVaJIY53oC1pRAF8FIwajf
         bXEJsB3OoxC4+c7nn+yR0dZnH7CXxWDUZ5e5L9HyD/dAirDab/f7v43wxJGZk43Xvufu
         lNAg==
X-Gm-Message-State: ANhLgQ3ikPNhK2ZF8SG/w8LvMFWaZRKTGa4M3vutC8JWzcLGmTpCWIRY
        kZvC3qp+yhioFmGy5LIm7hCf4w==
X-Google-Smtp-Source: ADFU+vvRlwA0LZ9KP5rmbRl2mgti1nj2cWcZL2YYuP9kiKy8Yf2dakTV9Ih1AKSAhyD/TrN3BDvMMQ==
X-Received: by 2002:a17:90a:730b:: with SMTP id m11mr5903587pjk.195.1584554803163;
        Wed, 18 Mar 2020 11:06:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d11sm7208962pfo.39.2020.03.18.11.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 11:06:42 -0700 (PDT)
Date:   Wed, 18 Mar 2020 11:06:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
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
Subject: Re: [PATCH v2 02/11] blkoops: add blkoops, a warpper for pstore/blk
Message-ID: <202003181025.20B6978@keescook>
References: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1581078355-19647-3-git-send-email-liaoweixiong@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581078355-19647-3-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 08:25:46PM +0800, WeiXiong Liao wrote:
> blkoops is a better wrapper for pstore/blk, which provides efficient
> configuration mothod. It divides all configurations of pstore/blk into

typo: method

> 2 parts, configurations for user and configurations for driver.
> 
> Configurations for user detemine how pstore/blk work, such as
> dump_oops and dmesg_size. They can be set by Kconfig and module
> parameters.

I'd like to keep blkoops as close to ramoops as possible on the user
configuration side. Notes below...

> Configurations for driver are all about block/non-block device, such as
> total_size of device and read/write operations. They should be provided
> by device drivers, calling blkoops_register_device() for non-block
> device and blkoops_register_blkdev() for block device.

By non-block do you mean nvme etc? What is the right term for spinning
disk and nvme collectively? (I always considered them all to be "block"
devices.)

> If device driver support for panic records, @panic_write must be valid.
> If panic occurs and pstore/blk does not recover yet, the first zone
> of dmesg will be used.

I'd like to maintain pstore terminology here: there is the "front end"
(dmesg, console, pmsg, etc) and there is the "back end" (ramoops,
blkoops, efi, etc). Since the block layer is a behind blkoops, I'd like
to come up with a term for this since "device driver" is, I think, too
general. You call it later "block device driver", so let's use that
everywhere you say "device driver".

Then we have the layers: pstore front end, pstore core, pstore back end,
and block device driver.

> Besides, Block device driver has no need to verify which partition is
> used and provides generic read/write operations. Because blkoops has
> done it. It also means that if users do not care panic records but
> records for oops/console/pmsg/ftrace, block device driver should do
> nothing.
> 
> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
> ---
>  MAINTAINERS             |   2 +-
>  fs/pstore/Kconfig       |  61 ++++++++
>  fs/pstore/Makefile      |   2 +
>  fs/pstore/blkoops.c     | 402 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/blkoops.h |  58 +++++++
>  5 files changed, 524 insertions(+), 1 deletion(-)
>  create mode 100644 fs/pstore/blkoops.c
>  create mode 100644 include/linux/blkoops.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc0a4a8ae06a..e4ba97130560 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13381,7 +13381,7 @@ F:	drivers/firmware/efi/efi-pstore.c
>  F:	drivers/acpi/apei/erst.c
>  F:	Documentation/admin-guide/ramoops.rst
>  F:	Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> -K:	\b(pstore|ramoops)
> +K:	\b(pstore|ramoops|blkoops)
>  
>  PTP HARDWARE CLOCK SUPPORT
>  M:	Richard Cochran <richardcochran@gmail.com>
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 536fde9e13e8..7a57a8edb612 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -163,3 +163,64 @@ config PSTORE_BLK
>  	  where it can be read back at some later point.
>  
>  	  If unsure, say N.
> +
> +config PSTORE_BLKOOPS
> +	tristate "pstore block with oops logger"
> +	depends on PSTORE_BLK
> +	help
> +	  This is a wrapper for pstore/blk.

Is there a reason to keep this separate from PSTORE_BLK? (i.e. why a
separate Kconfig?)

> +
> +	  NOTE that, both kconfig and module parameters can configure blkoops,
> +	  but module parameters have priority over kconfig.
> +
> +	  If unsure, say N.
> +
> +config PSTORE_BLKOOPS_DMESG_SIZE
> +	int "dmesg size in kbytes for blkoops"

How about "Size in Kbytes of dmesg to store"? (It will already show up
under the parent config, so no need to repeat "blkoops" here.

> +	depends on PSTORE_BLKOOPS
> +	default 64
> +	help
> +	  This just sets size of dmesg (dmesg_size) for pstore/blk. The size is
> +	  in KB and must be a multiple of 4.
> +
> +	  NOTE that, both kconfig and module parameters can configure blkoops,

nit: "Kconfig" instead of "kconfig"

> +	  but module parameters have priority over kconfig.
>
> +config PSTORE_BLKOOPS_BLKDEV
> +	string "block device for blkoops"

Maybe clarify with as "block device identifier for blkoops" ? Also, I'd
put this before the DMESG_SIZE.

> +	depends on PSTORE_BLKOOPS
> +	default ""
> +	help
> +	  Which block device should be used for pstore/blk.
> +
> +	  It accept the following variants:
> +	  1) <hex_major><hex_minor> device number in hexadecimal represents
> +	     itself no leading 0x, for example b302.
> +	  2) /dev/<disk_name> represents the device number of disk
> +	  3) /dev/<disk_name><decimal> represents the device number
> +	     of partition - device number of disk plus the partition number
> +	  4) /dev/<disk_name>p<decimal> - same as the above, this form is
> +	     used when disk name of partitioned disk ends with a digit.
> +	  5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
> +	     unique id of a partition if the partition table provides it.
> +	     The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
> +	     partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
> +	     filled hex representation of the 32-bit "NT disk signature", and PP
> +	     is a zero-filled hex representation of the 1-based partition number.
> +	  6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation
> +	     to a partition with a known unique id.
> +	  7) <major>:<minor> major and minor number of the device separated by
> +	     a colon.
> +
> +	  NOTE that, both kconfig and module parameters can configure blkoops,
> +	  but module parameters have priority over kconfig.
> +
> +config PSTORE_BLKOOPS_DUMP_OOPS
> +	bool "dump oops"

Why is this a Kconfig at all? Isn't the whole point to always catch
oopses? :) Let's leave this default to 1 (as ramoops does).

> +	depends on PSTORE_BLKOOPS
> +	default y
> +	help
> +	  Whether blkoops dumps oops or not.
> +
> +	  NOTE that, both kconfig and module parameters can configure blkoops,
> +	  but module parameters have priority over kconfig.
> diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
> index 0ee2fc8d1bfb..24b3d488d2f0 100644
> --- a/fs/pstore/Makefile
> +++ b/fs/pstore/Makefile
> @@ -15,3 +15,5 @@ obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
>  
>  obj-$(CONFIG_PSTORE_BLK) += pstore_blk.o
>  pstore_blk-y += blkzone.o
> +
> +obj-$(CONFIG_PSTORE_BLKOOPS) += blkoops.o
> diff --git a/fs/pstore/blkoops.c b/fs/pstore/blkoops.c
> new file mode 100644
> index 000000000000..8027c3af8c8d
> --- /dev/null
> +++ b/fs/pstore/blkoops.c
> @@ -0,0 +1,402 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define pr_fmt(fmt) "blkoops : " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/blkoops.h>
> +#include <linux/mount.h>
> +#include <linux/uio.h>
> +
> +static long dmesg_size = -1;
> +module_param(dmesg_size, long, 0400);
> +MODULE_PARM_DESC(dmesg_size, "demsg size in kbytes");

Can this be named "record_size" to match ramoops?

> +static int dump_oops = -1;

I'd default this to 1 as mentioned in the Kconfig.

> +module_param(dump_oops, int, 0400);
> +MODULE_PARM_DESC(total_size, "whether dump oops");
> +
> +/**
> + * The block device to use. Most of the time, it is a partition of block
> + * device. It's fine to ignore it if you are not block device and register
> + * to blkoops by blkoops_register_device(). In this case, @blkdev is
> + * useless and @read, @write and @total_size must be supplied.
> + *
> + * @blkdev accepts the following variants:
> + * 1) <hex_major><hex_minor> device number in hexadecimal represents itself
> + *    no leading 0x, for example b302.
> + * 2) /dev/<disk_name> represents the device number of disk
> + * 3) /dev/<disk_name><decimal> represents the device number
> + *    of partition - device number of disk plus the partition number
> + * 4) /dev/<disk_name>p<decimal> - same as the above, that form is
> + *    used when disk name of partitioned disk ends on a digit.
> + * 5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the
> + *    unique id of a partition if the partition table provides it.
> + *    The UUID may be either an EFI/GPT UUID, or refer to an MSDOS
> + *    partition using the format SSSSSSSS-PP, where SSSSSSSS is a zero-
> + *    filled hex representation of the 32-bit "NT disk signature", and PP
> + *    is a zero-filled hex representation of the 1-based partition number.
> + * 6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to
> + *    a partition with a known unique id.
> + * 7) <major>:<minor> major and minor number of the device separated by
> + *    a colon.
> + */
> +static char blkdev[80];

static char blkdev[80] = CONFIG_PSTORE_BLKOOPS_BLKDEV;

> +module_param_string(blkdev, blkdev, 80, 0400);
> +MODULE_PARM_DESC(blkdev, "the block device for general read/write");
> +
> +static DEFINE_MUTEX(blkz_lock);
> +static struct block_device *blkoops_bdev;
> +static struct blkz_info *bzinfo;
> +static blkoops_blk_panic_write_op blkdev_panic_write;
> +
> +#ifdef CONFIG_PSTORE_BLKOOPS_DMESG_SIZE

This (and all the others below) will always be defined, so no need to
test it -- just use it as needed below.

> +#define DEFAULT_DMESG_SIZE CONFIG_PSTORE_BLKOOPS_DMESG_SIZE
> +#else
> +#define DEFAULT_DMESG_SIZE 0
> +#endif
> +
> +#ifdef CONFIG_PSTORE_BLKOOPS_DUMP_OOPS
> +#define DEFAULT_DUMP_OOPS CONFIG_PSTORE_BLKOOPS_DUMP_OOPS
> +#else
> +#define DEFAULT_DUMP_OOPS 1
> +#endif
> +
> +#ifdef CONFIG_PSTORE_BLKOOPS_BLKDEV
> +#define DEFAULT_BLKDEV CONFIG_PSTORE_BLKOOPS_BLKDEV
> +#else
> +#define DEFAULT_BLKDEV ""
> +#endif
> +
> +/**
> + * register device to blkoops
> + *
> + * Drivers, not only block drivers but also non-block drivers can call this
> + * function to register to blkoops. It will pack for blkzone and pstore.
> + */
> +int blkoops_register_device(struct blkoops_device *bo_dev)
> +{
> +	int ret;
> +
> +	if (!bo_dev || !bo_dev->total_size || !bo_dev->read || !bo_dev->write)
> +		return -EINVAL;
> +
> +	mutex_lock(&blkz_lock);
> +
> +	/* someone already registered before */
> +	if (bzinfo) {
> +		mutex_unlock(&blkz_lock);
> +		return -EBUSY;
> +	}
> +	bzinfo = kzalloc(sizeof(struct blkz_info), GFP_KERNEL);
> +	if (!bzinfo) {
> +		mutex_unlock(&blkz_lock);
> +		return -ENOMEM;
> +	}
> +
> +#define verify_size(name, defsize, alignsize) {				\
> +		long _##name_ = (name);					\
> +		if (_##name_ < 0)					\
> +			_##name_ = (defsize);				\
> +		_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
> +		if (_##name_ & ((alignsize) - 1)) {			\
> +			pr_info(#name " must align to %d\n",		\
> +					(alignsize));			\
> +			_##name_ = ALIGN(name, (alignsize));		\
> +		}							\
> +		name = _##name_ / 1024;					\
> +		bzinfo->name = _##name_;				\
> +	}
> +
> +	verify_size(dmesg_size, DEFAULT_DMESG_SIZE, 4096);
> +#undef verify_size

As mentioned, can this be named "record_size"?

> +	dump_oops = !!(dump_oops < 0 ? DEFAULT_DUMP_OOPS : dump_oops);
> +
> +	bzinfo->total_size = bo_dev->total_size;
> +	bzinfo->dump_oops = dump_oops;
> +	bzinfo->read = bo_dev->read;
> +	bzinfo->write = bo_dev->write;

Why copy these separate functions? Shouldn't bzinfo just keep a pointer
to bo_dev?

> +	bzinfo->panic_write = bo_dev->panic_write;
> +	bzinfo->name = "blkoops";
> +	bzinfo->owner = THIS_MODULE;
> +
> +	ret = blkz_register(bzinfo);
> +	if (ret) {
> +		kfree(bzinfo);
> +		bzinfo = NULL;
> +	}
> +	mutex_unlock(&blkz_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(blkoops_register_device);
> +
> +void blkoops_unregister_device(struct blkoops_device *bo_dev)
> +{
> +	mutex_lock(&blkz_lock);
> +	if (bzinfo && bzinfo->read == bo_dev->read) {

Why this read equality test?

> +		blkz_unregister(bzinfo);
> +		kfree(bzinfo);
> +		bzinfo = NULL;
> +	}
> +	mutex_unlock(&blkz_lock);
> +}
> +EXPORT_SYMBOL_GPL(blkoops_unregister_device);
> +
> +/**
> + * get block_device of @blkdev
> + * @holder: exclusive holder identifier
> + *
> + * On success, @blkoops_bdev will save the block_device and the returned
> + * block_device has reference count of one.
> + */
> +static struct block_device *blkoops_get_bdev(void *holder)
> +{
> +	struct block_device *bdev = ERR_PTR(-ENODEV);
> +	fmode_t mode = FMODE_READ | FMODE_WRITE;
> +
> +	if (!blkdev[0] && strlen(DEFAULT_BLKDEV))
> +		snprintf(blkdev, 80, "%s", DEFAULT_BLKDEV);
> +	if (!blkdev[0])
> +		return ERR_PTR(-ENODEV);

I'd drop these tests -- and the snprintf isn't needed with the change
above on initialization.

> +
> +	mutex_lock(&blkz_lock);
> +	if (bzinfo)
> +		goto out;
> +	if (holder)
> +		mode |= FMODE_EXCL;
> +	bdev = blkdev_get_by_path(blkdev, mode, holder);
> +	if (IS_ERR(bdev)) {
> +		dev_t devt;
> +
> +		devt = name_to_dev_t(blkdev);
> +		if (devt == 0) {
> +			bdev = ERR_PTR(-ENODEV);
> +			goto out;
> +		}
> +		bdev = blkdev_get_by_dev(devt, mode, holder);
> +	}
> +out:
> +	mutex_unlock(&blkz_lock);
> +	return bdev;
> +}
> +
> +static void blkoops_put_bdev(struct block_device *bdev, void *holder)
> +{
> +	fmode_t mode = FMODE_READ | FMODE_WRITE;
> +
> +	if (!bdev)
> +		return;
> +
> +	mutex_lock(&blkz_lock);
> +	if (holder)
> +		mode |= FMODE_EXCL;
> +	blkdev_put(bdev, mode);
> +	mutex_unlock(&blkz_lock);
> +}
> +
> +static ssize_t blkoops_generic_blk_read(char *buf, size_t bytes, loff_t pos)
> +{
> +	ssize_t ret;
> +	struct block_device *bdev = blkoops_bdev;
> +	struct file filp;
> +	mm_segment_t ofs;
> +	struct kiocb kiocb;
> +	struct iov_iter iter;
> +	struct iovec iov = {
> +		.iov_base = (void __user *)buf,
> +		.iov_len = bytes
> +	};
> +
> +	if (!bdev)
> +		return -ENODEV;
> +
> +	memset(&filp, 0, sizeof(struct file));
> +	filp.f_mapping = bdev->bd_inode->i_mapping;
> +	filp.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
> +	filp.f_inode = bdev->bd_inode;
> +
> +	init_sync_kiocb(&kiocb, &filp);
> +	kiocb.ki_pos = pos;
> +	iov_iter_init(&iter, READ, &iov, 1, bytes);
> +
> +	ofs = get_fs();
> +	set_fs(KERNEL_DS);
> +	ret = generic_file_read_iter(&kiocb, &iter);
> +	set_fs(ofs);

Please don't use "set_fs". I think you want ITER_KVEC and to use
vfs_iter_read()? A lot of work went into removing set_fs() uses; we
should not add more. :)
https://lwn.net/Articles/722267/

> +	return ret;
> +}
> +
> +static ssize_t blkoops_generic_blk_write(const char *buf, size_t bytes,
> +		loff_t pos)
> +{
> +	struct block_device *bdev = blkoops_bdev;
> +	struct iov_iter iter;
> +	struct kiocb kiocb;
> +	struct file filp;
> +	mm_segment_t ofs;
> +	ssize_t ret;
> +	struct iovec iov = {
> +		.iov_base = (void __user *)buf,
> +		.iov_len = bytes
> +	};
> +
> +	if (!bdev)
> +		return -ENODEV;
> +
> +	/* Console/Ftrace recorder may handle buffer until flush dirty zones */
> +	if (in_interrupt() || irqs_disabled())
> +		return -EBUSY;
> +
> +	memset(&filp, 0, sizeof(struct file));
> +	filp.f_mapping = bdev->bd_inode->i_mapping;
> +	filp.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
> +	filp.f_inode = bdev->bd_inode;
> +
> +	init_sync_kiocb(&kiocb, &filp);
> +	kiocb.ki_pos = pos;
> +	iov_iter_init(&iter, WRITE, &iov, 1, bytes);
> +
> +	ofs = get_fs();
> +	set_fs(KERNEL_DS);

Same.

> +
> +	inode_lock(bdev->bd_inode);
> +	ret = generic_write_checks(&kiocb, &iter);
> +	if (ret > 0)
> +		ret = generic_perform_write(&filp, &iter, pos);
> +	inode_unlock(bdev->bd_inode);
> +
> +	if (likely(ret > 0)) {
> +		const struct file_operations f_op = {.fsync = blkdev_fsync};
> +
> +		filp.f_op = &f_op;
> +		kiocb.ki_pos += ret;
> +		ret = generic_write_sync(&kiocb, ret);
> +	}
> +	set_fs(ofs);
> +	return ret;
> +}
> +
> +static inline unsigned long blkoops_bdev_size(struct block_device *bdev)
> +{
> +	return (unsigned long)part_nr_sects_read(bdev->bd_part) << SECTOR_SHIFT;
> +}
> +
> +static ssize_t blkoops_blk_panic_write(const char *buf, size_t size,
> +		loff_t off)
> +{
> +	int ret;
> +
> +	if (!blkdev_panic_write)
> +		return -EOPNOTSUPP;
> +
> +	/* size and off must align to SECTOR_SIZE for block device */
> +	ret = blkdev_panic_write(buf, off >> SECTOR_SHIFT,
> +			size >> SECTOR_SHIFT);
> +	return ret ? -EIO : size;
> +}
> +
> +/**
> + * register block device to blkoops
> + * @major: the major device number of registering device
> + * @panic_write: the write interface for panic case.
> + *
> + * It is ONLY used for block device to register to blkoops. In this case,
> + * the module parameter @blkdev must be valid. Generic read/write interfaces
> + * will be used.
> + *
> + * Block driver has no need to verify which partition is used. Block driver
> + * should only tell me what major number is, so blkoops can get the matching
> + * driver for @blkdev.
> + *
> + * If block driver support for panic records, @panic_write must be valid. If
> + * panic occurs but pstore/blk does not recover yet, the first zone of dmesg
> + * will be used.
> + */
> +int blkoops_register_blkdev(unsigned int major,
> +		blkoops_blk_panic_write_op panic_write)
> +{
> +	struct block_device *bdev;
> +	struct blkoops_device bo_dev = {0};
> +	int ret = -ENODEV;
> +	void *holder = blkdev;
> +
> +	bdev = blkoops_get_bdev(holder);
> +	if (IS_ERR(bdev))
> +		return PTR_ERR(bdev);

This seems like a good place to report getting or failing to get the
named block device.

	bdev = blkoops_get_bdev(holder);
	if (IS_ERR(bdev)) {
		pr_err("failed to open '%s'!\n", blkdev);
		return PTR_ERR(bdev);
	}

> +
> +	blkoops_bdev = bdev;
> +	blkdev_panic_write = panic_write;
> +
> +	/* only allow driver matching the @blkdev */
> +	if (!bdev->bd_dev || MAJOR(bdev->bd_dev) != major)

And add similar error reports here.

> +		goto err_put_bdev;
> +
> +	bo_dev.total_size = blkoops_bdev_size(bdev);
> +	if (bo_dev.total_size == 0)
> +		goto err_put_bdev;

And here. We want to make failures as discoverable as possible.

> +	bo_dev.panic_write = panic_write ? blkoops_blk_panic_write : NULL;
> +	bo_dev.read = blkoops_generic_blk_read;
> +	bo_dev.write = blkoops_generic_blk_write;
> +
> +	ret = blkoops_register_device(&bo_dev);
> +	if (ret)
> +		goto err_put_bdev;

	pr_info("using '%s'\n", blkdev);

> +	return 0;
> +
> +err_put_bdev:
> +	blkdev_panic_write = NULL;
> +	blkoops_bdev = NULL;
> +	blkoops_put_bdev(bdev, holder);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(blkoops_register_blkdev);
> +
> +void blkoops_unregister_blkdev(unsigned int major)
> +{
> +	struct blkoops_device bo_dev = {.read = blkoops_generic_blk_read};
> +	void *holder = blkdev;
> +
> +	if (blkoops_bdev && MAJOR(blkoops_bdev->bd_dev) == major) {
> +		blkoops_unregister_device(&bo_dev);
> +		blkoops_put_bdev(blkoops_bdev, holder);
> +		blkdev_panic_write = NULL;
> +		blkoops_bdev = NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(blkoops_unregister_blkdev);
> +
> +/**
> + * get information of @blkdev
> + * @devt: the block device num of @blkdev
> + * @nr_sectors: the sector count of @blkdev
> + * @start_sect: the start sector of @blkdev
> + *
> + * Block driver needs the follow information for @panic_write.
> + */
> +int blkoops_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect)
> +{
> +	struct block_device *bdev;
> +
> +	bdev = blkoops_get_bdev(NULL);
> +	if (IS_ERR(bdev))
> +		return PTR_ERR(bdev);
> +
> +	if (devt)
> +		*devt = bdev->bd_dev;
> +	if (nr_sects)
> +		*nr_sects = part_nr_sects_read(bdev->bd_part);
> +	if (start_sect)
> +		*start_sect = get_start_sect(bdev);
> +
> +	blkoops_put_bdev(bdev, NULL);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(blkoops_blkdev_info);

I don't see this function getting used anywhere. Can it be removed? I
see the notes in the Documentation. Could these values just be cached at
open time instead of reopening the device?

> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
> +MODULE_DESCRIPTION("Wrapper for Pstore BLK with Oops logger");
> diff --git a/include/linux/blkoops.h b/include/linux/blkoops.h
> new file mode 100644
> index 000000000000..fe63739309aa
> --- /dev/null
> +++ b/include/linux/blkoops.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __BLKOOPS_H_
> +#define __BLKOOPS_H_
> +
> +#include <linux/types.h>
> +#include <linux/blkdev.h>
> +#include <linux/pstore_blk.h>
> +
> +/**
> + * struct blkoops_device - backend blkoops driver structure.
> + *
> + * This structure is ONLY used for non-block device by
> + * blkoops_register_device(). If block device, you are strongly recommended
> + * to use blkoops_register_blkdev().
> + *
> + * @total_size:
> + *	The total size in bytes pstore/blk can use. It must be greater than
> + *	4096 and be multiple of 4096.
> + * @read, @write:
> + *	The general (not panic) read/write operation.
> + *
> + *	Both of the @size and @offset parameters on this interface are
> + *	the relative size of the space provided, not the whole disk/flash.
> + *
> + *	On success, the number of bytes read should be returned.
> + *	On error, negative number should be returned.
> + * @panic_write:
> + *	The write operation only used for panic.
> + *
> + *	Both of the @size and @offset parameters on this interface are
> + *	the relative size of the space provided, not the whole disk/flash.
> + *
> + *	On success, the number of bytes read should be returned.
> + *	On error, negative number should be returned.
> + */
> +struct blkoops_device {
> +	unsigned long total_size;
> +	blkz_read_op read;
> +	blkz_write_op write;
> +	blkz_write_op panic_write;
> +};
> +
> +/*
> + * Panic write for block device who should write alignmemt to SECTOR_SIZE.
> + * On success, zero should be returned. Others mean error.
> + */
> +typedef int (*blkoops_blk_panic_write_op)(const char *buf, sector_t start_sect,
> +		sector_t sects);
> +
> +int  blkoops_register_device(struct blkoops_device *bo_dev);
> +void blkoops_unregister_device(struct blkoops_device *bo_dev);
> +int  blkoops_register_blkdev(unsigned int major,
> +		blkoops_blk_panic_write_op panic_write);
> +void blkoops_unregister_blkdev(unsigned int major);
> +int  blkoops_blkdev_info(dev_t *devt, sector_t *nr_sects, sector_t *start_sect);
> +
> +#endif
> -- 
> 1.9.1
> 

-- 
Kees Cook
