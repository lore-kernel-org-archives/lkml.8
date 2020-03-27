Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A98C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9B1206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz8p9gtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgC0JqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:46:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55191 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgC0JqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:46:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id c81so10713428wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 02:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yHVi+7ZN3/9e/qM65XZYi0xvmnmgvNFFTLxCBWYOgT0=;
        b=Dz8p9gtZS2nY3E95bA9jcBRkRNJ141wsZpk7u5FkCoAUV0PCVULYJ1tqdNvk1R0h0M
         8djCy9ykV0ScL1/i2XINH0ON0ACQqauSOjvFGtzRdwPhmUMBg/lDlqxGv6b3E4JquZzX
         fb8FdWTWkID42ze1l1i2NaHvvKG72zIjXu0GQgHdSfF20P8Th4rYy0+yKg2YTAeTIoHl
         sdY83YNc+7a79nwJn1yI6RD4QF6GKcqUWhNOgsFnX+Lz0HfW538Fo4l8AiTV4q5m94ob
         CZDjnPDkTrnQk5hITwi5wJWJcF6zonpAPsVHiwUJJkFfEuqUTxN7NjiMqXBdPDRYhdfU
         y1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yHVi+7ZN3/9e/qM65XZYi0xvmnmgvNFFTLxCBWYOgT0=;
        b=nxDpu1Bm8v7cTKZsp3mVgNiXO7+q5NYzI5r767nJFJF9BstUzcg9v4pOhCrjJO8XGH
         FzOm0+7V5IN++R9eUU9nO7y06q+J6fGeMfbRmYezP4OdStPwPuhnKsUmlrubVTCXyVm1
         Eb6lQAHpAq6y67KsRdM9xv7HV4Qt7K60EtehF2QhJpejG3rQ0LoFMooGD1P604vHJ3lF
         Kle8B9lMqeHmcPGwHBBvCW3JLcfvCwgwpUY2EW1WKyjVsReNaGqDIeHKUmDrSc5qUGjn
         9TgHbXWCxp16zJRkjhJLBycuMgPcYcBcvl3+1CJT7lnIPsjgHgKpKIqStmxsw3mT+PLo
         243g==
X-Gm-Message-State: ANhLgQ0AhqR66IBGp1pdzpjsJchDVj1rqnVEzS+O5hZFnPfPm8BLabtP
        Hdj34OShBH1AdpTWQ0I8LxJa04R4
X-Google-Smtp-Source: ADFU+vu6VsZdE6d2vTXdz9WajuMHSTP6pLITtd+aLSEwPcuvtU6qdJlWHCRrCN4uSB2euhKp7y0DRw==
X-Received: by 2002:a7b:c0d7:: with SMTP id s23mr4506610wmh.104.1585302374592;
        Fri, 27 Mar 2020 02:46:14 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f29:6000:9d76:401f:98cb:c084? (p200300EA8F2960009D76401F98CBC084.dip0.t-ipconnect.de. [2003:ea:8f29:6000:9d76:401f:98cb:c084])
        by smtp.googlemail.com with ESMTPSA id a192sm7615040wme.5.2020.03.27.02.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 02:46:14 -0700 (PDT)
Subject: Re: BUG: sleeping function called from invalid context at
 include/linux/percpu-rwsem.h:49
To:     Hillf Danton <hdanton@sina.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200327084647.7940-1-hdanton@sina.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <7f927429-6317-fecd-8771-8fe59350fac2@gmail.com>
Date:   Fri, 27 Mar 2020 10:46:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327084647.7940-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.03.2020 09:46, Hillf Danton wrote:
> 
> On Fri, 27 Mar 2020 00:56:34 +0100 Heiner Kallweit wrote:
>>
>> I just got the following on linux-next from March 25th. You dealt last with
>> include/linux/percpu-rwsem.h, so you may have an idea where to look for the
>> root cause.
>>
>>
>> Mar 26 23:29:51 zotac kernel: BUG: kernel NULL pointer dereference, address: 0000000000000000
>> Mar 26 23:29:51 zotac kernel: #PF: supervisor read access in kernel mode
>> Mar 26 23:29:51 zotac kernel: #PF: error_code(0x0000) - not-present page
>> Mar 26 23:29:51 zotac kernel: PGD 0 P4D 0
>> Mar 26 23:29:51 zotac kernel: Oops: 0000 [#1] SMP
>> Mar 26 23:29:51 zotac kernel: CPU: 2 PID: 2404 Comm: resolvconf Not tainted 5.6.0-rc7-next-20200325+ #1
>> Mar 26 23:29:51 zotac kernel: Hardware name: NA ZBOX-CI327NANO-GS-01/ZBOX-CI327NANO-GS-01, BIOS 5.12 04/26/2018
>> Mar 26 23:29:51 zotac kernel: RIP: 0010:link_path_walk.part.0+0x1c5/0x350
>> Mar 26 23:29:51 zotac kernel: Code: 41 83 ef 01 31 f6 4c 89 f7 49 63 c7 48 8d 04 40 48 c1 e0 04 49 03 46 58 4c 8b 68 20 e8 84 fc ff ff 48 85 c0 75 5f 49 8b 46 08 <8b> 00 25 00 00 70 00 3d 00 00 20 00 0f 84 a5 fe ff ff 41 f6 46 38
>> Mar 26 23:29:51 zotac kernel: RSP: 0018:ffffb272403c7ba8 EFLAGS: 00010246
>> Mar 26 23:29:51 zotac kernel: RAX: 0000000000000000 RBX: fefefefefefefeff RCX: 0000000000000000
>> Mar 26 23:29:51 zotac kernel: RDX: ffff9f21bab88000 RSI: ffffffffbea46aa0 RDI: ffff9f21bab88858
>> Mar 26 23:29:51 zotac kernel: RBP: ffffb272403c7bf0 R08: 0000000000000001 R09: 0000000000000000
>> Mar 26 23:29:51 zotac kernel: R10: 80800000007fffff R11: 0000000000000000 R12: 2f2f2f2f2f2f2f2f
>> Mar 26 23:29:51 zotac kernel: R13: ffff9f21b9476243 R14: ffffb272403c7c30 R15: 0000000000000001
>> Mar 26 23:29:51 zotac kernel: FS:  00007f464ebc8b80(0000) GS:ffff9f21bbd00000(0000) knlGS:0000000000000000
>> Mar 26 23:29:51 zotac kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> Mar 26 23:29:51 zotac kernel: CR2: 0000000000000000 CR3: 0000000178b7d000 CR4: 00000000003406e0
>> Mar 26 23:29:51 zotac kernel: Call Trace:
>> Mar 26 23:29:51 zotac kernel:  path_lookupat.isra.0+0x3b/0x150
>> Mar 26 23:29:51 zotac kernel:  filename_lookup+0xb4/0x140
>> Mar 26 23:29:51 zotac kernel:  ? rcu_read_lock_sched_held+0x4a/0x80
>> Mar 26 23:29:51 zotac kernel:  ? kmem_cache_alloc+0x24c/0x280
>> Mar 26 23:29:51 zotac kernel:  kern_path+0x31/0x40
>> Mar 26 23:29:51 zotac kernel:  unix_find_other+0x4f/0x2b0
>> Mar 26 23:29:51 zotac kernel:  unix_stream_connect+0x115/0x6c4
>> Mar 26 23:29:51 zotac kernel:  __sys_connect+0xec/0x110
>> Mar 26 23:29:51 zotac kernel:  ? lockdep_hardirqs_on+0xf2/0x1a0
>> Mar 26 23:29:51 zotac kernel:  __x64_sys_connect+0x19/0x20
>> Mar 26 23:29:51 zotac kernel:  do_syscall_64+0x50/0x1e0
>> Mar 26 23:29:51 zotac kernel:  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> 
> FYI: another null-ptr-deref was reported at
> 
>   https://lore.kernel.org/lkml/4CBDE0F3-FB73-43F3-8535-6C75BA004233@lca.pw/
> 
> and fix in that thread.
> 
Thanks for the quick feedback and the hint!

Heiner
