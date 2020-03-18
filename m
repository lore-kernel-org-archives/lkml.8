Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E982C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05C320785
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ow7UpM6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCRSb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:31:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41535 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRSb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:31:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so4519643plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IqBbiS2PhVAX+PrDYUW3yPcRGZi+DYTjRrtpQaKx6NA=;
        b=Ow7UpM6AYzVnY5Q9sAmWVUrnvF7uV4i+qkvYZv51NXuwHHw1FiL0v0UuchqEFv+UEz
         vzDW8zoxihqXUzsInD4WaZgqnmfcw/zZhDkjyXc38HjOkZTHyZkz0aOC0mY1Pg0BkRov
         7w1e3KJ8FZv7pGSdvdNAVxu4MKRpleHQoNtbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IqBbiS2PhVAX+PrDYUW3yPcRGZi+DYTjRrtpQaKx6NA=;
        b=DvAjMm256+xcqyRWViMB9PK7R9Ww+01an3GD1V+0yPwHkKq0QPS4ZxYy/9EzZA4ci+
         SGr5F3lLG7F3bkMfNMHGyQR8zsoOsD66ZPHvaTgEv5IX6tWuumR60JtC3Kp2qK0XRrUk
         BiAHOvsvL/44PFJDfGZniidEzHSDEEOuKrKCNAV3FuSWMGdh3Vj+n3nfbGok4s00g2ro
         kpAbn58oWsTnNn4bSH0dLgGwq8kbbCL+Cz/i6AhbxyEzAotdr0Fy0HG96K2djUvSsw4x
         s1G+XvLag8lrs5JAo8B38uXlmxNQy3GllifkDiJuZtgMd2Thj0jFlM6Kl6Z5839IlGru
         48Cw==
X-Gm-Message-State: ANhLgQ3E/sgrP24jrWYYebhBv7eTuBrLiZOV7xrWNaEcYWOI539kA2qu
        /am6UiWsX5hQz09Fa2/4bL+kjQ==
X-Google-Smtp-Source: ADFU+vtoREvrmLVUS0979kynfO8HPb3n2fBcuXmnwZMoVKEZO6AcaTouL26UnL6AcVkJCnmZFxcJZg==
X-Received: by 2002:a17:902:8546:: with SMTP id d6mr5130113plo.193.1584556285082;
        Wed, 18 Mar 2020 11:31:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b70sm7631695pfb.6.2020.03.18.11.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 11:31:24 -0700 (PDT)
Date:   Wed, 18 Mar 2020 11:31:23 -0700
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
Subject: Re: [PATCH v2 06/11] Documentation: pstore/blk: blkoops: create
 document for pstore_blk
Message-ID: <202003181119.1A3774054@keescook>
References: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1581078355-19647-7-git-send-email-liaoweixiong@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581078355-19647-7-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 08:25:50PM +0800, WeiXiong Liao wrote:
> The document, at Documentation/admin-guide/pstore-block.rst, tells us
> how to use pstore/blk and blkoops.
> 
> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
> ---
>  Documentation/admin-guide/pstore-block.rst | 281 +++++++++++++++++++++++++++++
>  MAINTAINERS                                |   1 +
>  fs/pstore/Kconfig                          |   2 +
>  3 files changed, 284 insertions(+)
>  create mode 100644 Documentation/admin-guide/pstore-block.rst
> 
> diff --git a/Documentation/admin-guide/pstore-block.rst b/Documentation/admin-guide/pstore-block.rst
> new file mode 100644
> index 000000000000..c8a5f68960c3
> --- /dev/null
> +++ b/Documentation/admin-guide/pstore-block.rst
> @@ -0,0 +1,281 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Pstore block oops/panic logger
> +==============================
> +
> +Introduction
> +------------
> +
> +Pstore block (pstore/blk) is an oops/panic logger that writes its logs to a
> +block device before the system crashes. It also supports non-block devices such
> +as mtd device.
> +
> +There is a trapper named blkoops for pstore/blk, which makes pstore/blk be
> +nicer to device drivers.

"trapper" is an odd term here (oh, maybe this was a typo of
"wrapper"?). Regardless, is there a need to separate blkzone from
blkoops? It seems everything would just use blkoops directly, even
mtdpstore?

> +
> +Pstore block concepts
> +---------------------
> +
> +Pstore/blk works as a zone manager as it cuts the block device or partition
> +into several zones and stores data for different recorders. What device drivers

s/recorders/pstore front-ends/

> +should do is to provide read/write APIs.

"A block device driver only needs to provide read/write APIs."

> +
> +Pstore/blk begins at function ``blkz_register``. Besides, blkoops, a wrapper of
> +pstore/blk, begins at function ``blkoops_register_blkdev`` for block device and
> +``blkoops_register_device`` for non-block device, which is recommended instead
> +of directly using pstore/blk.
> +
> +Blkoops provides efficient configuration method for pstore/blk, which divides
> +all configurations of pstore/blk into two parts, configurations for user and
> +configurations for driver.
> +
> +Configurations for user determine how pstore/blk works, such as pmsg_size,
> +dmesg_size and so on. All of them support both kconfig and module parameters,
> +but module parameters have priority over kconfig.
> +
> +Configurations for driver are all about block/non-block device, such as
> +total_size of device and read/write operations. Device driver transfers a
> +structure ``blkoops_device`` defined in *linux/blkoops.h*.
> +
> +All of the following are for blkoops.
> +
> +Configurations for user
> +-----------------------
> +
> +All of these configurations support both kconfig and module parameters, but
> +module parameters have priority over kconfig.
> +Here is an example for module parameters::
> +
> +        blkoops.blkdev=179:7 blkoops.dmesg_size=64 blkoops.dump_oops=1
> +
> +The detail of each configurations may be of interest to you.
> +
> +blkdev
> +~~~~~~
> +
> +The block device to use. Most of the time, it is a partition of block device.
> +It's fine to ignore it if you are not using a block device.
> +
> +It accepts the following variants:
> +
> +1. <hex_major><hex_minor> device number in hexadecimal represents itself; no
> +   leading 0x, for example b302.
> +#. /dev/<disk_name> represents the device number of disk
> +#. /dev/<disk_name><decimal> represents the device number of partition - device
> +   number of disk plus the partition number
> +#. /dev/<disk_name>p<decimal> - same as the above; this form is used when disk
> +   name of partitioned disk ends with a digit.
> +#. PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF represents the unique id of
> +   a partition if the partition table provides it. The UUID may be either an
> +   EFI/GPT UUID, or refer to an MSDOS partition using the format SSSSSSSS-PP,
> +   where SSSSSSSS is a zero-filled hex representation of the 32-bit
> +   "NT disk signature", and PP is a zero-filled hex representation of the
> +   1-based partition number.
> +#. PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to a
> +   partition with a known unique id.
> +#. <major>:<minor> major and minor number of the device separated by a colon.
> +
> +dmesg_size
> +~~~~~~~~~~
> +
> +The chunk size in KB for dmesg(oops/panic). It **MUST** be a multiple of 4.
> +If you don't need it, safely set it to 0 or ignore it.
> +
> +NOTE that, the remaining space, except ``pmsg_size``, ``console_size``` and
> +others, belongs to dmesg. It means that there are multiple chunks for dmesg.
> +
> +Pstore/blk will log to dmesg chunks one by one, and always overwrite the oldest
> +chunk if there is no more free chunks.
> +
> +pmsg_size
> +~~~~~~~~~
> +
> +The chunk size in KB for pmsg. It **MUST** be a multiple of 4. If you do not
> +need it, safely set it to 0 or ignore it.
> +
> +There is only one chunk for pmsg.
> +
> +Pmsg is a user space accessible pstore object. Writes to */dev/pmsg0* are
> +appended to the chunk. On reboot the contents are available in
> +/sys/fs/pstore/pmsg-pstore-blk-0.
> +
> +console_size
> +~~~~~~~~~~~~
> +
> +The chunk size in KB for console. It **MUST** be a multiple of 4. If you
> +do not need it, safely set it to 0 or ignore it.
> +
> +There is only one chunk for console.
> +
> +All log of console will be appended to the chunk. On reboot the contents are
> +available in /sys/fs/pstore/console-pstore-blk-0.
> +
> +ftrace_size
> +~~~~~~~~~~~
> +
> +The chunk size in KB for ftrace. It **MUST** be a multiple of 4. If you
> +do not need it, safely set it to 0 or ignore it.
> +
> +There may be several chunks for ftrace, according to how many processors on
> +your CPU. Each chunk size is equal to (ftrace_size / processors_count).
> +
> +All log of ftrace will be appended to the chunk. On reboot the contents are
> +available in /sys/fs/pstore/ftrace-pstore-blk-[N], where N is the processor
> +number.
> +
> +Persistent function tracing might be useful for debugging software or hardware
> +related hangs. Here is an example of usage::
> +
> + # mount -t pstore pstore /sys/fs/pstore
> + # mount -t debugfs debugfs /sys/kernel/debug/
> + # echo 1 > /sys/kernel/debug/pstore/record_ftrace
> + # reboot -f
> + [...]
> + # mount -t pstore pstore /sys/fs/pstore
> + # tail /sys/fs/pstore/ftrace-pstore-blk-0
> + CPU:0 ts:109860 c03a4310  c0063ebc  cpuidle_select <- cpu_startup_entry+0x1a8/0x1e0
> + CPU:0 ts:109861 c03a5878  c03a4324  menu_select <- cpuidle_select+0x24/0x2c
> + CPU:0 ts:109862 c00670e8  c03a589c  pm_qos_request <- menu_select+0x38/0x4cc
> + CPU:0 ts:109863 c0092bbc  c03a5960  tick_nohz_get_sleep_length <- menu_select+0xfc/0x4cc
> + CPU:0 ts:109865 c004b2f4  c03a59d4  get_iowait_load <- menu_select+0x170/0x4cc
> + CPU:0 ts:109868 c0063b60  c0063ecc  call_cpuidle <- cpu_startup_entry+0x1b8/0x1e0
> + CPU:0 ts:109869 c03a433c  c0063b94  cpuidle_enter <- call_cpuidle+0x44/0x48
> + CPU:0 ts:109871 c03a4000  c03a4350  cpuidle_enter_state <- cpuidle_enter+0x24/0x28
> + CPU:0 ts:109873 c0063ba8  c03a4090  sched_idle_set_state <- cpuidle_enter_state+0xa4/0x314
> + CPU:0 ts:109874 c03a605c  c03a40b4  arm_enter_idle_state <- cpuidle_enter_state+0xc8/0x314

It would be nice to extract ftrace_log_combine() from ram.c and make the
front-end and inode layers aware of this as a way to auto-merge the
records from all backends supporting ftrace.

> +dump_oops
> +~~~~~~~~~
> +
> +Dumping both oopses and panics can be done by setting 1 (not zero) in the
> +``dump_oops`` member while setting 0 in that variable dumps only the panics.
> +
> +Configurations for driver
> +-------------------------
> +
> +Only a device driver cares about these configurations. A block device driver
> +uses ``blkoops_register_blkdev`` while a non-block device driver uses
> +``blkoops_register_device``

Given this clarification, I'd say there is no reason to discuss
blkzone.c at all.

> +
> +The parameters of these two APIs may be of interest to you.
> +
> +major
> +~~~~~
> +
> +It is only required by block device which is registered by
> +``blkoops_register_blkdev``.  It's the major device number of registered
> +devices, by which blkoops can get the matching driver for @blkdev.
> +
> +total_size
> +~~~~~~~~~~
> +
> +It is only required by non-block device which is registered by
> +``blkoops_register_device``.  It tells pstore/blk the total size
> +pstore/blk can use. It is in KB and **MUST** be greater than or equal to 4
> +and a multiple of 4.
> +
> +For block devices, blkoops can get size of block device/partition automatically.
> +
> +read/write
> +~~~~~~~~~~
> +
> +It's generic read/write APIs for pstore/blk, which are required by non-block
> +device. The generic APIs are used for almost all data except panic data,
> +such as pmsg, console, oops and ftrace.
> +
> +The parameter @offset of these interface is the relative position of the device.
> +
> +Normally the number of bytes read/written should be returned, while for error,
> +negative number will be returned. The following return numbers mean more:
> +
> +-EBUSY: pstore/blk should try again later.
> +
> +panic_write (for non-block device)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I still think some other term is needed for "non-block device", since it
_is_ a block device. i.e. we're using it with pstore/blk. ;) I find it
just odd language.

> +
> +It's a interface for panic recorder and will be used only when panic occurs.
> +Non-block device driver registers it by ``blkoops_register_device``. If panic
> +log is unnecessary, it's fine to ignore it.
> +
> +Note that pstore/blk will recover data from device while mounting pstore
> +filesystem by default. If panic occurs but pstore/blk does not recover yet, the
> +first zone of dmesg will be used.
> +
> +The parameter @offset of this interface is the relative position of the device.
> +
> +Normally the number of bytes written should be returned, while for error,
> +negative number should be returned.
> +
> +panic_write (for block device)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It's much similar to panic_write for non-block device, but the position and
> +data size of panic_write for block device must be aligned to SECTOR_SIZE,
> +that's why the parameters are @sects and @start_sect. Block device driver
> +should register it by ``blkoops_register_blkdev``.
> +
> +The parameter @start_sect is the relative position of the block device and
> +partition. If block driver requires absolute position for panic_write,
> +``blkoops_blkdev_info`` will be helpful, which can provide the absolute
> +position of the block device (or partition) on the whole disk/flash.
> +
> +Normally zero should be returned, otherwise it indicates an error.
> +
> +Compression and header
> +----------------------
> +
> +Block device is large enough for uncompressed dmesg data. Actually we do not
> +recommend data compression because pstore/blk will insert some information into
> +the first line of dmesg data. For example::
> +
> +        Panic: Total 16 times
> +
> +It means that it's OOPS|Panic for the 16th time since the first booting.
> +Sometimes the number of occurrences of oops|panic since the first booting is
> +important to judge whether the system is stable.
> +
> +The following line is inserted by pstore filesystem. For example::
> +
> +        Oops#2 Part1
> +
> +It means that it's OOPS for the 2nd time on the last boot.
> +
> +Reading the data
> +----------------
> +
> +The dump data can be read from the pstore filesystem. The format for these
> +files is ``dmesg-pstore-blk-[N]`` for dmesg(oops|panic), ``pmsg-pstore-blk-0``
> +for pmsg and so on, where N is the record number. To delete a stored
> +record from block device, simply unlink the respective pstore file. The
> +timestamp of the dump file records the trigger time.
> +
> +Attentions in panic read/write APIs
> +-----------------------------------
> +
> +If on panic, the kernel is not going to run for much longer, the tasks will not
> +be scheduled and most kernel resources will be out of service. It
> +looks like a single-threaded program running on a single-core computer.
> +
> +The following points require special attention for panic read/write APIs:
> +
> +1. Can **NOT** allocate any memory.
> +   If you need memory, just allocate while the block driver is initializing
> +   rather than waiting until the panic.
> +#. Must be polled, **NOT** interrupt driven.
> +   No task schedule any more. The block driver should delay to ensure the write
> +   succeeds, but NOT sleep.
> +#. Can **NOT** take any lock.
> +   There is no other task, nor any shared resource; you are safe to break all
> +   locks.
> +#. Just use CPU to transfer.
> +   Do not use DMA to transfer unless you are sure that DMA will not keep lock.
> +#. Control registers directly.
> +   Please control registers directly rather than use Linux kernel resources.
> +   Do I/O map while initializing rather than wait until a panic occurs.
> +#. Reset your block device and controller if necessary.
> +   If you are not sure of the state of your block device and controller when
> +   a panic occurs, you are safe to stop and reset them.
> +
> +Blkoops supports blkoops_blkdev_info(), which is defined in *linux/blkoops.h*,
> +to get information of block device, such as the device number, sector count and
> +start sector of the whole disk.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e4ba97130560..a5122e3aaf76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13380,6 +13380,7 @@ F:	include/linux/pstore*
>  F:	drivers/firmware/efi/efi-pstore.c
>  F:	drivers/acpi/apei/erst.c
>  F:	Documentation/admin-guide/ramoops.rst
> +F:	Documentation/admin-guide/pstore-block.rst
>  F:	Documentation/devicetree/bindings/reserved-memory/ramoops.txt
>  K:	\b(pstore|ramoops|blkoops)
>  
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 308a0a4c5ee5..466908a242aa 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -162,6 +162,8 @@ config PSTORE_BLK
>  	  This enables panic and oops message to be logged to a block dev
>  	  where it can be read back at some later point.
>  
> +	  For more information, see Documentation/admin-guide/pstore-block.rst.
> +
>  	  If unsure, say N.
>  
>  config PSTORE_BLKOOPS
> -- 
> 1.9.1
> 

I love the docs; thank you for them! As mentioned in the other email,
perhaps add a section at the bottom like:

blkoops internals
-----------------

For developer reference, here are all the important structures and APIs:

.. kernel-doc: fs/pstore/blkzone.c
   :internal:

.. kernel-doc: fs/pstore/blkoops.c
   :export:

etc

-- 
Kees Cook
