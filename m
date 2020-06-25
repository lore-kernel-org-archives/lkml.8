Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E818EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2FDA20775
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WjxhY8Yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406417AbgFYQmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404106AbgFYQmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:42:36 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1CDC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:42:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q90so2778995pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GrviZJ6eU6hS5ncWY3d15qiqcFrbFlQQ8yXs+/Zv0y4=;
        b=WjxhY8YdNnls8JN3WEluiSqlPjm6WVExOknCjW4VAt8q7CSZK4OygjWwYGjVfMPRGL
         0SZ2sXX48hzp6vXEnaaQFan+b8CVCUq/kYJ+XIQHe4S7iMA1BC2FVkn/ZlIRG0knzI50
         aMjfmlCG2dAKcnX9MxG3V4izN9aGmmciB2QyMHNEjTgWO4juqA516XjClx/XFhB05NYp
         WUNqS5lGuLV81EnvGsBGqEhskS+vvhNtBwFFKXkggzHTIDmmdAbLpVotiiWaPMlSidai
         jqdCFDvWXW8zInSVyRNAgg5B3/WjfdNupWezxLveQAAHN2rtoV5GlElXzf361GfIi2GG
         hueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GrviZJ6eU6hS5ncWY3d15qiqcFrbFlQQ8yXs+/Zv0y4=;
        b=InnncqwyMt43i0cpdPWaqAd0SeTUBR0q0IezxTSUyH4iaQ5W2pMbtpn/n7z9H0G7R2
         BqJhTygjrcZJ9exUlHoTzYEEuVqISD46Q2ibV9s0nCh7qUSMqL8QO53DE0XLz06NMIHl
         iEAiaz/i2RClpXPKiLsH/Za+SoyPEjHYujtS6jgHRO3Qetm/9Y/mRjK7qHS8Vb6ZNi+n
         HXf9lhLtnS66/eUke3p3Ph6n75radPBY2YBCsTnpDRptdJAk8V8r3D3h9KEtQh01QQ3V
         v3I8SgxsVe0wCGFj67cHgsd+YVgT3ax7mSnKECz24+RgqE4yPJHUM8Hgnpek4xe5AEeE
         5yOg==
X-Gm-Message-State: AOAM531nnBo7UziVbrUAgMI5Bso3iwgaovquQNrpRgx8suDE9C1mvLCI
        aJyv8Lt8imsJHXMsx30Mp4R9Vg==
X-Google-Smtp-Source: ABdhPJwxqNWTmS/l0zuf3b5jbO07r45hOv0N1z77mn5pLlslP6IvIQF5kgexEoT+CE8WMxg++pkfog==
X-Received: by 2002:a17:90a:2c48:: with SMTP id p8mr4275164pjm.189.1593103356318;
        Thu, 25 Jun 2020 09:42:36 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id a83sm23448474pfa.146.2020.06.25.09.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 09:42:35 -0700 (PDT)
Subject: Re: [PATCH 2/3] x86/dumpstack: Add log_lvl to __show_regs()
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20200623162958.331051-1-dima@arista.com>
 <20200623162958.331051-3-dima@arista.com>
 <CAG48ez3v9dHq1+jvPmvQapFRji=4XhA8iNurTGZeC6xoy7Qc1w@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <a0e7b79b-2ce7-f349-b308-e5329defd3fe@arista.com>
Date:   Thu, 25 Jun 2020 17:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3v9dHq1+jvPmvQapFRji=4XhA8iNurTGZeC6xoy7Qc1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/20 5:45 PM, Jann Horn wrote:
> On Tue, Jun 23, 2020 at 6:30 PM Dmitry Safonov <dima@arista.com> wrote:
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
>> higher log level).
>>
>> Add log_lvl parameter to __show_regs().
>> Keep the used log level intact to separate visible change.
> 
> This change seems like a good idea to me; just one small nit:
> 
> [...]
>>  void show_regs(struct pt_regs *regs)
>>  {
>> +       int print_kernel_regs;
>> +
>>         show_regs_print_info(KERN_DEFAULT);
>>
>> -       __show_regs(regs, user_mode(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL);
>> +       print_kernel_regs = user_mode(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL;
>> +       __show_regs(regs, print_kernel_regs, KERN_DEFAULT);
> 
> print_kernel_regs should probably have type "enum show_regs_mode"? 

Makes sense, will fix in v2.

Thanks,
          Dmitry
