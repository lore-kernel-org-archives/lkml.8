Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CABC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE9D207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpUiy3Xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgAMIUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:20:37 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47019 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgAMIUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:20:36 -0500
Received: by mail-pl1-f195.google.com with SMTP id y8so3522755pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 00:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bMqucdvwW4DxJLa5hqSQSlZ+HKdfxlLmr5IwDINyABs=;
        b=fpUiy3Xg2sDv9bf5OvF1hAah/1QRfWGgnppILok/K04EQDtG9R8vzvFWp4cJJKwGLz
         NAKUewD9PkneM7K0lq/XVUrVVe2YZj3FXxwyi2gJMFc/Tu1EctP5uhoFSWDxgoxt/awA
         mtI01TvYQOh3VqyTmS7ku9hk1TVXft8kUl1Fg48XO4QTe5wThfSIPsKwX17AlW9qmKSC
         e4FKuRVBJFjWZKAvtU/pe3rGvgIarYB8fz0A/Z+k8gy9XjZO+lg0VM56D2D21k+fiq7+
         kpeBO8Hg2XKDGFX82AXVVoq58alG+dpAO45W2ZKvWvKM8jWCDWB5ujkDx1ThFoiiQjdW
         hYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bMqucdvwW4DxJLa5hqSQSlZ+HKdfxlLmr5IwDINyABs=;
        b=gtPaoftDvcGapUwBEtC6MJinLAJC5qRyGr0KxMW+UcKbdrG5zFZUlU11V4MMvd6W8u
         +9lQi8/ng0kj8uA9eraZJZoEgtI9j7st6NhUyPdI7WyabMyOIuzJjQYDPpqB7kQqP5fI
         IYHosOdb9ExArwAeITzJHwDpmp4dbBMUZ0dfmdJ8FqeOSbhwdIj3vdp1R9txSmqmD319
         EscFopNCCapID6Cfm1p43lBEJ3Pwn515QI1zSAoWLe9hYG246KJg1/mx+HPlzycze4X/
         5ztN8lRJr77w/lLK4hB0jMLelOyRAiRF0/nbo1atrrKIRJEvChvZzEZXyD2ZKSD8tTjN
         2L7A==
X-Gm-Message-State: APjAAAV9V1zHYQn3sMIROs7DMex4IqWOxeVSpOjAqUGzLkBLMvXBauVF
        aS0JtQvdCT+FzfjfmrVzhs/extEe
X-Google-Smtp-Source: APXvYqzq8v/enDDBDTkt0OxdeBhm2NzezTQsHz2JVtReupHvyt0kSjM1nkMx9CUwKaZZe9bfqalBTQ==
X-Received: by 2002:a17:902:694c:: with SMTP id k12mr12673527plt.329.1578903635888;
        Mon, 13 Jan 2020 00:20:35 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.139.115? ([2402:f000:1:1501:200:5efe:a66f:8b73])
        by smtp.gmail.com with ESMTPSA id c22sm12668511pfo.50.2020.01.13.00.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 00:20:35 -0800 (PST)
Subject: Re: [PATCH] ALSA: cmipci: Fix possible a data race in
 snd_cmipci_interrupt()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, rfontana@redhat.com,
        tglx@linutronix.de, allison@lohutok.net,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200111163027.27135-1-baijiaju1990@gmail.com>
 <s5h5zhhkrwe.wl-tiwai@suse.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <de859611-4bd0-647f-61e9-7138425ed736@gmail.com>
Date:   Mon, 13 Jan 2020 16:20:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <s5h5zhhkrwe.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/12 16:20, Takashi Iwai wrote:
> On Sat, 11 Jan 2020 17:30:27 +0100,
> Jia-Ju Bai wrote:
>> The functions snd_cmipci_interrupt() and snd_cmipci_capture_trigger()
>> may be concurrently executed.
>>
>> The function snd_cmipci_capture_trigger() calls
>> snd_cmipci_pcm_trigger(). In snd_cmipci_pcm_trigger(), the variable
>> rec->running is written with holding a spinlock cm->reg_lock. But in
>> snd_cmipci_interrupt(), the identical variable cm->channel[0].running
>> or cm->channel[1].running is read without holding this spinlock. Thus,
>> a possible data race may occur.
>>
>> To fix this data race, in snd_cmipci_interrupt(), the variables
>> cm->channel[0].running and cm->channel[1].running are read with holding
>> the spinlock cm->reg_lock.
>>
>> This data race is found by the runtime testing of our tool DILP-2.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> Thanks for the patch.
>
> That's indeed a kind of race, but this change won't fix anything in
> practice, though.  The inconsistent running flag between those places,
> there are two cases:
>
> - running became 0 to 1; this cannot happen, as the irq isn't issued
>    before the stream gets started
>
> - running became 1 to 0; this means that the stream gets stopped
>    between two points, and it's not better to call
>    snd_pcm_period_elapsed() for an already stopped stream.

Thanks for the reply :)

I am not sure to understand your words.

Do you mean that this code should be also protected by the spinlock?
     if (cm->pcm) {
         if ((status & CM_CHINT0) && cm->channel[0].running)
             snd_pcm_period_elapsed(cm->channel[0].substream);
         if ((status & CM_CHINT1) && cm->channel[1].running)
             snd_pcm_period_elapsed(cm->channel[1].substream);
     }


Best wishes,
Jia-Ju Bai
