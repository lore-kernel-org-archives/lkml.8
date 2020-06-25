Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9B7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA652076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="if8UG9iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406449AbgFYQla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404503AbgFYQla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:41:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39658C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:41:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p11so3252491pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/9wqHgin8SZEC1IRcBJkZ+xGaXaJroFt05E1wtYvRGA=;
        b=if8UG9iwCTP3nZiA0F2VMdcBRZeuwQVvgVXAaEKWDJPfVo6fJfEAkRx/WNXyNsrgYZ
         iIgwIRl3d4sWKo8SwvkN6NBStYjR5PbRqfPn9uZgeW4o8DcGhYU2m21in0ezypaiK8Ch
         09C4KOqACDxogdhRT8coaptP0PFQm4y6ZH86ALYTEjGMnfV5A+J9lCdqTTsNjI0EYqLf
         5JeoyxcNpNuXNvI44gLIgUDnsAt0YnIlDgRVM4C0e4wSghb6lCfgHjq9VMpJgtCfMBfq
         ERQ9XT900CvHXwYSHTZk0SWzt5OdOJ8ulgHaqYzwQBcyyLAcfh9jZlSe0Aa+2/4geBMO
         qkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/9wqHgin8SZEC1IRcBJkZ+xGaXaJroFt05E1wtYvRGA=;
        b=hRIujiDkPw8XNRgRate+Rv9E/BNwVS9Oq7DMImgyDcpbNj7AAiUeAhkkcZMVwci0Sk
         PFg65O4L7lBIUwKSW6JRrG/DuLaYEXR61x8+8kKppTuSreeSJn+BBpLWACU8tgeNTbun
         rLW+y4mhQiiua6gWjXrvadS8swhtbZQKjKf8zy28CyJvErmyLeh8I7LLtrCm4cKHpSm5
         FPUeEGdf9Z1BPUQGmnC3/A321HevFM0SKny+AHQEL0cKTW0/qIJjZUNllMGIjyStXVqe
         BtKdtqhprVFZkBuBU0gmX6+EMlDYTyxTpigLtGTG2EMY1pX7nilHaG+Z4qVW5SHcUGMY
         1zQg==
X-Gm-Message-State: AOAM531WGMXnmmFKxzISTk/L9cBFye1OdQqmoKxeT31QXXxjkz/pqJRJ
        ErouqbFBm4q8O2irlBB6geX5Bw==
X-Google-Smtp-Source: ABdhPJz0CYUzgtNmucllQ92WqtC92lexQ9rD2FSkyOUGnrzheLOuA1Jm+Vgyd/P+1S14azMq8mQt/w==
X-Received: by 2002:aa7:8389:: with SMTP id u9mr8053510pfm.269.1593103289412;
        Thu, 25 Jun 2020 09:41:29 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id q39sm9012496pja.30.2020.06.25.09.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 09:41:28 -0700 (PDT)
Subject: Re: [PATCH 0/3] x86/dumpstack: Print registers with the same log
 level as the backtrace
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
References: <20200623162958.331051-1-dima@arista.com>
 <20200624065054.GC8444@alley>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <86995860-74e7-31fb-5f94-f5b87d6aba07@arista.com>
Date:   Thu, 25 Jun 2020 17:41:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624065054.GC8444@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/20 7:50 AM, Petr Mladek wrote:
> On Tue 2020-06-23 17:29:55, Dmitry Safonov wrote:
>> show_trace_log_lvl() provides x86 platform-specific way to unwind
>> backtrace with a given log level. Unfortunately, registers dump(s) are
>> not printed with the same log level - instead, KERN_DEFAULT is always
>> used.
>>
>> Arista's switches uses quite common setup with rsyslog, where only
>> urgent messages goes to console (console_log_level=KERN_ERR), everything
>> else goes into /var/log/ as the console baud-rate often is indecently
>> slow (9600 bps).
>>
>> Backtrace dumps without registers printed have proven to be as useful as
>> morning standups. Furthermore, in order to introduce KERN_UNSUPPRESSED
>> (which I believe is still the most elegant way to fix raciness of sysrq[1])
>> the log level should be passed down the stack to register dumping
>> functions. Besides, I have a potential use-case for printing traces
>> with KERN_DEBUG level [2] (where registers dump shouldn't appear with
>> higher log level than the backtrace).
>>
>> Dmitry Safonov (3):
>>   x86/dumpstack: Add log_lvl to show_iret_regs()
>>   x86/dumpstack: Add log_lvl to __show_regs()
>>   x86/dumpstack: Show registers dump with trace's log level
> 
> The change makes sense. It is natural next step after adding log_lvl
> parameter for printing stack traces. For the entire patchset:
> 
> Acked-by: Petr Mladek <pmladek@suse.com>

I'll address the nit by Jann and resend v2 with your Ack, thanks!

> Are there any plans to add this also for other architectures, please?

Yes, I'll look into that.

Thanks,
          Dmitry
