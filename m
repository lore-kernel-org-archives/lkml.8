Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A17CC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2537C2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zVLHo5qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgDGUGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:06:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39432 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgDGUGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:06:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id k15so1301805pfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fukz/tfuybeiqmTM+2SV38GcrGMp3Az6WJlxhUcp1Jg=;
        b=zVLHo5qrTOfpYQNwKeA5+MIylxoUib8I0GtH/Y+Cmo++MYy64FE/v7wXZjNkQH002a
         zzUprnJvk1W0X2/SnK/xvoH7UojYXsg3WOwAES3ctkOqA/2FTGwcjiO1rLQU59bq5jOR
         hDa+ow+9amWea0ivFbDyXF7ofGg9e6tJRctBd0nCbV53fMDLKbGPb0JspwPE15KW5pGc
         2epGWoOEVA0ugWMwBForhSf6RWTnDJrZnfCgWqufmR1nvBp1atmKYlz5KZ2yVjdbjgLJ
         H67lm7vKqRz4Oo4q1MtRDG9kq+cpSSiIojY7BfFeyTUF6zAreIvfOmN0F0wCZo9Mu9cK
         YFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fukz/tfuybeiqmTM+2SV38GcrGMp3Az6WJlxhUcp1Jg=;
        b=nBv+W1YZlbp83CfQu72HSUCqIelgjc5JE+OYpoCFcHaG6iiPZv+2o0DCptqpTTVp+1
         eZ6Rjq6Lp5FIXjVAsItnp236lAS17hgek2PBUnxfKvwVD1PkvSPTDK41+FBpiOPTdBVw
         VE8ytKo/4oHvbcCOwgQGbjxPBR8t/yEjGMdRsUhog5B0zy5uhSpFfb+ip2bwERyrQTCp
         qwPoNcZwaomFz/YII5QYahZT3l4xvWO0VLbWiwpbRxOJp6ZazX+BmONnaQ9O7O9KumqN
         7mufUStvBNNLoVbt39mnaEFSyMSf4SPytC5erTSavkDpwWlNzUGfRd7ia1RpwcRHnGQI
         f/RA==
X-Gm-Message-State: AGi0Puaud6EZeY+xQWoLSH69ybgxZanboQN8GAEUWsMIplYwjv2M2uBs
        S3I6+YcT+zQvZ64Xcc8BItFSM1zw7t+jUQ==
X-Google-Smtp-Source: APiQypLHXQYs2KZJCJAwqvJ0ui6yuU+LpsEl6acBu+kqfe5a4Zhxr6gwepf3yior3ML4qF678231AQ==
X-Received: by 2002:a62:5a03:: with SMTP id o3mr4061495pfb.301.1586290012300;
        Tue, 07 Apr 2020 13:06:52 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab? ([2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab])
        by smtp.gmail.com with ESMTPSA id w63sm4433951pgb.5.2020.04.07.13.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 13:06:51 -0700 (PDT)
Subject: Re: [PATCH 1/2] eventfd: Make wake counter work for single fd instead
 of all
To:     zhe.he@windriver.com, viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
References: <1586257192-58369-1-git-send-email-zhe.he@windriver.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3f395813-a497-aa25-71cc-8aed345b9f75@kernel.dk>
Date:   Tue, 7 Apr 2020 13:06:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1586257192-58369-1-git-send-email-zhe.he@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/20 3:59 AM, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> introduces a percpu counter that tracks the percpu recursion depth and
> warn if it greater than one, to avoid potential deadlock and stack
> overflow.
> 
> However sometimes different eventfds may be used in parallel.
> Specifically, when high network load goes through kvm and vhost, working
> as below, it would trigger the following call trace.
> 
> -  100.00%
>    - 66.51%
>         ret_from_fork
>         kthread
>       - vhost_worker
>          - 33.47% handle_tx_kick
>               handle_tx
>               handle_tx_copy
>               vhost_tx_batch.isra.0
>               vhost_add_used_and_signal_n
>               eventfd_signal
>          - 33.05% handle_rx_net
>               handle_rx
>               vhost_add_used_and_signal_n
>               eventfd_signal
>    - 33.49%
>         ioctl
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         __x64_sys_ioctl
>         ksys_ioctl
>         do_vfs_ioctl
>         kvm_vcpu_ioctl
>         kvm_arch_vcpu_ioctl_run
>         vmx_handle_exit
>         handle_ept_misconfig
>         kvm_io_bus_write
>         __kvm_io_bus_write
>         eventfd_signal
> 
> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
> ---- snip ----
> 001: Call Trace:
> 001:  vhost_signal+0x15e/0x1b0 [vhost]
> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
> 001:  handle_rx+0xb9/0x900 [vhost_net]
> 001:  handle_rx_net+0x15/0x20 [vhost_net]
> 001:  vhost_worker+0xbe/0x120 [vhost]
> 001:  kthread+0x106/0x140
> 001:  ? log_used.part.0+0x20/0x20 [vhost]
> 001:  ? kthread_park+0x90/0x90
> 001:  ret_from_fork+0x35/0x40
> 001: ---[ end trace 0000000000000003 ]---
> 
> This patch moves the percpu counter into eventfd control structure and
> does the clean-ups, so that eventfd can still be protected from deadlock
> while allowing different ones to work in parallel.
> 
> As to potential stack overflow, we might want to figure out a better
> solution in the future to warn when the stack is about to overflow so it
> can be better utilized, rather than break the working flow when just the
> second one comes.

This doesn't work for the infinite recursion case, the state has to be
global, or per thread.

-- 
Jens Axboe

