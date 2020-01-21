Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB7EC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348DD217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgAUFXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 00:23:02 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:56528 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727173AbgAUFXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:23:02 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.696249-0.0161319-0.287619;DS=CONTINUE|ham_system_inform|0.0867104-0.0017247-0.911565;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16370;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.GfbBBA4_1579584171;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.GfbBBA4_1579584171)
          by smtp.aliyun-inc.com(10.147.42.197);
          Tue, 21 Jan 2020 13:22:52 +0800
Subject: Re: [PATCH v1 06/11] Documentation: pstore/blk: blkoops: create
 document for pstore_blk
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1579482233-2672-7-git-send-email-liaoweixiong@allwinnertech.com>
 <b9cd734b-8bb1-5e26-a7ed-fbc79ab2d958@infradead.org>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <c87bdf3a-f129-a2a7-40b2-2220f79b505a@allwinnertech.com>
Date:   Tue, 21 Jan 2020 13:23:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b9cd734b-8bb1-5e26-a7ed-fbc79ab2d958@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Randy Dunlap,

On 2020/1/21 PM12:13, Randy Dunlap wrote:
> Hi,
> 
> I have some documentation comments for you:
> 
> 
> On 1/19/20 5:03 PM, WeiXiong Liao wrote:
>> The document, at Documentation/admin-guide/pstore-block.rst, tells us
>> how to use pstore/blk and blkoops.
>>
>> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
>> ---
>>  Documentation/admin-guide/pstore-block.rst | 278 +++++++++++++++++++++++++++++
>>  MAINTAINERS                                |   1 +
>>  fs/pstore/Kconfig                          |   2 +
>>  3 files changed, 281 insertions(+)
>>  create mode 100644 Documentation/admin-guide/pstore-block.rst
>>
>> diff --git a/Documentation/admin-guide/pstore-block.rst b/Documentation/admin-guide/pstore-block.rst
>> new file mode 100644
>> index 000000000000..58418d429c55
>> --- /dev/null
>> +++ b/Documentation/admin-guide/pstore-block.rst
>> @@ -0,0 +1,278 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +Pstore block oops/panic logger
>> +==============================
>> +
>> +Introduction
>> +------------
>> +
>> +Pstore block (pstore/blk) is an oops/panic logger that writes its logs to a
>> +block device before the system crashes. It also supports non-block devices such
>> +as mtd device.
>> +
>> +There is a trapper named blkoops for pstore/blk, which makes pstore/blk be
>> +nicer to device drivers.
>> +
>> +Pstore block concepts
>> +---------------------
>> +
>> +Pstore/blk works as a zone manager as it cuts the block device or partition
>> +into several zones and stores data for different recorders. What device driver
> 
> "What a device driver" or "What device drivers" should do ...
> 

I will fix it, thank you.

>> +should do is to provide read/write APIs.
>> +
>> +Pstore/blk begins at function ``blkz_register``. Besides, blkoops, a wrapper of
>> +pstore/blk, begins at function ``blkoops_register_blkdev`` for block device and
>> +``blkoops_register_device`` for non-block device, which is recommended instead
>> +of directly using pstore/blk.
>> +
>> +Blkoops provides efficient configuration mothod for pstore/blk, which divides
> 
>                                             method
> 

I will fix it, thank you.

>> +all configurations of pstore/blk into two parts, configurations for user and
>> +configurations for driver.
>> +
>> +Configurations for user determine how pstore/blk works, such as pmsg_size,
>> +dmesg_size and so on. All of them support both kconfig and module parameters,
>> +but module parameters have priority over kconfig.
>> +
>> +Configurations for driver are all about block/non-block device, such as
>> +total_size of device and read/write operations. Device driver transfers a
>> +structure ``blkoops_device`` defined in *linux/blkoops.h*.
>> +
>> +Configurations for user
>> +-----------------------
>> +
>> +All of these configurations support both kconfig and module parameters, but
>> +module parameters have priority over kconfig.
>> +Here is an example for module parameters::
>> +
>> +        blkoops.blkdev=179:7 blkoops.dmesg_size=64 blkoops.dump_oops=1
>> +
>> +The detail of each configurations may be of interest to you.
>> +
>> +blkdev
>> +~~~~~~
>> +
>> +The block device to use. Most of the time, it is a partition of block device.
>> +It's fine to ignore it if you are not block device.
> 
>                                  are not using a block device.
> 

I will fix it, thank you.

>> +
>> +It accepts the following variants:
>> +
>> +1. <hex_major><hex_minor> device number in hexadecimal represents itself; no
>> +   leading 0x, for example b302.
>> +#. /dev/<disk_name> represents the device number of disk
>> +#. /dev/<disk_name><decimal> represents the device number of partition - device
>> +   number of disk plus the partition number
>> +#. /dev/<disk_name>p<decimal> - same as the above; this form is used when disk
>> +   name of partitioned disk ends with a digit.
>> +#. PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing the unique id of
> 
>                                                     represents
> 

I will fix it, thank you.

>> +   a partition if the partition table provides it. The UUID may be either an
>> +   EFI/GPT UUID, or refer to an MSDOS partition using the format SSSSSSSS-PP,
>> +   where SSSSSSSS is a zero-filled hex representation of the 32-bit
>> +   "NT disk signature", and PP is a zero-filled hex representation of the
>> +   1-based partition number.
>> +#. PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in relation to a
>> +   partition with a known unique id.
>> +#. <major>:<minor> major and minor number of the device separated by a colon.
>> +
>> +dmesg_size
>> +~~~~~~~~~~
>> +
>> +The chunk size in bytes for dmesg(oops/panic). It **MUST** be a multiple of
>> +4096. If you don't need it, safely set it 0 or ignore it.
> 
>                                       set it to 0 or ignore it.
> 

I will fix it, thank you.

> The example above is:  blkoops.dmesg_size=64
> where 64 is not a multiple of 4096. (?)
> 

The module parameter dmesg_size is in unit KB.

>> +
>> +NOTE that, the remaining space, except ``pmsg_size``, ``console_size``` and
>> +others, belongs to dmesg. It means that there are multiple chunks for dmesg.
>> +
>> +Pstore/blk will log to dmesg chunks one by one, and always overwrite the oldest
>> +chunk if there is no more free chunks.
>> +
>> +pmsg_size
>> +~~~~~~~~~
>> +
>> +The chunk size in bytes for pmsg. It **MUST** be a multiple of 4096. If you
>> +do not need it, safely set it 0 or ignore it.
> 
>                           set it to 0 or ignore it.
> 

I will fix it, thank you.

>> +
>> +There is only one chunk for pmsg.
>> +
>> +Pmsg is a user space accessible pstore object. Writes to */dev/pmsg0* are
>> +appended to the chunk. On reboot the contents are available in
>> +/sys/fs/pstore/pmsg-pstore-blk-0.
>> +
>> +console_size
>> +~~~~~~~~~~~~
>> +
>> +The chunk size in bytes for console. It **MUST** be a multiple of 4096. If you
>> +do not need it, safely set it 0 or ignore it.
> 
>                           set it to 0 or ignore it.
> 

I will fix it, thank you.

>> +
>> +There is only one chunk for console.
>> +
>> +All log of console will be appended to the chunk. On reboot the contents are
>> +available in /sys/fs/pstore/console-pstore-blk-0.
>> +
>> +ftrace_size
>> +~~~~~~~~~~~
>> +
>> +The chunk size in bytes for ftrace. It **MUST** be a multiple of 4096. If you
>> +do not need it, safely set it 0 or ignore it.
>> +
>> +There may be several chunks for ftrace, according to how many processors on
>> +your CPU. Each chunk size is equal to (ftrace_size / processors_count).
> 
> That is confusing (to me). It seems like it handles CPU packages separately,
> so that a package that has 4 processors is collected together.
> But what if the system has multiple CPU packages?  how is that handled?
> 

The ftrace chunk size is divide to processors_count for each processor,
by this, each processor has itself chunk. So, cpu0 write to chunk0 and
cpu1 write to chunk1.

>> +
>> +All log of ftrace will be appended to the chunk. On reboot the contents are
>> +available in /sys/fs/pstore/ftrace-pstore-blk-[N], where N is the processor
>> +number.
>> +
>> +Persistent function tracing might be useful for debugging software or hardware
>> +related hangs. Here is an example of usage::
>> +
>> + # mount -t pstore pstore /sys/fs/pstore
>> + # mount -t debugfs debugfs /sys/kernel/debug/
>> + # echo 1 > /sys/kernel/debug/pstore/record_ftrace
>> + # reboot -f
>> + [...]
>> + # mount -t pstore pstore /sys/fs/pstore
>> + # tail /sys/fs/pstore/ftrace-pstore-blk-0
>> + CPU:0 ts:109860 c03a4310  c0063ebc  cpuidle_select <- cpu_startup_entry+0x1a8/0x1e0
>> + CPU:0 ts:109861 c03a5878  c03a4324  menu_select <- cpuidle_select+0x24/0x2c
>> + CPU:0 ts:109862 c00670e8  c03a589c  pm_qos_request <- menu_select+0x38/0x4cc
>> + CPU:0 ts:109863 c0092bbc  c03a5960  tick_nohz_get_sleep_length <- menu_select+0xfc/0x4cc
>> + CPU:0 ts:109865 c004b2f4  c03a59d4  get_iowait_load <- menu_select+0x170/0x4cc
>> + CPU:0 ts:109868 c0063b60  c0063ecc  call_cpuidle <- cpu_startup_entry+0x1b8/0x1e0
>> + CPU:0 ts:109869 c03a433c  c0063b94  cpuidle_enter <- call_cpuidle+0x44/0x48
>> + CPU:0 ts:109871 c03a4000  c03a4350  cpuidle_enter_state <- cpuidle_enter+0x24/0x28
>> + CPU:0 ts:109873 c0063ba8  c03a4090  sched_idle_set_state <- cpuidle_enter_state+0xa4/0x314
>> + CPU:0 ts:109874 c03a605c  c03a40b4  arm_enter_idle_state <- cpuidle_enter_state+0xc8/0x314
>> +
>> +dump_oops
>> +~~~~~~~~~
>> +
>> +Dumping both oopses and panics can be done by setting 1 (not zero) in the
>> +``dump_oops`` member while setting 0 in that variable dumps only the panics.
>> +
>> +Configurations for driver
>> +-------------------------
>> +
>> +Only device driver would care these configurations. Block device driver
> 
>    Only a device driver cares about these configurations. A block device driver
> 

I will fix it, thank you.

>> +refers ``blkoops_register_blkdev`` while ``blkoops_register_device`` for
> 
>    uses ...                           while a non-block device [driver] uses 
>    ``blkoops_register_device``.
> 

I will fix it, thank you.

>> +non-block device.
>> +
>> +The parameters of these two APIs may be of interest to you.
>> +
>> +major
>> +~~~~~
>> +
>> +It is only requested by block device which is registered by
> 
>               required (?)
> 

Yes, you are right. I will fix it.

>> +``blkoops_register_blkdev``.  It's the major device number of registered
>> +devices, by which blkoops can get the matching driver for @blkdev.
>> +
>> +total_size
>> +~~~~~~~~~~
>> +
>> +It is only requested by non-block device which is registered by
> 
>               required (?)
> 

I will fix it, thank you.

>> +``blkoops_register_device``.  It tells pstore/blk that the total size
> 
>                                               drop:  that
> 

I will fix it, thank you.

>> +pstore/blk can use. It **MUST** be greater than 4096 and a multiple of 4096.
> 
> not greater than or equal to 4096?
> 

Yes, you are right. I will fix it.

>> +
>> +If block device, blkoops can get size of block device/partition automatically.
> 
>    For block devices, ...
> 

I will fix it, thank you.

>> +
>> +read/write
>> +~~~~~~~~~~
>> +
>> +It's generic read/write APIs for pstore/blk, which are requested by non-block
> 
>                                                           required (?)
> 

I will fix it, thank you.

>> +device. The generic APIs are used for almost all data but except panic data,
> 
>                                                 drop:    but
> 

I will fix it, thank you.

>> +such as pmsg, console, oops and ftrace.
>> +
>> +The parameter @offset is the relative position of the device.
> 
> I don't get that description. Can you improve it?
> 

The parameter @offset of these interface is the relative position of the
device.

>> +
>> +Normally the number of bytes read/written should be returned, while for error,
>> +negative number will be returned. The following return numbers mean more:
>> +
>> +-EBUSY: pstore/blk should try again later.
>> +
>> +panic_write (for non-block device)
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +It's a interface for panic recorder and will be used only when panic occurs.
>> +Non-block device driver registers it by ``blkoops_register_device``. If panic
>> +log is unnecessary, it's fine to ignore it.
>> +
>> +Note that pstore/blk will recover data from device while mounting pstore
>> +filesystem by default. If panic occurs but pstore/blk does not recover yet, the
>> +first zone of dmesg will be used.
>> +
>> +The parameter @offset is the relative position of the device.
> 
> improve??
> 

The parameter @offset of this interface is the relative position of the
device.

>> +
>> +Normally the number of bytes written should be returned, while for error,
>> +negative number should be returned.
>> +
>> +panic_write (for block device)
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +It's much similar to panic_write for non-block device, but panic_write for
>> +block device writes alignment to SECTOR_SIZE, that's why the parameters are
> 
>                 writes only aligned sectors of SECTOR_SIZE  (??)
> 

How about this?

It's much similar to panic_write for non-block device, but the position and
data size of panic_write for block device must be aligned to SECTOR_SIZE,
that's why the parameters are @sects and @start_sect. Block device driver
should register it by ``blkoops_register_blkdev``.

>> +@sects and @start_sect. Block device driver should register it by
>> +``blkoops_register_blkdev``.
>> +
>> +The parameter @start_sect is the relative position of the block device and
>> +partition. If block driver requires absolute position for panic_write,
>> +``blkoops_blkdev_info`` will be helpful, which can provide the absolute
>> +position of the block device (or partition) on the whole disk/flash.
>> +
>> +Normally zero should be returned, otherwise it indicates an error.
>> +
>> +Compression and header
>> +----------------------
>> +
>> +Block device is large enough for uncompressed dmesg data. Actually we do not
>> +recommend data compression because pstore/blk will insert some information into
>> +the first line of dmesg data. For example::
>> +
>> +        Panic: Total 16 times
>> +
>> +It means that it's the 16th times panic log since the first booting. Sometimes
> 
>                                time of a panic log since ...
> 

Should it be like this?
It means the time of a panic log since the first booting.

>> +the oops|panic occurs since burning is very important for embedded device to
> 
>                                ^^^^^^^ huh??
> 

How about this?

Sometimes the number of occurrences of oops|panic since the first
booting is important
to judge whether the system is stable.

>> +judge whether the system is stable.
>> +
>> +The following line is inserted by pstore filesystem. For example::
>> +
>> +        Oops#2 Part1
>> +
>> +It means that it's the 2nd times oops log on last booting.
> 
>                           2nd time of an oops log on the last boot. (?)
> 

How about this?

It means that it's OOPS for the 2nd time on the last boot.

>> +
>> +Reading the data
>> +----------------
>> +
>> +The dump data can be read from the pstore filesystem. The format for these
>> +files is ``dmesg-pstore-blk-[N]`` for dmesg(oops|panic), ``pmsg-pstore-blk-0``
>> +for pmsg and so on, where N is the record number. To delete a stored
>> +record from block device, simply unlink the respective pstore file. The
>> +timestamp of the dump file records the trigger time.
>> +
>> +Attentions in panic read/write APIs
>> +-----------------------------------
>> +
>> +If on panic, the kernel is not going to run for much longer. The tasks will not
> 
>                                                         longer, the tasks will not
> 

I will fix it, thank you.

>> +be scheduled and the most kernel resources will be out of service. It
> 
>              drop:  the
> 

I will fix it, thank you.

>> +looks like a single-threaded program running on a single-core computer.
>> +
>> +The following points require special attention for panic read/write APIs:
>> +
>> +1. Can **NOT** allocate any memory.
>> +   If you need memory, just allocate while the block driver is initializing
>> +   rather than waiting until the panic.
>> +#. Must be polled, **NOT** interrupt driven.
>> +   No task schedule any more. The block driver should delay to ensure the write
>> +   succeeds, but NOT sleep.
>> +#. Can **NOT** take any lock.
>> +   There is no other task, nor any share resource; you are safe to break all
> 
>                                       shared
> 

I will fix it, thank you.

>> +   locks.
>> +#. Just use CPU to transfer.
>> +   Do not use DMA to transfer unless you are sure that DMA will not keep lock.
>> +#. Operate register directly.
> 
>       Don't know what that means.
> 

How about this?

#. Control registers directly.
    Please control registers directly rather than use Linux kernel
resources.
    Do I/O map while initializing rather than wait until a panic occurs.

>> +   Try not to use Linux kernel resources. Do I/O map while initializing rather
>> +   than waiting until the panic.
>> +#. Reset your block device and controller if necessary.
>> +   If you are not sure the state of you block device and controller when panic,
> 
>                          of the state of your block device and controller when a panic occurs,
> 
> 

I will fix it, thank you.

>> +   you are safe to stop and reset them.
>> +
>> +Blkoops supports blkoops_blkdev_info(), which is defined in *linux/blkoops.h*,
>> +to get information of block device, such as the device number, sector count and
>> +start sector of the whole disk.
> 
> 
> HTH.
> 

I will collect more suggestions and submit the new version at one time.
Thank you very much.

-- 
liaoweixiong
