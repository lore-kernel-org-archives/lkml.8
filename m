Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A912FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3032067B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlSOb8fW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgFENSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgFENSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:18:06 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD850C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 06:18:04 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id a17so718240ybm.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdJTl0GPkTxtAgl6xMtvqZp439J+9Sibdiju/StvYLY=;
        b=rlSOb8fWfH/Eamq30To66VF7U7csd+Z6te+gJmJnu7jmPbeLhbrPZ3ktbBEPzxmoLC
         hCSSlewjbBxhHW7NJz5UNinLnehS8c1EtitAJz7MBmQWK+3YECuX0kaBzp+o5//R0CGj
         zwLyEAjcQlzSksz3VmK0pLve/I6qW3Yne3jLV7hG3KY9ckUtJa2gdWlUmkoltWklPjfX
         VuoCQtPs3fGnswMGFMLfjf8l5cVKxsCwtlW3+zoV1M2tJ3OJtSZ9xhirRBdvdx5TPfTI
         h49cIrxGsyY6l3jG09VUsBSuLJ7RNbBCWUywU0Y6GLbLLxd/gLOjPk4hjsiSLtX+oPl1
         8rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdJTl0GPkTxtAgl6xMtvqZp439J+9Sibdiju/StvYLY=;
        b=tcWJh09FECwsZwSQpCVRKMQGCBpT4eBLv41lI7akngVTVsmNa9ciS3or38xz+5a6ec
         S3Yk4HiQCbs4lRhE/db2zUOvvwP5swBY3Ct+a+xUUUWWWVo+6ymyDb01uChSqSeoFrUz
         RqlvmNCJuGlhFCVhLqf4Ja/OXpAJ9BUPSPudyiat5zYREuBYiSd0CdoHbWlkK73E+RM6
         CZxDLrxq/3dsqcP0L4iyQ1kPKFlF5umqADc9zgQPH0vYaCdGpPDc1ljTpeaNnuRZv/HY
         5k7ZIiP5qQMEi5y3Zh0b8klDfVNydWjv0dk/byXHlZ7V7s8d8LlJTW+Qk+UyYqe3YdNp
         r7hg==
X-Gm-Message-State: AOAM530d6vBbH6smmuA0I2l7GJA/gs5G54OL0785TS7YFYAJ9sE89Y4H
        qXEjIrkjI7irUxEjei1zP92D86/p+5TTwRgSbv1T3g==
X-Google-Smtp-Source: ABdhPJx6wUs4Nzt4/wuy+bgyV1kkClscLotf2CiaWnCATT3GZeN5ZpUcNMpmLPPoJS1/QDosLxthHzM2rKa1GJ9VpSo=
X-Received: by 2002:a25:b88d:: with SMTP id w13mr8727619ybj.520.1591363083445;
 Fri, 05 Jun 2020 06:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200605080929.GK12456@shao2-debian>
In-Reply-To: <20200605080929.GK12456@shao2-debian>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 5 Jun 2020 06:17:51 -0700
Message-ID: <CANn89iK1EfAqw-SkXyQR=88fKnBpXCcR_FaiFkVDUNazNgAX1g@mail.gmail.com>
Subject: Re: [net] a6211caa63: dmesg.UBSAN:signed-integer-overflow_in_arch/x86/include/asm/atomic.h
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Yuqi Jin <jinyuqi@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jiong Wang <jiongwang@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 1:10 AM kernel test robot <rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-4.9):
>
> commit: a6211caa634da39d861a47437ffcda8b38ef421b ("net: revert "net: get rid of an signed integer overflow in ip_idents_reserve()"")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: boot
>
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>

There you go.

We decided this was a bogus report, and that UBSAN requires sane compilers.

Please read the fine comment that was added in this commit and update
your compiler or do not mess with compiler flags.

+       /* If UBSAN reports an error there, please make sure your compiler
+        * supports -fno-strict-overflow before reporting it that was a bug
+        * in UBSAN, and it has been fixed in GCC-8.
+        */
+       return atomic_add_return(segs + delta, p_id) - segs;

Thanks.


>
> [   35.019158] ================================================================================
> [   35.019995] UBSAN: signed-integer-overflow in arch/x86/include/asm/atomic.h:167:2
> [   35.020884] -1045826149 + -1341282523 cannot be represented in type 'int'
> [   35.021544] CPU: 0 PID: 350 Comm: systemd-timesyn Tainted: G S                5.7.0-rc5-00221-ga6211caa634da #1
> [   35.022550] Call Trace:
> [   35.022812]  dump_stack+0x16/0x26
> [   35.023151]  ubsan_epilogue+0x8/0x40
> [   35.023526]  handle_overflow+0x80/0xa0
> [   35.023925]  ? __ip_append_data+0x8ca/0xdd0
> [   35.024408]  __ubsan_handle_add_overflow+0xa/0x10
> [   35.024872]  ip_idents_reserve+0x79/0x90
> [   35.025263]  __ip_select_ident+0x48/0x70
> [   35.025659]  __ip_make_skb+0x32f/0x410
> [   35.026039]  ip_make_skb+0xa6/0xe0
> [   35.026383]  ? ip_reply_glue_bits+0x50/0x50
> [   35.026770]  ? ip_route_output_key_hash+0xb6/0xe0
> [   35.027221]  udp_sendmsg+0x577/0xba0
> [   35.027551]  ? ip_reply_glue_bits+0x50/0x50
> [   35.027960]  ? lock_release+0x9d/0x260
> [   35.028328]  inet_sendmsg+0x2e/0x50
> [   35.028819]  __sys_sendto+0xe2/0x130
> [   35.029178]  ? lock_acquire+0x92/0x310
> [   35.029552]  ? __might_fault+0x41/0x80
> [   35.029903]  ? find_held_lock+0x2d/0xd0
> [   35.030262]  ? lock_release+0x9d/0x260
> [   35.030620]  __ia32_sys_socketcall+0x141/0x240
> [   35.031064]  do_int80_syscall_32+0x46/0x3d0
> [   35.031470]  entry_INT80_32+0x113/0x113
> [   35.031854] EIP: 0xb7f54a02
> [   35.032133] Code: 95 01 00 05 25 36 02 00 83 ec 14 8d 80 e8 99 ff ff 50 6a 02 e8 1f ff 00 00 c7 04 24 7f 00 00 00 e8 7e 87 01 00 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 1c 24 c3 8d b6 00 00
> [   35.033938] EAX: ffffffda EBX: 0000000b ECX: bfecd7c8 EDX: 00000000
> [   35.034562] ESI: b7cd3000 EDI: 00000000 EBP: 00000000 ESP: bfecd7bc
> [   35.035199] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000293
> [   35.035865] ================================================================================
> [  OK  ] Started OpenBSD Secure Shell server.
> [  OK  ] Started LSB: Start and stop bmc-watchdog.
> [  OK  ] Started LSB: Execute the kexec -e command to reboot system.
> [  OK  ] Started Login Service.
>          Starting Preprocess NFS configuration...
> [  OK  ] Reached target Host and Network Name Lookups.
>          Starting LSB: Load kernel image with kexec...
> [  OK  ] Reached target Login Prompts.
> [  OK  ] Started Preprocess NFS configuration.
>          Starting Notify NFS peers of a restart...
>          Starting NFS status monitor for NFSv2/3 locking....
> [  OK  ] Started Notify NFS peers of a restart.
> [  OK  ] Started LSB: Load kernel image with kexec.
> [  OK  ] Started NFS status monitor for NFSv2/3 locking..
> [   48.881188] sysrq: Emergency Sync
> [   48.881750] sysrq: Resetting
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.7.0-rc5-00221-ga6211caa634da .config
>         make HOSTCC=gcc-4.9 CC=gcc-4.9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>
>
>
> Thanks,
> Rong Chen
>
