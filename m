Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8ECC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB822080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9BEh8YS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbgGTUGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgGTUGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:06:23 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9EFC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:06:23 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i80so10393646lfi.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qerqyyq8aW+ueEjW6P8mihDDO48Lc3v+ScNleEm3ji4=;
        b=t9BEh8YSPu5diXvOkcmKxR0VJuqqyGv+mQ7SnSl5oeUcrp+RQjkYAswNhtB/aQQZA1
         hRdFyUydJKBlNpdT3UAS+S/7UZ43aH9Ftzn5i4/LtCUMrYr4go6Vr6Tl1lgzDBk09dwC
         E1Dvs1MpwmBEoWHL4l8LRdQieOrh7cOXjM+pQxXa761n9sb46nWfJcCz/5/76UbOJS7Y
         5RBJUmMjkXdqwusCM4Q1YDzwAG/FIbDATISlQDK1PPLUAYVHZRx7jqZED+9ACOClLE7V
         WcHZXw0S/JQzic6X1VtEFa7O52HfwbDi/pYb5v/AHAC3d1zlHKXPpU207ygO4b2RDcfK
         2igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qerqyyq8aW+ueEjW6P8mihDDO48Lc3v+ScNleEm3ji4=;
        b=qreXIlHWNx5id1yVhLSt/doc4cUT+RtPPQ9pJq9cYNGMLFHCV9yGf+C3yp95xcrVU4
         B/Kv8K4dIpJToqv98fbBBuU47MJo1ccwd99Ry29LA3n+Y/SHRg+ZiL1qpHgNzihhz2U8
         6KVkV8Hf+G50dXgPhBoE9ZydT5SXQNN9sOcXoVW3BDcjMYl+OvnCD/tjt+pukvMYSeQy
         /thKe+29JwYEpCL+3oCm5UhaErtpyJti8WhDk9b4d7VHrOPQMudS99jJsdOte+02BGSn
         3/bRR0C19y6wy4jzNJGWjofQY9GAO1JblulT3ylKNogLq4Bm3CoKOegKOgXcRnSEpzmj
         /4lA==
X-Gm-Message-State: AOAM531w+gI339jGnDuL7DqqXCu5/4KA5zIwoVlnYRv9zpTNAuqi7+S2
        OhMsIIF4EaRVaY7izSKXGy5ZKldVU2w=
X-Google-Smtp-Source: ABdhPJwLeeZAUBi1AF40kIvutcHf76WNKzXWshlAO4FgY9s1S6GP7ju8m/jClSO5ICJbBO7AHH0kPw==
X-Received: by 2002:a19:c1d6:: with SMTP id r205mr3821151lff.141.1595275581839;
        Mon, 20 Jul 2020 13:06:21 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a8sm3412002ljk.138.2020.07.20.13.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 13:06:20 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 20 Jul 2020 22:06:18 +0200
To:     akpm@linux-foundation.org
Cc:     akpm@linux-foundation.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: kernel BUG at mm/vmalloc.c:LINE! (2)
Message-ID: <20200720200618.GA9501@pc636>
References: <000000000000588c2c05aa156b2b@google.com>
 <0000000000003cdc6c05aae24652@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003cdc6c05aae24652@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 09:48:21AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    ab8be66e Add linux-next specific files for 20200720
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=161a0cc8900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c4bf77d63d0cf88c
> dashboard link: https://syzkaller.appspot.com/bug?extid=5f326d255ca648131f87
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151192bb100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d7a873100000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5f326d255ca648131f87@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at mm/vmalloc.c:3089!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.8.0-rc6-next-20200720-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: events pcpu_balance_workfn
> RIP: 0010:free_vm_area mm/vmalloc.c:3089 [inline]
> RIP: 0010:free_vm_area mm/vmalloc.c:3085 [inline]
> RIP: 0010:pcpu_free_vm_areas+0x96/0xc0 mm/vmalloc.c:3432
> Code: 75 48 48 8b 2b 48 8d 7d 08 48 89 f8 48 c1 e8 03 42 80 3c 30 00 75 2c 48 8b 7d 08 e8 c4 c8 ff ff 48 39 c5 74 a5 e8 ea c3 c9 ff <0f> 0b e8 e3 c3 c9 ff 4c 89 ff 5b 5d 41 5c 41 5d 41 5e 41 5f e9 71
> RSP: 0018:ffffc90000d2fba8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff8880a801be00 RCX: 0000000000000000
> RDX: ffff8880a95fa300 RSI: ffffffff81aa7c76 RDI: 0000000000000001
> RBP: ffff8880a2b38180 R08: 0000000000000000 R09: ffffffff89cfecc3
> R10: fffffbfff139fd98 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000001 R14: dffffc0000000000 R15: ffff8880a801be00
> FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004c8e48 CR3: 00000000a4c08000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  pcpu_destroy_chunk mm/percpu-vm.c:366 [inline]
>  __pcpu_balance_workfn mm/percpu.c:1982 [inline]
>  pcpu_balance_workfn+0x8b3/0x1310 mm/percpu.c:2069
>  process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
>  kthread+0x3b5/0x4a0 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> Modules linked in:
> ---[ end trace 6a2e56ec52e1f480 ]---
> RIP: 0010:free_vm_area mm/vmalloc.c:3089 [inline]
> RIP: 0010:free_vm_area mm/vmalloc.c:3085 [inline]
> RIP: 0010:pcpu_free_vm_areas+0x96/0xc0 mm/vmalloc.c:3432
> Code: 75 48 48 8b 2b 48 8d 7d 08 48 89 f8 48 c1 e8 03 42 80 3c 30 00 75 2c 48 8b 7d 08 e8 c4 c8 ff ff 48 39 c5 74 a5 e8 ea c3 c9 ff <0f> 0b e8 e3 c3 c9 ff 4c 89 ff 5b 5d 41 5c 41 5d 41 5e 41 5f e9 71
> RSP: 0018:ffffc90000d2fba8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff8880a801be00 RCX: 0000000000000000
> RDX: ffff8880a95fa300 RSI: ffffffff81aa7c76 RDI: 0000000000000001
> RBP: ffff8880a2b38180 R08: 0000000000000000 R09: ffffffff89cfecc3
> R10: fffffbfff139fd98 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000001 R14: dffffc0000000000 R15: ffff8880a801be00
> FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004c8e48 CR3: 00000000a4c08000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
That is because of below revert:

<snip>
commit bdbfb1d52d5e576c1d275fd8ab59b677011229e8
Author: Ingo Molnar <mingo@kernel.org>
Date:   Sun Jun 7 21:12:51 2020 +0200

    Revert "mm/vmalloc: modify struct vmap_area to reduce its size"
    
    This reverts commit 688fcbfc06e4fdfbb7e1d5a942a1460fe6379d2d.
    
    Signed-off-by: Ingo Molnar <mingo@kernel.org>
    
    Conflicts:
            mm/vmalloc.c
<snip>

I can check further, but it can be it was not correctly reverted,
because everything should work just fine even with the revert,
though i i do not understand a reason of reverting.

--
Vlad Rezki
