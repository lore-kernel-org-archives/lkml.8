Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2E8C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F008A20575
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1vGKU1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgCKVjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:39:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44056 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgCKVjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:39:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id b72so2068790pfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sl9GHfGzf2QUy7300Q4gk5ANpc5xeOTQ3Fi2iLEwhOM=;
        b=K1vGKU1h40BdqAJl+l/0czEuRMXtzjDnKFDheUDvuIg8SkRL2CINYNhyINU6gRhbKf
         RinREekTolIUkKQQxQn/FBiUeIfzpwsKoaaNm6d7kR8Uf6qDyAo9MPq/wqqIafbFOxB9
         wC5+NIxWmAVj3/wF41Zg1NEZATJJpNi7yHDzqBDB87P0oV+oQ2YQwt1C4JendaQwzR5i
         65QpnxavktUa6HwbRMPKWjKpwuRm8WBB2pQUE7KWFW6zvOI+pMPD9Oom/B2Nu5veu0g6
         MYFm0qAuc3hQz4wUpGu092wsYRSddX2uckMELWe4Z4Ck5gI/2/69zTFd8m1sB9YPY9Zv
         OhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Sl9GHfGzf2QUy7300Q4gk5ANpc5xeOTQ3Fi2iLEwhOM=;
        b=tp120RlM6KfD1UHthRMQB6O1Ijv7hcGcvAzwFXzFYnuB1K+sQzrVyDNjh0t8snB9F9
         N+c4dGYysF8ZwKpUq9U1rr0M/3drymImxA2YhL9k+aRrtqIogM6+LcVdDo9To0oBMCiG
         u2pI1YZ4/gNBkPU2vOvzXCsCwVAo5y1KQ91B5lzqflcc4zqU4g5Jr2g4S47kcA2iBwId
         VVcFtUM5qOPsqkaZDzFBm/rz5XSCQcD6CBK/8NQHIuNocAp0XXN8473Cesu/QF7U+ZQV
         EHKubWp3brK7ceMOLNFWNrwraJ4g2qfHC8bcMsm3jfpysY5chC8W16amkZ+CHThHeOq9
         ATHw==
X-Gm-Message-State: ANhLgQ0ff2VhTtzEMh8KeHaELiNuTgzbSK2m3jmfc86wAJNyOqbnOpYG
        Zi0wDxEXOGOavwtcwTDooeA=
X-Google-Smtp-Source: ADFU+vscnBsit6mUuBo7nPbsdiHN2YTEMd1jL4JQMB010jdhv4gjDAgt8RHb+W/MONZu+53NTeVbNg==
X-Received: by 2002:a63:36cd:: with SMTP id d196mr4708568pga.280.1583962775004;
        Wed, 11 Mar 2020 14:39:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 11sm1354425pfv.43.2020.03.11.14.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 14:39:33 -0700 (PDT)
Subject: Re: [PATCH v3] ARM: smp: add support for per-task stack canaries
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Emese Revfy <re.emese@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        kernel-hardening@lists.openwall.com
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
 <20200309164931.GA23889@roeck-us.net> <202003111020.D543B4332@keescook>
 <04a8c31a-3c43-3dcf-c9fd-82ba225a19f6@roeck-us.net>
 <202003111146.E3FC1924@keescook>
 <20200311204531.GU25745@shell.armlinux.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <2f99ffbf-d0c0-d98d-f44a-1014bdcb778b@roeck-us.net>
Date:   Wed, 11 Mar 2020 14:39:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311204531.GU25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/20 1:45 PM, Russell King - ARM Linux admin wrote:
> On Wed, Mar 11, 2020 at 11:47:20AM -0700, Kees Cook wrote:
>> On Wed, Mar 11, 2020 at 11:31:13AM -0700, Guenter Roeck wrote:
>>> On 3/11/20 10:21 AM, Kees Cook wrote:
>>>> On Mon, Mar 09, 2020 at 09:49:31AM -0700, Guenter Roeck wrote:
>>>>> On Thu, Dec 06, 2018 at 09:32:57AM +0100, Ard Biesheuvel wrote:
>>>>>> On ARM, we currently only change the value of the stack canary when
>>>>>> switching tasks if the kernel was built for UP. On SMP kernels, this
>>>>>> is impossible since the stack canary value is obtained via a global
>>>>>> symbol reference, which means
>>>>>> a) all running tasks on all CPUs must use the same value
>>>>>> b) we can only modify the value when no kernel stack frames are live
>>>>>>    on any CPU, which is effectively never.
>>>>>>
>>>>>> So instead, use a GCC plugin to add a RTL pass that replaces each
>>>>>> reference to the address of the __stack_chk_guard symbol with an
>>>>>> expression that produces the address of the 'stack_canary' field
>>>>>> that is added to struct thread_info. This way, each task will use
>>>>>> its own randomized value.
>>>>>>
>>>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>>>> Cc: Kees Cook <keescook@chromium.org>
>>>>>> Cc: Emese Revfy <re.emese@gmail.com>
>>>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>>>> Cc: Laura Abbott <labbott@redhat.com>
>>>>>> Cc: kernel-hardening@lists.openwall.com
>>>>>> Acked-by: Nicolas Pitre <nico@linaro.org>
>>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>>
>>>>> Since this patch is in the tree, cc-option no longer works on
>>>>> the arm architecture if CONFIG_STACKPROTECTOR_PER_TASK is enabled.
>>>>>
>>>>> Any idea how to fix that ? 
>>>>
>>>> I thought Arnd sent a patch to fix it and it got picked up?
>>>>
>>>
>>> Yes, but the fix is not upstream (it is only in -next), and I missed it.
>>
>> Ah, yes, I found it again now too; it went through rmk's tree.
>>
>> For thread posterity:
>>
>> ARM: 8961/2: Fix Kbuild issue caused by per-task stack protector GCC plugin
>> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8961/2
> 
> It's in my fixes branch, waiting for me to do my (now usual) push
> of fixes to Linus.
> 
> I'm not sure whether the above discussion is suggesting that there's
> a problem with this patch, or whether it's trying to encourage me
> to send it up to Linus.  I _think_ there's the suggestion that it
> causes a regression, hmm?
> ARM: 8961/2: Fix Kbuild issue caused by per-task stack protector GCC plugin

Commit 189af4657186da08 ("ARM: smp: add support for per-task stack canaries")
caused a regression. "ARM: 8961/2: Fix Kbuild issue caused by per-task stack
protector GCC plugin" fixes it.

Guenter
