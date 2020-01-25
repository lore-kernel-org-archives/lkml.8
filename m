Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E51C35246
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 22:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C952071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 22:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLIPleQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgAYW2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 17:28:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54681 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgAYW2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 17:28:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id g1so3028667wmh.4;
        Sat, 25 Jan 2020 14:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JuIIuzl/aUbh+G2KKabF03wm8Z2xQCzAlj66QQd7f6M=;
        b=rLIPleQc0Wji7dJaPdcJUUojzJxZLNZckJi1XGzpETZ6cHNZ0p3brsVX/ZgJy7AjYG
         H9AIxBfJvgruTYpB+/fVLWU0TTa/09bMPQ0XG6Wp6LrR3YFJsV/6LB+kafTCPT+XNDZS
         tKB3LUkb9OTVd2urF901g5dwLh+uMymY1PA/NUFf4BHiX4VFrwyDwslHMNMEpfxVqyd/
         80oYEyplzCe4x8K7xJMt7Y2XnON855NMuF0caLNSG2mR5byRBtNMtKZGUMcbHP3ec5ML
         OfKsAlsjVuxhh9cXE6XnDhdfz5EF3QBqCxaeovugPw6bDyZa2HJOE825EswiSKL4+CG8
         RirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JuIIuzl/aUbh+G2KKabF03wm8Z2xQCzAlj66QQd7f6M=;
        b=siXAT0CK6e4ccvB7cVjSAF8wW5PFfedMDA96kEaQNOG/m0hJDRz12nnAH+tDgXN5Tp
         5BU0ctS+Ihp+MFgkhlIkqzOfC1wUuucIMJci7aPMntpw7NMtQEP75p4AKbKBU0JTvqWH
         9J6DNUPjxnZbMLQnIl+hg63WwgJXOdp6ImfARYslLsajMk0vzCp3UU3aRJREIcSM/Vxq
         qReJh/OAW/4JAIWo3GuHlMmYTOy0eQCmGp9t9Ewpk5Onif6Cx8WtWEBSrHuMAWSuV5Pd
         9XqwofW1FS+vFjQdzxv9mY8iyW6b5I2eL1LZvH7ubESYKn3Qi0IRuh244ceN5QQjq9qG
         6T2w==
X-Gm-Message-State: APjAAAV04EVAR9WLvwLnC6OLOmMfvjS79Df2lPpC1EEaC09hN0kMitMU
        L0z6GFDv0B0Vib5McCLWCv4=
X-Google-Smtp-Source: APXvYqz5BIt7pACL1GHEpmqqXj8Xco8xfSye9IZWqYTSbnpswncvmZj5/2o76yKiCIMZj0o+U7EZAw==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr6169031wmc.185.1579991314340;
        Sat, 25 Jan 2020 14:28:34 -0800 (PST)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o4sm13290965wrw.97.2020.01.25.14.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 14:28:33 -0800 (PST)
Subject: Re: [RFC PATCH v2 00/10] Enable RK3066 NANDC for MK808
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, yifeng.zhao@rock-chips.com
References: <20200124163001.28910-1-jbx6244@gmail.com>
 <20200124181751.721aa428@xps13>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <dd4bb5d4-76fe-1a34-5fee-5b9e58596c1d@gmail.com>
Date:   Sat, 25 Jan 2020 23:28:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124181751.721aa428@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

See below.
Btw, what is your impression of the other V2 'improvements'?

Thanks

[..]

>> Not tested:
>>
>> NANDC version 9.
>> NAND raw write.
>
> nandbiterrs -i /dev/mtd<x> to validate it works!
>
>> RK3066 still has no support for Uboot.
>> Any write command would interfere with data structures made by the
boot loader.
>>
>> Etc.
>>
>> Problems:
>>
>> No bad block support. Most devices use a FTL bad block map with tags
>> that must be located on specific page locations which is outside
>> the scope of the raw MTD framework.
>
> I don't understand this story of bad block map. Are you comparing with
> a vendor kernel?

Two separate things:

-Rockchip FTL has it's own FTL storage format.
The original factory BBM (marker) information is lost, so it stores
a BB (bad block) map/table at the (last erase block - n) and then downwards.
See source below. Not usable for raw MTD. It's the situation most user will
find on there NAND.


- For raw MTD to use it's own BB map in this stage the proposed solution
for raw MTD just didn't gave me something/results that I understand,
so I leave it out for now. For an empty NAND without Rockchip FTL this could
work as long as it stays out of our bootrom blocks.
It's fine that MTD is 'rigid', but not all Socs fit, so find solutions
that are maybe second best. MTD has most components already in place,
see what we can make out of it.

>
> If vendors invent new ways to handle MTD blocks it's sad but they will
> never be compatible with mainline. It's a fact. However for an upstream
> version, I don't get if there is any real issue? The location of the
> BBM is not related to your controller driver but depends on the NAND
> chip and as you say below we know provide three possible positions in
> a block.
>

Handling of MTD blocks remains the same AFAICT.
It transfers data and oob byte to MTD data structures.
Just find a way to tell MTD not mess with bootrom blocks.
Programming/reading in Uboot and Linux is something that Open Source
has to find a solution for.

> What you refer as the FTL is the equivalent of UBI in Linux, which
> indeed offers to the user a linear logical view of all the valid blocks
> while physically the data is spread across all the available
> eraseblocks.

When I refer to FTL it's to the Rockchip FTL.
In this current EXPERIMENTAL driver stage I just warn a potential
unaware user
of the things that are at play on that NAND. UBI might work fine, but
not now.

>
>>
>> hynix_nand_init() add extra option NAND_BBM_LASTPAGE for H27UCG8T2ATR-BC.
>>

Example:
To see what happens when a partition is placed over the bootrom erase
blocks.
From the previous log example it seems that it somehow does do a read
command
at the end of this partition. That what tests are for.

>> No partition support. A FTL driver will store at random locations and
>> a linear user specific layout does not fit within
>> the generic character of this basic driver.
>>

MTD partition support works fine. It's just the current content of my
RK3066 NAND
written with a Rockchip FTL loader that makes write tests not so smart
as I have
to reprogram then with USB. Chicken egg problem.

>> Driver assumes that IO pins are correctly set by the boot loader.
>
> Which pins are you talking about? Are you missing a pinctrl driver?
>

No, NAND share the same data IO pins as emmc.
Set direct in grfReg, not with pinctrl.
Every Rockchip grfReg is different, so leave it out for now.
For my Linux TEST driver not a issue as that is already done
by the loader.

Would you like this grf thing included in a Linux driver for every Soc?

>>
>> Fixed timing setting.

Mentioned for completeness.

>>
>> RK3228A/RK3228B compatibility version 701 unknown
>> RV1108 nand version unknown

Can Shawn Lin or someone else help here?
RV1108 TRM (manual) is still missing?

>>

[..]

Have fun!

/////////////////////
From rk3066a.dtsi:
SPDX-License-Identifier: (GPL-2.0+ OR MIT)
Copyright (c) 2013 MundoReader S.L.

		emmc {
			emmc_clk: emmc-clk {
				rockchip,pins = <3 RK_PD7 2 &pcfg_pull_default>;
			};

			emmc_cmd: emmc-cmd {
				rockchip,pins = <4 RK_PB1 2 &pcfg_pull_default>;
			};

			emmc_rst: emmc-rst {
				rockchip,pins = <4 RK_PB2 2 &pcfg_pull_default>;
			};

			/*
			 * The data pins are shared between nandc and emmc and
			 * not accessible through pinctrl. Also they should've
			 * been already set correctly by firmware, as
			 * flash/emmc is the boot-device.
			 */
		};

/////////////////////
From pinctrl_rk3066.c:
SPDX-License-Identifier:     GPL-2.0+
Copyright 2017 Paweł Jarosz

static void pinctrl_rk3066_nand_config(struct rk3066_grf *grf)
{
	rk_clrsetreg(&grf->soc_con0,
		     EMMC_FLASH_SEL_MASK,
		     0 << EMMC_FLASH_SEL_SHIFT);
	rk_clrsetreg(&grf->gpio3d_iomux,
		     GPIO3D7_MASK,
		     GPIO3D7_FLASH_DQS << GPIO3D7_SHIFT);
}

/////////////////////
For EMMC:

GRF_GPIO_IOMUX[3].GPIOD_IOMUX = ((0x3<<14)<<16)|(0x2<<14); // dqs
GRF_GPIO_IOMUX[4].GPIOB_IOMUX = ((0xf<<2)<<16)|(0xa<<2);   // cmd,rstn
GRF_SOC_CON[0] = ((0x1<<11)<<16)|(0x1<<11);                // emmc
data0-7,wp

/////////////////////

GRF_SOC_CON0 RK3066:
Bit Attr Reset Value        Description
31:16 RW 0x0 write_enable   bit 0~bit 15 write enable

11    RW 0x0 emmc_flash_sel emmc flash select used for iomux
                            IO_FLASH_DATA[7:0] , IO_FLASH_WP are
                            selected for emmc instead of flash

/////////////////////////////////////////////////////////////

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
 */

struct nand_req {
	uint32_t status;
	uint32_t page_addr;
	uint32_t *p_data;
	uint16_t *p_spare;
	uint32_t lpn;
	uint32_t res2;
	uint32_t res3;
	uint32_t res4;
	uint32_t res5;
};

struct tagBbtInfo {
	uint16_t id;
	uint16_t page;
	uint16_t region;
	uint16_t counter;
	uint32_t index;
	uint16_t blk_cnt[8];
	uint32_t *map[8];
};

struct tag_sys_spare_buf {
	uint16_t tag;
	uint16_t id;
	uint32_t index;
	uint16_t region;
	uint16_t bb_num;
	uint32_t sys_blks_per_plane;
};

struct tagBbtInfo gBbtInfo;
struct nand_req req_sys;

uint32_t FtlBbmIsBadBlock(uint32_t lbn)
{
	return (gBbtInfo.map[(uint16_t)(lbn / c_ftl_nand_blks_per_die)]
		[lbn % c_ftl_nand_blks_per_die >> 5] >>
		(lbn % c_ftl_nand_blks_per_die & 0x1F)) & 1;
}

int FtlLoadBbt(void)
{
	struct tag_sys_spare_buf *p_spare;
	uint32_t counter;
	int i;
	uint32_t index;
	uint16_t page1;
	uint32_t page2;
	uint8_t *p_buf;
	uint32_t *p_map1;
	uint8_t *p_map2;
	uint16_t region;
	size_t size;
	uint16_t sys_blks_per_plane;
	uint32_t tmp;

	FTL_DBG();

	req_sys.p_data = p_sys_data_buf;
	p_spare = (struct tag_sys_spare_buf *)p_sys_spare_buf;
	req_sys.p_spare = p_sys_spare_buf;
	FtlBbtMemInit();
	for (i = (uint16_t)(c_ftl_nand_blks_per_die - 1);
	     c_ftl_nand_blks_per_die - 47 <= i;
	     i = (uint16_t)(i - 1)) {
		req_sys.page_addr = i << 10;
		FlashReadPages(&req_sys, 1u, 1u);
		if (req_sys.status == NAND_STS_ERROR) {
			++req_sys.page_addr;
			FlashReadPages(&req_sys, 1u, 1u);
		}
		if (req_sys.status != NAND_STS_ERROR &&
		    p_spare->tag == ID_BBTB) {
			index = p_spare->index;
			gBbtInfo.id = i;
			gBbtInfo.index = index;
			gBbtInfo.region = p_spare->region;
			break;
		}
	}
	if (gBbtInfo.id == 0xFFFF)
		return -1;
	if (gBbtInfo.region != 0xFFFF) {
		req_sys.page_addr = gBbtInfo.region << 10;
		FlashReadPages(&req_sys, 1u, 1u);
		if (req_sys.status != NAND_STS_ERROR &&
		    p_spare->tag == ID_BBTB &&
		    p_spare->index > gBbtInfo.index) {
			gBbtInfo.index = p_spare->index;
			region = p_spare->region;
			gBbtInfo.id = gBbtInfo.region;
			gBbtInfo.region = region;
		}
	}
	page1 = FtlGetLastWrittenPage(gBbtInfo.id, 1u);
	page2 = (uint16_t)page1;
	gBbtInfo.page = page1 + 1;
	while ((page2 & 0x80000000) == 0) {
		req_sys.page_addr = page2 | (gBbtInfo.id << 10);
		req_sys.p_data = p_sys_data_buf;
		FlashReadPages(&req_sys, 1u, 1u);
		if (req_sys.status != NAND_STS_ERROR &&
		    p_spare->tag == ID_BBTB) {
			goto label_1;
		}
		page2 = (uint16_t)(page2 - 1);
	}
	FTL_ERR();
label_1:
	sys_blks_per_plane = p_spare->sys_blks_per_plane;
	gBbtInfo.counter = p_spare->bb_num;
	if (sys_blks_per_plane != 0xFFFF &&
	    sys_blks_per_plane != c_ftl_nand_sys_blks_per_plane) {
		tmp = (uint32_t)c_ftl_nand_blk_per_plane >> 2;
		if (c_ftl_nand_sys_blks_per_plane < tmp &&
		    sys_blks_per_plane < tmp) {
			FtlSysBlkNumInit(sys_blks_per_plane);
		}
	}
	p_map1 = (uint32_t *)&gBbtInfo.blk_cnt[6];
	counter = 0;
	while (counter < c_ftl_nand_die_num) {
		p_map2 = (uint8_t *)p_map1[1];
		++p_map1;
		size = 4 * c_ftl_nand_bbm_buf_size;
		p_buf = (uint8_t *)req_sys.p_data + counter++ * size;
		ftl_memcpy(p_map2, p_buf, size);
	}
	return 0;
}

void FtlBbmTblFlush(void)
{
	struct tag_sys_spare_buf *p_spare;
	uint32_t bb_num;
	uint16_t counter1;
	uint32_t counter2;
	uint32_t die_counter;
	uint16_t lbn1;
	uint32_t lbn2;
	uint32_t *p_map;
	uint32_t sector;
	uint8_t *tmp_p_map;

	FTL_DBG();

	die_counter = 0;
	if (!g_flash_read_only_en) {
		p_map = (uint32_t *)&gBbtInfo.blk_cnt[6];
		req_sys.p_spare = p_sys_spare_buf;
		req_sys.p_data = p_sys_data_buf;
		ftl_memset(
			p_sys_data_buf,
			g_flash_read_only_en,
			c_ftl_nand_byte_per_page);
		while ((uint32_t)die_counter < c_ftl_nand_die_num) {
			tmp_p_map = (uint8_t *)p_map[1];
			++p_map;
			sector = die_counter++
				 * c_ftl_nand_bbm_buf_size;
			ftl_memcpy(
				&req_sys.p_data[sector],
				tmp_p_map,
				4 * c_ftl_nand_bbm_buf_size);
		}
		p_spare = (struct tag_sys_spare_buf *)req_sys.p_spare;
		counter1 = 0;
		counter2 = 0;
		ftl_memset(req_sys.p_spare, 0xFFu, 16u);
		p_spare->tag = ID_BBTB;
		p_spare->index = gBbtInfo.index;
		p_spare->id = gBbtInfo.id;
		p_spare->region = gBbtInfo.region;
		p_spare->bb_num = gBbtInfo.counter;
		p_spare->sys_blks_per_plane = c_ftl_nand_sys_blks_per_plane;
		do {
			while (1) {
				req_sys.p_data = p_sys_data_buf;
				bb_num = p_spare->bb_num;
				req_sys.p_spare = p_sys_spare_buf;
				req_sys.status = NAND_STS_OK;
				req_sys.page_addr = gBbtInfo.page
						    | (gBbtInfo.id << 10);
				FTL_INFO(
					"FtlBbmTblFlush id=%x,page=%x,"
					"previd=%x cnt=%d\n",
					gBbtInfo.id,
					gBbtInfo.page,
					gBbtInfo.region,
					bb_num);
				if (gBbtInfo.page >=
				    c_ftl_nand_page_per_slc_blk - 1) {
					lbn1 = gBbtInfo.id;
					gBbtInfo.page = 0;
					p_spare->index = ++gBbtInfo.index;
					p_spare->region = lbn1;
					lbn2 = gBbtInfo.region;
					gBbtInfo.region = lbn1;
					gBbtInfo.id = lbn2;
					req_sys.page_addr = lbn2 << 10;
					req_erase->page_addr = lbn2 << 10;
					FlashEraseBlocks(
						req_erase,
						1u,
						1u);
				}
				FlashProgPages(&req_sys, 1u, 1u, 1u);
				++gBbtInfo.page;
				if (req_sys.status == NAND_STS_ERROR)
					break;
				if (++counter2 != 1 &&
				    req_sys.status != NAND_STS_REFRESH) {
					return;
				}
			}
			++counter1;
			FTL_INFO(
				"FtlBbmTblFlush error:%x\n",
				req_sys.page_addr);
		} while (counter1 <= 3u);
		FTL_INFO(
			"FtlBbmTblFlush error = %x error count = %d\n",
			req_sys.page_addr,
			counter1);
		g_flash_read_only_en = 1;
	}
}
