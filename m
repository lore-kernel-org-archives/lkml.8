Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97D0C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90FF82070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGQBt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 21:49:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726710AbgGQBtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:49:22 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6E78924D9B1F4BEE533D;
        Fri, 17 Jul 2020 09:49:20 +0800 (CST)
Received: from [10.174.179.105] (10.174.179.105) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 17 Jul
 2020 09:49:15 +0800
Subject: Re: [PATCH] ASoC: meson: add the missed kfree() for
 axg_card_add_tdm_loopback
To:     Jerome Brunet <jbrunet@baylibre.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <khilman@baylibre.com>, <kuninori.morimoto.gx@renesas.com>
References: <20200716132558.33932-1-jingxiangfeng@huawei.com>
 <1jzh7zegfw.fsf@starbuckisacylon.baylibre.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5F11039A.7040308@huawei.com>
Date:   Fri, 17 Jul 2020 09:49:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1jzh7zegfw.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.105]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/7/16 21:29, Jerome Brunet wrote:
>
> On Thu 16 Jul 2020 at 15:25, Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:
>
>> axg_card_add_tdm_loopback() misses to call kfree() in an error path. Add
>> the missed function call to fix it.
>>
>> Fixes: c84836d7f650 ("ASoC: meson: axg-card: use modern dai_link style")
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>
> Thanks for fixing this.
> Maybe it would be better to use the devm_ variant for the name instead ?

Ok, I'll send a v2 with this change.

Thanks for your review.
>
>> ---
>>   sound/soc/meson/axg-card.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
>> index 89f7f64747cd..6eac22ba8b99 100644
>> --- a/sound/soc/meson/axg-card.c
>> +++ b/sound/soc/meson/axg-card.c
>> @@ -121,8 +121,10 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
>>   		return -ENOMEM;
>>
>>   	dlc = devm_kzalloc(card->dev, 2 * sizeof(*dlc), GFP_KERNEL);
>> -	if (!dlc)
>> +	if (!dlc) {
>> +		kfree(lb->name);
>>   		return -ENOMEM;
>> +	}
>>
>>   	lb->cpus = &dlc[0];
>>   	lb->codecs = &dlc[1];
>
> .
>
