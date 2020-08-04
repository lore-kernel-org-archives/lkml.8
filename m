Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31504C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43DF12073E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgHDBjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:39:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45762 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728867AbgHDBjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 21:39:48 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9962D526A60D04327E95;
        Tue,  4 Aug 2020 09:39:46 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.108) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 4 Aug 2020
 09:39:41 +0800
Subject: Re: [PATCH -next] media: staging: tegra-vde: Mark
 tegra_vde_runtime_suspend as __maybe_unused
To:     Dmitry Osipenko <digetx@gmail.com>, <mchehab@kernel.org>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <hverkuil-cisco@xs4all.nl>
References: <20200803115901.44068-1-yuehaibing@huawei.com>
 <721b8d01-5d7e-09c6-5f86-705130ab31a9@gmail.com>
 <e15a688e-934b-82a8-34c5-aac07928fd8f@huawei.com>
 <95162bdc-2658-30a7-6ed2-63e095244139@gmail.com>
CC:     <linux-media@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <f30f49f4-f249-d0de-fcfd-1fc52631a1f5@huawei.com>
Date:   Tue, 4 Aug 2020 09:39:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <95162bdc-2658-30a7-6ed2-63e095244139@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/3 22:11, Dmitry Osipenko wrote:
> 03.08.2020 16:00, Yuehaibing пишет:
>> On 2020/8/3 20:51, Dmitry Osipenko wrote:
>>> 03.08.2020 14:59, YueHaibing пишет:
>>>> If CONFIG_PM is not set, gcc warns:
>>>>
>>>> drivers/staging/media/tegra-vde/vde.c:916:12:
>>>>  warning: 'tegra_vde_runtime_suspend' defined but not used [-Wunused-function]
>>>>
>>>> Make it __maybe_unused to fix this.
>>>>
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>> ---
>>>>  drivers/staging/media/tegra-vde/vde.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/staging/media/tegra-vde/vde.c b/drivers/staging/media/tegra-vde/vde.c
>>>> index a3c24d96d5b9..2d043d518eef 100644
>>>> --- a/drivers/staging/media/tegra-vde/vde.c
>>>> +++ b/drivers/staging/media/tegra-vde/vde.c
>>>> @@ -913,7 +913,7 @@ static irqreturn_t tegra_vde_isr(int irq, void *data)
>>>>  	return IRQ_HANDLED;
>>>>  }
>>>>  
>>>> -static int tegra_vde_runtime_suspend(struct device *dev)
>>>> +static __maybe_unused int tegra_vde_runtime_suspend(struct device *dev)
>>>>  {
>>>>  	struct tegra_vde *vde = dev_get_drvdata(dev);
>>>>  	int err;
>>>>
>>>
>>> Hello Yue,
>>>
>>> Shouldn't the tegra_vde_runtime_resume() be marked as well?
>>
>> No, tegra_vde_runtime_resume() always be called by tegra_vde_shutdown().
> 
> Well.. it's unused, but compiler doesn't complain about runtime_resume()
> because it sees the potential reference to that function in the code
> (even that it's a dead code), while runtime_suspend() reference is
> completely removed by preprocessor before compiler sees the code.
> 

I see, thanks, will send v2.

> Should be nicer to have both suspend and resume functions marked, for
> consistency, IMO.
> 
> .
> 

