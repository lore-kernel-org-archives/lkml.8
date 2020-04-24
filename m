Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C249CC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764BA2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bzXgut1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgDXPwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgDXPwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:52:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E0EC09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:52:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r26so11390553wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rtV64CdoXvodJnTwhQjpfJxxVe45YkDM4hkifaxGTP4=;
        b=bzXgut1D3RMLHq+6TOlFXEGKdoDJSQqqm0o8pV8jytLUrH58+0aLEm94VnDZ7AkrUk
         xNDfM0s8GOdUZw/OiJd+QDrUdBKATW8a1cdNYICSDa27AkURhZBYfJkGBYD2Xt4HIIcR
         e0V8tiumDDlPrTTe6Sz7iNk3kHEFW86jligXyvzUBSMc5/kdMKtoyCz4uA3IPASpNBBl
         jSuh4dsVYyUcdX92swDnfzTzkZ/QCt+sfkR3dBD/tvueKKon+0jVM0vSyMN+EBLKVvxF
         NFHcN2o45xlcYBTCwy6HyUD6CI1b8Jc6Umj/aeRzqjr3tx0ZX6qgpLI0sBHAQwMihfD4
         QyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rtV64CdoXvodJnTwhQjpfJxxVe45YkDM4hkifaxGTP4=;
        b=T2PI+bcMTVsidl4BtvxLqqvmJN+lsgJUBoQh/lXN38MA9/SdHMmKyEZ1uiGLkAlsXh
         wGMus873dB4FB5g/LhtlBKDQ/TxywTlTwFtNTRifESJS2IVH4iGjnh3nN5OFZMO9Iy3x
         ayrpA18Wq0hOsAtaC0gujyJSMBJMPCR/yiHlMFU01SQ02R+vyh8q4MyYqi6RG3EJm8Xi
         N0Zpoz7+teGgkHOfakEaTdu/dSs6VwauKsnd17ifgqe2VRy4r0JNKPEJYLdJVHHbByCq
         Q3+Z08eVQqJj4a6KD8OPBM0CDAewTS4u0PUB87Pxhs3Pw9m5feSSi9mABI7RXO37UU3I
         luzQ==
X-Gm-Message-State: AGi0PuYuHVXqZXjn9F5zUydeikYrN4TuDiOwZymFXfvwrLI8lNoCw0Mx
        vARVtcOu4LaE+R619LWP+H7W5w==
X-Google-Smtp-Source: APiQypLHoMtXgNvUu4rSXl4sbf4gXGV+tWNxmLDcuR0fz6lAjF9ERRKa1+QHe3UHlNpGkUzFVpTL3w==
X-Received: by 2002:a1c:e408:: with SMTP id b8mr11014823wmh.68.1587743553991;
        Fri, 24 Apr 2020 08:52:33 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id q143sm3661290wme.31.2020.04.24.08.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:52:33 -0700 (PDT)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200424092816.62a61b1d@gandalf.local.home>
 <579fbe97-9aae-2b67-03ff-01291b9cbb7d@i-love.sakura.ne.jp>
 <20200424103131.7987f890@gandalf.local.home>
 <7ec0b0a3-39ae-0f1c-b8c2-e1e9e60f1223@i-love.sakura.ne.jp>
 <20200424114225.5a3bab7e@gandalf.local.home>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <b3129b4a-cd08-c507-4c6a-8b3e24b130d0@arista.com>
Date:   Fri, 24 Apr 2020 16:52:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424114225.5a3bab7e@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/20 4:42 PM, Steven Rostedt wrote:
> On Sat, 25 Apr 2020 00:28:53 +0900
> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> For those who analyze log files (instead of console output), the point of
>> printk() is to save kernel messages into log files (via userspace syslog
>> daemon).
>>
>> By the way, I think
>>
>>   printk(KERN_NO_CONSOLES "hello\n")
>>
>> is almost same with doing
>>
>>   saved_loglevel = console_loglevel;
>>   console_loglevel = CONSOLE_LOGLEVEL_SILENT;
>>   printk("hello\n");
>>   console_loglevel = saved_loglevel;
>>
>> used by vkdb_printf().
> 
> And both shouldn't be done within the kernel. The "CONSOLE_LOGLEVEL_SILENT"
> if for user decided policy, not the kernel making that policy for the user.

Though, I believe the reverse KERN_UNSUPPRESSED [1] still makes sense
for sysrq/kdb where user expects their interactive messages to appear on
console. And unfortunately, userspace depends on the loglevel of those
messages as it is.
With KERN_UNSUPPRESSED I hope to remove all those console_loglevel
tricks and make it static variable for printk.

[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/

Thanks,
          Dmitry
