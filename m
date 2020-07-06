Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC585C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2DC32074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgGFJB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:01:29 -0400
Received: from mail.loongson.cn ([114.242.206.163]:49064 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728616AbgGFJB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:01:29 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx72pY6AJf6pZQAA--.1917S3;
        Mon, 06 Jul 2020 17:01:13 +0800 (CST)
Subject: Re: [PATCH] serial: Remove duplicated macro definition of port type
To:     Jiri Slaby <jslaby@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1588853015-28392-1-git-send-email-yangtiezhu@loongson.cn>
 <74173351-9d43-07fc-30c4-3c5aab72dcd0@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <faa2c3bd-c816-7285-b5c7-92b2c379e22f@loongson.cn>
Date:   Mon, 6 Jul 2020 17:01:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <74173351-9d43-07fc-30c4-3c5aab72dcd0@suse.cz>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx72pY6AJf6pZQAA--.1917S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyrKFy3ury8ZFWUKr1kAFb_yoW8GF15pr
        nIyFWrtr47GFZrCw4IgwsxXr12q3y5Kr1UWw1xWr4kJ3WYyw1furs09r45tryIqrZ5JryF
        qr1DZa90gryDur7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2
        z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUrR6wUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2020 02:40 PM, Jiri Slaby wrote:
> On 07. 05. 20, 14:03, Tiezhu Yang wrote:
>> There exists the same macro definition of port type from 0 to 13
>> in include/uapi/linux/serial.h, remove these duplicated code in
>> include/uapi/linux/serial_core.h which includes the former header.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Acked-by: Jiri Slaby <jslaby@suse.cz>

Hi,

Could you please apply this patch?

Thanks,
Tiezhu

>
>> ---
>>   include/uapi/linux/serial_core.h | 14 --------------
>>   1 file changed, 14 deletions(-)
>>
>> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
>> index 8ec3dd7..851b982 100644
>> --- a/include/uapi/linux/serial_core.h
>> +++ b/include/uapi/linux/serial_core.h
>> @@ -26,20 +26,6 @@
>>   /*
>>    * The type definitions.  These are from Ted Ts'o's serial.h
>>    */
>> -#define PORT_UNKNOWN	0
>> -#define PORT_8250	1
>> -#define PORT_16450	2
>> -#define PORT_16550	3
>> -#define PORT_16550A	4
>> -#define PORT_CIRRUS	5
>> -#define PORT_16650	6
>> -#define PORT_16650V2	7
>> -#define PORT_16750	8
>> -#define PORT_STARTECH	9
>> -#define PORT_16C950	10
>> -#define PORT_16654	11
>> -#define PORT_16850	12
>> -#define PORT_RSA	13
>>   #define PORT_NS16550A	14
>>   #define PORT_XSCALE	15
>>   #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
>>
> thanks,

