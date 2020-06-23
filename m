Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB8CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E2D20723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqoXXZcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbgFWN1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbgFWN1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:27:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79506C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:27:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r18so9844394pgk.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SsKS5mtlyTSBuA7lQLVh/zJIe0OsrqWtdZSsKuwIrUc=;
        b=TqoXXZcKyyPb9HS2XVIUCdg2LBZCMKf8LnqXgJp9a82Vq4+PPLSRekQ6DV33Aae/4t
         KDNZHIC1kMkQPOmLRJQpLbbKD4lprR84NVFHYPkJ0U4SVaDSYyP5pnvb26Jy8y3A3KiY
         PD0dbf8z4xEjf5uIpMUa/1LMNseqC5SPqepJ8+NwmgYBBH0YWXJ3YtQLmQ2c53XZS8Z4
         ReWCorbVyC8DJGmKxtghxXPh1Xn1G/txmBjiFpe4ymGWjkg6gdpV08qldL1E59FPvhde
         j2/6AWoYyp+bP6x0gp/RVaPgRUgPNZFVIlRs4kJMNSOzrt4UNvPvlweeGaNS7aWW+l3i
         8X3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SsKS5mtlyTSBuA7lQLVh/zJIe0OsrqWtdZSsKuwIrUc=;
        b=nYRyanz0OUEBC4QT9MvV6eviSET4R/RExhrkmNer6ZbgVBqNp/pbOeofciIcxNGa3y
         uM+TdNDB15mGd5vwhpHgx982HpHzYsDJfOnZ9ef6oQvmvogU7y8ZnAxlgDKvwrOCkbmO
         Xg+V8dNksj4gy2vfwBvvedaSzsGbVr2KPO/Ft9VOfFuWYfUX/vJdURvY9T1MCaMfUJkr
         lzAEvskx1E6/ay/xA0jvTyUXQZUho//6rFP6dCw9oRoHIuux/0sbF3ehqHRGVOBntwq+
         WU10YdF1P9fKtmyP83WA2lZ9zqlK3VGwZJyjKknbvegi4keK50WQF+9FVe9K06wkW4sA
         qFoQ==
X-Gm-Message-State: AOAM531Gdvuy6koPHYv5E/fi+6HWaak0zUfHuXB4wLN3JZdVS6NBACgy
        1D9vO3onlDaxv8jQTVGe0Hc=
X-Google-Smtp-Source: ABdhPJwQXuQ/JyLy8VXptsP5ta/cXckkNUC+bko1uGcRnwjU4ZHAGNcmvop7ZgGpOpT4A6n/P+llBQ==
X-Received: by 2002:aa7:9811:: with SMTP id e17mr24948820pfl.61.1592918837877;
        Tue, 23 Jun 2020 06:27:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id hv15sm2465969pjb.17.2020.06.23.06.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 06:27:17 -0700 (PDT)
Subject: Re: [PATCH 0/8] remove unicore32 support
To:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20200623065744.18393-1-rppt@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <16d2f666-03d1-b9fe-f044-4dd9bd65a521@roeck-us.net>
Date:   Tue, 23 Jun 2020 06:27:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200623065744.18393-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/20 11:57 PM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> The unicore32 port do not seem maintained for a long time now, there is no
> upstream toolchain that can create unicore32 binaries and all the links to
> prebuilt toolchains for unicore32 are dead. Even compilers that were
> available are not supported by the kernel anymore.
> 
> Guenter Roeck says:
> 
>   I have stopped building unicore32 images since v4.19 since there is no
>   available compiler that is still supported by the kernel. I am surprised
>   that support for it has not been removed from the kernel.
> 
> These patches remove support for unicre32 architecture as well as several
> drives for devices available only on unicore32 machines.
> 
s/drives/drivers/

Acked-by: Guenter Roeck <linux@roeck-us.net>

> The patches are also available at 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=rm-unicore
> 
> Mike Rapoport (8):
>   arch: remove unicore32 port
>   cpufreq: remove unicore32 driver
>   i2c/buses: remove i2c-puv3  driver
>   input: i8042: remove support for 8042-unicore32io
>   pwm: remove pwm-puv3  driver
>   video: fbdev: remove fb-puv3  driver
>   rtc: remove fb-puv3  driver
>   MAINTAINERS: remove "PKUNITY SOC DRIVERS" entry
> 
>  .../features/core/cBPF-JIT/arch-support.txt   |   1 -
>  .../features/core/eBPF-JIT/arch-support.txt   |   1 -
>  .../core/generic-idle-thread/arch-support.txt |   1 -
>  .../core/jump-labels/arch-support.txt         |   1 -
>  .../features/core/tracehook/arch-support.txt  |   1 -
>  .../features/debug/KASAN/arch-support.txt     |   1 -
>  .../debug/debug-vm-pgtable/arch-support.txt   |   1 -
>  .../debug/gcov-profile-all/arch-support.txt   |   1 -
>  .../features/debug/kgdb/arch-support.txt      |   1 -
>  .../debug/kprobes-on-ftrace/arch-support.txt  |   1 -
>  .../features/debug/kprobes/arch-support.txt   |   1 -
>  .../debug/kretprobes/arch-support.txt         |   1 -
>  .../features/debug/optprobes/arch-support.txt |   1 -
>  .../debug/stackprotector/arch-support.txt     |   1 -
>  .../features/debug/uprobes/arch-support.txt   |   1 -
>  .../debug/user-ret-profiler/arch-support.txt  |   1 -
>  .../io/dma-contiguous/arch-support.txt        |   1 -
>  .../locking/cmpxchg-local/arch-support.txt    |   1 -
>  .../features/locking/lockdep/arch-support.txt |   1 -
>  .../locking/queued-rwlocks/arch-support.txt   |   1 -
>  .../locking/queued-spinlocks/arch-support.txt |   1 -
>  .../perf/kprobes-event/arch-support.txt       |   1 -
>  .../features/perf/perf-regs/arch-support.txt  |   1 -
>  .../perf/perf-stackdump/arch-support.txt      |   1 -
>  .../membarrier-sync-core/arch-support.txt     |   1 -
>  .../sched/numa-balancing/arch-support.txt     |   1 -
>  .../seccomp/seccomp-filter/arch-support.txt   |   1 -
>  .../time/arch-tick-broadcast/arch-support.txt |   1 -
>  .../time/clockevents/arch-support.txt         |   1 -
>  .../time/context-tracking/arch-support.txt    |   1 -
>  .../time/irq-time-acct/arch-support.txt       |   1 -
>  .../time/modern-timekeeping/arch-support.txt  |   1 -
>  .../time/virt-cpuacct/arch-support.txt        |   1 -
>  .../features/vm/ELF-ASLR/arch-support.txt     |   1 -
>  .../features/vm/PG_uncached/arch-support.txt  |   1 -
>  .../features/vm/THP/arch-support.txt          |   1 -
>  .../features/vm/TLB/arch-support.txt          |   1 -
>  .../features/vm/huge-vmap/arch-support.txt    |   1 -
>  .../features/vm/ioremap_prot/arch-support.txt |   1 -
>  .../features/vm/pte_special/arch-support.txt  |   1 -
>  MAINTAINERS                                   |  17 -
>  arch/unicore32/.gitignore                     |  22 -
>  arch/unicore32/Kconfig                        | 200 -----
>  arch/unicore32/Kconfig.debug                  |  29 -
>  arch/unicore32/Makefile                       |  59 --
>  arch/unicore32/boot/Makefile                  |  39 -
>  arch/unicore32/boot/compressed/Makefile       |  64 --
>  arch/unicore32/boot/compressed/head.S         | 201 -----
>  arch/unicore32/boot/compressed/misc.c         | 123 ---
>  arch/unicore32/boot/compressed/piggy.S.in     |   6 -
>  arch/unicore32/boot/compressed/vmlinux.lds.S  |  58 --
>  arch/unicore32/configs/defconfig              | 214 -----
>  arch/unicore32/include/asm/Kbuild             |   7 -
>  arch/unicore32/include/asm/assembler.h        | 128 ---
>  arch/unicore32/include/asm/barrier.h          |  16 -
>  arch/unicore32/include/asm/bitops.h           |  46 -
>  arch/unicore32/include/asm/bug.h              |  20 -
>  arch/unicore32/include/asm/cache.h            |  24 -
>  arch/unicore32/include/asm/cacheflush.h       | 186 ----
>  arch/unicore32/include/asm/checksum.h         |  38 -
>  arch/unicore32/include/asm/cmpxchg.h          |  58 --
>  arch/unicore32/include/asm/cpu-single.h       |  42 -
>  arch/unicore32/include/asm/cputype.h          |  30 -
>  arch/unicore32/include/asm/delay.h            |  49 -
>  arch/unicore32/include/asm/dma.h              |  20 -
>  arch/unicore32/include/asm/elf.h              |  90 --
>  arch/unicore32/include/asm/fpstate.h          |  23 -
>  arch/unicore32/include/asm/fpu-ucf64.h        |  50 --
>  arch/unicore32/include/asm/gpio.h             | 101 ---
>  arch/unicore32/include/asm/hwcap.h            |  29 -
>  arch/unicore32/include/asm/hwdef-copro.h      |  45 -
>  arch/unicore32/include/asm/io.h               |  69 --
>  arch/unicore32/include/asm/irq.h              | 102 ---
>  arch/unicore32/include/asm/irqflags.h         |  50 --
>  arch/unicore32/include/asm/linkage.h          |  19 -
>  arch/unicore32/include/asm/memblock.h         |  43 -
>  arch/unicore32/include/asm/memory.h           | 102 ---
>  arch/unicore32/include/asm/mmu.h              |  14 -
>  arch/unicore32/include/asm/mmu_context.h      |  98 --
>  arch/unicore32/include/asm/page.h             |  74 --
>  arch/unicore32/include/asm/pci.h              |  20 -
>  arch/unicore32/include/asm/pgalloc.h          |  87 --
>  arch/unicore32/include/asm/pgtable-hwdef.h    |  51 --
>  arch/unicore32/include/asm/pgtable.h          | 267 ------
>  arch/unicore32/include/asm/processor.h        |  74 --
>  arch/unicore32/include/asm/ptrace.h           |  58 --
>  arch/unicore32/include/asm/stacktrace.h       |  28 -
>  arch/unicore32/include/asm/string.h           |  35 -
>  arch/unicore32/include/asm/suspend.h          |  26 -
>  arch/unicore32/include/asm/switch_to.h        |  27 -
>  arch/unicore32/include/asm/syscall.h          |  12 -
>  arch/unicore32/include/asm/thread_info.h      | 133 ---
>  arch/unicore32/include/asm/timex.h            |  31 -
>  arch/unicore32/include/asm/tlb.h              |  24 -
>  arch/unicore32/include/asm/tlbflush.h         | 192 ----
>  arch/unicore32/include/asm/traps.h            |  18 -
>  arch/unicore32/include/asm/uaccess.h          |  38 -
>  arch/unicore32/include/asm/vmalloc.h          |   4 -
>  arch/unicore32/include/mach/PKUnity.h         |  95 --
>  arch/unicore32/include/mach/bitfield.h        |  21 -
>  arch/unicore32/include/mach/dma.h             |  45 -
>  arch/unicore32/include/mach/hardware.h        |  30 -
>  arch/unicore32/include/mach/map.h             |  17 -
>  arch/unicore32/include/mach/memory.h          |  54 --
>  arch/unicore32/include/mach/ocd.h             |  33 -
>  arch/unicore32/include/mach/pm.h              |  37 -
>  arch/unicore32/include/mach/regs-ac97.h       |  33 -
>  arch/unicore32/include/mach/regs-dmac.h       |  82 --
>  arch/unicore32/include/mach/regs-gpio.h       |  71 --
>  arch/unicore32/include/mach/regs-i2c.h        |  64 --
>  arch/unicore32/include/mach/regs-intc.h       |  29 -
>  arch/unicore32/include/mach/regs-nand.h       |  80 --
>  arch/unicore32/include/mach/regs-ost.h        |  91 --
>  arch/unicore32/include/mach/regs-pci.h        |  95 --
>  arch/unicore32/include/mach/regs-pm.h         | 127 ---
>  arch/unicore32/include/mach/regs-ps2.h        |  21 -
>  arch/unicore32/include/mach/regs-resetc.h     |  35 -
>  arch/unicore32/include/mach/regs-rtc.h        |  38 -
>  arch/unicore32/include/mach/regs-sdc.h        | 157 ----
>  arch/unicore32/include/mach/regs-spi.h        |  99 ---
>  arch/unicore32/include/mach/regs-uart.h       |   3 -
>  arch/unicore32/include/mach/regs-umal.h       | 230 -----
>  arch/unicore32/include/mach/regs-unigfx.h     | 201 -----
>  arch/unicore32/include/mach/uncompress.h      |  31 -
>  arch/unicore32/include/uapi/asm/Kbuild        |   2 -
>  arch/unicore32/include/uapi/asm/byteorder.h   |  25 -
>  arch/unicore32/include/uapi/asm/ptrace.h      |  91 --
>  arch/unicore32/include/uapi/asm/sigcontext.h  |  30 -
>  arch/unicore32/include/uapi/asm/unistd.h      |  21 -
>  arch/unicore32/kernel/Makefile                |  31 -
>  arch/unicore32/kernel/asm-offsets.c           | 108 ---
>  arch/unicore32/kernel/clock.c                 | 387 --------
>  arch/unicore32/kernel/debug-macro.S           |  86 --
>  arch/unicore32/kernel/debug.S                 |  82 --
>  arch/unicore32/kernel/dma.c                   | 179 ----
>  arch/unicore32/kernel/early_printk.c          |  46 -
>  arch/unicore32/kernel/elf.c                   |  35 -
>  arch/unicore32/kernel/entry.S                 | 802 -----------------
>  arch/unicore32/kernel/fpu-ucf64.c             | 117 ---
>  arch/unicore32/kernel/gpio.c                  | 121 ---
>  arch/unicore32/kernel/head.S                  | 249 ------
>  arch/unicore32/kernel/hibernate.c             | 159 ----
>  arch/unicore32/kernel/hibernate_asm.S         | 114 ---
>  arch/unicore32/kernel/irq.c                   | 371 --------
>  arch/unicore32/kernel/ksyms.c                 |  57 --
>  arch/unicore32/kernel/ksyms.h                 |  14 -
>  arch/unicore32/kernel/module.c                | 105 ---
>  arch/unicore32/kernel/pci.c                   | 371 --------
>  arch/unicore32/kernel/pm.c                    | 121 ---
>  arch/unicore32/kernel/process.c               | 319 -------
>  arch/unicore32/kernel/ptrace.c                | 147 ---
>  arch/unicore32/kernel/puv3-core.c             | 276 ------
>  arch/unicore32/kernel/puv3-nb0916.c           | 147 ---
>  arch/unicore32/kernel/setup.c                 | 352 --------
>  arch/unicore32/kernel/setup.h                 |  36 -
>  arch/unicore32/kernel/signal.c                | 424 ---------
>  arch/unicore32/kernel/sleep.S                 | 199 -----
>  arch/unicore32/kernel/stacktrace.c            | 127 ---
>  arch/unicore32/kernel/sys.c                   |  37 -
>  arch/unicore32/kernel/time.c                  | 128 ---
>  arch/unicore32/kernel/traps.c                 | 322 -------
>  arch/unicore32/kernel/vmlinux.lds.S           |  59 --
>  arch/unicore32/lib/Makefile                   |  28 -
>  arch/unicore32/lib/backtrace.S                | 168 ----
>  arch/unicore32/lib/clear_user.S               |  54 --
>  arch/unicore32/lib/copy_from_user.S           | 101 ---
>  arch/unicore32/lib/copy_page.S                |  36 -
>  arch/unicore32/lib/copy_template.S            | 211 -----
>  arch/unicore32/lib/copy_to_user.S             |  93 --
>  arch/unicore32/lib/delay.S                    |  48 -
>  arch/unicore32/lib/findbit.S                  |  97 --
>  arch/unicore32/lib/strncpy_from_user.S        |  42 -
>  arch/unicore32/lib/strnlen_user.S             |  39 -
>  arch/unicore32/mm/Kconfig                     |  41 -
>  arch/unicore32/mm/Makefile                    |  14 -
>  arch/unicore32/mm/alignment.c                 | 524 -----------
>  arch/unicore32/mm/cache-ucv2.S                | 209 -----
>  arch/unicore32/mm/extable.c                   |  21 -
>  arch/unicore32/mm/fault.c                     | 481 ----------
>  arch/unicore32/mm/flush.c                     |  94 --
>  arch/unicore32/mm/init.c                      | 261 ------
>  arch/unicore32/mm/ioremap.c                   | 242 -----
>  arch/unicore32/mm/mm.h                        |  31 -
>  arch/unicore32/mm/mmu.c                       | 513 -----------
>  arch/unicore32/mm/pgd.c                       | 102 ---
>  arch/unicore32/mm/proc-macros.S               | 142 ---
>  arch/unicore32/mm/proc-syms.c                 |  19 -
>  arch/unicore32/mm/proc-ucv2.S                 | 131 ---
>  arch/unicore32/mm/tlb-ucv2.S                  |  86 --
>  drivers/cpufreq/Makefile                      |   1 -
>  drivers/cpufreq/unicore2-cpufreq.c            |  76 --
>  drivers/i2c/busses/Kconfig                    |  11 -
>  drivers/i2c/busses/Makefile                   |   1 -
>  drivers/i2c/busses/i2c-puv3.c                 | 275 ------
>  drivers/input/serio/i8042-unicore32io.h       |  70 --
>  drivers/input/serio/i8042.h                   |   2 -
>  drivers/pwm/Kconfig                           |   9 -
>  drivers/pwm/Makefile                          |   1 -
>  drivers/pwm/pwm-puv3.c                        | 150 ----
>  drivers/rtc/Kconfig                           |   9 -
>  drivers/rtc/Makefile                          |   1 -
>  drivers/rtc/rtc-puv3.c                        | 286 ------
>  drivers/video/fbdev/Kconfig                   |  11 -
>  drivers/video/fbdev/Makefile                  |   1 -
>  drivers/video/fbdev/fb-puv3.c                 | 836 ------------------
>  kernel/reboot.c                               |   2 +-
>  206 files changed, 1 insertion(+), 17455 deletions(-)
>  delete mode 100644 arch/unicore32/.gitignore
>  delete mode 100644 arch/unicore32/Kconfig
>  delete mode 100644 arch/unicore32/Kconfig.debug
>  delete mode 100644 arch/unicore32/Makefile
>  delete mode 100644 arch/unicore32/boot/Makefile
>  delete mode 100644 arch/unicore32/boot/compressed/Makefile
>  delete mode 100644 arch/unicore32/boot/compressed/head.S
>  delete mode 100644 arch/unicore32/boot/compressed/misc.c
>  delete mode 100644 arch/unicore32/boot/compressed/piggy.S.in
>  delete mode 100644 arch/unicore32/boot/compressed/vmlinux.lds.S
>  delete mode 100644 arch/unicore32/configs/defconfig
>  delete mode 100644 arch/unicore32/include/asm/Kbuild
>  delete mode 100644 arch/unicore32/include/asm/assembler.h
>  delete mode 100644 arch/unicore32/include/asm/barrier.h
>  delete mode 100644 arch/unicore32/include/asm/bitops.h
>  delete mode 100644 arch/unicore32/include/asm/bug.h
>  delete mode 100644 arch/unicore32/include/asm/cache.h
>  delete mode 100644 arch/unicore32/include/asm/cacheflush.h
>  delete mode 100644 arch/unicore32/include/asm/checksum.h
>  delete mode 100644 arch/unicore32/include/asm/cmpxchg.h
>  delete mode 100644 arch/unicore32/include/asm/cpu-single.h
>  delete mode 100644 arch/unicore32/include/asm/cputype.h
>  delete mode 100644 arch/unicore32/include/asm/delay.h
>  delete mode 100644 arch/unicore32/include/asm/dma.h
>  delete mode 100644 arch/unicore32/include/asm/elf.h
>  delete mode 100644 arch/unicore32/include/asm/fpstate.h
>  delete mode 100644 arch/unicore32/include/asm/fpu-ucf64.h
>  delete mode 100644 arch/unicore32/include/asm/gpio.h
>  delete mode 100644 arch/unicore32/include/asm/hwcap.h
>  delete mode 100644 arch/unicore32/include/asm/hwdef-copro.h
>  delete mode 100644 arch/unicore32/include/asm/io.h
>  delete mode 100644 arch/unicore32/include/asm/irq.h
>  delete mode 100644 arch/unicore32/include/asm/irqflags.h
>  delete mode 100644 arch/unicore32/include/asm/linkage.h
>  delete mode 100644 arch/unicore32/include/asm/memblock.h
>  delete mode 100644 arch/unicore32/include/asm/memory.h
>  delete mode 100644 arch/unicore32/include/asm/mmu.h
>  delete mode 100644 arch/unicore32/include/asm/mmu_context.h
>  delete mode 100644 arch/unicore32/include/asm/page.h
>  delete mode 100644 arch/unicore32/include/asm/pci.h
>  delete mode 100644 arch/unicore32/include/asm/pgalloc.h
>  delete mode 100644 arch/unicore32/include/asm/pgtable-hwdef.h
>  delete mode 100644 arch/unicore32/include/asm/pgtable.h
>  delete mode 100644 arch/unicore32/include/asm/processor.h
>  delete mode 100644 arch/unicore32/include/asm/ptrace.h
>  delete mode 100644 arch/unicore32/include/asm/stacktrace.h
>  delete mode 100644 arch/unicore32/include/asm/string.h
>  delete mode 100644 arch/unicore32/include/asm/suspend.h
>  delete mode 100644 arch/unicore32/include/asm/switch_to.h
>  delete mode 100644 arch/unicore32/include/asm/syscall.h
>  delete mode 100644 arch/unicore32/include/asm/thread_info.h
>  delete mode 100644 arch/unicore32/include/asm/timex.h
>  delete mode 100644 arch/unicore32/include/asm/tlb.h
>  delete mode 100644 arch/unicore32/include/asm/tlbflush.h
>  delete mode 100644 arch/unicore32/include/asm/traps.h
>  delete mode 100644 arch/unicore32/include/asm/uaccess.h
>  delete mode 100644 arch/unicore32/include/asm/vmalloc.h
>  delete mode 100644 arch/unicore32/include/mach/PKUnity.h
>  delete mode 100644 arch/unicore32/include/mach/bitfield.h
>  delete mode 100644 arch/unicore32/include/mach/dma.h
>  delete mode 100644 arch/unicore32/include/mach/hardware.h
>  delete mode 100644 arch/unicore32/include/mach/map.h
>  delete mode 100644 arch/unicore32/include/mach/memory.h
>  delete mode 100644 arch/unicore32/include/mach/ocd.h
>  delete mode 100644 arch/unicore32/include/mach/pm.h
>  delete mode 100644 arch/unicore32/include/mach/regs-ac97.h
>  delete mode 100644 arch/unicore32/include/mach/regs-dmac.h
>  delete mode 100644 arch/unicore32/include/mach/regs-gpio.h
>  delete mode 100644 arch/unicore32/include/mach/regs-i2c.h
>  delete mode 100644 arch/unicore32/include/mach/regs-intc.h
>  delete mode 100644 arch/unicore32/include/mach/regs-nand.h
>  delete mode 100644 arch/unicore32/include/mach/regs-ost.h
>  delete mode 100644 arch/unicore32/include/mach/regs-pci.h
>  delete mode 100644 arch/unicore32/include/mach/regs-pm.h
>  delete mode 100644 arch/unicore32/include/mach/regs-ps2.h
>  delete mode 100644 arch/unicore32/include/mach/regs-resetc.h
>  delete mode 100644 arch/unicore32/include/mach/regs-rtc.h
>  delete mode 100644 arch/unicore32/include/mach/regs-sdc.h
>  delete mode 100644 arch/unicore32/include/mach/regs-spi.h
>  delete mode 100644 arch/unicore32/include/mach/regs-uart.h
>  delete mode 100644 arch/unicore32/include/mach/regs-umal.h
>  delete mode 100644 arch/unicore32/include/mach/regs-unigfx.h
>  delete mode 100644 arch/unicore32/include/mach/uncompress.h
>  delete mode 100644 arch/unicore32/include/uapi/asm/Kbuild
>  delete mode 100644 arch/unicore32/include/uapi/asm/byteorder.h
>  delete mode 100644 arch/unicore32/include/uapi/asm/ptrace.h
>  delete mode 100644 arch/unicore32/include/uapi/asm/sigcontext.h
>  delete mode 100644 arch/unicore32/include/uapi/asm/unistd.h
>  delete mode 100644 arch/unicore32/kernel/Makefile
>  delete mode 100644 arch/unicore32/kernel/asm-offsets.c
>  delete mode 100644 arch/unicore32/kernel/clock.c
>  delete mode 100644 arch/unicore32/kernel/debug-macro.S
>  delete mode 100644 arch/unicore32/kernel/debug.S
>  delete mode 100644 arch/unicore32/kernel/dma.c
>  delete mode 100644 arch/unicore32/kernel/early_printk.c
>  delete mode 100644 arch/unicore32/kernel/elf.c
>  delete mode 100644 arch/unicore32/kernel/entry.S
>  delete mode 100644 arch/unicore32/kernel/fpu-ucf64.c
>  delete mode 100644 arch/unicore32/kernel/gpio.c
>  delete mode 100644 arch/unicore32/kernel/head.S
>  delete mode 100644 arch/unicore32/kernel/hibernate.c
>  delete mode 100644 arch/unicore32/kernel/hibernate_asm.S
>  delete mode 100644 arch/unicore32/kernel/irq.c
>  delete mode 100644 arch/unicore32/kernel/ksyms.c
>  delete mode 100644 arch/unicore32/kernel/ksyms.h
>  delete mode 100644 arch/unicore32/kernel/module.c
>  delete mode 100644 arch/unicore32/kernel/pci.c
>  delete mode 100644 arch/unicore32/kernel/pm.c
>  delete mode 100644 arch/unicore32/kernel/process.c
>  delete mode 100644 arch/unicore32/kernel/ptrace.c
>  delete mode 100644 arch/unicore32/kernel/puv3-core.c
>  delete mode 100644 arch/unicore32/kernel/puv3-nb0916.c
>  delete mode 100644 arch/unicore32/kernel/setup.c
>  delete mode 100644 arch/unicore32/kernel/setup.h
>  delete mode 100644 arch/unicore32/kernel/signal.c
>  delete mode 100644 arch/unicore32/kernel/sleep.S
>  delete mode 100644 arch/unicore32/kernel/stacktrace.c
>  delete mode 100644 arch/unicore32/kernel/sys.c
>  delete mode 100644 arch/unicore32/kernel/time.c
>  delete mode 100644 arch/unicore32/kernel/traps.c
>  delete mode 100644 arch/unicore32/kernel/vmlinux.lds.S
>  delete mode 100644 arch/unicore32/lib/Makefile
>  delete mode 100644 arch/unicore32/lib/backtrace.S
>  delete mode 100644 arch/unicore32/lib/clear_user.S
>  delete mode 100644 arch/unicore32/lib/copy_from_user.S
>  delete mode 100644 arch/unicore32/lib/copy_page.S
>  delete mode 100644 arch/unicore32/lib/copy_template.S
>  delete mode 100644 arch/unicore32/lib/copy_to_user.S
>  delete mode 100644 arch/unicore32/lib/delay.S
>  delete mode 100644 arch/unicore32/lib/findbit.S
>  delete mode 100644 arch/unicore32/lib/strncpy_from_user.S
>  delete mode 100644 arch/unicore32/lib/strnlen_user.S
>  delete mode 100644 arch/unicore32/mm/Kconfig
>  delete mode 100644 arch/unicore32/mm/Makefile
>  delete mode 100644 arch/unicore32/mm/alignment.c
>  delete mode 100644 arch/unicore32/mm/cache-ucv2.S
>  delete mode 100644 arch/unicore32/mm/extable.c
>  delete mode 100644 arch/unicore32/mm/fault.c
>  delete mode 100644 arch/unicore32/mm/flush.c
>  delete mode 100644 arch/unicore32/mm/init.c
>  delete mode 100644 arch/unicore32/mm/ioremap.c
>  delete mode 100644 arch/unicore32/mm/mm.h
>  delete mode 100644 arch/unicore32/mm/mmu.c
>  delete mode 100644 arch/unicore32/mm/pgd.c
>  delete mode 100644 arch/unicore32/mm/proc-macros.S
>  delete mode 100644 arch/unicore32/mm/proc-syms.c
>  delete mode 100644 arch/unicore32/mm/proc-ucv2.S
>  delete mode 100644 arch/unicore32/mm/tlb-ucv2.S
>  delete mode 100644 drivers/cpufreq/unicore2-cpufreq.c
>  delete mode 100644 drivers/i2c/busses/i2c-puv3.c
>  delete mode 100644 drivers/input/serio/i8042-unicore32io.h
>  delete mode 100644 drivers/pwm/pwm-puv3.c
>  delete mode 100644 drivers/rtc/rtc-puv3.c
>  delete mode 100644 drivers/video/fbdev/fb-puv3.c
> 
> 
> base-commit: 1b5044021070efa3259f3e9548dc35d1eb6aa844
> 

