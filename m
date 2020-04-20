Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF16C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2444020735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgDTMwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:52:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2416 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728937AbgDTMwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:52:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3E7B429041ABCD99F1AA;
        Mon, 20 Apr 2020 20:52:46 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.154) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 20:52:41 +0800
Subject: Re: [PATCH] ASoC: wm89xx: Fix build error without CONFIG_I2C
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
References: <20200418090853.30340-1-yuehaibing@huawei.com>
 <20200420102701.GB44490@ediswmail.ad.cirrus.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <geert@linux-m68k.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <f175d79f-ff45-18e5-f7e7-1b22a1495871@huawei.com>
Date:   Mon, 20 Apr 2020 20:52:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20200420102701.GB44490@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/20 18:27, Charles Keepax wrote:
> On Sat, Apr 18, 2020 at 05:08:53PM +0800, YueHaibing wrote:
>> sound/soc/codecs/wm8900.o: In function `wm8900_i2c_probe':
>> wm8900.c:(.text+0xa36): undefined reference to `__devm_regmap_init_i2c'
>> sound/soc/codecs/wm8900.o: In function `wm8900_modinit':
>> wm8900.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
>> sound/soc/codecs/wm8900.o: In function `wm8900_exit':
>> wm8900.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'
>> sound/soc/codecs/wm8988.o: In function `wm8988_i2c_probe':
>> wm8988.c:(.text+0x857): undefined reference to `__devm_regmap_init_i2c'
>> sound/soc/codecs/wm8988.o: In function `wm8988_modinit':
>> wm8988.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
>> sound/soc/codecs/wm8988.o: In function `wm8988_exit':
>> wm8988.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'
>> sound/soc/codecs/wm8995.o: In function `wm8995_i2c_probe':
>> wm8995.c:(.text+0x1c4f): undefined reference to `__devm_regmap_init_i2c'
>> sound/soc/codecs/wm8995.o: In function `wm8995_modinit':
>> wm8995.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
>> sound/soc/codecs/wm8995.o: In function `wm8995_exit':
>> wm8995.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'
>>
>> Add missing I2C dependency to fix this.
>>
> 
> This doesn't look like the right fix there, all these parts can
> be used on SPI so should be usable without I2C build in.

Sorry, the patch title is wrong, the issue is CONFIG_I2C m but SND_SOC_WM8900 is y.

This should depends on SND_SOC_I2C_AND_SPI like others.

> 
> Thanks,
> Charles
> 
> .
> 

