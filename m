Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FD6C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E2F20737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeNW4Ujv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbgFIUSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbgFIUSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:18:20 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8324C05BD1E;
        Tue,  9 Jun 2020 13:18:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q19so10914eja.7;
        Tue, 09 Jun 2020 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KC+Q83VPZzMlqolXBXEKcpuJ9FScuGWzx6JhmUmNyNc=;
        b=EeNW4UjvW+6S95WUz7HfGxgUJn1gTCj9PL6zjddRXbKFlkdYb0qnzEyUpYMLYEBiAG
         5Rk84vvPjS3gHPAYgklMyLmwQ5uNOFj89xf6Yon8QKt9Q8pdrWfMXS97H/Ihba6ITkc+
         WclOMXtoecZUjQB8R98r2/NXbXX7JvmvqBCMKumx/43z/WX1pANRxrDhuSrRgIYlCeXx
         2aL4nUYA/1uv+6qkZKxmqJ34ZlRvI5H2zb5c3g+vhEzR4kpKQoY7sUWwv0DrS80AAuTs
         gxqySTzEuew1YaXOkua01d7GqKwBOhsDiJUAvxgZMF1xtZEV0IAiCwSak0YQlO6KSJHd
         rJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KC+Q83VPZzMlqolXBXEKcpuJ9FScuGWzx6JhmUmNyNc=;
        b=KYgKIvsXFyiwKxbqL58dE7kErlLP4ACQY1g4mZU2yRI06SY9OHAka8nZwst41gPwSH
         mSnW/ZmITF6d9hrVkXh0n2ApptOKxEt03gmuz0mKZeqdxFVm0Ltz8VZlzzWlRA+gFsUt
         2grpKiRBQ70ITC2xbDros7bBMZuAw73MMg/xD7Jn7to1P8Oj4wZdR22oqYrxjvWoyrea
         CAXll3Ln3FCKd00fHseZZigxlwrtgEN0xljVnLz+KHB0V9padZ25mGpocR2/aJTPA/Qe
         p9UZXzaVHyhhBOrZmyfyLAZncpmh28KIM1iev5VvK7PljmJiPHYNMjP/oyadei/cfTG0
         E/1A==
X-Gm-Message-State: AOAM531ycMws1D1+Nu148Hq8z7nxI71+xLO/kp7xc46EajCR8n441HGL
        OwefyQx7RG1AtN0cn8WWYXA=
X-Google-Smtp-Source: ABdhPJxfFjAQ2iFrXqTiotmLGJ0K4tuq7uoLusv+WJ6CJh25HXZ7mplpOTW07mjA7oajhYRrItzAWw==
X-Received: by 2002:a17:906:799:: with SMTP id l25mr135009ejc.234.1591733897541;
        Tue, 09 Jun 2020 13:18:17 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id y12sm13986179ejr.77.2020.06.09.13.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 13:18:17 -0700 (PDT)
Subject: Re: [PATCH v6 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
From:   Johan Jonker <jbx6244@gmail.com>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20200609074020.23860-1-yifeng.zhao@rock-chips.com>
 <20200609074020.23860-3-yifeng.zhao@rock-chips.com>
 <7eb89126-9d4b-9cdf-0f77-3242df36e090@gmail.com>
Message-ID: <0b83ca45-3218-aaff-1462-7e08ae1e3afd@gmail.com>
Date:   Tue, 9 Jun 2020 22:18:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7eb89126-9d4b-9cdf-0f77-3242df36e090@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 6:10 PM, Johan Jonker wrote:

> On 6/9/20 9:40 AM, Yifeng Zhao wrote:

[..]

>> +static int rk_nfc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
>> +			     const u8 *buf, int page, int raw)
>> +{
>> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
>> +	struct rk_nfc_nand_chip *rk_nand = to_rk_nand(chip);
>> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>> +	int oob_step = (ecc->bytes > 60) ? NFC_MAX_OOB_PER_STEP :
>> +			NFC_MIN_OOB_PER_STEP;
>> +	int pages_per_blk = mtd->erasesize / mtd->writesize;
>> +	int ret = 0, i, boot_rom_mode = 0;
>> +	dma_addr_t dma_data, dma_oob;
>> +	u32 reg;
>> +	u8 *oob;
>> +
>> +	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
>> +
>> +	if (!raw) {
>> +		memcpy(nfc->page_buf, buf, mtd->writesize);
>> +		memset(nfc->oob_buf, 0xff, oob_step * ecc->steps);
>> +
> 
>> +		/*
>> +		 * The first 8(some devices are 4 or 16) blocks in use by
> 
> are in use by
> 
>> +		 * the boot ROM and the first 32 bits of oob need to link
>> +		 * to the next page address in the same block.
>> +		 * Config the ECC algorithm supported by the boot ROM.
>> +		 */
>> +		if (page < pages_per_blk * rk_nand->boot_blks &&
>> +		    chip->options & NAND_IS_BOOT_MEDIUM) {
>> +			boot_rom_mode = 1;
>> +			if (rk_nand->boot_ecc != ecc->strength)
>> +				rk_nfc_hw_ecc_setup(chip, ecc,
>> +						    rk_nand->boot_ecc);
>> +		}
> 
> Helper?
> 
>> +
>> +		/*
> 


>> +		 * Swap the first oob with the seventh oob and bad block
> 
> 
> Swap the first oob byte with the seventh oob byte.
> 
>> +		 * mask is saved at the seventh oob.
> 
> The bad block mask is stored at the seventh oob byte.

Just wondering bit or byte?
seventh or eight?

> 
>> +		 */
>> +		swap(chip->oob_poi[0], chip->oob_poi[7]);

uint8_t *oob_poi;

1: oob_poi points to a byte I think?

What was the swap puspose? A bit or a byte?
There's 4 bytes oob per step.
Could you explain?

2: oob_poi[7] counting starts at [0] #1, [7] is then #8 ?
Is that correct?

>> +
>> +		for (i = 0; i < ecc->steps; i++) {
>> +			oob = chip->oob_poi + i * NFC_SYS_DATA_SIZE;
>> +			reg = oob[0] | oob[1] << 8 | oob[2] << 16 |
>> +			      oob[3] << 24;
>> +			if (!i && boot_rom_mode)
>> +				reg = (page & (pages_per_blk - 1)) * 4;
>> +
>> +			if (nfc->cfg->type == NFC_V6 ||
>> +			    nfc->cfg->type == NFC_V8)
>> +				nfc->oob_buf[i * oob_step / 4] = reg;
>> +			else
>> +				nfc->oob_buf[i] = reg;
>> +		}
>> +
>> +		dma_data = dma_map_single(nfc->dev, (void *)nfc->page_buf,
>> +					  mtd->writesize, DMA_TO_DEVICE);
>> +		dma_oob = dma_map_single(nfc->dev, nfc->oob_buf,
>> +					 ecc->steps * oob_step,
>> +					 DMA_TO_DEVICE);
>> +
>> +		reinit_completion(&nfc->done);
>> +		writel(INT_DMA, nfc->regs + nfc->cfg->int_en_off);
>> +
>> +		rk_nfc_xfer_start(nfc, NFC_WRITE, ecc->steps, dma_data,
>> +				  dma_oob);
>> +		ret = wait_for_completion_timeout(&nfc->done,
>> +						  msecs_to_jiffies(100));
>> +		if (!ret)
>> +			dev_warn(nfc->dev, "write: wait dma done timeout.\n");
>> +		/*
>> +		 * Whether the DMA transfer is completed or not. The driver
>> +		 * needs to check the NFC`s status register to see if the data
>> +		 * transfer was completed.
>> +		 */
>> +		ret = rk_nfc_wait_for_xfer_done(nfc);
>> +
>> +		dma_unmap_single(nfc->dev, dma_data, mtd->writesize,
>> +				 DMA_TO_DEVICE);
>> +		dma_unmap_single(nfc->dev, dma_oob, ecc->steps * oob_step,
>> +				 DMA_TO_DEVICE);
>> +
> 
>> +		if (boot_rom_mode && rk_nand->boot_ecc != ecc->strength)
>> +			rk_nfc_hw_ecc_setup(chip, ecc, ecc->strength);
> 
> Helper?
> 
>> +
>> +		if (ret) {
>> +			ret = -EIO;
> 
>> +			dev_err(nfc->dev,
>> +				 "write: wait transfer done timeout.\n");
> 
> align
> 
>> +		}
>> +	} else {

>> +		rk_nfc_write_buf(chip, buf, mtd->writesize + + mtd->oobsize);

Too many +++ here?                                         ^ ^

>> +	}
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = nand_prog_page_end_op(chip);
>> +
>> +	/* Deselect the currently selected target. */
>> +	rk_nfc_select_chip(chip, -1);
>> +
>> +	return ret;
>> +}
