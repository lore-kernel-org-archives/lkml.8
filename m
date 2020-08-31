Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E802C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59ABB2076D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHaB0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:26:45 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:19864 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgHaB0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:26:43 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 07V1QYMQ016064;
        Mon, 31 Aug 2020 10:26:34 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Mon, 31 Aug 2020 10:26:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from [192.168.1.2] (80.57.232.153.ap.dti.ne.jp [153.232.57.80])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 07V1QYSl016061
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 31 Aug 2020 10:26:34 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v2] arm64: dts: rockchip: enable HDMI sound nodes for
 rk3328-rock64
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200802154231.2639186-1-katsuhiro@katsuster.net>
 <7880329.2VsnZ9RgxX@phil>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <0e1c3467-0ba0-6b82-4227-40959f0c4b0e@katsuster.net>
Date:   Mon, 31 Aug 2020 10:26:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7880329.2VsnZ9RgxX@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/08/31 4:16, Heiko Stuebner wrote:
> Hi,
> 
> Am Sonntag, 2. August 2020, 17:42:31 CEST schrieb Katsuhiro Suzuki:
>> This patch enables HDMI sound (I2S0) and Analog sound (I2S1) which
>> are defined in rk3328.dtsi, and replace SPDIF nodes.
>>
>> We can use SPDIF pass-through with suitable ALSA settings and on
>> mpv or other media players.
>>    - Settings: https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockchip/filesystem/usr/share/alsa/cards/SPDIF.conf
>>    - Ex.: mpv foo.ac3 --audio-spdif=ac3 --audio-device='alsa/SPDIF.pcm.iec958.0:SPDIF'
>>
>> [Why use simple-audio-card for SPDIF?]
>>
>> For newly adding nodes, ASoC guys recommend to use audio-graph-card.
>> But all other sound nodes for rk3328 have already been defined by
>> simple-audio-card. In this time, I chose for consistent sound nodes.
>>
>> [DMA allocation problem]
>>
>> After this patch is applied, UART2 will fail to allocate DMA resources
>> but UART driver can work fine without DMA.
>>
>> This error is related to the DMAC of rk3328 (pl330 or compatible).
>> DMAC connected to 16 DMA sources. Each sources have ID number that is
>> called 'Req number' in rk3328 TRM. After this patch is applied total 7
>> of DMA sources will be activated as follows:
>>
>> | Req number | Source | Required  |
>> |            |        | channels  |
>> |------------+--------+-----------|
>> |  8,  9     | SPI0   | 2ch       |
>> | 11, 12     | I2S0   | 2ch       |
>> | 14, 15     | I2S1   | 2ch       |
>> |     10     | SPDIF  | 1ch       |
>> |------------+--------+-----------|
>> |            | Total  | 7ch       |
>> |------------+--------+-----------|
>> |  6,  7     | UART2  | 2ch       | -> cannot get DMA channels
>>
>> Due to rk3328 DMAC specification we can use max 8 channels at same
>> time. If SPI0/I2S0/I2S1/SPDIF will be activated by this patch,
>> required DMAC channels reach to 7. So the last two channels (for
>> UART2) cannot get DMA resources.
> 
> Wouldn't the dma allocation depend on the probe ordering?
> Or is this predetermined, so that always uart2 looses its dmas?
> 

Ah, it's depends on probe ordering when users use kernel modules...

It's better to disable DMA channels for UART2 for avoiding problem.
I'll fix and resend patch.


> Heiko
> 
> 
> 

Best Regards,
Katsuhiro Suzuki
