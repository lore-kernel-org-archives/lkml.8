Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E03C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE51122482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HmSvWcnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgGTSv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTSv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:51:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD143C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:51:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so529376wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JuEZiy78CpRyblowJsYCudttbavKEDYhJKor5ADKG6c=;
        b=HmSvWcnbw96evB2Dh+OoZMtkL+44cYcUSwTdncz+x8WAC+fiXrabr79MbmRidh6MLT
         9JCAUUZ4YpGGgUG4XpnMl5C+2lavGoNwUIyLhJx+UgQKps+dTR/KTuD/OzfX/HI1DMam
         ff519WxDaVZV8I2MHU4gpRPh46s+SU35E4RyX+ZmgZxwCd9LruHlIGxgyBYOtOiHHo5f
         bno7kXE6d1mQwdFaG1wAKVtwuMtmbARkoc+iYK2Io7/m1Tzld8GIDOt1eBklo+/o+HLe
         4CLJCOewKJPlLXafuIXYobzo2u8+4uN4+Y8DkcdGU0rM4Qo04PCkbseLCbT2p3ALLeuW
         JUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JuEZiy78CpRyblowJsYCudttbavKEDYhJKor5ADKG6c=;
        b=eAPrCOKACoVfJ72jEfjz2M0LWJuLsZnZgr7+3Uk1Uy6/HIf9p1ZMVaByCXp2rHqTvK
         MyLngqkj1sYlx4CUjAFN3lYorGk2CqNcf5cvd6uxG8pyCYIbU5gqCQW13Qj3LzJmE7m9
         k8L4HRHsd84yylYWoNQfwhrKXcuevO52mYSRoOyGzFJPjQX7siASmVjxAixBSdkOcl1X
         1tpeAgNjBtC3sFUTjcu8LJE+k3EYD6OKqZiNVKt023et6wVM3tA+t+qrT8j6b/6fUym/
         PlaP7fz+EiAjvci7YUQvKVC/40dSkpWyheYqaNxYwq82RoPKI7XLyOo0N/DM1TWM8BhH
         N8gw==
X-Gm-Message-State: AOAM530kbEHEVF0FkztugvC+LM0srthi34i5J3VgJjQ7416QZP0tzA91
        vh1s1KUQbkD9sg9BaugHDdWYbhlmQPZDHqfY
X-Google-Smtp-Source: ABdhPJwdbhIlh8DkChk8CCAZKS7ExhYNLGnGTfit4XogqGTM7SYE7hB62lM6yqI202UtEvO0ugTOCQ==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr661101wmc.154.1595271114422;
        Mon, 20 Jul 2020 11:51:54 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id p11sm10644236wre.32.2020.07.20.11.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 11:51:53 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] x86/dumpstack: Print registers with the same log
 level as the backtrace
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jann Horn <jannh@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20200629144847.492794-1-dima@arista.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <a6a9072f-8b8c-1b86-4f01-af254d968811@arista.com>
Date:   Mon, 20 Jul 2020 19:51:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200629144847.492794-1-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Thomas,

Could you take these to x86/tip tree?
(in case they are good enough)

On 6/29/20 3:48 PM, Dmitry Safonov wrote:
> Changes since v1 [3]:
> - Use (enum show_regs_mode) instead of (int) [nit by Jann, thanks!]
> - Add acks from Petr
> 
> show_trace_log_lvl() provides x86 platform-specific way to unwind
> backtrace with a given log level. Unfortunately, registers dump(s) are
> not printed with the same log level - instead, KERN_DEFAULT is always
> used.
> 
> Arista's switches uses quite common setup with rsyslog, where only
> urgent messages goes to console (console_log_level=KERN_ERR), everything
> else goes into /var/log/ as the console baud-rate often is indecently
> slow (9600 bps).
> 
> Backtrace dumps without registers printed have proven to be as useful as
> morning standups. Furthermore, in order to introduce KERN_UNSUPPRESSED
> (which I believe is still the most elegant way to fix raciness of sysrq[1])
> the log level should be passed down the stack to register dumping
> functions. Besides, I have a potential use-case for printing traces
> with KERN_DEBUG level [2] (where registers dump shouldn't appear with
> higher log level than the backtrace).
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/
> [2]: https://lore.kernel.org/linux-doc/20190724170249.9644-1-dima@arista.com/
> [3]: https://lore.kernel.org/lkml/20200623162958.331051-1-dima@arista.com/
> Dmitry Safonov (3):
>   x86/dumpstack: Add log_lvl to show_iret_regs()
>   x86/dumpstack: Add log_lvl to __show_regs()
>   x86/dumpstack: Show registers dump with trace's log level
> 
>  arch/x86/include/asm/kdebug.h |  5 ++--
>  arch/x86/kernel/dumpstack.c   | 23 +++++++++-------
>  arch/x86/kernel/process_32.c  | 29 ++++++++++----------
>  arch/x86/kernel/process_64.c  | 51 ++++++++++++++++++-----------------
>  4 files changed, 57 insertions(+), 51 deletions(-)
> 

Thanks,
          Dmitry
