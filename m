Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD91C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBE52075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgEGK1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:27:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:59776 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgEGK1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:27:47 -0400
IronPort-SDR: zWVZl2vueykMgb0GNpPLMkD1hrgWcX2NKhJBamFcXxTV2PwDbjU4PBntvaGyEhRcTosuFrS/Ev
 2IMnWM/OYlUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 03:27:46 -0700
IronPort-SDR: Irk2tQgnYo+gbOdg87WicPuaGadj5Kd2audklTbI4Daf6Vohc65d+JjGMoCsueL5LAGvSpkvfH
 hdOHI7pB8+8g==
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="435235371"
Received: from aslawinx-mobl1.ger.corp.intel.com (HELO [10.249.152.99]) ([10.249.152.99])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 03:27:44 -0700
Subject: Re: KASAN: use-after-free Write in snd_rawmidi_kernel_write1
To:     Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     security@kernel.org, alsa-devel@alsa-project.org,
        butt3rflyh4ck <butterflyhuangxx@gmail.com>, tiwai@suse.com,
        linux-kernel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
References: <CAFcO6XMGT42wFBxEa01Ee5Msuecm+WiXnn4rc-VWkC4vTzycPg@mail.gmail.com>
 <20200507082302.GF1024567@kroah.com> <s5h8si45ard.wl-tiwai@suse.de>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Message-ID: <ecc5f76f-2e87-f634-b98c-9fbcad177d72@linux.intel.com>
Date:   Thu, 7 May 2020 12:27:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <s5h8si45ard.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/2020 11:56 AM, Takashi Iwai wrote:
> On Thu, 07 May 2020 10:23:02 +0200,
> Greg Kroah-Hartman wrote:
>>
>> On Thu, May 07, 2020 at 04:04:25PM +0800, butt3rflyh4ck wrote:
>>> I report a bug (in linux-5.7-rc1) found by syzkaller.
>>>
>>> kernel config: https://github.com/butterflyhack/syzkaller-fuzz/blob/master/v5.7.0-rc1.config
>>> reproducer: https://github.com/butterflyhack/syzkaller-fuzz/blob/master/repro.cprog
>>>
>>> I test the reproducer in linux-5.7-rc4 and crash too.
>>
>> Great, care to create a fix for this and send it to the proper
>> maintainers?  That's the best way to get it fixed, otherwise it just
>> goes in the file with the rest of the syzbot reports we are burried
>> under.
> 
> Don't worry, I already prepared a fix patch below :)
> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: rawmidi: Fix racy buffer resize under concurrent
>   accesses
> 
> The rawmidi core allows user to resize the runtime buffer via ioctl,
> and this may lead to UAF when performed during concurrent reads or
> writes.
> 
> This patch fixes the race by introducing a reference counter for the
> runtime buffer access and returns -EBUSY error when the resize is
> performed concurrently.
> 
> Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/r/CAFcO6XMWpUVK_yzzCpp8_XP7+=oUpQvuBeCbMffEDkpe8jWrfg@mail.gmail.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   include/sound/rawmidi.h |  1 +
>   sound/core/rawmidi.c    | 29 ++++++++++++++++++++++++++++-
>   2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
> index a36b7227a15a..334842daa904 100644
> --- a/include/sound/rawmidi.h

(...)

> @@ -1021,6 +1039,7 @@ static long snd_rawmidi_kernel_read1(struct snd_rawmidi_substream *substream,
>   	unsigned long appl_ptr;
>   
>   	spin_lock_irqsave(&runtime->lock, flags);
> +	snd_rawmidi_buffer_ref(runtime);
>   	while (count > 0 && runtime->avail) {
>   		count1 = runtime->buffer_size - runtime->appl_ptr;
>   		if (count1 > count)
> @@ -1040,13 +1059,17 @@ static long snd_rawmidi_kernel_read1(struct snd_rawmidi_substream *substream,
>   			spin_unlock_irqrestore(&runtime->lock, flags);
First unlock
>   			if (copy_to_user(userbuf + result,
>   					 runtime->buffer + appl_ptr, count1)) {
> -				return result > 0 ? result : -EFAULT;
> +				if (!result)
> +					result = -EFAULT;
> +				goto out;

goto -> Second unlock
>   			}
>   			spin_lock_irqsave(&runtime->lock, flags);
>   		}
>   		result += count1;
>   		count -= count1;
>   	}
> + out:
> +	snd_rawmidi_buffer_unref(runtime);
>   	spin_unlock_irqrestore(&runtime->lock, flags);
Second unlock
>   	return result;
>   }

So if I follow this correctly, you call spin_unlock_irqrestore twice in 
case of error?
