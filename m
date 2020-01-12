Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A921C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E845B2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJ/bBz+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbgALR0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 12:26:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45372 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgALR0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 12:26:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so6291355wrj.12;
        Sun, 12 Jan 2020 09:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xVRZT7YHVPE3GbyttbmSvMk99hkpTLXEzonadfBniK0=;
        b=sJ/bBz+I6AX+VbqaGHYqU8oVcVl/3fSB0h+kVMFnrusHsAraBxY0dWeSBp/G6dF6VS
         KC3iiITMz4jGvTyFgMdWFv/IKS0nvXQGjasscb3dfzY5UDXLcJ8F43s9WRibK76KLk2I
         c4tCo4dpuJ0itfQSWTdmYgfgkTHkMqoI1jEQJmcC6AYjiCK5vcexTiLyYWe+2oaf1D7X
         n1xemEpadN4Z3XRFXs7Ysx4/EzdtgFKlHMLMD3Jwv7S28I230Ek2qNGbLPva3NdGiWEt
         zyqdsLAx3UCcNjPnhi4d1sx3JnxiT305p4d9Q7DL03PDA9H5c2Tr5gIytdsAZv2wKxVJ
         WQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xVRZT7YHVPE3GbyttbmSvMk99hkpTLXEzonadfBniK0=;
        b=tJcq8MAegMe+lz2qur8n4FYPPvisOxiXO+1K7KLGCWNr+EGjQaQO2278KnxR196Yfw
         0JPzPOG87NtfjstkHrtJYQAYbuuXmgsoSYI1sg2K9gk2AsuIHOkVCkGf4sP6RHAwyPQO
         4yWOtyAmzdCcPHyXnA3Qv408npE2vqlEzpfOHweqTIBpEzaZnGjH8+wJDbf2xdCigaxl
         fBmAPFkmFEGtjBXowmP7SSqeUOCWr9+w7zGbxjIllLf5Kfdl7BmWzY6fFpccv0pOMcuE
         qJOrEpTE97a56hgS4m+Ky8UxteLGS+/HuuDMKXYncsS/UFg3To5yZctfazcHkI5HqZx0
         dMxg==
X-Gm-Message-State: APjAAAWKKtJmr9I6xNd4SGTqOpvIXbwRlKzAQU3hf/bI/WFwYjZOslZx
        C5iuLwJA4jTOf78pbEPlXOzOz9ko
X-Google-Smtp-Source: APXvYqyNJb2sZ+BEdl8Qe/N/WrvcZaNsBPjLBsFGSsIaeCCg3xu/NTbmYXVL2WXphD8eiIaYdsHO/Q==
X-Received: by 2002:adf:fbc9:: with SMTP id d9mr14694899wrs.20.1578849984608;
        Sun, 12 Jan 2020 09:26:24 -0800 (PST)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 4sm10505338wmg.22.2020.01.12.09.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2020 09:26:23 -0800 (PST)
Subject: Re: [RFC PATCH v1 02/10] mtd: nand: raw: add rockchip nand controller
 driver
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200108205338.11369-1-jbx6244@gmail.com>
 <20200108205338.11369-3-jbx6244@gmail.com> <20200110120534.1b4026b0@xps13>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <7a477af0-1448-4f26-4004-9331978e824c@gmail.com>
Date:   Sun, 12 Jan 2020 18:26:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200110120534.1b4026b0@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

Thank you for your detailed and useful review.

Without manufacturer support I must scrape my information
from all over the internet, together with slow interpretation of
Rockchip drivers.
So please have some patience with my updates and new versions.

Below are some comments and questions in random order.

/////////////////////////////

To prevent guessing games could you confirm the following names:

driver file name:   rockchip-nand-controller.c
document file name: rockchip-nand-controller.yaml

compatible: "rockchip,nandc-v6"
compatible: "rockchip,nandc-v9"

/////////////////////////////

My incomplete sort list for controller versions.

Can someone with access to the RV1108 TRM (manual) report the details
for the Nandc Version Register and whether it is compatible. Thanks.

Added version 7 for RK3228A/RK3228B. Can someone with insider info confirm
if this works or not.

RK3066/PX2
NANDC_NANDC_VER 0x0160 W 0x56363030 Nandc Version Register

RK3188
NANDC_NANDC_VER 0x0160 W 0x56363030 Nandc Version Register

PX3
NANDC_NANDC_VER 0x0160 W 0x56363030 Nandc Version Register

RK312X
NANDC_NANDC_VER 0x0160 W 0x56363232 Nandc Version Register

RK3288
NANDC_NANDC_VER 0x0160 W 0x56363232 Nandc Version Register

RK3368/PX5
NANDC_NANDC_VER 0x0160 W 0x56363232 Nandc Version Register

RK3228A/RK3228B
NANDC_NANDC_VER 0x0160 W 0x00000701 Nandc Version Register

RK3308
NANDC_NANDC_VER 0x0160 W 0x00000801 Nandc Version Register

RK3326/PX30
NANDC_NANDC_VER 0x0080 W 0x56393030 Nandc Version Register

RK3328
NO NANDC

RK3399
NO NANDC

RV1108
unknown

/////////////////////////////

My debug kernel.log with 1 partition in dts.

Jan  1 00:02:27 mk808 kernel: [  147.051587] rockchip-nandc
10500000.nand-controller: get clk_nandc failed
Jan  1 00:02:27 mk808 kernel: [  147.052402] nand: device found,
Manufacturer ID: 0xad, Chip ID: 0xde
Jan  1 00:02:27 mk808 kernel: [  147.052945] nand: Hynix H27UCG8T2ATR-BC
64G 3.3V 8-bit
Jan  1 00:02:27 mk808 kernel: [  147.053388] nand: 8192 MiB, MLC, erase
size: 2048 KiB, page size: 8192, OOB size: 640
Jan  1 00:02:27 mk808 kernel: [  147.054050] rockchip-nandc
10500000.nand-controller: nand->numchips = 1
Jan  1 00:02:27 mk808 kernel: [  147.054740] rockchip-nandc
10500000.nand-controller: nand->chipsize = 8589934592
Jan  1 00:02:27 mk808 kernel: [  147.055380] rockchip-nandc
10500000.nand-controller: nand->pagemask =    fffff
Jan  1 00:02:27 mk808 kernel: [  147.055994] rockchip-nandc
10500000.nand-controller: nand->badblockpos = 0
Jan  1 00:02:27 mk808 kernel: [  147.056591] rockchip-nandc
10500000.nand-controller: nand->chip_shift = 33
Jan  1 00:02:27 mk808 kernel: [  147.057174] rockchip-nandc
10500000.nand-controller: nand->page_shift = 13
Jan  1 00:02:27 mk808 kernel: [  147.057751] rockchip-nandc
10500000.nand-controller: nand->phys_erase_shift = 21
Jan  1 00:02:27 mk808 kernel: [  147.058366] rockchip-nandc
10500000.nand-controller: nand->ecc.mode = 3
Jan  1 00:02:27 mk808 kernel: [  147.058920] rockchip-nandc
10500000.nand-controller: nand->ecc.steps = 8
Jan  1 00:02:27 mk808 kernel: [  147.059481] rockchip-nandc
10500000.nand-controller: nand->ecc.bytes = 70
Jan  1 00:02:27 mk808 kernel: [  147.060049] rockchip-nandc
10500000.nand-controller: nand->ecc.total = 0
Jan  1 00:02:27 mk808 kernel: [  147.060607] rockchip-nandc
10500000.nand-controller: nand->ecc.prepad = 4
Jan  1 00:02:27 mk808 kernel: [  147.061175] rockchip-nandc
10500000.nand-controller: nand->ecc.size = 1024
Jan  1 00:02:27 mk808 kernel: [  147.061748] rockchip-nandc
10500000.nand-controller: nand->ecc.strength = 40
Jan  1 00:02:27 mk808 kernel: [  147.062341] rockchip-nandc
10500000.nand-controller: mtd->ooblayout = 91ce9ce2
Jan  1 00:02:27 mk808 kernel: [  147.062943] rockchip-nandc
10500000.nand-controller: mtd->flags = 00000000
Jan  1 00:02:27 mk808 kernel: [  147.063518] rockchip-nandc
10500000.nand-controller: mtd->size = 8589934592
Jan  1 00:02:27 mk808 kernel: [  147.064098] rockchip-nandc
10500000.nand-controller: mtd->erasesize = 2097152
Jan  1 00:02:27 mk808 kernel: [  147.064815] rockchip-nandc
10500000.nand-controller: mtd->writesize = 8192
Jan  1 00:02:27 mk808 kernel: [  147.065413] rockchip-nandc
10500000.nand-controller: mtd->oobsize = 640
Jan  1 00:02:27 mk808 kernel: [  147.068985] 1 fixed-partitions
partitions found on MTD device 10500000.nand-controller.0
Jan  1 00:02:27 mk808 kernel: [  147.069190] Creating 1 MTD partitions
on "10500000.nand-controller.0":
Jan  1 00:02:27 mk808 kernel: [  147.072375]
0x000000000000-0x000000400000 : "parameter"


Jan  1 00:02:27 mk808 kernel: [  147.075649] rockchip-nandc
10500000.nand-controller: R:0x00ff cs:0
Jan  1 00:02:27 mk808 kernel: [  147.079423] rockchip-nandc
10500000.nand-controller: R:0x01ff cs:0


Despite nand->options = NAND_SKIP_BBTSCAN.

What is the reason for these 2 rk_nandc_hw_syndrome_ecc_read_page() commands
at page R:0x00ff and R:0x01ff right after creating partitions.

When enabled BBTSCAN MTD starts to store at all kind of places. Can you
state
there page address logic, ie. Would that damage the excisting Rockchip
layout?

/////////////////////////////

No bad block support

Based on:
drivers: mtd: nand: rockchip nandc add bad block detect api
https://github.com/rockchip-linux/u-boot/commit/
7aec704a4e9d9322f1102bcf61ee5c3cf6ec794d

rockchip: drivers: mtd: nand: modify the bad block detection process
https://github.com/rockchip-linux/u-boot/commit/
d6d708d1a329a6369143e8dd34cf4e2c81d5d92f

BCH      |      oob size
------------------------
16: bytes: 28 + 4 = 32
24: bytes: 42 + 4 = 46
40: bytes: 70 + 4 = 74
60: bytes: 106 + 4 = 110

The data layout that is written by an internal Rockchip nandc dma is:
    1024 bytes data + 32 obb + 1024 data + 32 obb ...

The MTD system however tries to detect bad block flags located at:
    2048, 4096, 8192...

The system checks for bad blocks and looks at the wrong bad block marker
location.
Yifeng Zhao proposes to add a bad block detecting strategy by doing
a read with rk_nandc_hw_syndrome_ecc_read_page() first,
if failure then assume it's still raw unwritten NAND and test bytes are
at the position MTD normaly would check for right from the factory.
When this function is used on a FTL controlled NAND it creates
an awful lot of errors in the kernel log, because it uses the BB marker
for dirty tag tricks for there data storage.
So what is good for a raw empty NAND without FTL
does not work for the majority of Rockchip devices I think.

Please advise for other options.

static uint8_t rk_nand_read_byte(struct nand_chip *nand)
{
	uint8_t ret;

	rk_nand_read_buf(nand, &ret, 1);

	return ret;
}

static int rk_nand_block_bad(struct nand_chip *nand, loff_t ofs)
{
	struct mtd_info *mtd = nand_to_mtd(nand);
	int page, res = 0;
	u16 bad = 0xff;
	u8 *buf = nand_get_data_buf(nand);
	int chipnr = (int)(ofs >> nand->chip_shift);

	page = (int)(ofs >> nand->page_shift) & nand->pagemask;
	rk_nand_select_chip(nand, chipnr);
	if (rk_nand_hw_syndrome_ecc_read_page(nand, buf, false, page) == -1) {
		/* first page of a block*/
		nand_read_page_op(nand, page, nand->badblockpos, NULL, 0);
		bad = rk_nand_read_byte(nand);
		if (bad != 0xFF)
			res = 1;
		/* second page of a block*/
		nand_read_page_op(nand, page + 1, nand->badblockpos, NULL, 0);
		bad = rk_nand_read_byte(nand);
		if (bad != 0xFF)
			res = 1;
		/* last page of a block */
		page += ((mtd->erasesize - mtd->writesize) >> nand->chip_shift);
		page--;
		nand_read_page_op(nand, page, nand->badblockpos, NULL, 0);
		bad = rk_nand_read_byte(nand);
		if (bad != 0xFF)
			res = 1;
	}
	rk_nand_select_chip(nand, -1);
	return res;
}

This also requires a patch for nand_bbt.c
As I try to get to get some shape in the rest of this driver,
I have left it out for version 1 and as I wait for our respons first.

drivers/mtd/nand/nand_bbt.c
@@ -487,8 +487,10 @@ static int create_bbt(struct mtd_info *mtd, uint8_t
*buf,
		int ret;

		BUG_ON(bd->options & NAND_BBT_NO_OOB);

		ret = scan_block_fast(mtd, bd, from, buf, numpages);
		if (this->block_bad)
			ret = this->block_bad(mtd, from);
		else
			ret = scan_block_fast(mtd, bd, from, buf, numpages);

/////////////////////////////

Data structures/Partitions

The majority of Rockchip devices use a closed source FTL driver,
so when we want to read or write we must deal with it.

Example MTD string:
mtdparts=rk29xxnand:
0x00002000@0x00002000(misc),
0x00008000@0x00004000(kernel),
0x00008000@0x0000C000(boot),
0x00008000@0x00014000(recovery),
0x000C0000@0x0001C000(backup),
0x00040000@0x000DC000(cache),
0x00300000@0x0011C000(userdata),
0x00002000@0x0041C000(kpanic),
0x00200000@0x0041E000(system),
-@0x0063E000(user)"

When Rockchip mentions a string like this it has nothing to do
with the real position on NAND. FTL write where wants,
so reading there is not useful.
All sizes have to be multiplied by 512 and casted to (u64)!
All partitions need to contain at least 2 erase blocks.
One for normal use and one spare.

--------------------
FlashSavePhyInfo
RawIdbData
--------------------
...
FTL data
...
--------------------
Map blocks:
+ L2pMapInfo
+ VendorBlkInfo

Sys info:
+ sys_save_data

Vendor partition:
+ sys_ext_data    0
+ ect_tbl_info   64
+ vendor        256 + ?
+ BootConfig    512 + 0
+ DrmKeyInfo    512 + 1
+ Vendor0Info   512 + 2
+ Vendor1Info   512 + 3
+ sys           512 + ?
+ public key    520
--------------------
Bad Block Map Tbl(not compatible with MTD)
--------------------
reserved: last NAND block - n
--------------------

From the above diagram only RawIdbData has to be located in the first
erase block.
Boot ROM searches for the tag ID_IDRW = 0xFCDC8C3B.
Only the first 4 sections (4*1024) of a page are used.
When writing multiple pages extra spaces in the data
for between the sections are required.
Older cpu's (RK3066) might need extra RC4 coding.

FTL uses that RawIdbData area unfortunately also to save struct
FlashSavePhyInfo.
For a bare basic application only RawIdbData is needed.

For users that might consider MTD as a option to do something on a
Rockchip NAND
see the source code below to get an indication of what is needed for a
useful
setup to just read and write a bootloader alone. Writing of any user
partition
is not even included.
Having a basic MTD driver is just not enough.
Please advise if such a overhead can interface with MTD?
Have fun!

/////////////////////////////

On 1/10/20 12:05 PM, Miquel Raynal wrote:
> Hi Johan,
>
> Johan Jonker <jbx6244@gmail.com> wrote on Wed,  8 Jan 2020 21:53:30
> +0100:
>
>> From: Yifeng Zhao <zyf@rock-chips.com>
>>
>
> Can you change the title to "mtd: rawnand: rockchip: Add NAND
> controller driver"
>
>> Add basic Rockchip nand controller driver.
>>
>> Compatible with hardware version 6 and 9.
>> V6:16, 24, 40, 60 per 1024B BCH/ECC.
>> V9:16, 40, 60, 70 per 1024B BCH/ECC.
>> 8 bit asynchronous flash interface support.
>> Supports up to 2 identical nandc nodes.
>> Max 4 nand chips per controller.
>> Able to select a different hardware ecc setup
>> for the loader blocks.
>> No bad block support.
>
> Thank you very much for this series, as the bad blocks support is
> absolutely fundamental, I wonder what is the issue here?
>
>>
>> Signed-off-by: Yifeng Zhao <zyf@rock-chips.com>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>  drivers/mtd/nand/raw/Kconfig          |    8 +
>>  drivers/mtd/nand/raw/Makefile         |    1 +
>>  drivers/mtd/nand/raw/rockchip_nandc.c | 1224
+++++++++++++++++++++++++++++++++
>>  3 files changed, 1233 insertions(+)
>>  create mode 100644 drivers/mtd/nand/raw/rockchip_nandc.c
>>
>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>> index 74fb91ade..68dc9a36d 100644
>> --- a/drivers/mtd/nand/raw/Kconfig
>> +++ b/drivers/mtd/nand/raw/Kconfig
>> @@ -457,6 +457,14 @@ config MTD_NAND_CADENCE
>>  	  Enable the driver for NAND flash on platforms using a Cadence NAND
>>  	  controller.
>>
>> +config MTD_NAND_ROCKCHIP
>> +	tristate "Rockchip raw NAND controller driver"
>> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
>> +	depends on HAS_IOMEM
>> +	help
>> +	  Enables support for the Rockchip raw NAND controller driver.
>> +	  This controller is found on rk3066, rk3188, rk3288 and more.
>
> Can you write an exhaustive list if you know it? Or at least the
> families? It is quite challenging when you are not in the Rockchip
> world to know what SoC is similar to another random SoC.

See above.

>
>> +
>>  comment "Misc"
>>
>>  config MTD_SM_COMMON
>> diff --git a/drivers/mtd/nand/raw/Makefile
b/drivers/mtd/nand/raw/Makefile
>> index 2d136b158..3063fe74a 100644
>> --- a/drivers/mtd/nand/raw/Makefile
>> +++ b/drivers/mtd/nand/raw/Makefile
>> @@ -58,6 +58,7 @@ obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
>>  obj-$(CONFIG_MTD_NAND_STM32_FMC2)	+= stm32_fmc2_nand.o
>>  obj-$(CONFIG_MTD_NAND_MESON)		+= meson_nand.o
>>  obj-$(CONFIG_MTD_NAND_CADENCE)		+= cadence-nand-controller.o
>> +obj-$(CONFIG_MTD_NAND_ROCKCHIP)		+= rockchip_nandc.o
>
> A driver named rockchip-nand-controller.c would be nice!
>
>>
>>  nand-objs := nand_base.o nand_legacy.o nand_bbt.o nand_timings.o
nand_ids.o
>>  nand-objs += nand_onfi.o
>> diff --git a/drivers/mtd/nand/raw/rockchip_nandc.c
b/drivers/mtd/nand/raw/rockchip_nandc.c
>> new file mode 100644
>> index 000000000..018308e58
>> --- /dev/null
>> +++ b/drivers/mtd/nand/raw/rockchip_nandc.c
>> @@ -0,0 +1,1224 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Based on:
>> + *
https://github.com/rockchip-linux/kernel/blob/develop-4.4/drivers/mtd/nand/
>> + *         rockchip_nand_v6.c
>> + *
https://github.com/rockchip-linux/kernel/blob/develop-4.4/drivers/mtd/nand/
>> + *         rockchip_nand_v9.c
>
> I'm not sure the entire link is relevant, I would simple mention the
> Rockchip official Github repository and work from Yifeng.
>
>> + * Copyright (c) 2016-2019 Yifeng Zhao yifeng.zhao@rock-chips.com
>> + *
>> + * Update/restyle for linux-next.
>> + * Add exec_op function.
>
> You can drop these two lines too. This is more a "commit description"
> thing.
>
>> + * Combine driver for nandc version 6 and 9.
>
>       Support NAND controller versions 6 and 9 found on SoCs ...
>
>> + * Copyright (c) 2020 Johan Jonker jbx6244@gmail.com
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <linux/mtd/rawnand.h>
>> +
>> +#define NANDC_ID_V600			0x56363030
>> +#define NANDC_ID_V622			0x56363232
>> +#define NANDC_ID_V701			0x701
>> +#define NANDC_ID_V800			0x56383030
>> +#define NANDC_ID_V801			0x801
>> +#define NANDC_ID_V900			0x56393030
>

> I would prefer prefixing everything RK_NANDC_ or RK_

Will change define list above and below to RK_NANDC_
It takes more space though. Already difficult to stay below 80 char/line.

>
>> +
>> +#define NANDC_IDBResBlkNum		16
>> +#define NANDC_IDBEccBits		24
>> +#define NANDC_IDBStartAddr		0
>> +
>> +#define NANDC_V6_ECC_16			0x00000000
>> +#define NANDC_V6_ECC_24			0x00000010
>> +#define NANDC_V6_ECC_40			0x00040000
>> +#define NANDC_V6_ECC_60			0x00040010
>> +
>> +#define NANDC_V9_ECC_16			0x02000001
>> +#define NANDC_V9_ECC_40			0x04000001
>> +#define NANDC_V9_ECC_60			0x06000001
>> +#define NANDC_V9_ECC_70			0x00000001
>> +
>> +#define NANDC_NUM_BANKS			4
>> +#define NANDC_DEF_TIMEOUT		10000
>> +
>> +#define NANDC_REG_DATA			0x00
>> +#define NANDC_REG_ADDR			0x04
>> +#define NANDC_REG_CMD			0x08
>> +
>> +/* register offset nandc version 6 */
>> +#define NANDC_REG_V6_FMCTL		0x00
>> +#define NANDC_REG_V6_FMWAIT		0x04
>> +#define NANDC_REG_V6_FLCTL		0x08
>> +#define NANDC_REG_V6_BCHCTL		0x0c
>> +#define NANDC_REG_V6_DMA_CFG		0x10
>> +#define NANDC_REG_V6_DMA_BUF0		0x14
>> +#define NANDC_REG_V6_DMA_BUF1		0x18
>> +#define NANDC_REG_V6_DMA_ST		0x1C
>> +#define NANDC_REG_V6_BCHST		0x20
>> +#define NANDC_REG_V6_RANDMZ		0x150
>> +#define NANDC_REG_V6_VER		0x160
>> +#define NANDC_REG_V6_INTEN		0x16C
>> +#define NANDC_REG_V6_INTCLR		0x170
>> +#define NANDC_REG_V6_INTST		0x174
>> +#define NANDC_REG_V6_SPARE0		0x200
>> +#define NANDC_REG_V6_SPARE1		0x230
>> +
>> +/* register offset nandc version 9 */
>> +#define NANDC_REG_V9_FMCTL		0x00
>> +#define NANDC_REG_V9_FMWAIT		0x04
>> +#define NANDC_REG_V9_FLCTL		0x10
>> +#define NANDC_REG_V9_BCHCTL		0x20
>> +#define NANDC_REG_V9_DMA_CFG		0x30
>> +#define NANDC_REG_V9_DMA_BUF0		0x34
>> +#define NANDC_REG_V9_DMA_BUF1		0x38
>> +#define NANDC_REG_V9_DMA_ST		0x40
>> +#define NANDC_REG_V9_VER		0x80
>> +#define NANDC_REG_V9_INTEN		0x120
>> +#define NANDC_REG_V9_INTCLR		0x124
>> +#define NANDC_REG_V9_INTST		0x128
>> +#define NANDC_REG_V9_BCHST		0x150
>> +#define NANDC_REG_V9_SPARE0		0x200
>> +#define NANDC_REG_V9_SPARE1		0x204
>> +#define NANDC_REG_V9_RANDMZ		0x208
>> +
>> +/* register offset nandc common */
>> +#define NANDC_REG_BANK0			0x800
>> +#define NANDC_REG_SRAM0			0x1000
>> +
>> +/* FMCTL */
>> +#define NANDC_V6_FM_WP			BIT(8)
>> +#define NANDC_V6_FM_CE_SEL_M		0xFF
>> +#define NANDC_V6_FM_CE_SEL(x)		(1 << (x))
>> +#define NANDC_V6_FM_FREADY		BIT(9)
>> +
>> +#define NANDC_V9_FM_WP			BIT(8)
>> +#define NANDC_V9_FM_CE_SEL_M		0xFF
>> +#define NANDC_V9_FM_CE_SEL(x)		(1 << (x))
>> +#define NANDC_V9_RDY			BIT(9)
>> +
>> +/* FLCTL */
>> +#define NANDC_V6_FL_RST			BIT(0)
>> +#define NANDC_V6_FL_DIR(x)		((x) ? BIT(1) : 0)
>> +#define NANDC_V6_FL_XFER_START		BIT(2)
>> +#define NANDC_V6_FL_XFER_EN		BIT(3)
>> +#define NANDC_V6_FL_ST_BUF_S		0x4
>> +#define NANDC_V6_FL_XFER_COUNT		BIT(5)
>> +#define NANDC_V6_FL_ACORRECT		BIT(10)
>> +#define NANDC_V6_FL_XFER_READY		BIT(20)
>> +#define NANDC_V6_FL_PAGE_NUM(x)		((x) << 22)
>> +#define NANDC_V6_FL_ASYNC_TOG_MIX	BIT(29)
>> +
>> +#define NANDC_V9_FL_RST			BIT(0)
>> +#define NANDC_V9_FL_DIR(x)		((x) ? BIT(1) : 0)
>> +#define NANDC_V9_FL_XFER_START		BIT(2)
>> +#define NANDC_V9_FL_XFER_EN		BIT(3)
>> +#define NANDC_V9_FL_ST_BUF_S		0x4
>> +#define NANDC_V9_FL_XFER_COUNT		BIT(5)
>> +#define NANDC_V9_FL_ACORRECT		BIT(10)
>> +#define NANDC_V9_FL_XFER_READY		BIT(20)
>> +#define NANDC_V9_FL_PAGE_NUM(x)		((x) << 22)
>> +#define NANDC_V9_FL_ASYNC_TOG_MIX	BIT(29)
>> +
>> +/* BCHCTL */
>> +#define NAND_V6_BCH_REGION_S		0x5
>> +#define NAND_V6_BCH_REGION_M		0x7
>> +
>> +#define NAND_V9_BCH_MODE_S		25
>> +#define NAND_V9_BCH_MODE_M		0x7
>> +
>> +/* BCHST */
>> +#define NANDC_V6_BCH0_ST_ERR		BIT(2)
>> +#define NANDC_V6_BCH1_ST_ERR		BIT(15)
>> +#define NANDC_V6_ECC_ERR_CNT0(x)	((((x & (0x1F << 3)) >> 3) \
>> +					| ((x & (1 << 27)) >> 22)) & 0x3F)
>> +#define NANDC_V6_ECC_ERR_CNT1(x)	((((x & (0x1F << 16)) >> 16) \
>> +					| ((x & (1 << 29)) >> 24)) & 0x3F)
>> +
>> +#define NANDC_V9_BCH0_ST_ERR		BIT(2)
>> +#define NANDC_V9_BCH1_ST_ERR		BIT(18)
>> +#define NANDC_V9_ECC_ERR_CNT0(x)	(((x) & (0x7F << 3)) >> 3)
>> +#define NANDC_V9_ECC_ERR_CNT1(x)	(((x) & (0x7F << 19)) >> 19)
>> +
>> +/* DMA_CFG */
>> +#define NANDC_V6_DMA_CFG_WR_ST		BIT(0)
>> +#define NANDC_V6_DMA_CFG_WR(x)		((!x) ? BIT(1) : 0)
>> +#define NANDC_V6_DMA_CFG_BUS_MODE	BIT(2)
>> +
>> +#define NANDC_V6_DMA_CFG_HSIZE_8	0
>> +#define NANDC_V6_DMA_CFG_HSIZE_16	(1 << 3)
>> +#define NANDC_V6_DMA_CFG_HSIZE_32	(2 << 3)
>> +
>> +#define NANDC_V6_DMA_CFG_BURST_1	0
>> +#define NANDC_V6_DMA_CFG_BURST_4	(3 << 6)
>> +#define NANDC_V6_DMA_CFG_BURST_8	(5 << 6)
>> +#define NANDC_V6_DMA_CFG_BURST_16	(7 << 6)
>> +
>> +#define NANDC_V6_DMA_CFG_INCR_NUM(x)	((x) << 9)
>> +
>> +#define NANDC_V9_DMA_CFG_WR_ST		BIT(0)
>> +#define NANDC_V9_DMA_CFG_WR(x)		((!x) ? BIT(1) : 0)
>> +#define NANDC_V9_DMA_CFG_BUS_MODE	BIT(2)
>> +
>> +#define NANDC_V9_DMA_CFG_HSIZE_8	0
>> +#define NANDC_V9_DMA_CFG_HSIZE_16	(1 << 3)
>> +#define NANDC_V9_DMA_CFG_HSIZE_32	(2 << 3)
>> +
>> +#define NANDC_V9_DMA_CFG_BURST_1	0
>> +#define NANDC_V9_DMA_CFG_BURST_4	(3 << 6)
>> +#define NANDC_V9_DMA_CFG_BURST_8	(5 << 6)
>> +#define NANDC_V9_DMA_CFG_BURST_16	(7 << 6)
>> +
>> +#define NANDC_V9_DMA_CFG_INCR_NUM(x)	((x) << 9)
>> +
>> +/* INTEN */
>> +#define NANDC_V6_INT_DMA		BIT(0)
>> +
>> +#define NANDC_V9_INT_DMA		BIT(0)
>> +
>> +enum rk_nandc_version {
>> +	VERSION_6 = 6,
>> +	VERSION_9 = 9,
>> +};
>> +
>> +struct rk_nandc_data {
>> +	enum rk_nandc_version version;
>

> If you make a distinction between both version, maybe you can add more
> parameters here and do
>
> 	foo = data->param
>
> instead of
>
> 	if (data->version == 6)
> 		foo = this;
> 	else
> 		foo = that;
>

TODO v2

>> +};


>> +
>> +struct rk_nand_controller {
>> +	void __iomem *regs;
>> +	int irq;
>> +	struct clk *hclk;
>> +	struct clk *clk;
>> +	struct list_head chips;
>> +	struct completion complete;
>> +	struct nand_controller controller;
>> +	int banks[NANDC_NUM_BANKS];
>
>> +	bool bootromblocks;
>> +	int ecc_mode;
>> +	uint32_t ecc_strength;
>> +	int max_ecc_strength;
>

> I have not read yet the entire driver but I believe the above 4
> parameters should probably be moved in rk_nand_chip, right? Anything
> that is NAND chip related should not be in the controller structure. It
> depends if you can change ECC requirements on the fly or not.

Short answer:
The reason that it is the most convenience place to have them for now.
With one pointer from nand_get_controller_data() I have all data available.

struct rk_nand_controller *ctrl = nand_get_controller_data(nand);

The ECC is now sort of fixed to 24 and 40 for legacy reasons.
The older rk3066 bootrom apparently only works for ecc 24.
See info based on older work by Paweł Jarosz for Uboot.

I'm not too familiar with all inner working of MTD, so please advise.
Can the users get access to struct rk_nand_chip?
Would you like to give users control over what ecc to use?
What program can we use for that? Can't use dd then any more.
How do we regain ecc control if we really have to for example rk3066?
Or remove that bootrom check and always set ECC with every
rk_nandc_hw_syndrome_ecc_read_page and rk_nandc_hw_syndrome_ecc_write_page
with whatever passed along?

>
>> +	uint32_t *oob_buf;
>> +	uint32_t *page_buf;
>> +	int selected_bank;
>> +	enum rk_nandc_version version;
>> +};
>> +
>> +struct rk_nand_chip {
>> +	struct nand_chip nand;
>> +	struct list_head chip_list;
>> +};
>> +
>> +static struct rk_nand_controller g_nandc_info[2];
>
> I don't like this idea so much. I prefer a dynamic allocation in the
> probe.
>
>> +static int g_id_counter;
>
> Don't know what this is yet, but it is probably a bad idea :)
>

Maybe not interesting for MTD, but RK3288 has 2 identical NANDC's.
The currect FTL setup only works with nandc0.
To reuse the probe function for other things then MTD
it needs to be aware of alias order.
Will remove it for version 2.

>> +
>> +static void rk_nandc_init(struct rk_nand_controller *ctrl)
>> +{
>> +	if (ctrl->version == VERSION_9) {
>> +		writel(0, ctrl->regs + NANDC_REG_V9_RANDMZ);
>> +		writel(0, ctrl->regs + NANDC_REG_V9_DMA_CFG);
>> +		writel(NANDC_V9_FM_WP, ctrl->regs + NANDC_REG_V9_FMCTL);
>> +		writel(NANDC_V9_FL_RST, ctrl->regs + NANDC_REG_V9_FLCTL);
>> +		writel(0x1081, ctrl->regs + NANDC_REG_V9_FMWAIT);
>> +	} else {
>> +		writel(0, ctrl->regs + NANDC_REG_V6_RANDMZ);
>> +		writel(0, ctrl->regs + NANDC_REG_V6_DMA_CFG);
>> +		writel(NANDC_V6_FM_WP, ctrl->regs + NANDC_REG_V6_FMCTL);
>> +		writel(NANDC_V6_FL_RST, ctrl->regs + NANDC_REG_V6_FLCTL);
>> +		writel(0x1081, ctrl->regs + NANDC_REG_V6_FMWAIT);
>> +	}
>
> My above comment about the platform data would make a lot of sense here!
>
>> +}
>> +
>> +static irqreturn_t rk_nandc_interrupt(int irq, void *dev_id)
>> +{
>> +	struct rk_nand_controller *ctrl = dev_id;
>> +
>> +	if (ctrl->version == VERSION_9) {
>> +		uint32_t st = readl(ctrl->regs + NANDC_REG_V9_INTST);
>> +		uint32_t ien = readl(ctrl->regs + NANDC_REG_V9_INTEN);
>> +
>> +		if (!(ien & st))
>> +			return IRQ_NONE;
>> +
>> +		if ((ien & st) == ien)
>> +			complete(&ctrl->complete);
>> +
>> +		writel(st, ctrl->regs + NANDC_REG_V9_INTCLR);
>> +		writel(~st & ien, ctrl->regs + NANDC_REG_V9_INTEN);
>> +	} else {
>> +		uint32_t st = readl(ctrl->regs + NANDC_REG_V6_INTST);
>> +		uint32_t ien = readl(ctrl->regs + NANDC_REG_V6_INTEN);
>> +
>> +		if (!(ien & st))
>> +			return IRQ_NONE;
>> +
>> +		if ((ien & st) == ien)
>> +			complete(&ctrl->complete);
>> +
>> +		writel(st, ctrl->regs + NANDC_REG_V6_INTCLR);
>> +		writel(~st & ien, ctrl->regs + NANDC_REG_V6_INTEN);
>> +	}
>
> Same comment!
>
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void rk_nandc_select_chip(struct nand_chip *nand, int chipnr)
>> +{
>> +	struct rk_nand_controller *ctrl = nand_get_controller_data(nand);
>> +	uint32_t reg;
>> +	int banknr;
>> +
>> +	/* The register offset and bit positions for
>
> should be:
>
> 	/*
> 	 * The register...
>

> Please run checkpatch.pl --strict on this file, this kind of mistake
> would have been detected.
>

When you think that you got rid of all warnings there's always
an extra option for more...
Thanks for that advice.

>> +	 * NANDC_REG_V6_FMCTL and NANDC_REG_V9_FMCTL
>> +	 * are identical.
>> +	 */
>> +	reg = readl(ctrl->regs + NANDC_REG_V6_FMCTL);
>> +	reg &= ~NANDC_V6_FM_CE_SEL_M;
>> +
>> +	if (chipnr == -1) {
>> +		banknr = -1;
>> +	} else {
>> +		banknr = ctrl->banks[chipnr];
>> +
>> +		reg |= NANDC_V6_FM_CE_SEL(banknr);
>> +	}
>> +	writel(reg, ctrl->regs + NANDC_REG_V6_FMCTL);
>
> Maybe you can spare this writel by returning early if banknr ==
> ctrl->selected_bank.
>
>> +
>> +	ctrl->selected_bank = banknr;
>> +}
>> +
>> +static int rk_nandc_hw_ecc_setup(struct nand_chip *nand,
>> +				 uint32_t strength)
>> +{
>> +	struct rk_nand_controller *ctrl = nand_get_controller_data(nand);
>> +	uint32_t reg;
>> +
>> +	nand->ecc.strength = strength;

Should I add this comment below?

/* HW ECC always request ECC bytes for 1024 bytes blocks */

>> +	nand->ecc.bytes = DIV_ROUND_UP(nand->ecc.strength * 14, 8);
>

> What do 14 and 8 mean?

fls - find last (most-significant) bit set

int fls(unsigned int x)
{
	int r = 32;

	if (!x)
		return 0;
	if (!(x & 0xffff0000u)) {
		x <<= 16;
		r -= 16;
	}
	if (!(x & 0xff000000u)) {
		x <<= 8;
		r -= 8;
	}
	if (!(x & 0xf0000000u)) {
		x <<= 4;
		r -= 4;
	}
	if (!(x & 0xc0000000u)) {
		x <<= 2;
		r -= 2;
	}
	if (!(x & 0x80000000u)) {
		x <<= 1;
		r -= 1;
	}
	return r;
}

	nand->ecc.bytes = DIV_ROUND_UP(ecc->strength * fls(8 * 1024), 8);

formule is used to translate strength in bit/1024 BCH/ECC
to MTD ECC bytes for 1024 bytes blocks in nand->ecc.bytes

14 is replacement for fls(8 * 1024)
8 bits in a byte

>
>> +	/* HW ECC only works with an even number of ECC bytes */
>> +	nand->ecc.bytes = ALIGN(nand->ecc.bytes, 2);
>> +
>> +	if (ctrl->version == VERSION_9) {
>> +		switch (nand->ecc.strength) {
>> +		case 70:
>> +			reg = NANDC_V9_ECC_70;
>> +			break;
>> +		case 60:
>> +			reg = NANDC_V9_ECC_60;
>> +			break;
>> +		case 40:
>> +			reg = NANDC_V9_ECC_40;
>> +			break;
>> +		case 16:
>> +			reg = NANDC_V9_ECC_16;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		writel(reg, ctrl->regs + NANDC_REG_V9_BCHCTL);
>> +	} else {
>> +		switch (nand->ecc.strength) {
>> +		case 60:
>> +			reg = NANDC_V6_ECC_60;
>> +			break;
>> +		case 40:
>> +			reg = NANDC_V6_ECC_40;
>> +			break;
>> +		case 24:
>> +			reg = NANDC_V6_ECC_24;
>> +			break;
>> +		case 16:
>> +			reg = NANDC_V6_ECC_16;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		writel(reg, ctrl->regs + NANDC_REG_V6_BCHCTL);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void rk_nandc_xfer_start(struct rk_nand_controller *ctrl,
>> +				uint8_t dir, uint8_t n_KB,
>> +				dma_addr_t dma_data, dma_addr_t dma_oob)
>> +{
>> +	uint32_t reg;
>> +
>> +	if (ctrl->version == VERSION_9) {
>> +		reg = NANDC_V9_DMA_CFG_WR_ST |
>> +		      NANDC_V9_DMA_CFG_WR(dir) |
>> +		      NANDC_V9_DMA_CFG_BUS_MODE |
>> +		      NANDC_V9_DMA_CFG_HSIZE_32 |
>> +		      NANDC_V9_DMA_CFG_BURST_16 |
>> +		      NANDC_V9_DMA_CFG_INCR_NUM(16);
>> +		writel(reg, ctrl->regs + NANDC_REG_V9_DMA_CFG);
>> +		writel((uint32_t)dma_data, ctrl->regs + NANDC_REG_V9_DMA_BUF0);
>> +		writel((uint32_t)dma_oob, ctrl->regs + NANDC_REG_V9_DMA_BUF1);
>
> I'm pretty sure most of these writel could be turned into
> writel_relaxed.

writel()       -- write to the little-endian hardware register with
compiler memory barrier,
writel_relaxed -- as above, without barrier,
__raw_writel() -- as above (writel_relaxed()) without endianess
conversion (CPU ordering will be used).
Architecture-dependent.
I don't know.

>
> Also I am not a big fan of these casts, maybe you should change
> dma_data and dma_oob types (be careful: you enabled COMPILE_TEST in
> Kconfig, you must support 32-bit and 64-bit pointers, please try to
> compile this driver with different toolchains).

Driver is used for both ARM as arm64.
These registers are 32 bit. Please advise what happens
when writel gets dma_addr_t and dma_data as 64 bit.
Don't have the hardware to find out.

>
>> +
>> +		reg = NANDC_V9_FL_DIR(dir) |
>> +		      NANDC_V9_FL_XFER_EN |
>> +		      NANDC_V9_FL_XFER_COUNT |
>> +		      NANDC_V9_FL_ACORRECT |
>> +		      NANDC_V9_FL_PAGE_NUM(n_KB) |
>> +		      NANDC_V9_FL_ASYNC_TOG_MIX;
>> +		writel(reg, ctrl->regs + NANDC_REG_V9_FLCTL);
>> +		reg |= NANDC_V9_FL_XFER_START;
>> +		writel(reg, ctrl->regs + NANDC_REG_V9_FLCTL);
>> +	} else {
>> +		reg = readl(ctrl->regs + NANDC_REG_V6_BCHCTL);
>> +		reg = (reg & (~(NAND_V6_BCH_REGION_M <<
>> +				NAND_V6_BCH_REGION_S))) |
>> +		      (ctrl->selected_bank << NAND_V6_BCH_REGION_S);
>> +		writel(reg, ctrl->regs + NANDC_REG_V6_BCHCTL);
>> +
>> +		reg = NANDC_V6_DMA_CFG_WR_ST |
>> +		      NANDC_V6_DMA_CFG_WR(dir) |
>> +		      NANDC_V6_DMA_CFG_BUS_MODE |
>> +		      NANDC_V6_DMA_CFG_HSIZE_32 |
>> +		      NANDC_V6_DMA_CFG_BURST_16 |
>> +		      NANDC_V6_DMA_CFG_INCR_NUM(16);
>> +		writel(reg, ctrl->regs + NANDC_REG_V6_DMA_CFG);
>> +		writel(dma_data, ctrl->regs + NANDC_REG_V6_DMA_BUF0);
>> +		writel(dma_oob, ctrl->regs + NANDC_REG_V6_DMA_BUF1);

Same here.

>> +
>> +		reg = NANDC_V6_FL_DIR(dir) |
>> +		      NANDC_V6_FL_XFER_EN |
>> +		      NANDC_V6_FL_XFER_COUNT |
>> +		      NANDC_V6_FL_ACORRECT |
>> +		      NANDC_V6_FL_PAGE_NUM(n_KB) |
>> +		      NANDC_V6_FL_ASYNC_TOG_MIX;
>> +		writel(reg, ctrl->regs + NANDC_REG_V6_FLCTL);
>> +		reg |= NANDC_V6_FL_XFER_START;
>> +		writel(reg, ctrl->regs + NANDC_REG_V6_FLCTL);
>> +	}
>> +}
>> +
>> +static int rk_nandc_wait_for_xfer_done(struct rk_nand_controller *ctrl)
>> +{
>> +	uint32_t reg;
>> +	int ret;
>> +
>> +	if (ctrl->version == VERSION_9) {
>> +		void __iomem *ptr = ctrl->regs + NANDC_REG_V9_FLCTL;
>> +
>> +		ret = readl_poll_timeout_atomic(ptr, reg,
>> +						reg & NANDC_V9_FL_XFER_READY,
>> +						1, NANDC_DEF_TIMEOUT);
>> +	} else {
>> +		void __iomem *ptr = ctrl->regs + NANDC_REG_V6_FLCTL;
>> +
>> +		ret = readl_poll_timeout_atomic(ptr, reg,
>> +						reg & NANDC_V6_FL_XFER_READY,
>> +						1, NANDC_DEF_TIMEOUT);
>> +	}
>
> Space
>
>> +	if (ret)
>> +		pr_err("timeout reg=%x\n", reg);
>> +
>> +	return ret;
>> +}
>> +
>> +static unsigned long rk_nandc_dma_map_single(struct device *dev,
>> +		void *ptr, int size, int dir)
>

> Unaligned parameters

To restyle I use:
astyle -T8 --max-code-length=80 --style=linux rockchip_nandc.c

Please advise for a better solution.

>
>> +{
>> +#ifdef CONFIG_ARM64
>> +	__dma_map_area((void *)ptr, size, dir);
>> +	return ((unsigned long)virt_to_phys((void *)ptr));
>> +#else
>> +	return dma_map_single(dev, (void *)ptr, size, dir);
>> +#endif
>

> Please try to remove these #ifdefs, I don't know why would you need the
> former block?

This driver is used both for ARM as arm64.
Original from Rockchip: arm64 doesn't have dma_map_single() as I remember.
Don't know what to use instead.
Please advise.

>
>> +}
>> +
>> +static void rk_nandc_dma_unmap_single(struct device *dev,
>> +				      unsigned long ptr, int size, int dir)
>> +{
>> +#ifdef CONFIG_ARM64
>> +	__dma_unmap_area(phys_to_virt(ptr), size, dir);
>> +#else
>> +	dma_unmap_single(dev, (dma_addr_t)ptr, size, dir);
>> +#endif
>
> Same
>
>> +}
>> +
>> +static int rk_nandc_hw_syndrome_ecc_read_page(struct nand_chip *nand,
>> +		uint8_t *buf,
>> +		int oob_required, int page)
>

> Unaligned parameters (please check all of them).

Again blame astyle ...
After correcting it manually a few time I just left it as it is.

>
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>> +	struct rk_nand_controller *ctrl = nand_get_controller_data(nand);
>> +	struct nand_ecc_ctrl *ecc = &nand->ecc;
>> +	int max_bitflips = 0;
>> +	dma_addr_t dma_data, dma_oob;
>> +	int ret, i;
>> +	int bch_st;
>> +	int dma_oob_size = ecc->steps * 128;
>> +	int pages_per_blk = mtd->erasesize / mtd->writesize;
>> +
>> +	rk_nandc_select_chip(nand, ctrl->selected_bank);
>> +
>> +	if ((page < pages_per_blk * NANDC_IDBResBlkNum) &&
>

> Camel case is usually not welcome

Any suggestions for a beter replace for NANDC_IDBResBlkNum are welcome.

>
>> +	    ctrl->bootromblocks)
>
> This would probably deserve a helper
>
>> +		rk_nandc_hw_ecc_setup(nand, NANDC_IDBEccBits);
>> +
>> +	nand_read_page_op(nand, page, 0, NULL, 0);
>> +
>> +	dma_data = rk_nandc_dma_map_single(mtd->dev.parent,
>> +					   ctrl->page_buf, mtd->writesize,
>> +					   DMA_FROM_DEVICE);
>> +	dma_oob = rk_nandc_dma_map_single(mtd->dev.parent,
>> +					  ctrl->oob_buf, dma_oob_size,
>> +					  DMA_FROM_DEVICE);
>> +
>> +	init_completion(&ctrl->complete);
>

> One init_completion is needed (in the probe, probably) then please use
> reinit_completion().

Must study this later.

>
>> +	if (ctrl->version == VERSION_9)
>> +		writel(NANDC_V9_INT_DMA, ctrl->regs + NANDC_REG_V9_INTEN);
>> +	else
>> +		writel(NANDC_V6_INT_DMA, ctrl->regs + NANDC_REG_V6_INTEN);
>> +	rk_nandc_xfer_start(ctrl, 0, ecc->steps, dma_data, dma_oob);

>> +	wait_for_completion_timeout(&ctrl->complete, msecs_to_jiffies(5));
>> +	rk_nandc_wait_for_xfer_done(ctrl);
>
> Yous should check the return status of almost all the functions here.

Please advise what ERROR code should be returned here
that is compatible with MTD.

>
>> +	rk_nandc_dma_unmap_single(mtd->dev.parent, dma_data, mtd->writesize,
>> +				  DMA_FROM_DEVICE);
>> +	rk_nandc_dma_unmap_single(mtd->dev.parent, dma_oob, dma_oob_size,
>> +				  DMA_FROM_DEVICE);
>> +
>> +	memcpy(buf, ctrl->page_buf, mtd->writesize);
>> +
>> +	if (oob_required) {
>> +		uint8_t *oob;
>> +		uint32_t tmp;
>

> Please use u8, u16 and u32 types.

Should this be changed for the entire source?

>
>> +
>> +		for (i = 0; i < ecc->steps; i++) {
>> +			oob = nand->oob_poi +
>> +			      i * (ecc->bytes + nand->ecc.prepad);
>> +			if (ctrl->version == VERSION_9) {
>> +				tmp = ctrl->oob_buf[i];
>> +			} else {
>> +				uint8_t oob_step = (ctrl->ecc_mode <= 24) ?
>> +						   64 : 128;
>> +				tmp = ctrl->oob_buf[i * oob_step / 4];
>> +			}
>> +			*oob++ = (uint8_t)tmp;
>> +			*oob++ = (uint8_t)(tmp >> 8);
>> +			*oob++ = (uint8_t)(tmp >> 16);
>> +			*oob++ = (uint8_t)(tmp >> 24);
>> +		}
>> +	}
>> +
>> +	if (ctrl->version == VERSION_9) {
>> +		for (i = 0; i < ecc->steps / 2; i++) {
>> +			bch_st = readl(ctrl->regs + NANDC_REG_V9_BCHST + i * 4);
>> +			if (bch_st & NANDC_V9_BCH0_ST_ERR ||
>> +			    bch_st & NANDC_V9_BCH1_ST_ERR) {
>> +				mtd->ecc_stats.failed++;
>> +				max_bitflips = -1;
>> +			} else {
>> +				ret = NANDC_V9_ECC_ERR_CNT0(bch_st);
>> +				mtd->ecc_stats.corrected += ret;
>> +				max_bitflips = max_t(unsigned int,
>> +						     max_bitflips, ret);
>> +
>> +				ret = NANDC_V9_ECC_ERR_CNT1(bch_st);
>> +				mtd->ecc_stats.corrected += ret;
>> +				max_bitflips = max_t(unsigned int,
>> +						     max_bitflips, ret);
>> +			}
>> +		}
>> +	} else {
>> +		for (i = 0; i < ecc->steps / 2; i++) {
>> +			bch_st = readl(ctrl->regs + NANDC_REG_V6_BCHST + i * 4);
>> +			if (bch_st & NANDC_V6_BCH0_ST_ERR ||
>> +			    bch_st & NANDC_V6_BCH1_ST_ERR) {
>> +				mtd->ecc_stats.failed++;
>> +				max_bitflips = -1;
>

> Why not using ret = $(real error) instead of using max_bitflips here?
>
> Then:
>
> 	if (ret) {

> 		dev_err();

Do you really want to litter the kernel log with each time you hit a bad
block,
in case you use this function in a search bad block loop?
Don't thinks so ...
Please advise.

> 		return ret;
> 	}
>
> 	return max_bitflips;

rk_nandc_hw_syndrome_ecc_read_page() is used in a bad block search strategy.
I think max_bitflips = -1 was chosen as a saver value to return.
Please advise what number range MTD interprets as max_bitflips or as fault.
Also consider some uncontrolled status return value, it would be better
if we
are in control of what goes return.

>
>> +			} else {
>> +				ret = NANDC_V6_ECC_ERR_CNT0(bch_st);
>> +				mtd->ecc_stats.corrected += ret;
>> +				max_bitflips = max_t(unsigned int,
>> +						     max_bitflips, ret);
>> +
>> +				ret = NANDC_V6_ECC_ERR_CNT1(bch_st);
>> +				mtd->ecc_stats.corrected += ret;
>> +				max_bitflips = max_t(unsigned int,
>> +						     max_bitflips, ret);
>> +			}
>> +		}
>> +	}
>> +
>> +	if (max_bitflips == -1) {
>> +		dev_err(mtd->dev.parent,
>> +			"read_page %x %x %x %x %x %p %x\n",
>> +			page,
>> +			max_bitflips,
>> +			bch_st,
>> +			((uint32_t *)buf)[0],
>> +			((uint32_t *)buf)[1],
>> +			buf,
>> +			(uint32_t)dma_data);
>

> This is not very informative, please write a real error message. Avoid
> putting too much debug information, people will troubleshoot themselves
> if needed.

OK, agree.

>
>> +	}
>> +
>> +	if (ctrl->bootromblocks)
>> +		rk_nandc_hw_ecc_setup(nand, ctrl->ecc_mode);
>> +
>

> You don't use the same condition as above. Why ? Maybe the helper would
> help.

A few less conditions to check. It won't do damage in case ecc is
same before and after. Will make conditions equal.

>
>> +	return max_bitflips;
>> +}
>> +
>> +static int rk_nandc_hw_syndrome_ecc_write_page(struct nand_chip *nand,
>> +		const uint8_t *buf,
>> +		int oob_required,
>> +		int page)
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>> +	struct rk_nand_controller *ctrl = nand_get_controller_data(nand);
>> +	struct nand_ecc_ctrl *ecc = &nand->ecc;
>> +	dma_addr_t dma_data, dma_oob;
>> +	int i;
>> +	int dma_oob_size = ecc->steps * 128;
>> +	int pages_per_blk = mtd->erasesize / mtd->writesize;
>> +
>> +	rk_nandc_select_chip(nand, ctrl->selected_bank);
>> +
>> +	if ((page < pages_per_blk * NANDC_IDBResBlkNum) &&
>> +	    ctrl->bootromblocks)
>> +		rk_nandc_hw_ecc_setup(nand, NANDC_IDBEccBits);
>> +
>> +	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
>> +
>> +	for (i = 0; i < ecc->steps; i++) {
>> +		uint32_t tmp;
>> +
>> +		if (oob_required) {
>> +			uint8_t *oob;
>> +
>> +			oob = nand->oob_poi +
>> +			      i * (ecc->bytes + nand->ecc.prepad);
>> +			tmp = oob[0] |
>> +			      (oob[1] << 8) |
>> +			      (oob[2] << 16) |
>> +			      (oob[3] << 24);
>> +		} else {
>> +			/* The first NANDC_IDBResBlkNum blocks are
>> +			 * for the stored loader. The first 32 bits
>> +			 * of oob must contain a sort of link to
>> +			 * the next page address in that same block
>> +			 * for the Bootrom.
>> +			 * Depending on what FTL from Rockchip is used,
>> +			 * the first 2 pages in the NANDC_IDBResBlkNum blocks
>> +			 * are reserved for FlashPhyInfo.
>> +			 * Raw IDB data then starts at page 2 or higher.
>
> I would separate the function to read/write the loader than the usual
> read/write helpers to avoid any confusion on why you do these tricks.
>
> Maybe not the whole function, but at least the data/oob placement?
> (This is really a suggestion)
>
>> +			 */
>> +			if (!i &&
>> +			    page < pages_per_blk * NANDC_IDBResBlkNum &&
>> +			    page >= NANDC_IDBStartAddr)
>> +				tmp = (page & (pages_per_blk - 1)) * 4;
>> +			else
>> +				tmp = 0xFFFFFFFF;
>> +		}
>> +		if (ctrl->version == VERSION_9) {
>> +			ctrl->oob_buf[i] = tmp;
>> +		} else {
>> +			uint8_t oob_step = (ctrl->ecc_mode <= 24) ?
>> +					   64 : 128;
>> +			ctrl->oob_buf[i * oob_step / 4] = tmp;
>> +		}
>> +	}
>> +
>> +	memcpy(ctrl->page_buf, buf, mtd->writesize);
>> +	dma_data = rk_nandc_dma_map_single(mtd->dev.parent,
>> +					   ctrl->page_buf, mtd->writesize,
>> +					   DMA_TO_DEVICE);
>> +	dma_oob = rk_nandc_dma_map_single(mtd->dev.parent,
>> +					  ctrl->oob_buf, dma_oob_size,
>> +					  DMA_TO_DEVICE);
>> +	init_completion(&ctrl->complete);
>> +	if (ctrl->version == VERSION_9)
>> +		writel(NANDC_V9_INT_DMA, ctrl->regs + NANDC_REG_V9_INTEN);
>> +	else
>> +		writel(NANDC_V6_INT_DMA, ctrl->regs + NANDC_REG_V6_INTEN);
>> +	rk_nandc_xfer_start(ctrl, 1, ecc->steps, dma_data, dma_oob);
>> +	wait_for_completion_timeout(&ctrl->complete, msecs_to_jiffies(10));
>> +	rk_nandc_wait_for_xfer_done(ctrl);
>> +	rk_nandc_dma_unmap_single(mtd->dev.parent, dma_data, mtd->writesize,
>> +				  DMA_TO_DEVICE);
>> +	rk_nandc_dma_unmap_single(mtd->dev.parent, dma_oob, dma_oob_size,
>> +				  DMA_TO_DEVICE);
>> +
>> +	if (ctrl->bootromblocks)
>> +		rk_nandc_hw_ecc_setup(nand, ctrl->ecc_mode);
>> +
>> +	return nand_prog_page_end_op(nand);
>> +}
>> +
>> +static int rk_nandc_hw_ecc_read_oob(struct nand_chip *nand, int page)
>> +{
>> +	uint8_t *buf = nand_get_data_buf(nand);
>> +
>> +	return nand->ecc.read_page(nand, buf, true, page);
>> +}
>> +
>> +static int rk_nandc_hw_ecc_write_oob(struct nand_chip *nand, int page)
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>> +	int ret;
>> +	uint8_t *buf = nand_get_data_buf(nand);
>> +
>> +	memset(buf, 0xFF, mtd->writesize);
>> +	ret = nand->ecc.write_page(nand, buf, true, page);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return nand_prog_page_end_op(nand);
>> +}
>> +
>> +static void rk_nandc_read_buf(struct nand_chip *nand, uint8_t *buf,
int len)
>> +{
>> +	struct rk_nand_controller *ctrl = nand_get_controller_data(nand);
>> +	int offs = 0;
>> +	void __iomem *bank_base = ctrl->regs + NANDC_REG_BANK0 +
>> +				  ctrl->selected_bank * 0x100;
>

> 0x100: Maybe a define

OK, agree.

>
>> +
>> +	for (offs = 0; offs < len; offs++)
>> +		buf[offs] = readb(bank_base);
>> +}
>> +
>> +static void rk_nandc_write_buf(struct nand_chip *nand,
>> +			       const uint8_t *buf, int len)
>> +{
>> +	struct rk_nand_controller *ctrl = nand_get_controller_data(nand);
>> +	int offs = 0;
>> +	void __iomem *bank_base = ctrl->regs + NANDC_REG_BANK0 +
>> +				  ctrl->selected_bank * 0x100;
>> +
>> +	for (offs = 0; offs < len; offs++)
>> +		writeb(buf[offs], bank_base);
>> +}
>> +
>> +static void rk_nandc_write_cmd(struct nand_chip *nand, uint8_t cmd)
>> +{
>> +	struct rk_nand_controller *ctrl = nand_get_controller_data(nand);
>> +
>> +	void __iomem *bank_base = ctrl->regs + NANDC_REG_BANK0 +
>> +				  ctrl->selected_bank * 0x100 +
>> +				  NANDC_REG_CMD;
>

> You might want to write an helper to calculate bank_base, to avoid
> repeating these lines.

Even with a separate define or helper function I still have to supply
my reg, selected_bank and offset. It doesn't make things cleaner pumping
date
to and from a helper or neither doesn't it shorten my source with a define.
Tend to keep it as it is for now. If you agree of course.

>
>> +
>> +	writeb(cmd, bank_base);
>> +}
>> +
>> +static void rk_nandc_write_addr(struct nand_chip *nand, uint8_t addr)
>> +{
>> +	struct rk_nand_controller *ctrl = nand_get_controller_data(nand);
>> +
>> +	void __iomem *bank_base = ctrl->regs + NANDC_REG_BANK0 +
>> +				  ctrl->selected_bank * 0x100 +
>> +				  NANDC_REG_ADDR;
>> +
>> +	writeb(addr, bank_base);
>> +}
>> +
>> +static int rk_nandc_dev_ready(struct nand_chip *nand)
>> +{
>> +	struct rk_nand_controller *ctrl = nand_get_controller_data(nand);
>> +
>> +	if (readl(ctrl->regs + NANDC_REG_V6_FMCTL) & NANDC_V6_FM_FREADY)
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static int rk_nandc_ooblayout_ecc(struct mtd_info *mtd, int section,
>> +				  struct mtd_oob_region *oobregion)
>> +{
>> +	struct nand_chip *nand = mtd_to_nand(mtd);
>> +
>> +	if (section >= nand->ecc.steps)
>> +		return -ERANGE;
>> +
>> +	oobregion->offset = (nand->ecc.bytes + nand->ecc.prepad) * section +
>> +			    nand->ecc.prepad;
>> +	oobregion->length = nand->ecc.steps * nand->ecc.bytes;
>> +
>> +	return 0;
>> +}
>> +
>> +static int rk_nandc_ooblayout_free(struct mtd_info *mtd, int section,
>> +				   struct mtd_oob_region *oobregion)
>> +{
>> +	struct nand_chip *nand = mtd_to_nand(mtd);
>> +
>> +	if (section >= nand->ecc.steps)
>> +		return -ERANGE;
>> +
>> +	oobregion->offset = (nand->ecc.bytes + nand->ecc.prepad) * section;
>> +	oobregion->length = nand->ecc.steps * nand->ecc.prepad;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct mtd_ooblayout_ops rk_nandc_oob_ops = {
>> +	.ecc = rk_nandc_ooblayout_ecc,
>> +	.free = rk_nandc_ooblayout_free,
>> +};
>> +
>> +static void rk_nandc_free_buffer(struct nand_chip *nand)
>> +{
>> +	struct rk_nand_controller *ctrl = nand_get_controller_data(nand);
>> +
>> +	kfree(ctrl->page_buf);
>> +	kfree(ctrl->oob_buf);
>> +}
>> +
>> +static int rk_nandc_buffer_init(struct nand_chip *nand)
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>> +	struct rk_nand_controller *ctrl = nand_get_controller_data(nand);
>> +
>> +	ctrl->page_buf = kmalloc(mtd->writesize, GFP_KERNEL | GFP_DMA);
>

> device managed allocations (devm_...) would be nice

devm_kzalloc() needs an extra struct device.
Does MTD safe-gard the correct order to detach from struct
rk_nand_controller
without rk_nandc_free_buffer()?

>
>> +	if (!ctrl->page_buf)
>> +		return -ENOMEM;
>> +
>> +	ctrl->oob_buf = kmalloc(nand->ecc.steps * 128, GFP_KERNEL | GFP_DMA);
>> +	if (!ctrl->oob_buf) {
>> +		kfree(ctrl->page_buf);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rk_nandc_hw_ecc_ctrl_init(struct nand_chip *nand)
>> +{
>> +	uint8_t strengths_v6[] = {60, 40, 24, 16};
>> +	uint8_t strengths_v9[] = {70, 60, 40, 16};
>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>> +	struct rk_nand_controller *ctrl = nand_get_controller_data(nand);
>> +	int max_strength;
>> +	uint32_t i, ver;
>> +
>> +	if (nand->options & NAND_IS_BOOT_MEDIUM)
>> +		ctrl->bootromblocks = true;
>> +	else
>> +		ctrl->bootromblocks = false;
>> +
>> +	nand->ecc.prepad = 4;
>> +	nand->ecc.steps = mtd->writesize / nand->ecc.size;
>> +
>> +	max_strength = ((mtd->oobsize / nand->ecc.steps) - 4) * 8 / 14;
>> +	if (ctrl->version == VERSION_9) {
>> +		ctrl->max_ecc_strength = 70;
>> +		ver = readl(ctrl->regs + NANDC_REG_V9_VER);
>> +		if (ver != NANDC_ID_V900)
>> +			dev_err(mtd->dev.parent,
>> +				"unsupported nandc version %x\n", ver);
>> +
>> +		if (max_strength > ctrl->max_ecc_strength)
>> +			max_strength = ctrl->max_ecc_strength;
>> +
>> +		for (i = 0; i < ARRAY_SIZE(strengths_v9); i++) {
>> +			if (max_strength >= strengths_v9[i])
>> +				break;
>> +		}
>> +
>> +		if (i >= ARRAY_SIZE(strengths_v9)) {
>> +			dev_err(mtd->dev.parent,
>> +				"unsupported strength\n");
>> +			return -ENOTSUPP;
>> +		}
>> +
>> +		ctrl->ecc_mode = strengths_v9[i];
>> +	} else {
>> +		ctrl->max_ecc_strength = 60;
>> +
>> +		ver = readl(ctrl->regs + NANDC_REG_V6_VER);
>> +		if (ver == NANDC_ID_V801)
>> +			ctrl->max_ecc_strength = 16;
>> +		else if (ver == NANDC_ID_V600 ||
>> +			 ver == NANDC_ID_V622 ||

>> +			 ver == NANDC_ID_V701 ||

Added version 7 for RK3228A/RK3228B. Can someone with insider info confirm
if this works or not.

>> +			 ver == NANDC_ID_V800)
>> +			ctrl->max_ecc_strength = 60;
>> +		else
>> +			dev_err(mtd->dev.parent,
>> +				"unsupported nandc version %x\n", ver);
>> +
>> +		if (max_strength > ctrl->max_ecc_strength)
>> +			max_strength = ctrl->max_ecc_strength;
>> +
>> +		for (i = 0; i < ARRAY_SIZE(strengths_v6); i++) {
>> +			if (max_strength >= strengths_v6[i])
>> +				break;
>> +		}
>> +
>> +		if (i >= ARRAY_SIZE(strengths_v6)) {
>> +			dev_err(mtd->dev.parent,
>> +				"unsupported strength\n");
>> +			return -ENOTSUPP;
>> +		}
>> +
>> +		ctrl->ecc_mode = strengths_v6[i];
>> +	}
>> +	rk_nandc_hw_ecc_setup(nand, ctrl->ecc_mode);
>> +
>> +	mtd_set_ooblayout(mtd, &rk_nandc_oob_ops);
>> +
>> +	if (mtd->oobsize < ((nand->ecc.bytes + nand->ecc.prepad) *
>> +			    nand->ecc.steps)) {
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void rk_nandc_detach_chip(struct nand_chip *nand)
>> +{
>> +	switch (nand->ecc.mode) {
>> +	case NAND_ECC_HW_SYNDROME:
>> +		rk_nandc_free_buffer(nand);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +}
>> +
>> +static int rk_nandc_attach_chip(struct nand_chip *nand)
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(nand);
>> +	int ret;
>> +
>> +	switch (nand->ecc.mode) {
>> +	case NAND_ECC_HW_SYNDROME:
>> +		ret = rk_nandc_hw_ecc_ctrl_init(nand);
>> +		if (ret)
>> +			return ret;
>> +		ret = rk_nandc_buffer_init(nand);
>> +		if (ret)
>> +			return -ENOMEM;
>> +		nand->ecc.read_page = rk_nandc_hw_syndrome_ecc_read_page;
>> +		nand->ecc.write_page = rk_nandc_hw_syndrome_ecc_write_page;
>> +		nand->ecc.read_oob = rk_nandc_hw_ecc_read_oob;
>> +		nand->ecc.write_oob = rk_nandc_hw_ecc_write_oob;
>> +		break;
>> +	case NAND_ECC_HW:
>
> I would either refuse ECC_HW or put it besides HW_SYNDROME.

Is there a fundamental difference in handling ECC_HW and HW_SYNDROME
from the MTD point of view? Other then a indication how it's done on
the driver side?
Will drop it.

>
>> +	case NAND_ECC_NONE:
>> +	case NAND_ECC_SOFT:
>

> Have you tested with SW BCH?

Short answer: No
Just copied it from the original.
Please advise a tool to do a test between the individual ecc read options.
Or do I have to write the tool my self with mtd-utils?

>
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rk_nandc_exec_op(struct nand_chip *nand,
>> +			    const struct nand_operation *op,
>> +			    bool check_only)
>> +{
>> +	int i;
>> +	unsigned int op_id;
>> +	const struct nand_op_instr *instr = NULL;
>> +
>> +	rk_nandc_select_chip(nand, op->cs);
>> +
>> +	if (check_only)
>> +		return 0;
>> +
>> +	for (op_id = 0; op_id < op->ninstrs; op_id++) {
>> +		instr = &op->instrs[op_id];
>> +
>> +		switch (instr->type) {
>> +		case NAND_OP_CMD_INSTR:
>> +			rk_nandc_write_cmd(nand, instr->ctx.cmd.opcode);
>> +			break;
>> +		case NAND_OP_ADDR_INSTR:
>> +			for (i = 0; i < instr->ctx.addr.naddrs; i++)
>> +				rk_nandc_write_addr(nand,
>> +						    instr->ctx.addr.addrs[i]);
>> +			break;
>> +		case NAND_OP_DATA_IN_INSTR:
>> +			rk_nandc_read_buf(nand, instr->ctx.data.buf.in,
>> +					  instr->ctx.data.len);
>> +			break;
>> +		case NAND_OP_DATA_OUT_INSTR:
>> +			rk_nandc_write_buf(nand, instr->ctx.data.buf.out,
>> +					   instr->ctx.data.len);
>> +			break;
>> +		case NAND_OP_WAITRDY_INSTR:
>> +			rk_nandc_dev_ready(nand);
>> +			break;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct nand_controller_ops rk_nand_controller_ops = {
>> +	.attach_chip = rk_nandc_attach_chip,
>> +	.detach_chip = rk_nandc_detach_chip,
>> +	.exec_op = rk_nandc_exec_op,
>> +};
>> +
>> +static int rk_nandc_chip_init(struct device *dev,
>> +			      struct rk_nand_controller *ctrl,
>> +			      struct device_node *np, unsigned int chipnr)
>> +{
>> +	struct rk_nand_chip *node;
>> +	struct nand_chip *nand;
>> +	struct mtd_info *mtd;
>> +	const __be32 *reg;
>> +	int ret;
>> +
>> +	reg = of_get_property(np, "reg", NULL);
>> +	if (!reg)
>> +		return -EINVAL;
>> +
>> +	ctrl->banks[chipnr] = be32_to_cpu(*reg);
>> +
>> +	if (ctrl->banks[chipnr] < 0)
>> +		return -EINVAL;
>> +
>> +	node = devm_kzalloc(dev, sizeof(*node), GFP_KERNEL);
>> +	if (!node)
>> +		return -ENOMEM;
>> +
>> +	nand = &node->nand;
>> +
>> +	nand_set_flash_node(nand, np);
>> +	nand_set_controller_data(nand, ctrl);
>> +
>> +	nand->controller = &ctrl->controller;
>> +	nand->controller->ops = &rk_nand_controller_ops;
>> +
>> +	nand->ecc.mode = NAND_ECC_HW_SYNDROME;
>> +	nand->ecc.size = 1024;
>> +	nand->ecc.strength = 40;
>> +
>> +	nand->options = NAND_SKIP_BBTSCAN | NAND_NO_SUBPAGE_WRITE;
>> +
>> +	mtd = nand_to_mtd(nand);
>> +	mtd->dev.parent = dev;
>> +	mtd->name = devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev),
>> +				   ctrl->banks[chipnr]);
>> +
>> +	ret = nand_scan(nand, 1);
>
> Why 1 here?

TODO for version 2.
A little misunderstanding on how for_each_child_of_node works.
All chips should be scanned.
/////
Derive chipnr
Example from sunxi_nand.c

	if (!of_get_property(np, "reg", &nsels))
		return -EINVAL;

	nsels /= sizeof(u32);
	if (!nsels) {
		dev_err(dev, "invalid reg property size\n");
		return -EINVAL;
	}
/////
From rk_nandc_chips_init()

	for_each_child_of_node(np, nand_np) {
		ret = rk_nandc_chip_init(dev, ctrl, nand_np, i);

Why does sunxi_nand.c need this extra for_each_child_of_node?

>
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = mtd_device_register(mtd, NULL, 0);
>> +	if (ret) {
>> +		dev_err(dev, "mtd device register failed: %d\n", ret);
>> +		nand_release(nand);
>> +		return ret;
>> +	}
>> +
>> +	list_add_tail(&node->chip_list, &ctrl->chips);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rk_nandc_cleanup_chips(struct rk_nand_controller *ctrl)
>> +{
>> +	struct rk_nand_chip *node;
>> +	struct mtd_info *mtd;
>> +	int ret;
>> +
>> +	while (!list_empty(&ctrl->chips)) {
>> +		node = list_first_entry(&ctrl->chips, struct rk_nand_chip,
>> +					chip_list);
>> +		mtd = nand_to_mtd(&node->nand);
>> +		ret = mtd_device_unregister(mtd);
>> +		if (ret)
>> +			return ret;
>> +
>> +		rk_nandc_free_buffer(&node->nand);
>> +		nand_cleanup(&node->nand);
>> +		list_del(&node->chip_list);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rk_nandc_chips_init(struct device *dev,
>> +			       struct rk_nand_controller *ctrl)
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	struct device_node *nand_np;
>> +	int nchips = of_get_child_count(np);
>> +	int i = 0;
>> +	int ret;
>> +
>> +	if (nchips > NANDC_NUM_BANKS) {
>> +		dev_err(dev, "too many NAND chips: %d (max = 4)\n", nchips);
>> +		return -EINVAL;
>> +	}
>> +
>> +	for_each_child_of_node(np, nand_np) {
>> +		ret = rk_nandc_chip_init(dev, ctrl, nand_np, i);
>> +		if (ret) {
>> +			rk_nandc_cleanup_chips(ctrl);
>> +			of_node_put(nand_np);
>> +			return ret;
>> +		}
>> +		i++;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rk_nandc_probe(struct platform_device *pdev)
>> +{
>> +	const struct rk_nandc_data *data;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *node;
>> +	int id;
>> +	int ret;
>> +
>> +	data = of_device_get_match_data(&pdev->dev);
>> +	if (!data)
>> +		return -ENODEV;
>> +

>> +	node = pdev->dev.of_node;
>> +
>> +	id = of_alias_get_id(node, "nandc");
>> +	if (id < 0)
>> +		id = g_id_counter;
>> +	if ((id >= ARRAY_SIZE(g_nandc_info) || g_nandc_info[id].regs)) {
>> +		dev_err(
>> +			&pdev->dev,
>> +			"failed to get id for nandc node '%pOFn'\n",
>> +			node);
>> +		of_node_put(node);
>> +		return -ENODEV;
>> +	}
>> +	++g_id_counter;

See comments above about Rk3288. Keeping track node alias for nandc0.
To remove or not?

>> +
>> +	g_nandc_info[id].version = data->version;
>> +
>> +	g_nandc_info[id].regs = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(g_nandc_info[id].regs)) {
>> +		dev_err(dev, "ioremap failed\n");
>> +		return PTR_ERR(g_nandc_info[id].regs);
>> +	}
>> +
>> +	g_nandc_info[id].irq = platform_get_irq(pdev, 0);
>> +	if (g_nandc_info[id].irq < 0) {
>> +		dev_err(dev, "get irq failed\n");
>> +		return g_nandc_info[id].irq;
>> +	}
>> +
>> +	g_nandc_info[id].hclk = devm_clk_get(dev, "hclk_nandc");
>> +	if (IS_ERR(g_nandc_info[id].hclk)) {
>> +		dev_err(dev, "get hclk_nandc failed\n");
>> +		return PTR_ERR(g_nandc_info[id].hclk);
>> +	}
>> +
>> +	ret = clk_prepare_enable(g_nandc_info[id].hclk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	g_nandc_info[id].clk = devm_clk_get(dev, "clk_nandc");
>> +	if (!(IS_ERR(g_nandc_info[id].clk))) {
>> +		clk_set_rate(g_nandc_info[id].clk, 150 * 1000 * 1000);
>> +
>> +		ret = clk_prepare_enable(g_nandc_info[id].clk);
>> +		if (ret)
>> +			goto err_disable_hclk;
>> +	} else
>> +		dev_err(dev, "get clk_nandc failed\n");
>> +
>> +	if (g_nandc_info[id].version == VERSION_9)
>> +		writel(0, g_nandc_info[id].regs + NANDC_REG_V9_INTEN);
>> +	else
>> +		writel(0, g_nandc_info[id].regs + NANDC_REG_V6_INTEN);
>> +	ret = devm_request_irq(dev, g_nandc_info[id].irq, rk_nandc_interrupt,
>> +			       0, "nandc", &g_nandc_info[id]);
>> +	if (ret)
>> +		goto err_disable_clk;
>> +
>> +	nand_controller_init(&g_nandc_info[id].controller);
>> +	INIT_LIST_HEAD(&g_nandc_info[id].chips);
>> +
>> +	rk_nandc_init(&g_nandc_info[id]);
>> +
>> +	ret = rk_nandc_chips_init(dev, &g_nandc_info[id]);
>> +	if (ret) {
>> +		dev_err(dev, "init nand chips failed\n");
>> +		goto err_disable_clk;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, &g_nandc_info[id]);
>> +
>> +	return 0;
>> +
>> +err_disable_clk:
>> +	clk_disable_unprepare(g_nandc_info[id].clk);
>> +err_disable_hclk:
>> +	clk_disable_unprepare(g_nandc_info[id].hclk);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rk_nandc_remove(struct platform_device *pdev)
>> +{
>> +	struct rk_nand_controller *ctrl = platform_get_drvdata(pdev);
>> +	int ret;
>> +
>> +	ret = rk_nandc_cleanup_chips(ctrl);
>> +	if (ret)
>> +		return ret;
>> +
>> +	clk_disable_unprepare(ctrl->clk);
>> +	clk_disable_unprepare(ctrl->hclk);
>> +	platform_set_drvdata(pdev, NULL);
>> +
>> +	return 0;
>> +}
>> +
>> +static void rk_nandc_shutdown(struct platform_device *pdev)
>> +{
>> +	struct rk_nand_controller *ctrl = platform_get_drvdata(pdev);
>> +	int ret;
>> +
>> +	ret = rk_nandc_cleanup_chips(ctrl);
>> +	if (ret)
>> +		return;
>> +
>> +	clk_disable_unprepare(ctrl->clk);
>> +	clk_disable_unprepare(ctrl->hclk);
>> +	platform_set_drvdata(pdev, NULL);
>> +}
>> +
>> +static const struct rk_nandc_data rk_nandc_v6_data = {
>> +	.version = VERSION_6,
>> +};
>> +
>> +static const struct rk_nandc_data rk_nandc_v9_data = {
>> +	.version = VERSION_9,
>> +};
>> +
>> +static const struct of_device_id of_rk_nandc_match[] = {


>> +	{
>> +		.compatible = "rockchip,nandc-v6",
>> +		.data = &rk_nandc_v6_data,
>> +	},
>> +	{
>> +		.compatible = "rockchip,nandc-v9",
>> +		.data = &rk_nandc_v9_data,
>> +	},

Again to prevent guessing games please advise
if "rockchip,nandc-v6" and "rockchip,nandc-v9" are correct or
state the desired compatible strings.

>> +	{ /* sentinel */ },
>> +};
>> +
>> +static struct platform_driver rk_nandc_driver = {
>> +	.probe  = rk_nandc_probe,
>> +	.remove = rk_nandc_remove,
>> +	.shutdown = rk_nandc_shutdown,
>> +	.driver = {
>> +		.name = "rockchip-nandc",
>> +		.of_match_table = of_rk_nandc_match,
>> +	},
>> +};
>> +
>
> Move this empty line...
>
>> +module_platform_driver(rk_nandc_driver);
>
> ...Here
>
>> +MODULE_LICENSE("GPL v2");
>
> Thanks,
> Miquèl
>
//////////////////////////////////

// SPDX-License-Identifier: GPL-2.0
/*
 * Copyright (c) 2019, Johan Jonker <jbx6244@gmail.com>
 *
 * Based on:
 *
https://github.com/rockchip-linux/kernel/blob/develop-4.4/drivers/rk_nand/rk_ftl_arm_v7.S
 *
https://raw.githubusercontent.com/rockchip-linux/kernel/develop-4.4/drivers/rk_nand/rk_ftl_arm_v7.S
 * Copyright (c) 2016-2018, Fuzhou Rockchip Electronics Co., Ltd
 * SPDX-License-Identifier: GPL-2.0+
 *
 *
https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/rknand/rk_ftl_arm_v7.S
 *
https://raw.githubusercontent.com/rockchip-linux/u-boot/next-dev/drivers/rknand/rk_ftl_arm_v7.S
 * Copyright (c) 2016-2018, Fuzhou Rockchip Electronics Co., Ltd
 * SPDX-License-Identifier: GPL-2.0+
 *
 * https://github.com/rockchip-linux/rkdeveloptool/blob/master/crc.cpp
 * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
 * SPDX-License-Identifier: GPL-2.0+
 */

enum NAND_TAG {
	ID_IDBT = 0xEFF0,
	ID_VNDR = 0xF086,
	ID_SBFX = 0xF095,
	ID_SYSB = 0xF0A4,
	ID_L2PM = 0xF0C2,
	ID_BBTB = 0xF0D1,
	ID_BBTF = 0xF0E0,
	ID_RGMP = 0xFAF5,
	ID_XXXW = 0xFFFF,
	ID_SBTG = 0x12345678,
	ID_CHCK = 0x12348765,
	ID_BTCE = 0x42544345,
	ID_FTLS = 0x46544C53,
	ID_HASH = 0x47C6A7E6,
	ID_NAND = 0x4E414E44,
	ID_VPCT = 0x50000056,
	ID_IDRW = 0xFCDC8C3B,
	ID_XXXD = 0xFFFFFFFF,
};

struct __attribute__((aligned(4))) tagFlashSaveInfo {
	uint32_t Id;
	uint32_t Size;
	uint32_t JSHash;
	uint16_t gNandMaxDie;
	uint16_t gNandIDBResBlkNum;
	uint64_t IDByte[8];
	uint16_t DieCsIndex[8];
	uint64_t DieAddrs[8];
	uint32_t gNandParaInfo[8];
	uint32_t gNandOptPara[8];
	uint8_t gReadRetryInfo[852];
	uint32_t gFlashToggleModeEn;
};

struct __attribute__((aligned(2))) tagNandOptPara {
	uint8_t res1[8];
	uint8_t StartDpCmd;
	uint8_t EndDpCmd;
	uint8_t DpFirstCmd;
	uint8_t DpSecondCmd;
	uint8_t res6;
	uint8_t cmd2;
	uint8_t cmd1;
	uint8_t max;
	uint8_t option;
	uint8_t res11[15];
};

struct __attribute__((aligned(2))) tagNandParaInfo {
	uint8_t id_bytes;
	uint8_t nand_id[6];
	uint8_t vendor;
	uint8_t die_per_chip;
	uint8_t sec_per_page;
	uint16_t page_per_blk;
	uint8_t cell;
	uint8_t plane_per_die;
	uint16_t blk_per_plane;
	uint16_t operation_opt;
	uint8_t lsb_mode;
	uint8_t read_retry_mode;
	uint8_t ecc_bits;
	uint8_t access_freq;
	uint8_t opt_mode;
	uint8_t die_gap;
	uint8_t bad_block_mode;
	uint8_t multi_plane_mode;
	uint8_t slc_mode;
	uint8_t reserved[5];
};

struct __attribute__((aligned(4))) tagNandPhyInfo {
	uint32_t chip_id;
	uint32_t vendor;
	uint16_t nand_type;
	uint16_t die_num;
	uint16_t planes_per_die;
	uint16_t blk_per_plane;
	uint16_t page_per_blk;
	uint16_t page_per_slc_blk;
	uint16_t sec_per_page;
	uint16_t block_size;
	uint16_t sector_size;
	uint16_t reserved_blks;
};

struct tagReadRetryInfo {
	uint8_t retryMode;
	uint8_t size;
	uint8_t max;
	uint8_t res3;
	uint8_t addr[8];
	uint8_t offset1[8];
	uint8_t buf[832];
};

uint8_t gNandIDataBuf[2048];
struct tagNandParaInfo *gpNandParaInfo;
struct tagNandOptPara gNandOptPara;
struct tagNandPhyInfo gNandPhyInfo;
struct tagReadRetryInfo gReadRetryInfo;

uint16_t mlcPageToSlcPageTbl[512];
uint16_t slcPageToMlcPageTbl[256];

uint32_t *gFlashPageBuffer0;
uint32_t *gFlashPageBuffer1;

void P_RC4(uint8_t *buf, uint32_t size)
{
	uint8_t key[16] = {
		0x7C, 0x4E, 0x03, 0x04, 0x55, 0x05, 0x09, 0x07,
		0x2D, 0x2C, 0x7B, 0x38, 0x17, 0x0D, 0x17, 0x11,
	};
	uint8_t S[256], K[256], temp;
	uint32_t i, j, t, x;

	j = 0;
	for (i = 0; i < 256; i++) {
		S[i] = (uint8_t)i;
		j &= 0x0f;
		K[i] = key[j];
		j++;
	}
	j = 0;
	for (i = 0; i < 256; i++) {
		j = (j + S[i] + K[i]) % 256;
		temp = S[i];
		S[i] = S[j];
		S[j] = temp;
	}
	i = j = 0;
	for (x = 0; x < size; x++) {
		i = (i+1) % 256;
		j = (j + S[i]) % 256;
		temp = S[i];
		S[i] = S[j];
		S[j] = temp;
		t = (S[i] + (S[j] % 256)) % 256;
		buf[x] = buf[x] ^ S[t];
	}
}

uint32_t js_hash(uint8_t *buf, uint32_t size)
{
	uint32_t hash;
	uint8_t *p_max;
	uint32_t tmp;

	hash = ID_HASH;
	p_max = &buf[size];
	while (buf != p_max) {
		tmp = *buf++;
		hash ^= (hash >> 2) + 32 * hash + tmp;
	}
	return hash;
}

void BuildFlashLsbPageTable(uint32_t lsb_mode, uint16_t size)
{
	uint32_t counter1;
	uint32_t counter2;
	uint32_t counter3;
	uint32_t counter4;
	uint32_t counter5;
	uint32_t counter6;
	uint32_t counter7;
	uint32_t counter8;
	uint16_t offset1;
	uint16_t offset2;
	uint32_t offset3;
	uint16_t offset4;
	uint16_t *p_table1;
	uint16_t *p_table2;
	uint16_t *p_table3;
	uint16_t tmp1;
	uint16_t tmp2;
	uint16_t tmp3;
	uint32_t tmp4;
	uint16_t tmp5;
	uint32_t tmp6;

	if (lsb_mode) {
		switch (lsb_mode) {
		case 1u:
			counter2 = 0;
			do {
				tmp1 = counter2;
				if (counter2 > 3) {
					if (counter2 & 1)
						offset1 = 3;
					else
						offset1 = 2;
					tmp1 = 2 * counter2 - offset1;
				}
				slcPageToMlcPageTbl[counter2++] = tmp1;
			} while (counter2 != 256);
			break;
		case 2u:
			counter3 = 0;
			do {
				tmp2 = counter3;
				if (counter3 > 1)
					tmp2 = 2 * counter3 - 1;
				slcPageToMlcPageTbl[counter3++] = tmp2;
			} while (counter3 != 256);
			break;
		case 3u:
			counter4 = 0;
			do {
				tmp3 = counter4;
				if (counter4 > 5) {
					if (counter4 & 1)
						offset2 = 5;
					else
						offset2 = 4;
					tmp3 = 2 * counter4 - offset2;
				}
				slcPageToMlcPageTbl[counter4++] = tmp3;
			} while (counter4 != 256);
			break;
		default:
			counter5 = 0;
			switch (lsb_mode) {
			case 4u:
				slcPageToMlcPageTbl[0] = 0;
				slcPageToMlcPageTbl[1] = 1;
				slcPageToMlcPageTbl[2] = 2;
				slcPageToMlcPageTbl[3] = 3;
				slcPageToMlcPageTbl[5] = 5;
				slcPageToMlcPageTbl[6] = 7;
				counter6 = 8;
				slcPageToMlcPageTbl[4] = 4;
				slcPageToMlcPageTbl[7] = 8;
				p_table1 = &slcPageToMlcPageTbl[7];
				do {
					if (counter6 & 1)
						offset3 = 7;
					else
						offset3 = 6;
					tmp4 = 2 * counter6 - offset3;
					counter6 = (uint16_t)(counter6 + 1);
					p_table1[1] = tmp4;
					++p_table1;
				} while (counter6 != 256);
				break;
			case 5u:
				do {
					slcPageToMlcPageTbl[counter5] =
						counter5;
					++counter5;
				} while (counter5 != 16);
				p_table2 = &slcPageToMlcPageTbl[15];
				do {
					p_table2[1] = counter5;
					++p_table2;
					counter5 = (uint16_t)(counter5 + 2);
				} while (counter5 != 496);
				break;
			case 6u:
				counter7 = 0;
				do {
					tmp5 = counter7;
					if (counter7 > 5) {
						if (counter7 & 1)
							offset4 = 12;
						else
							offset4 = 10;
						tmp5 = counter5 - offset4;
					}
					slcPageToMlcPageTbl[counter7++] = tmp5;
					counter5 = (uint16_t)(counter5 + 3);
				} while (counter7 != 256);
				break;
			case 9u:
				slcPageToMlcPageTbl[0] = 0;
				slcPageToMlcPageTbl[1] = 1;
				slcPageToMlcPageTbl[2] = 2;
				p_table3 = &slcPageToMlcPageTbl[2];
				counter8 = 3;
				do {
					p_table3[1] = counter8;
					++p_table3;
					counter8 = (uint16_t)(counter8 + 2);
				} while (counter8 != 509);
				break;
			}
			break;
		}
	} else {
		do {
			slcPageToMlcPageTbl[lsb_mode] = lsb_mode;
			++lsb_mode;
		} while (lsb_mode != 256);
	}
	ftl_memset(mlcPageToSlcPageTbl, 0xFFu, 1024u);
	counter1 = 0;
	while (size > (uint16_t)counter1) {
		tmp6 = slcPageToMlcPageTbl[counter1++];
		mlcPageToSlcPageTbl[tmp6] = tmp6;
	}
}

int FlashEraseBlock(uint32_t cs, uint32_t page_addr, uint32_t slc_mode)
{
	uint8_t status;

	NandcWaitFlashReady(cs);
	NandcFlashCs(cs);
	FlashEraseCmd(cs, page_addr, slc_mode);
	NandcWaitFlashReady(cs);
	status = FlashReadStatus(cs);
	NandcFlashDeCs(cs);
	return status & 1;
}

int FlashProgPageRaw(uint32_t cs, uint32_t page_addr, uint32_t *p_data,
		     uint16_t *p_spare)
{
	uint8_t sec_per_page;
	uint8_t status;

	sec_per_page = gNandParaInfo.sec_per_page;
	if (!cs && gBlockPageAlignSize * gNandIDBResBlkNum > page_addr) {
		sec_per_page = 4;
	}
	NandcWaitFlashReady(cs);
	NandcFlashCs(cs);
	FlashProgFirstCmd(cs, page_addr);
	NandcXferData(cs, 1u, sec_per_page, p_data, p_spare);
	FlashProgSecondCmd(cs);
	NandcWaitFlashReady(cs);
	status = FlashReadStatus(cs);
	NandcFlashDeCs(cs);
	return status & 1;
}

uint32_t FlashReadRawPage(uint32_t cs, uint32_t page_addr, uint32_t *p_data,
			  uint16_t *p_spare)
{
	uint32_t sec_per_page;
	uint32_t status;

	sec_per_page = gNandParaInfo.sec_per_page;
	if (!cs && gBlockPageAlignSize * gNandIDBResBlkNum > page_addr) {
		sec_per_page = 4;
	}
	NandcWaitFlashReady(cs);
	NandcFlashCs(cs);
	FlashReadCmd(cs, page_addr);
	NandcWaitFlashReady(cs);
	status = NandcXferData(cs, 0, sec_per_page, p_data, p_spare);
	NandcFlashDeCs(cs);
	return status;
}

void FlashBlockAlignInit(uint32_t page_per_blk)
{
	uint32_t align_size;

	if (page_per_blk > 256) {
		align_size = 512;
label_3:
		gBlockPageAlignSize = align_size;
		return;
	}
	if (page_per_blk > 128) {
		align_size = 256;
		goto label_3;
	}
	gBlockPageAlignSize = page_per_blk;
}

uint32_t FlashLoadPhyInfo(void)
{
	struct tagFlashSaveInfo *info;
	uint32_t align_size;
	uint32_t bch_counter;
	uint32_t counter;
	uint32_t page_addr;
	uint32_t status;
	uint8_t bch[4];

	page_addr = 0;
	counter = 4;
	bch[0] = 60;
	bch[1] = 40;
	bch[2] = 24;
	bch[3] = 16;
	status = NAND_STS_ERROR;
	align_size = gBlockPageAlignSize;
	gNandFlashInfoBlockAddr = 0;
	gpFlashSaveInfo = (struct tagFlashSaveInfo *)gFlashPageBuffer0;
	flash_enter_slc_mode(0);
	while (1) {
		bch_counter = 0;
		while (1) {
			FlashBchSel(bch[bch_counter]);
			if (FlashReadRawPage(
				    0,
				    page_addr,
				    gFlashPageBuffer0,
				    0) != NAND_STS_ERROR ||
			    FlashReadRawPage(
				    0,
				    page_addr + 1,
				    gFlashPageBuffer0,
				    0) != NAND_STS_ERROR) {
				break;
			}
			if (++bch_counter == 4)
				goto label_6;
		}
		info = gpFlashSaveInfo;
		if (gpFlashSaveInfo->Id == ID_NAND) {
			if (!status) {
				gNandFlashIdbBlockAddr =
					page_addr
					/ gBlockPageAlignSize + 1;
				break;
			}
			if ( info->JSHash == js_hash(
				     (uint8_t *)&gpFlashSaveInfo->gNandMaxDie,
				     2036u)) {
				ftl_memcpy(
					&gNandParaInfo,
					info->gNandParaInfo,
					32u);
				ftl_memcpy(
					&gNandOptPara,
					gpFlashSaveInfo->gNandOptPara,
					32u);
				ftl_memcpy(
					&gReadRetryInfo,
					gpFlashSaveInfo->gReadRetryInfo,
					852u);
				FlashBlockAlignInit(gNandParaInfo.page_per_blk);
				gFlashToggleModeEn =
					gpFlashSaveInfo->gFlashToggleModeEn;
				gNandFlashInfoBlockAddr = page_addr;
				if (page_addr / gBlockPageAlignSize + 1 > 1)
					gNandFlashIdbBlockAddr =
						page_addr
						/ gBlockPageAlignSize + 1;
				else
					gNandFlashIdbBlockAddr = 2;
				status = NAND_STS_OK;
				gNandIDBResBlkNumSaveInFlash =
					gpFlashSaveInfo->gNandIDBResBlkNum;
			} else {
				status = NAND_STS_ERROR;
			}
		}
label_6:
		--counter;
		page_addr += align_size;
		if (counter)
			continue;
		break;
	}
	flash_exit_slc_mode(0);
	return status;
}

void FlashSavePhyInfo(void)
{
	uint32_t counter1;
	uint32_t counter2;
	uint32_t done;
	uint32_t hash;
	uint32_t status;

	gpFlashSaveInfo = (struct tagFlashSaveInfo *)gFlashPageBuffer0;
	FlashBchSel(gNandFlashIDBEccBits);
	ftl_memset(gFlashPageBuffer0, 0, 2048u);
	gpFlashSaveInfo->Id = ID_NAND;
	gpFlashSaveInfo->gNandMaxDie = gNandMaxDie;
	gpFlashSaveInfo->gNandIDBResBlkNum = gNandIDBResBlkNum;
	gpFlashSaveInfo->gFlashToggleModeEn = gFlashToggleModeEn;
	ftl_memcpy(gpFlashSaveInfo->IDByte, IDByte, 32u);
	ftl_memcpy(gpFlashSaveInfo->DieCsIndex, DieCsIndex, 8u);
	ftl_memcpy(gpFlashSaveInfo->DieAddrs, DieAddrs, 32u);
	ftl_memcpy(
		gpFlashSaveInfo->gNandParaInfo,
		&gNandParaInfo,
		32u);
	ftl_memcpy(gpFlashSaveInfo->gNandOptPara, &gNandOptPara, 32u);
	ftl_memcpy(
		gpFlashSaveInfo->gReadRetryInfo,
		&gReadRetryInfo,
		852u);
	gpFlashSaveInfo->JSHash = js_hash(
					  (uint8_t *)
					  &gpFlashSaveInfo->gNandMaxDie,
					  2036u);
	gpFlashSaveInfo->Size = 1592;
	done = 0;
	counter1 = 0;
	gpFlashSaveInfo = (struct tagFlashSaveInfo *)gFlashPageBuffer1;
	flash_enter_slc_mode(0);
	do {
		FlashEraseBlock(0, gBlockPageAlignSize * counter1, 0);
		FlashProgPageRaw(
			0,
			gBlockPageAlignSize * counter1,
			gFlashPageBuffer0,
			0);
		FlashProgPageRaw(
			0,
			gBlockPageAlignSize * counter1 + 1,
			gFlashPageBuffer0,
			0);
		status = FlashReadRawPage(
				 0,
				 gBlockPageAlignSize * counter1,
				 gFlashPageBuffer1,
				 0);
		counter2 = counter1 + 1;
		if (status != NAND_STS_ERROR &&
		    gpFlashSaveInfo->Id == ID_NAND) {
			hash = js_hash(
				       (uint8_t *)
				       &gpFlashSaveInfo->gNandMaxDie,
				       2036u);
			counter2 = counter1 + 1;
			if (gpFlashSaveInfo->JSHash == hash) {
				gNandFlashIdbBlockAddr = counter1 + 1;
				gNandFlashInfoBlockAddr = counter1
							  * gBlockPageAlignSize;
				if (done == 1)
					break;
				done = 1;
			}
		}
		counter1 = counter2;
	} while (counter2 != 4);
	flash_exit_slc_mode(0);
}

int FlashReadIdbDataRaw(uint8_t *p_buf)
{
	uint32_t bch_counter;
	uint32_t ecc_bits;
	uint32_t ecc_bits2;
	uint32_t page_counter;
	int status;
	uint8_t bch[4];

	bch[0] = 60;
	bch[1] = 40;
	bch[2] = 24;
	bch[3] = 16;
	ecc_bits2 = gNandFlashEccBits;
	if (idb_flash_slc_mode)
		flash_enter_slc_mode(0);
	status = NAND_STS_ERROR;
	page_counter = 2;
	ftl_memset(p_buf, 0, 2048u);
	while (1) {
		if (page_counter < gNandIDBResBlkNum) {
			bch_counter = 0;
			while (1) {
				ecc_bits = bch[bch_counter];
				FlashBchSel(ecc_bits);
				if ( FlashReadRawPage(
					     0,
					     gBlockPageAlignSize
					     * page_counter,
					     gFlashPageBuffer0,
					     0) != NAND_STS_ERROR)
					break;
				if (++bch_counter == 4)
					goto label_11;
			}
			if (*gFlashPageBuffer0 == ID_IDRW) {
				FTL_INFO("ECC:%d\n", ecc_bits);
				ftl_memcpy(
					p_buf,
					gFlashPageBuffer0,
					2048u);
				gNandIDBResBlkNum = gFlashPageBuffer0[128];
				if (page_counter >= gNandFlashIdbBlockAddr) {
					status = NAND_STS_OK;
					break;
				}
				gNandFlashIdbBlockAddr = page_counter;
				status = NAND_STS_OK;
				FlashSavePhyInfo();
			}
label_11:
			++page_counter;
			continue;
		}
		break;
	}
	FlashBchSel(ecc_bits2);
	if (idb_flash_slc_mode)
		flash_exit_slc_mode(0);
	return status;
}

void FlashPageProgMsbFFData(uint32_t cs, uint32_t page_addr, uint32_t count)
{
	uint32_t retry_mode;
	uint32_t shift;
	uint32_t tmp;

	if (!gFlashSlcMode || !idb_flash_slc_mode) {
		retry_mode = gpNandParaInfo->read_retry_mode;
		shift = (uint8_t)(retry_mode - 5);
		if (shift > 30) {
			if (retry_mode != 68)
				return;
		} else if (!((0x4000400Fu >> shift) & 1)) {
			return;
		}
		while (gpNandParaInfo->page_per_blk > count &&
		       mlcPageToSlcPageTbl[count] == 0xFFFF) {
			if (retry_mode == 8)
				tmp = 0;
			else
				tmp = 0xFFu;
			ftl_memset(gFlashPageBuffer1, tmp, 32768u);
			FlashProgPageRaw(
				cs,
				count + page_addr,
				gFlashPageBuffer1,
				(uint16_t *)gFlashPageBuffer1);
			count = (uint16_t)(count + 1);
		}
	}
}

void IdBlockReadData(uint32_t index, uint32_t count, uint32_t *buf)
{
	uint32_t counter;
	uint16_t counter_add;
	uint32_t ecc_bits;
	uint32_t min_sector;
	uint32_t page;
	uint32_t sector;
	uint32_t sector2;
	uint16_t size;
	uint32_t start_offset;

	size = gpNandParaInfo->sec_per_page * (uint16_t)gBlockPageAlignSize;
	FTL_INFO(
		"IdBlockReadData %x %x\n",
		index,
		count);
	counter = 0;
	sector2 = index % size;
	min_sector = index - index % size;
	start_offset = (gpNandParaInfo->sec_per_page * (index % size) >> 2) & 3;
	while (counter < count) {
		counter_add = 4 - start_offset;
		page = slcPageToMlcPageTbl[((counter + sector2) >> 2) & 0xFFFF];
		if (gFlashSlcMode &&
		    g_nandc_version_data == NAND_VERSION_V800)
			page = ((counter + sector2) >> 2) & 0xFFFF;
		ecc_bits = gNandFlashEccBits;
		sector = start_offset +
			 min_sector +
			 gpNandParaInfo->sec_per_page * page;
		FlashBchSel(gNandFlashIDBEccBits);
		flash_boot_enter_slc_mode(0);
		FlashReadPage(
			0,
			sector / gpNandParaInfo->sec_per_page,
			gFlashPageBuffer1,
			0);
		flash_boot_exit_slc_mode(0);
		FlashBchSel(ecc_bits);
		memcpy(&buf[128 * counter], gFlashPageBuffer1, 2048u);
		start_offset = 0;
		counter = (uint16_t)(counter_add + counter);
	}
	FTL_INFO(
		"IdBlockReadData %x %x ret= %x\n",
		index,
		count,
		0);
}

void IDBlockWriteData(uint32_t index, uint32_t count, uint32_t *buf)
{
	uint32_t counter;
	uint32_t ecc_bits;
	uint32_t min_sector;
	uint32_t page;
	uint32_t page1;
	uint32_t page2;
	uint32_t sector2;
	uint16_t size;
	uint32_t spare[32];

	size = gpNandParaInfo->sec_per_page * (uint16_t)gBlockPageAlignSize;
	FTL_INFO(
		"IDBlockWriteData %x %x\n",
		index,
		count);
	flash_boot_enter_slc_mode(0);
	FlashEraseBlock(0, index / gNandPhyInfo.sec_per_page, 0);
	flash_boot_exit_slc_mode(0);
	counter = 0;
	sector2 = index % size;
	min_sector = index - index % size;
	while (counter < count) {
		page = ((counter + sector2) >> 2) & 0xFFFF;
		if (page) {
			page1 = slcPageToMlcPageTbl[page + 1];
			if (gFlashSlcMode &&
			    g_nandc_version_data == NAND_VERSION_V800)
				page1 = (uint16_t)
					(((counter + sector2) >> 2) + 1);
			spare[0] = 4 * (page1 - 1);
			spare[1] = 0;
		}
		page2 = slcPageToMlcPageTbl[page];
		if (gFlashSlcMode &&
		    g_nandc_version_data == NAND_VERSION_V800)
			page2 = ((counter + sector2) >> 2) & 0xFFFF;
		ecc_bits = gNandFlashEccBits;
		FlashBchSel(gNandFlashIDBEccBits);
		flash_boot_enter_slc_mode(0);
		FlashProgPageRaw(
			0,
			(min_sector + gpNandParaInfo->sec_per_page * page2)
			/ gpNandParaInfo->sec_per_page,
			&buf[128 * counter],
			(uint16_t *)spare);
		flash_boot_exit_slc_mode(0);
		FlashBchSel(ecc_bits);
		FlashPageProgMsbFFData(
			0,
			min_sector / gpNandParaInfo->sec_per_page,
			(uint16_t)(page2 + 1));
		counter = (uint16_t)(counter + 4);
	}
	FTL_INFO(
		"IDBlockWriteData %x %x ret= %x\n",
		index,
		count,
		0);
}

int write_idblock(uint32_t size, uint32_t *buf, uint32_t *p_data)
{
	uint32_t count;
	uint32_t counter;
	uint32_t counter2;
	uint32_t index;
	uint32_t max_size;
	uint32_t offset;
	uint32_t offset2;
	uint32_t page_addr;
	uint32_t *p_read;
	uint32_t *p_write;
	uint32_t r;
	uint32_t w;
	uint16_t size2;
	uint32_t status;
	uint32_t write_counter;

	size2 = gpNandParaInfo->sec_per_page * (uint16_t)gBlockPageAlignSize;
	p_read = (uint32_t *)kmalloc_order_trace(256000, 208, 6);
	if (p_read) {
		index = (size + 511) >> 9;
		if (index <= 255)
			memcpy(&buf[128 * index], buf, 256 - index);
		count = index + 128;
		rknand_print_hex("idblk:", p_data, 4, 5);
		if (count >= 256)
			count = 256;
		counter = 0;
		FTL_INFO(
			"idb reverse %x %x\n",
			buf[128],
			gNandIDBResBlkNum);
		write_counter = 0;
		p_write = buf;
		if (buf[128] > gNandIDBResBlkNum)
			buf[128] = gNandIDBResBlkNum;
		FTL_INFO(
			"write_idblock total_sec %x %x\n",
			count,
			size);
		max_size = count << 7;
		do {
			page_addr = *p_data;
			++p_data;
			if (page_addr < gNandPhyInfo.reserved_blks &&
			    page_addr >= gNandFlashIdbBlockAddr) {
				ftl_memset(p_read, 0, 512);
				IDBlockWriteData(
					*(p_data - 1) * size2,
					count,
					p_write);
				IdBlockReadData(
					*(p_data - 1) * size2,
					count,
					p_read);
				counter2 = 0;
				offset = 0;
				while (1) {
					r = p_read[counter2];
					w = p_write[counter2];
					++counter2;
					if (r != w)
						break;
					++offset;
					if (offset == max_size)
						goto label_1;
				}
				offset2 = offset & 0xFFFFFF00;
				FTL_INFO(
					"write and check error:"
					"%d idb=%x,offset=%x,r=%x,w=%x\n",
					write_counter,
					*(p_data - 1),
					offset,
					r,
					w);
				rknand_print_hex(
					"write",
					&p_write[offset2],
					4,
					256);
				rknand_print_hex(
					"read",
					&p_read[offset2],
					4,
					256);
				ftl_memset(p_read, 0, 512);
				IDBlockWriteData(
					*(p_data - 1) * size2,
					4u,
					p_read);
				FTL_INFO("write_idblock error\n");
				if (offset < max_size)
					goto label_0;
label_1:
				++counter;
			}
label_0:
			++write_counter;
		} while (write_counter != 5);
		ftl_free(p_read);
		if (counter)
			status = 0;
		else
			status = -1;
	} else {
		status = -1;
	}
	return status;
}

void write_loader_lba(uint32_t index, uint32_t count, uint32_t *buf)
{
	uint32_t counter1;
	uint32_t counter2;
	uint32_t lba1;
	uint32_t lba2;
	uint32_t size;
	uint32_t tmp;
	uint32_t block[130];

	if (index == 64 && *buf == ID_IDRW) {
		idb_write_enable = 1;
		idb_buf = ftl_malloc(256000);
		ftl_memset(
			idb_buf,
			0,
			256000);
		idb_last_lba = index;
	}
	FTL_INFO("wl_lba %p %x %x %x\n", idb_buf, *buf, index, count);
	if (idb_write_enable) {
		if (index - 64 >= 500) {
			if (index >= 564) {
				lba1 = idb_last_lba - 64;
				if (idb_last_lba - 64 >= 500)
					lba1 = 500;
				if (gpNandParaInfo->sec_per_page == 4) {
					counter1 = 0;
					do {
						tmp = 2 * counter1;
						if (lba1 <= 256)
							tmp = counter1;
						block[counter1++] = tmp;
					} while (counter1 != 5);
				} else {
					block[0] = 2;
					block[1] = 3;
					block[2] = 4;
					block[3] = 5;
					block[4] = 6;
				}
				counter2 = 63872;
				do {
					if (idb_buf[counter2]) {
						size = 4 * (counter2 + 128);
						goto label_28;
					}
					--counter2;
				} while (counter2 != 4096);
				size = lba1 << 9;
label_28:
				write_idblock(
					size,
					idb_buf,
					block);
				idb_write_enable = 0;
				ftl_free(idb_buf);
				idb_buf = 0;
				goto label_14;
			}
		} else {
			lba2 = 564 - index;
			if (564 - index >= count)
				lba2 = count;
			ftl_memcpy(
				(void *)
				(idb_buf + ((index - 64) << 9)),
				buf,
				lba2 << 9);
		}
		if (idb_last_lba != index) {
			idb_write_enable = 0;
			if (idb_buf)
				ftl_free(idb_buf);
			idb_buf = 0;
		}
label_14:
		idb_last_lba = index + count;
	}
}

#define GetIdblockDataNoRc4(p, s) P_RC4(p, s)

int FtlGetIdBlockSysData(void *p_buf, int index)
{
	if (index > 3)
		return -1;
	ftl_memcpy(p_buf, &gNandIDataBuf[index * 512], 512);
	if (index == 1)
		return 0;
	GetIdblockDataNoRc4(p_buf, 512);
	return 0;
}

int FtlGetChipSectorInfo(void *p_buf)
{
	return FtlGetIdBlockSysData(p_buf, 2);
}

int FtlGetSNSectorInfo(void *p_buf)
{
	return FtlGetIdBlockSysData(p_buf, 3);
}

/* init */

	gFlashPageBuffer0 =
		(uint32_t *)
		ftl_malloc(32768u);
	gFlashPageBuffer1 =
		(uint32_t *)
		ftl_malloc(32768u);

	gBlockPageAlignSize = 128;
/* more init */

		if (FlashLoadPhyInfo()) {

			/* sort out your mess here */

			FlashSavePhyInfo();
		}

/* more init */

	gFlashSlcMode = gpNandParaInfo->slc_mode;
	gNandRandomizer = (gpNandParaInfo->operation_opt >> 7) & 1;
	gMultiPageReadEn = (gpNandParaInfo->operation_opt >> 3) & 1;
	gMultiPageProgEn = (gpNandParaInfo->operation_opt >> 4) & 1;
	gFlashInterfaceMode = (gpNandParaInfo->operation_opt >> 8) & 7;

	BuildFlashLsbPageTable(
		gpNandParaInfo->lsb_mode,
		(uint32_t)gpNandParaInfo->page_per_blk /
		(uint32_t)gpNandParaInfo->cell);

	FlashReadIdbDataRaw(gNandIDataBuf);

	gNandIDBResBlkNum = 16;
	gNandPhyInfo.nand_type =
		gpNandParaInfo->cell;
	gNandPhyInfo.vendor =
		gpNandParaInfo->vendor;
	gNandPhyInfo.chip_id =
		*(uint32_t *)IDByte;
	gNandPhyInfo.die_num =
		gNandMaxDie;
	gNandPhyInfo.page_per_blk =
		gpNandParaInfo->page_per_blk;
	gNandPhyInfo.blk_per_plane =
		gpNandParaInfo->blk_per_plane;
	gNandPhyInfo.planes_per_die =
		gpNandParaInfo->plane_per_die;
	gNandPhyInfo.page_per_slc_blk =
		(uint32_t)gpNandParaInfo->page_per_blk /
		(uint32_t)gpNandParaInfo->cell;
	gNandPhyInfo.sector_size =
		512;
	gNandPhyInfo.sec_per_page =
		gpNandParaInfo->sec_per_page;
	gNandPhyInfo.reserved_blks =
		16;
	gNandPhyInfo.block_size =
		gpNandParaInfo->page_per_blk *
		gpNandParaInfo->sec_per_page;

