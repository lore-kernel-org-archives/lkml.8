Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4B4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FFBA206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="H1CM5bvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgEOMCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:02:11 -0400
Received: from mail1.perex.cz ([77.48.224.245]:45048 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgEOMCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:02:11 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 17599A004B;
        Fri, 15 May 2020 14:02:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 17599A004B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1589544129; bh=BSPQw7ZsQTM9qcuNnNNGa3TUk61bcBxmr+5Zb7SXb3k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=H1CM5bvnktpNfAz3IAga9bNh/b2OcwZBtSlsVek+Ha8mJPsdnpDNGE801xj1Pdu+g
         IIFKpDBjbeD8swsnCxKfR7+K++XN9kzm18xEUl/OtM9U4rM03tPINQBhjvFPCNHzwO
         17LkqcYiTTVRKQWLO+74MYTVT/6QMdTSUP5JXt0U=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Fri, 15 May 2020 14:01:57 +0200 (CEST)
Subject: Re: [PATCH] ALSA: pcm: fix incorrect hw_base increase
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Lu, Brent" <brent.lu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulhsia <paulhsia@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1589515779-20987-1-git-send-email-brent.lu@intel.com>
 <20200515070446.GA1226131@kroah.com>
 <BN6PR1101MB21327687327440F1DB7CB75F97BD0@BN6PR1101MB2132.namprd11.prod.outlook.com>
 <ce215f76-89c3-3543-c6ed-bc9b81af50a0@perex.cz>
 <s5hk11dmqhn.wl-tiwai@suse.de>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <6f98358d-99f1-3b54-ae1a-5e938d383c32@perex.cz>
Date:   Fri, 15 May 2020 14:01:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <s5hk11dmqhn.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 15. 05. 20 v 12:39 Takashi Iwai napsal(a):
> On Fri, 15 May 2020 11:30:54 +0200,
> Jaroslav Kysela wrote:
>>
>> Dne 15. 05. 20 v 11:04 Lu, Brent napsal(a):
>>>>
>>>> Is this a bugfix needed for older kernels as well?  When did this issue show
>>>> up?
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> It happens when DMA stop moving data from host to DSP/DAI for a long time
>>> (> half of buffer time). I know host driver should do something about it. But if
>>> not, the HWSYNC will keep increasing the hw_base and hw_ptr and confuses
>>> user space program.
>>
>> I'm afraid, but with this code, you turn off the hw_ptr jiffies
>> code. It would be better to fix the driver in this case (return the
>> updated / estimated DMA pointer, increase DMA buffer size etc.). This
>> "lag" is unacceptable.
> 
> The problem is obviously in the driver's side and it's best to be
> addressed there.  But, I think it's still worth to apply this change.
> 
> The hw_ptr jiffies check is performed basically in two places: one is
> snd_pcm_period_elapsed() call from ISR, and another is with the
> no_period_wakeup flag.  In both cases, it calculates the diff of
> jiffies from the previous update, and corrects the hw_ptr_base if that
> exceeds the threshold.
> 
> And the bug here is that the "previous" jiffies is kept as long as the
> hwptr itself is updated.  What we need is the correction of the base
> when it really has processed the period size; i.e. hwptr got the same
> value (with no_period_wakeup) and yet the jiffies diff is big.  For
> this check, it's correct to update hw_ptr_jiffies at each call no
> matter whether hwptr moved or not; we need to evaluate from the
> previous update, after all.
> 
> But I might overlook something.  Jaroslav, could you check it again?
> The jiffies check code is your black magic :)

I tried to imagine a negative impact for this hw_ptr_jiffies update when the 
DMA position is not updated from the driver and I haven't found any so far.

Let's apply this and we'll see in future :-)

And yes, the patch description should be improved (DMA ptr is not updated / 
streaming is inactive).

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

> 
> 
> thanks,
> 
> Takashi
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
