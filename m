Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50E2C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18CF20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgBZIgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:36:10 -0500
Received: from mail.loongson.cn ([114.242.206.163]:60150 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbgBZIgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:36:10 -0500
Received: from [10.130.0.70] (unknown [123.138.236.242])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf2jkLVZeS+QTAA--.18S3;
        Wed, 26 Feb 2020 16:35:57 +0800 (CST)
Subject: Re: [PATCH 1/2] USB: core: Fix build warning in
 usb_get_configuration()
To:     Johan Hovold <johan@kernel.org>
References: <1582697723-7274-1-git-send-email-yangtiezhu@loongson.cn>
 <20200226080459.GU32540@localhost>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d9637b5a-6d5e-17a1-e615-f828d311f654@loongson.cn>
Date:   Wed, 26 Feb 2020 16:35:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200226080459.GU32540@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxf2jkLVZeS+QTAA--.18S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1kJFy3Kr1kJF18tw17GFg_yoW8Xr1Dpr
        47tayUAFWUJF43Gay7Ga9Yga1Sgws7AFW8GryfX345Xr17Aa4DCFykKry5Zrn7WrZ7JF4I
        qFySgF1j9rZrG3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ
        7UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/2020 04:04 PM, Johan Hovold wrote:
> On Wed, Feb 26, 2020 at 02:15:22PM +0800, Tiezhu Yang wrote:
>> There is no functional issue, just fix the following build warning:
>>
>>    CC      drivers/usb/core/config.o
>> drivers/usb/core/config.c: In function ‘usb_get_configuration’:
>> drivers/usb/core/config.c:868:6: warning: ‘result’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>>    int result;
>>        ^
> What compiler are you using? The warning is clearly bogus and it hasn't
> been seen with any recent gcc at least.

[yangtiezhu@linux ~]$ gcc --version
gcc (GCC) 4.9.4 20160726 (Red Hat 4.9.4-14)
Copyright (C) 2015 Free Software Foundation, Inc.

The gcc version I used maybe too old,
if the warning is bogus, please ignore this patch.

Thanks,

Tiezhu Yang

>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   drivers/usb/core/config.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
>> index b7918f6..bb63ee0 100644
>> --- a/drivers/usb/core/config.c
>> +++ b/drivers/usb/core/config.c
>> @@ -865,7 +865,7 @@ int usb_get_configuration(struct usb_device *dev)
>>   	unsigned int cfgno, length;
>>   	unsigned char *bigbuffer;
>>   	struct usb_config_descriptor *desc;
>> -	int result;
>> +	int result = 0;
>>   
>>   	if (ncfg > USB_MAXCONFIG) {
>>   		dev_warn(ddev, "too many configurations: %d, "
> Johan

