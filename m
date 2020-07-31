Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A416BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C52208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbgGaIt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:49:26 -0400
Received: from mail.loongson.cn ([114.242.206.163]:45892 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728437AbgGaIt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:49:26 -0400
Received: from [10.130.0.69] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT9772iNfkvECAA--.45S3;
        Fri, 31 Jul 2020 16:49:00 +0800 (CST)
Subject: Re: [RFC] ALSA: hda: Add workaround to adapt to Loongson 7A1000
 controller
To:     Takashi Iwai <tiwai@suse.de>
References: <1596163314-21808-1-git-send-email-likaige@loongson.cn>
 <s5hlfj0b3jk.wl-tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Mohan Kumar <mkumard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
From:   Kaige Li <likaige@loongson.cn>
Message-ID: <15648946-3b87-69db-914c-354dce1abcac@loongson.cn>
Date:   Fri, 31 Jul 2020 16:48:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <s5hlfj0b3jk.wl-tiwai@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxT9772iNfkvECAA--.45S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW7Kr1DXw47JFW5CF4xCrg_yoW8XF1UpF
        n3CayUCF4Dtr1jkFsru3y5KayFg3yfGF45KryFvw1DAw1qk343X3WvvrWjkF9Y9wsY9r4Y
        kFy7ta4kGFW5ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
        wI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmYL9UUUUU=
X-CM-SenderInfo: 5olntxtjh6z05rqj20fqof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2020 02:29 PM, Takashi Iwai wrote:

> On Fri, 31 Jul 2020 04:41:54 +0200,
> Kaige Li wrote:
>> There's some issues that cause palyback without a sound on Loongson
>> platform (3A3000 + 7A1000) with a Realtek ALC269 codec. After lengthy
>> debugging sessions, we solved it by adding workaround.
>>
>> Signed-off-by: Kaige Li <likaige@loongson.cn>
> Thanks for the patch.  But this can't be taken as is due to the design
> problem.  Namely...
>
>> --- a/sound/hda/hdac_controller.c
>> +++ b/sound/hda/hdac_controller.c
>> @@ -9,6 +9,7 @@
>>   #include <sound/core.h>
>>   #include <sound/hdaudio.h>
>>   #include <sound/hda_register.h>
>> +#include "../pci/hda/hda_controller.h"
> ... here already suspicious, and ...
>
>>   #include "local.h"
>>   
>>   /* clear CORB read pointer properly */
>> @@ -42,6 +43,8 @@ static void azx_clear_corbrp(struct hdac_bus *bus)
>>    */
>>   void snd_hdac_bus_init_cmd_io(struct hdac_bus *bus)
>>   {
>> +	struct azx *chip = bus_to_azx(bus);
> ... here you cast the hdac_bus object to its child class.  This is
> disallowed, as it's a layer violation and would break if another child
> class like ASoC driver is used with this patch.
>
> IOW, inside the code in sound/hda/*, you must not use the contents in
> sound/pci/hda/* and include/sound/hda_codec.h.
>
> If any new workaround is needed, introduce a new flag in struct
> hdac_bus.

Thank you for your reply and suggestions. I will review it, and see how 
hdac_bus works.

Thanks,
Kaige
> thanks,
>
> Takashi

