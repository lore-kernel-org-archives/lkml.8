Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3B5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F30D20679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="asSTQpz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgEVUws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbgEVUwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:52:47 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFD0C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:52:47 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h10so12783460iob.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C0w98WNrq8RwJa7xUXc0zE5qi1XnFGyGA8zuRJzv1+A=;
        b=asSTQpz2RYbFcEsqJeFmmqKAhKE45IdJQkGhkHa4Fs6PX0Zt/OZ3+1UTl1AKx1cn8p
         bnLiEr97rwt5v4QnmemdE8NnRFnA62tER5n6TPE3gr1/TNcVyY84HZ0mnCyVvSG8MCxW
         uc7nKZLpkIyl8gjLYSdfkTevCkq7GTChKnVo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C0w98WNrq8RwJa7xUXc0zE5qi1XnFGyGA8zuRJzv1+A=;
        b=QwLJyld/FPrLQA4n5aAMx6sT7z8xoAXHGLf0aG7P9oQfZ7Wnn7bT+z2pq54K6EEtpT
         Ns5Jl9mJ6icQh3JYy/vH/bjGios4wdJ9PDoUX2TBFzCT1KcBaKAMw8yWyaovLSRilomm
         Rn+h+9lhXzzEy5GSfOdBKIiKzAMH8K5ewHpcuudCbEloNH6171JneoSC29JCwlpb2ODn
         yVMBZYCOF8dJZr9FLwt8ZY3Qo7GbbZ/0p+X09C3PlsNIhJGRnR+JTDj2BKnWQ4gnncFe
         xXdp8LCBn/0qo8q0bEyZDf3Cbu3XnboZ1bgGhwqWs0puzsiV/AfLbAekROcxeiyCEvmG
         3w9Q==
X-Gm-Message-State: AOAM531owY7BKOLGRyBa/vq7qDas7FHGc4Rwh76BCTIly3BJIcd4FF37
        2l10JFT4MQrdHZo+41d5QS/g4A==
X-Google-Smtp-Source: ABdhPJyrnf0qpFDgudB7Bi8na8AGrAjNMadhWgyDInXqAZ+9mGwu0LNs00x6csbFEY4ROgDxIjwocA==
X-Received: by 2002:a02:4446:: with SMTP id o67mr9770308jaa.25.1590180767044;
        Fri, 22 May 2020 13:52:47 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id 199sm2519230ilb.11.2020.05.22.13.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 13:52:46 -0700 (PDT)
Subject: Re: [PATCH v2 10/15] soc: qcom: ipa: use new
 module_firmware_crashed()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jeyu@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        rostedt@goodmis.org, mingo@redhat.com, aquini@redhat.com,
        cai@lca.pw, dyoung@redhat.com, bhe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, gpiccoli@canonical.com,
        pmladek@suse.com, tiwai@suse.de, schlad@suse.de,
        andriy.shevchenko@linux.intel.com, keescook@chromium.org,
        daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>
References: <20200515212846.1347-1-mcgrof@kernel.org>
 <20200515212846.1347-11-mcgrof@kernel.org>
 <0b159c53-57a6-b771-04ab-2a76c45d0ef4@ieee.org>
 <20200522052834.GA11244@42.do-not-panic.com>
From:   Alex Elder <elder@ieee.org>
Message-ID: <c23b7a5c-5534-b3e5-afa7-f71e097878de@ieee.org>
Date:   Fri, 22 May 2020 15:52:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522052834.GA11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/20 12:28 AM, Luis Chamberlain wrote:
> On Tue, May 19, 2020 at 05:34:13PM -0500, Alex Elder wrote:
>> On 5/15/20 4:28 PM, Luis Chamberlain wrote:
>>> This makes use of the new module_firmware_crashed() to help
>>> annotate when firmware for device drivers crash. When firmware
>>> crashes devices can sometimes become unresponsive, and recovery
>>> sometimes requires a driver unload / reload and in the worst cases
>>> a reboot.
>>>
>>> Using a taint flag allows us to annotate when this happens clearly.
>>
>> I don't fully understand what this is meant to do, so I can't
>> fully assess whether it's the right thing to do.
> 
> It is meant to taint the kernel to ensure it is clear that something
> critically bad has happened with the device firmware, it crashed, and
> recovery may or may not happen, we are not 100% certain.
>>
>> But in this particular place in the IPA code, the *modem* has
>> crashed.  And the IPA driver is not responsible for modem
>> firmware, remoteproc is.
> 
> Oi vei. So the device it depends on has crashed.

Yes, more or less.  It could be considered a little more
nuanced than even that, but I won't get into it here.

>> The IPA driver *can* be responsible for loading some other
>> firmware, but even in that case, it only happens on initial
>> boot, and it's basically assumed to never crash.
> 
> OK is this an issue which we can recover from? If for the slightest bit
> this can affect users it is something we should inform them over.

If the IPA driver successfully loads this firmware, it should
be assumed to never crash.  So in that respect, there is no
recovery required.

Again, the modem (with which the IPA hardware and driver
interacts) can crash, or it can be shut down intentionally.
And in either case it can recover, automatically or manually.
But all of that (and the modem's firmware loading) is the
responsibility of the remoteproc subsystem, not IPA.

> This patch set is missing uevents for these issues, but I just added
> support for this.
> 
>> So regardless of whether this module_firmware_crashed() call is
>> appropriate in some places, I believe it should not be used here.
> 
> OK thanks. Can the user be affected by this crash? If so how? Can
> we recover ? Is that always guaranteed?

We can't guarantee anything about recovering from a crash of
an independent entity.  But by design, recovery from a modem
crash is possible and is supposed to leave Linux in a
consistent state.  A modem crash is likely to be observable
to the user.

I'll repeat that I don't believe the new call you inserted
in the IPA driver belongs there.

					-Alex

> 
>    Luis
> 

