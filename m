Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B01C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 23:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C6220768
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 23:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZyiFe7G7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389938AbgDMXFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 19:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727968AbgDMXFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 19:05:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15527C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:05:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p8so5147056pgi.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SaYIPVdVhkuwIkFk3bD8dVzUALbztEKKAg5MczOboz4=;
        b=ZyiFe7G7sUH3t/FXMibHcdw2qi1c5uuDp4ZDgFg0g19BnSab16a84Jb4LmxhiInkEE
         McSbjf/verFYWGJU8uUvoaFRV5NFGYglKGROlDuJfZmJSJNxrU2iebn9yk8soxY98Rav
         Pe8Hg8Zd1cmLZnNPeyXcGnaVFu9VLSF8uilIBvWlzcEXMkgDs/MC4L6xhPqLTeOs91jK
         4SshxZcFAJK44CMgpWJ6WCZorqXu/yo09RPMglxPB908fISsw+fzEpjELb/oofhdBPqE
         GAEv2Cca4YkEWcrOTzPf6hIh3xf6Rln3+xZy6qxxxU3JC9+JSYB0AbpKfBi3/vpq1GM5
         PH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SaYIPVdVhkuwIkFk3bD8dVzUALbztEKKAg5MczOboz4=;
        b=nwB5QjYz+a1cU6WRavBcA/EDylhpbRtxfxJ6/3oHv4dpPAUBLT8PkK23pDNZJrjug3
         pe9lfk/EFxoz3GjNrXcHuuzMAVvhNMkbXVpgwv/Q1p6jcZtLvWpNed05DPlpHK6FQqY6
         XUOtrgRMTDHxPCpbdBGGruJTyPJbdriCveEoH7ecdvxv6ck0sv+6Pwk/PpbeuATdAEWO
         cguwl8e85EBOlPJeIKfv/kuqVBwAQR4dCJplTV7AzRS6nWpyw1h94NuSrVFSq2TJpa1D
         ny79T9vfvTL5xVCHZQOwNa2bR/93lTAamu6ssBizsvasSxNQpcaWFp4f5tdBuP8J3TXZ
         ROmg==
X-Gm-Message-State: AGi0PuZ0xydBnGkwy/MLGPRGyZ5jLJ0wXQ5YoHo2J0kEk+SMQ7RkRfGj
        e/8AQuyT0E4yAHDZr7HUHwOSWQ==
X-Google-Smtp-Source: APiQypJO0zJln+4gvdq7befp1YOEb6t/oNpeLU7apwyKi6R17OE/akQqz05npW/JCFIsnBG70E6xuA==
X-Received: by 2002:a63:575f:: with SMTP id h31mr5609253pgm.200.1586819107428;
        Mon, 13 Apr 2020 16:05:07 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id x25sm7289429pfm.203.2020.04.13.16.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 16:05:06 -0700 (PDT)
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <CACT4Y+bhQVcpSkSh_OZ5ZanfFZUqn2iypLhG_Z-nWKTkaYr1jw@mail.gmail.com>
 <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
 <20200410092951.6db32bfe@canb.auug.org.au>
 <7325374A-6072-44E4-85EE-F97FC7E8565F@lca.pw>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87e8c2e1-36b1-c56c-dd3b-43252343848c@kernel.dk>
Date:   Mon, 13 Apr 2020 17:05:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7325374A-6072-44E4-85EE-F97FC7E8565F@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/20 4:06 PM, Qian Cai wrote:
> 
> 
>> On Apr 9, 2020, at 7:29 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi Linus,
>>
>> On Thu, 9 Apr 2020 09:32:32 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>>
>>> On Thu, Apr 9, 2020 at 5:55 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>>>
>>>> linux-next is boot-broken for more than a month and bugs are piling
>>>> onto bugs, I've seen at least 3 different ones.
>>>> syzbot can't get any working linux-next build for testing for a very
>>>> long time now.  
>>>
>>> Ouch.
>>>
>>> Ok, that's not good. It means that linux-next has basically only done
>>> build-testing this whole cycle.
>>
>> Well, there are other CI's beyond syzbot .. Does syzbot only build/test
>> a single kernel arch/config?
>>
>>> Stephen, Dmitry - is there some way linux-next could possibly kick out
>>> trees more aggressively if syzbot can't even boot?
>>
>> Of course that could be done if I knew that there were problems.  From
>> memory and my mail archives, I was only cc'd on 3 problems by sysbot
>> since last November and they were all responded to by the appropriate
>> maintainers/developers.
>>
>> Currently, when I am cc'd on reports, if they are also sent to who
>> seem like the appropriate people, I just file the report assuming it
>> will be dealt with.
>>
>>> Kicking trees out of linux-next and making noise if they cause syzbot
>>> failures might also make some maintainers react more..
>>
>> That may be true, but in some cases I have carried fixups/reverts/older
>> versions of trees for quite some time before things get fixed.  But at
>> least if that happens, I do tend to remind people.
> 
> BTW, I’ll be adding fuzzers to my daily linux-next routines where it
> triggers this io_uring/scheduler bug almost immediately, so hopefully
> would buy syzbot some time to resume on linux-next.
> 
> [67493.516737][T211750] BUG: unable to handle page fault for address: ffffffffffffffe8
> [67493.557315][T211750] #PF: supervisor read access in kernel mode
> [67493.586726][T211750] #PF: error_code(0x0000) - not-present page
> [67493.614434][T211750] PGD f96e17067 P4D f96e17067 PUD f96e19067 PMD 0 
> [67493.644846][T211750] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> [67493.674127][T211750] CPU: 55 PID: 211750 Comm: trinity-c127 Tainted: G    B        L    5.7.0-rc1-next-20200413 #4
> [67493.722516][T211750] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 04/12/2017
> [67493.764925][T211750] RIP: 0010:__wake_up_common+0x98/0x290
> __wake_up_common at kernel/sched/wait.c:87
> [67493.790675][T211750] Code: 40 4d 8d 78 e8 49 8d 7f 18 49 39 fd 0f 84 80 00 00 00 e8 6b bd 2b 00 49 8b 5f 18 45 31 e4 48 83 eb 18 4c 89 ff e8 08 bc 2b 00 <45> 8b 37 41 f6 c6 04 75 71 49 8d 7f 10 e8 46 bd 2b 00 49 8b 47 10
> [67493.881650][T211750] RSP: 0018:ffffc9000adbfaf0 EFLAGS: 00010046
> [67493.909854][T211750] RAX: 0000000000000000 RBX: ffffffffffffffe8 RCX: ffffffffaa9636b8
> [67493.947131][T211750] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffffffffffffffe8
> [67493.983829][T211750] RBP: ffffc9000adbfb40 R08: fffffbfff582c5fd R09: fffffbfff582c5fd
> [67494.020861][T211750] R10: ffffffffac162fe3 R11: fffffbfff582c5fc R12: 0000000000000000
> [67494.059249][T211750] R13: ffff888ef82b0960 R14: ffffc9000adbfb80 R15: ffffffffffffffe8
> [67494.099699][T211750] FS:  00007fdcba4c4740(0000) GS:ffff889033780000(0000) knlGS:0000000000000000
> [67494.141858][T211750] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [67494.172660][T211750] CR2: ffffffffffffffe8 CR3: 0000000f776a0004 CR4: 00000000001606e0
> [67494.209760][T211750] Call Trace:
> [67494.224720][T211750]  __wake_up_common_lock+0xea/0x150
> (inlined by) __wake_up_common_lock at kernel/sched/wait.c:124
> [67494.248753][T211750]  ? __wake_up_common+0x290/0x290
> [67494.272014][T211750]  ? lockdep_hardirqs_on+0x16/0x2c0
> [67494.296139][T211750]  __wake_up+0x13/0x20
> [67494.314946][T211750]  io_cqring_ev_posted+0x75/0xe0
> (inlined by) io_cqring_ev_posted at fs/io_uring.c:1160
> [67494.337726][T211750]  io_ring_ctx_wait_and_kill+0x1c0/0x2f0
> io_ring_ctx_wait_and_kill at fs/io_uring.c:7305
> [67494.363840][T211750]  io_uring_create+0xa8d/0x13b0
> [67494.386526][T211750]  ? io_req_defer_prep+0x990/0x990
> [67494.410119][T211750]  ? __kasan_check_write+0x14/0x20
> [67494.433646][T211750]  io_uring_setup+0xb8/0x130
> [67494.454870][T211750]  ? io_uring_create+0x13b0/0x13b0
> [67494.478342][T211750]  ? check_flags.part.28+0x220/0x220
> [67494.502947][T211750]  ? lockdep_hardirqs_on+0x16/0x2c0
> [67494.526965][T211750]  __x64_sys_io_uring_setup+0x31/0x40
> [67494.551820][T211750]  do_syscall_64+0xcc/0xaf0
> [67494.574829][T211750]  ? syscall_return_slowpath+0x580/0x580
> [67494.604591][T211750]  ? lockdep_hardirqs_off+0x1f/0x140
> [67494.628901][T211750]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
> [67494.657616][T211750]  ? trace_hardirqs_off_caller+0x3a/0x150
> [67494.683999][T211750]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [67494.709982][T211750]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [67494.737167][T211750] RIP: 0033:0x7fdcb9dd76ed
> [67494.757698][T211750] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b 57 2c 00 f7 d8 64 89 01 48
> [67494.849485][T211750] RSP: 002b:00007ffe7fd4e4f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
> [67494.887906][T211750] RAX: ffffffffffffffda RBX: 00000000000001a9 RCX: 00007fdcb9dd76ed
> [67494.924754][T211750] RDX: fffffffffffffffc RSI: 0000000000000000 RDI: 0000000000005d54
> [67494.961516][T211750] RBP: 00000000000001a9 R08: 0000000e31d3caa7 R09: 0082400004004000
> [67494.998485][T211750] R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000002
> [67495.035510][T211750] R13: 00007fdcb842e058 R14: 00007fdcba4c46c0 R15: 00007fdcb842e000
> [67495.072679][T211750] Modules linked in: bridge stp llc nfnetlink cn brd vfat fat ext4 crc16 mbcache jbd2 loop kvm_intel kvm irqbypass intel_cstate intel_uncore dax_pmem intel_rapl_perf dax_pmem_core ip_tables x_tables xfs sd_mod tg3 firmware_class libphy hpsa scsi_transport_sas dm_mirror dm_region_hash dm_log dm_mod [last unloaded: binfmt_misc]
> [67495.221120][T211750] CR2: ffffffffffffffe8
> [67495.240237][T211750] ---[ end trace f9502383d57e0e22 ]---
> [67495.265301][T211750] RIP: 0010:__wake_up_common+0x98/0x290
> [67495.290903][T211750] Code: 40 4d 8d 78 e8 49 8d 7f 18 49 39 fd 0f 84 80 00 00 00 e8 6b bd 2b 00 49 8b 5f 18 45 31 e4 48 83 eb 18 4c 89 ff e8 08 bc 2b 00 <45> 8b 37 41 f6 c6 04 75 71 49 8d 7f 10 e8 46 bd 2b 00 49 8b 47 10
> [67495.382302][T211750] RSP: 0018:ffffc9000adbfaf0 EFLAGS: 00010046
> [67495.410551][T211750] RAX: 0000000000000000 RBX: ffffffffffffffe8 RCX: ffffffffaa9636b8
> [67495.447570][T211750] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffffffffffffffe8
> [67495.484252][T211750] RBP: ffffc9000adbfb40 R08: fffffbfff582c5fd R09: fffffbfff582c5fd
> [67495.521068][T211750] R10: ffffffffac162fe3 R11: fffffbfff582c5fc R12: 0000000000000000
> [67495.557461][T211750] R13: ffff888ef82b0960 R14: ffffc9000adbfb80 R15: ffffffffffffffe8
> [67495.594607][T211750] FS:  00007fdcba4c4740(0000) GS:ffff889033780000(0000) knlGS:0000000000000000
> [67495.639332][T211750] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [67495.669033][T211750] CR2: ffffffffffffffe8 CR3: 0000000f776a0004 CR4: 00000000001606e0
> [67495.704569][T211750] Kernel panic - not syncing: Fatal exception
> [67495.731758][T211750] Kernel Offset: 0x29800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [67495.784988][T211750] ---[ end Kernel panic - not syncing: Fatal exception ]—

This looks like it can happen if you fail setting up the ring (you
probably have some error injection enabled), and then
io_poll_remove_all() does an unconditional io_cqring_ev_posted() even if
we didn't post any events.

I think the best fix here is to ensure io_cqring_ev_posted() is only
called if we actually post events. If we did, we know for a fact that
rings have been setup.

I'll queue this up for 5.7.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5190bfb6a665..c0aa72e738b4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4342,7 +4342,7 @@ static void io_poll_remove_all(struct io_ring_ctx *ctx)
 {
 	struct hlist_node *tmp;
 	struct io_kiocb *req;
-	int i;
+	int posted = 0, i;
 
 	spin_lock_irq(&ctx->completion_lock);
 	for (i = 0; i < (1U << ctx->cancel_hash_bits); i++) {
@@ -4350,11 +4350,12 @@ static void io_poll_remove_all(struct io_ring_ctx *ctx)
 
 		list = &ctx->cancel_hash[i];
 		hlist_for_each_entry_safe(req, tmp, list, hash_node)
-			io_poll_remove_one(req);
+			posted += io_poll_remove_one(req);
 	}
 	spin_unlock_irq(&ctx->completion_lock);
 
-	io_cqring_ev_posted(ctx);
+	if (posted)
+		io_cqring_ev_posted(ctx);
 }
 
 static int io_poll_cancel(struct io_ring_ctx *ctx, __u64 sqe_addr)

-- 
Jens Axboe

