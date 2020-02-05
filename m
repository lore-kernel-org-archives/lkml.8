Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BEEC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2809B2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmI+kq7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgBELHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:07:48 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41542 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBELHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:07:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id j9so1031920pfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 03:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L6Gq18X94g9uiylf9X3urfBkcBlJnTY40OWqebofXxQ=;
        b=PmI+kq7dnuRDNGbAdL//xOu9iRIiDm/vC3Fk4dExvfWWxq597FO6gctGkjso02Mcm5
         MD2FGMwrFDm3CG8wlIJ79sqIDa+Otu0ScTI07M52p1QjJjvjsiCxr9J3ilaFgGHhrF+7
         2LbXh5JCWUdGYnRsr5qwfE+SHa+oQdBQHOF4g0BMxM7lCWx0W3d2HShDCvmwd8md1PV5
         CWMpGDh9o9v4h/2f/IEBDtV8phbpd02T85RRBFwf0hXU+iMREn6+vKXqa0vTbqLsi55T
         JscMNhVUozaz5R2Bond8gT7k/8J0Q1OiT6cilHrv5hLzNa9QtRcNPyRVWDLCkP513Knu
         gcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L6Gq18X94g9uiylf9X3urfBkcBlJnTY40OWqebofXxQ=;
        b=Zw/SkLH/gtx/NfjQRjIXVXHK2vr8QPyuhSiIF6UaW6o45E/AvPx5BbqtobRxvRtOic
         sDZJl+YRtZK6qH4QKVhLya/5iFeaXaA6wKCd7lcJI3hVYbw2iKTe7/rmTJbSebbl3EpK
         lxh5/VXpZlOsfK9F1NkXgD/b/RqYmIbA66X2VD/JT9EKNghx5Qs1si4z375zfiTGQSfJ
         0gjY7bDuv/5aM+CJahowxQB46+vRlBp7pr+QpuNmTDJGS63yJXzVkvZHpKQhL+YtCcjY
         dM8Cm1GxmLMb26kuPoyhjJwruOvdbsibjgDygmqmesosYU93lKxa4G6DVTuMBu+4w7NE
         vcfA==
X-Gm-Message-State: APjAAAVzYHO2YZPLP9BbbSntKZCyVrkfKvqvImrk7CDNs+1JdT73eyjr
        7oHXdpVLoPiTD/VdWd+E/gg=
X-Google-Smtp-Source: APXvYqwFAzf1zgsBrca5nJa7YG0i4kRv1JKUVvKUQZGhtEP47dp8RChltK3p9HOTw+aD0YqwRynuxg==
X-Received: by 2002:a63:211f:: with SMTP id h31mr34250918pgh.299.1580900867368;
        Wed, 05 Feb 2020 03:07:47 -0800 (PST)
Received: from localhost ([2a00:79e1:abc:f604:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id v8sm27291885pfn.172.2020.02.05.03.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 03:07:46 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 5 Feb 2020 20:07:44 +0900
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        lijiang <lijiang@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
Message-ID: <20200205110522.GA456@jagdpanzerIV.localdomain>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
 <20200205044848.GH41358@google.com>
 <20200205050204.GI41358@google.com>
 <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
 <20200205063640.GJ41358@google.com>
 <877e11h0ir.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877e11h0ir.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/05 10:00), John Ogness wrote:
> On 2020-02-05, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> >>>> So there is a General protection fault. That's the type of a
> >>>> problem that kills the boot for me as well (different backtrace,
> >>>> tho).
> >>> 
> >>> Do you have CONFIG_RELOCATABLE and CONFIG_RANDOMIZE_BASE (KASLR)
> >>> enabled?
> >> 
> >> Yes. These two options are enabled.
> >> 
> >> CONFIG_RELOCATABLE=y
> >> CONFIG_RANDOMIZE_BASE=y
> >
> > So KASLR kills the boot for me. So does KASAN.
> 
> Sergey, thanks for looking into this already!
> 

So I hacked the system a bit.

3BUG: KASAN: wild-memory-access in copy_data+0x129/0x220>
3Write of size 4 at addr 5a5a5a5a5a5a5a5a by task cat/474>
Call Trace:>
 dump_stack+0x76/0xa0>
 ? copy_data+0x129/0x220>
 __kasan_report.cold+0x5/0x3b>
 ? get_page_from_freelist+0x1224/0x1490>
 ? copy_data+0x129/0x220>
 copy_data+0x129/0x220>
 _prb_read_valid+0x1a0/0x330>
 ? prb_first_seq+0xe0/0xe0>
 ? __might_sleep+0x2f/0xd0>
 ? __zone_watermark_ok+0x180/0x180>
 ? ___might_sleep+0xbe/0xe0>
 prb_read_valid+0x4f/0x60>
 ? _prb_read_valid+0x330/0x330>
 devkmsg_read+0x12e/0x3d0>
 ? __mod_node_page_state+0x1a/0xa0>
 ? info_print_ext_header.constprop.0+0x120/0x120>
 ? __lru_cache_add+0x16c/0x190>
 ? __handle_mm_fault+0x1097/0x1f60>
 vfs_read+0xdc/0x200>
 ksys_read+0xa0/0x130>
 ? kernel_write+0xb0/0xb0>
 ? up_read+0x56/0x130>
 do_syscall_64+0xa0/0x520>
 ? syscall_return_slowpath+0x210/0x210>
 ? do_page_fault+0x399/0x4fa>
 entry_SYSCALL_64_after_hwframe+0x44/0xa9>
RIP: 0033:0x7ff5f39813f2>
Code: c0 e9 c2 fe ff ff 50 48 8d 3d 9a 0d 0a 00 e8 95 ed 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24>
RSP: 002b:00007ffc47b3ee58 EFLAGS: 0000024>
c ORIG_RAX: 0000000000000000>
RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007ff5f39813f2>
RDX: 0000000000020000 RSI: 00007ff5f3588000 RDI: 0000000000000003>
RBP: 00007ff5f3588000 R08: 00007ff5f3587010 R09: 0000000000000000>
R10: 0000000000000022 R11: 0000000000000246 R12: 000055f9c8a81c00>
R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000>

	-ss
