Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96263C33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 16:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FE62469A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 16:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e44DH7xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgARQib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 11:38:31 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47040 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgARQib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 11:38:31 -0500
Received: by mail-lj1-f196.google.com with SMTP id m26so29567137ljc.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 08:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Mnad9Y4HwGYjF8IJLmhlphkK0pEoM05Nxw8nOsHO/Tg=;
        b=e44DH7xca/38ohHk/5qlbfioHuIIBpjoStmDOqvVefalxjKrHggNWdfKsttz0jO40K
         z+0sntmbldFzlFgShkicBHEVJIW5Gp30fYg1Qk7rEASmpWWi22IbDvb6YxVk0FDUbFrp
         h6ZMCfHhz4y65+V2efAPxeJ8GKLoOdGEve5jGRNQqeompkM4fpCHUt+koH1SJgNztXL2
         CQsgy827zTqKINikGCdObqYgsUpSSwWsUAygUz7i2RY4W4anTx+qu8lQvWthhpEwslud
         /IbWKRWDQ/csZY+9N7n4O8E3oEt2qGqDKod6n9t6x/8U1pX6gHIbHvURMGiCmJzwN6PB
         nFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Mnad9Y4HwGYjF8IJLmhlphkK0pEoM05Nxw8nOsHO/Tg=;
        b=dmcnGKvFkAGIwR7fcwUULTZJ5vWu05aCGn2UvliUCViuzjzA5Lg0InLZnft8V9hpts
         AmCzqEHJnPk/tT4PhkVA5pSmgYuAzwdxMxLXvFIQ0Af1KC1DzzPZpsAegRjadkUcvxCU
         8jCF/dWvmTkNyWKQXt0a9N5RTzQ9OnYi1hqdJvz7QYQjc4dk5X4EWqvhCzi6kspbmxFN
         WazRjR9umE4fBZzuM9QRkU0AyR6+JdtnOvWG1i8C8Ded7AzW6ppqiWjr9qEJNF6tynYy
         5lYhZknja3gHY5EDB7C+BPz+PwPeDVzLBgzN9SzaYikgvLsKGamOu5P+TKnIkFGHOCeR
         opvg==
X-Gm-Message-State: APjAAAU5eox7eJZXIVtYmht3m0dIr5vsvEwrm8aYkgsGTh/7JPS2e+jo
        uLGp96AlLIO2BA6ulzPmhxhGosMR
X-Google-Smtp-Source: APXvYqz8Qb7wOprJhJtPJfLGL1HWAnd/h9ic6sr3R1sfH5Ss5H34zRLiKc0Lj4MtPfzfP6Rk+H1pRg==
X-Received: by 2002:a2e:3a0c:: with SMTP id h12mr8957424lja.200.1579365509032;
        Sat, 18 Jan 2020 08:38:29 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id b17sm14082243ljd.5.2020.01.18.08.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 08:38:28 -0800 (PST)
Subject: Re: [PATCH] firmware_loader: load files from the mount namespace of
 init
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <bb46ebae-4746-90d9-ec5b-fce4c9328c86@gmail.com>
 <20200117211419.GA2042215@kroah.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <c1a325f1-ad85-11ee-091a-aa179c124eaa@gmail.com>
Date:   Sat, 18 Jan 2020 18:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200117211419.GA2042215@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.1.2020 23.14, Greg Kroah-Hartman wrote:
> On Fri, Jan 17, 2020 at 08:36:13PM +0200, Topi Miettinen wrote:
>> Hi,
>>
>> I have an experimental setup where almost every possible system service
>> (even early startup ones) runs in separate namespace, using a dedicated,
>> minimal file system. In process of minimizing the contents of the file
>> systems with regards to modules and firmware files, I noticed that in my
>> system, the firmware files are loaded from three different mount namespaces,
>> those of systemd-udevd, init and systemd-networkd. The logic of the source
>> namespace is not very clear, it seems to depend on the driver, but the
>> namespace of the current process is used.
>>
>> So, this patch tries to make things a bit clearer and changes the loading of
>> firmware files only from the mount namespace of init. This may also improve
>> security, though I think that using firmware files as attack vector could be
>> too impractical anyway.
> 
> I like this, but:
> 
>> Later, it might make sense to make the mount namespace configurable, for
>> example with a new file in
>> /proc/sys/kernel/firmware_config/. That would allow a dedicated file system
>> only for firmware files and those need not be present anywhere else. This
>> configurability would make more sense if made also for kernel modules and
>> /sbin/modprobe. Modules are already loaded from init namespace
>> (usermodehelper uses kthreadd namespace) except when directly loaded by
>> systemd-udevd.
> 
> I think you answered your question of why firmware is loaded from the
> namespace of systemd-udevd at times, it happens due to a module being
> asked to be loaded which then called out and asked for firmware as part
> of its probe process.

r8169 requests firmware only when opening the device, so the firmware is 
loaded from systemd-networkd namespace.

> Now saying that the firmware load namespace is going to be tied always
> to the modprobe namespace is problematic, as we can't guarantee that
> will always happen for all bus and driver types.
> 
> So resetting this all back to the init namespace seems to make sense to
> me, and odds are it will not break anything.
> 
> But, as you are adding a new firmware feature, any chance you can write
> an additional test to the firmware self-tests so that we can verify that
> this really is working the way you are saying it does, so we can trust
> it and verify it doesn't break in the future?

OK, sent v2 of the patch with the tests. They assume a writable 
/lib/firmware, is that OK? Maybe I should change that to overmount it 
temporarily with a writable tmpfs instead.

-Topi
