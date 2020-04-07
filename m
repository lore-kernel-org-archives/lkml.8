Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F91C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A951B20857
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DhaBvZH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgDGBF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:05:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGBF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=3xxAe2yWU4Dhao/aGkTFZwfTyEWedDBbBqDJs5a6MO8=; b=DhaBvZH19vzsCtAYDfc0q+v8/r
        WPde3Rt8dzs949L/EmbRu7jBiHpS+akrP+ilMUO7mB0kkuqo48Cku1HazMrPSpzJJ9U6T9bu93sFg
        1ypYtDqIvMFNwyJHhPo5V/q1yQ7yMu+/bkLcCtnqKleBE1tecjnsI9qb25vwCAWef1hH82wYg9ErU
        HtpPoVu6I6TNQvDiiJCdNK/g06hXVOUEFWKGjlXJAdZCpIw/9XxypRO7ChK43t/X01icqnvsep5lv
        bMTHfeoEvIxOshJ/Y7VF656Wr4M1F+tez6d+E0G5IH8iTxeynxbJ8oPuPjaAtkRN+lc5bkYah2qqX
        hdT1kdiw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLcge-0005Bv-D0; Tue, 07 Apr 2020 01:05:56 +0000
Subject: Re: BUG: unable to handle kernel paging request in
 kernel_get_mempolicy
To:     Peter Xu <peterx@redhat.com>,
        syzbot <syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, bgeffon@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
References: <0000000000002b25f105a2a3434d@google.com>
 <20200407004745.GA48345@xz-x1>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3ff20c8a-5a26-5e38-42f7-ec751735d47c@infradead.org>
Date:   Mon, 6 Apr 2020 18:05:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407004745.GA48345@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/20 5:47 PM, Peter Xu wrote:
> On Mon, Apr 06, 2020 at 11:16:13AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    bef7b2a7 Merge tag 'devicetree-for-5.7' of git://git.kerne..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13966e8fe00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=91b674b8f0368e69
>> dashboard link: https://syzkaller.appspot.com/bug?extid=693dc11fcb53120b5559
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1738b02be00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d2c76de00000
>>
>> The bug was bisected to:
>>
>> commit 4426e945df588f2878affddf88a51259200f7e29
>> Author: Peter Xu <peterx@redhat.com>
>> Date:   Thu Apr 2 04:08:49 2020 +0000
>>
>>     mm/gup: allow VM_FAULT_RETRY for multiple times
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ac4a5de00000
>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=16ac4a5de00000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12ac4a5de00000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
>> Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
>>
>> BUG: unable to handle page fault for address: ffffffff00000000
>> #PF: supervisor read access in kernel mode
>> #PF: error_code(0x0000) - not-present page
>> PGD 987c067 P4D 987c067 PUD 0 
>> Oops: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 1 PID: 7181 Comm: syz-executor616 Not tainted 5.6.0-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> RIP: 0010:page_to_nid include/linux/mm.h:1245 [inline]
>> RIP: 0010:lookup_node mm/mempolicy.c:906 [inline]
>> RIP: 0010:do_get_mempolicy mm/mempolicy.c:970 [inline]
>> RIP: 0010:kernel_get_mempolicy+0x60e/0xfb0 mm/mempolicy.c:1615
>> Code: 88 00 07 00 00 e8 b2 35 c5 ff 4c 8b 7c 24 78 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 fb 08 00 00 <49> 8b 1f 48 c7 c7 ff ff ff ff 48 89 de e8 10 37 c5 ff 48 83 fb ff
>> RSP: 0018:ffffc900018d7de8 EFLAGS: 00010246
>> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81adaaf1
>> RDX: 1fffffffe0000000 RSI: ffffffff81adaafe RDI: 0000000000000005
>> RBP: 0000000000000000 R08: ffff88808de924c0 R09: ffffed1011bd2499
>> R10: ffff88808de924c7 R11: ffffed1011bd2498 R12: 0000000000000000
>> R13: 1ffff9200031afc4 R14: ffffffff89a6df60 R15: ffffffff00000000
>> FS:  00007f848cd4a700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffffff00000000 CR3: 00000000a7a8d000 CR4: 00000000001406e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  __do_sys_get_mempolicy mm/mempolicy.c:1633 [inline]
>>  __se_sys_get_mempolicy mm/mempolicy.c:1629 [inline]
>>  __x64_sys_get_mempolicy+0xba/0x150 mm/mempolicy.c:1629
>>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
>>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
>> RIP: 0033:0x446719
>> Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007f848cd49db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ef
>> RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446719
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: 00000000006dbc20 R08: 0000000000000003 R09: 0000000000000000
>> R10: 000000002073b000 R11: 0000000000000246 R12: 00000000006dbc2c
>> R13: 00007ffcfe6ba66f R14: 00007f848cd4a9c0 R15: 20c49ba5e353f7cf
>> Modules linked in:
>> CR2: ffffffff00000000
>> ---[ end trace 0becf554e06291c3 ]---
>> RIP: 0010:page_to_nid include/linux/mm.h:1245 [inline]
>> RIP: 0010:lookup_node mm/mempolicy.c:906 [inline]
>> RIP: 0010:do_get_mempolicy mm/mempolicy.c:970 [inline]
>> RIP: 0010:kernel_get_mempolicy+0x60e/0xfb0 mm/mempolicy.c:1615
>> Code: 88 00 07 00 00 e8 b2 35 c5 ff 4c 8b 7c 24 78 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 fb 08 00 00 <49> 8b 1f 48 c7 c7 ff ff ff ff 48 89 de e8 10 37 c5 ff 48 83 fb ff
>> RSP: 0018:ffffc900018d7de8 EFLAGS: 00010246
>> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81adaaf1
>> RDX: 1fffffffe0000000 RSI: ffffffff81adaafe RDI: 0000000000000005
>> RBP: 0000000000000000 R08: ffff88808de924c0 R09: ffffed1011bd2499
>> R10: ffff88808de924c7 R11: ffffed1011bd2498 R12: 0000000000000000
>> R13: 1ffff9200031afc4 R14: ffffffff89a6df60 R15: ffffffff00000000
>> FS:  00007f848cd4a700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffffff00000000 CR3: 00000000a7a8d000 CR4: 00000000001406e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> Hi, Andrew & all,
> 
> I can reproduce this locally right after I run the test program, and
> below patch fixed it for me - the test program can run with quite a
> few minutes without crashing again.
> 
> Is there a way I can feed this to the syzbot to re-verify this?

Hi Peter,

Send the patch. At the top of the email, put something like
#syz test <git repo> <branch>

It's documented here:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md


> Thanks,
> 
> 8<---------------------------------------------------------------
> From 23800bff6fa346a4e9b3806dc0cfeb74498df757 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Mon, 6 Apr 2020 20:40:13 -0400
> Subject: [PATCH] mm/mempolicy: Allow lookup_node() to handle fatal signal
> 
> lookup_node() uses gup to pin the page and get node information.  It
> checks against ret>=0 assuming the page will be filled in.  However
> it's also possible that gup will return zero, for example, when the
> thread is quickly killed with a fatal signal.  Teach lookup_node() to
> gracefully return an error -EFAULT if it happens.
> 
> Reported-by: syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
> Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/mempolicy.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 5fb427aed612..1398578db025 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -902,7 +902,10 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
>  
>  	int locked = 1;
>  	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
> -	if (err >= 0) {
> +	if (err == 0) {
> +		/* E.g. GUP interupted by fatal signal */
> +		err = -EFAULT;
> +	} else if (err > 0) {
>  		err = page_to_nid(p);
>  		put_page(p);
>  	}
> 



-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
