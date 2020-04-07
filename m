Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0776C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9315D206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgMD0qA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDGB1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:27:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48652 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726230AbgDGB1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586222831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nf5jW9RoZc+0Y98kzhpBrjzN6A2pniU7HhVOPJWHcuI=;
        b=TgMD0qA8YhtZ/wAf872vkhOCfjNIfKB/6fJmBN+b1sNKGMxqlOVBj516SDHOKaTn3k+jMC
        y1NkK2DvGftXuorCcQ0ZfGC0b9/oUsIqUs9f/+F9tRFHOSqH+GEODGKhIdvGEoAcJwyty+
        ewb+WGBdOLlzwhuN6eAvHgCVAB9j/Wo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-jrbYgikaP4iDbIlpM8NIcw-1; Mon, 06 Apr 2020 21:27:06 -0400
X-MC-Unique: jrbYgikaP4iDbIlpM8NIcw-1
Received: by mail-qt1-f199.google.com with SMTP id i17so1717811qtv.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nf5jW9RoZc+0Y98kzhpBrjzN6A2pniU7HhVOPJWHcuI=;
        b=LR580eSm0Cx0QMzYxVep1/tVfecuE2pSroqbMFUKRJIxU+GQE17NKmBiTOvD+0ikzX
         PAd2tXPP3GtE5EwnBkI6ZO4vjSUsUVdI7kMC9yASHPrvcNf4jYlASwv4Yo3rC8uuRT2B
         AX47Zz5NN+QFcWp55HtQ3RRQGEcwmKppnlOc/voxWaiCBM4oU18rpFdlYo5nlUxdopgG
         /M89gCX1Zf2YEEEq88ZMJD03UgcIdwxmLWXzCHZJaAfaWjeDs8bu0+mNmn0b+2be9ei7
         dLYztJPt9rmwJWHk+3ED342cmeLaUfCyThXew34btM7b5CvFLnViYE1L1hGgJgF295kX
         NhBQ==
X-Gm-Message-State: AGi0PubhGxg+AQsysXz7X9n2A9+cumyWFXkiJE/1+lhhNRBEr0/77vzC
        4MUqIS1iLTim5MhCm8vwO6xV1+pxIO3JM3BZDtpryrjKyDPXsft0MLY1A3bdO4jtUHfaObkYqc6
        LEgOtqY0MLg16RHGNIVu1Zl3s
X-Received: by 2002:a37:7605:: with SMTP id r5mr22068455qkc.345.1586222825786;
        Mon, 06 Apr 2020 18:27:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypLM+9o9ltbUoGCyqrkG3LiEzTmJ90mfmcrTF1QhfJVUS/+EV+t7IeANPaljL1rfMIVtJ8i3DA==
X-Received: by 2002:a37:7605:: with SMTP id r5mr22068439qkc.345.1586222825422;
        Mon, 06 Apr 2020 18:27:05 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
        by smtp.gmail.com with ESMTPSA id n63sm15829720qka.80.2020.04.06.18.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:27:04 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:27:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     syzbot <syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, bgeffon@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Subject: Re: BUG: unable to handle kernel paging request in
 kernel_get_mempolicy
Message-ID: <20200407012702.GB48345@xz-x1>
References: <0000000000002b25f105a2a3434d@google.com>
 <20200407004745.GA48345@xz-x1>
 <3ff20c8a-5a26-5e38-42f7-ec751735d47c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ff20c8a-5a26-5e38-42f7-ec751735d47c@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 06:05:54PM -0700, Randy Dunlap wrote:
> On 4/6/20 5:47 PM, Peter Xu wrote:
> > On Mon, Apr 06, 2020 at 11:16:13AM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    bef7b2a7 Merge tag 'devicetree-for-5.7' of git://git.kerne..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=13966e8fe00000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=91b674b8f0368e69
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=693dc11fcb53120b5559
> >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1738b02be00000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d2c76de00000
> >>
> >> The bug was bisected to:
> >>
> >> commit 4426e945df588f2878affddf88a51259200f7e29
> >> Author: Peter Xu <peterx@redhat.com>
> >> Date:   Thu Apr 2 04:08:49 2020 +0000
> >>
> >>     mm/gup: allow VM_FAULT_RETRY for multiple times
> >>
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ac4a5de00000
> >> final crash:    https://syzkaller.appspot.com/x/report.txt?x=16ac4a5de00000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=12ac4a5de00000
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
> >> Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
> >>
> >> BUG: unable to handle page fault for address: ffffffff00000000
> >> #PF: supervisor read access in kernel mode
> >> #PF: error_code(0x0000) - not-present page
> >> PGD 987c067 P4D 987c067 PUD 0 
> >> Oops: 0000 [#1] PREEMPT SMP KASAN
> >> CPU: 1 PID: 7181 Comm: syz-executor616 Not tainted 5.6.0-syzkaller #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >> RIP: 0010:page_to_nid include/linux/mm.h:1245 [inline]
> >> RIP: 0010:lookup_node mm/mempolicy.c:906 [inline]
> >> RIP: 0010:do_get_mempolicy mm/mempolicy.c:970 [inline]
> >> RIP: 0010:kernel_get_mempolicy+0x60e/0xfb0 mm/mempolicy.c:1615
> >> Code: 88 00 07 00 00 e8 b2 35 c5 ff 4c 8b 7c 24 78 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 fb 08 00 00 <49> 8b 1f 48 c7 c7 ff ff ff ff 48 89 de e8 10 37 c5 ff 48 83 fb ff
> >> RSP: 0018:ffffc900018d7de8 EFLAGS: 00010246
> >> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81adaaf1
> >> RDX: 1fffffffe0000000 RSI: ffffffff81adaafe RDI: 0000000000000005
> >> RBP: 0000000000000000 R08: ffff88808de924c0 R09: ffffed1011bd2499
> >> R10: ffff88808de924c7 R11: ffffed1011bd2498 R12: 0000000000000000
> >> R13: 1ffff9200031afc4 R14: ffffffff89a6df60 R15: ffffffff00000000
> >> FS:  00007f848cd4a700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: ffffffff00000000 CR3: 00000000a7a8d000 CR4: 00000000001406e0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>  __do_sys_get_mempolicy mm/mempolicy.c:1633 [inline]
> >>  __se_sys_get_mempolicy mm/mempolicy.c:1629 [inline]
> >>  __x64_sys_get_mempolicy+0xba/0x150 mm/mempolicy.c:1629
> >>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> >> RIP: 0033:0x446719
> >> Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> >> RSP: 002b:00007f848cd49db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ef
> >> RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446719
> >> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> >> RBP: 00000000006dbc20 R08: 0000000000000003 R09: 0000000000000000
> >> R10: 000000002073b000 R11: 0000000000000246 R12: 00000000006dbc2c
> >> R13: 00007ffcfe6ba66f R14: 00007f848cd4a9c0 R15: 20c49ba5e353f7cf
> >> Modules linked in:
> >> CR2: ffffffff00000000
> >> ---[ end trace 0becf554e06291c3 ]---
> >> RIP: 0010:page_to_nid include/linux/mm.h:1245 [inline]
> >> RIP: 0010:lookup_node mm/mempolicy.c:906 [inline]
> >> RIP: 0010:do_get_mempolicy mm/mempolicy.c:970 [inline]
> >> RIP: 0010:kernel_get_mempolicy+0x60e/0xfb0 mm/mempolicy.c:1615
> >> Code: 88 00 07 00 00 e8 b2 35 c5 ff 4c 8b 7c 24 78 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 fb 08 00 00 <49> 8b 1f 48 c7 c7 ff ff ff ff 48 89 de e8 10 37 c5 ff 48 83 fb ff
> >> RSP: 0018:ffffc900018d7de8 EFLAGS: 00010246
> >> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81adaaf1
> >> RDX: 1fffffffe0000000 RSI: ffffffff81adaafe RDI: 0000000000000005
> >> RBP: 0000000000000000 R08: ffff88808de924c0 R09: ffffed1011bd2499
> >> R10: ffff88808de924c7 R11: ffffed1011bd2498 R12: 0000000000000000
> >> R13: 1ffff9200031afc4 R14: ffffffff89a6df60 R15: ffffffff00000000
> >> FS:  00007f848cd4a700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: ffffffff00000000 CR3: 00000000a7a8d000 CR4: 00000000001406e0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > 
> > Hi, Andrew & all,
> > 
> > I can reproduce this locally right after I run the test program, and
> > below patch fixed it for me - the test program can run with quite a
> > few minutes without crashing again.
> > 
> > Is there a way I can feed this to the syzbot to re-verify this?
> 
> Hi Peter,
> 
> Send the patch. At the top of the email, put something like
> #syz test <git repo> <branch>
> 
> It's documented here:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md

Thanks Randy.

#syz test https://github.com/xzpeter/linux.git 23800bff6fa346a4e9b3806dc0cfeb74498df757

> 
> 
> > Thanks,
> > 
> > 8<---------------------------------------------------------------
> > From 23800bff6fa346a4e9b3806dc0cfeb74498df757 Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Mon, 6 Apr 2020 20:40:13 -0400
> > Subject: [PATCH] mm/mempolicy: Allow lookup_node() to handle fatal signal
> > 
> > lookup_node() uses gup to pin the page and get node information.  It
> > checks against ret>=0 assuming the page will be filled in.  However
> > it's also possible that gup will return zero, for example, when the
> > thread is quickly killed with a fatal signal.  Teach lookup_node() to
> > gracefully return an error -EFAULT if it happens.
> > 
> > Reported-by: syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
> > Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/mempolicy.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 5fb427aed612..1398578db025 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -902,7 +902,10 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
> >  
> >  	int locked = 1;
> >  	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
> > -	if (err >= 0) {
> > +	if (err == 0) {
> > +		/* E.g. GUP interupted by fatal signal */
> > +		err = -EFAULT;
> > +	} else if (err > 0) {
> >  		err = page_to_nid(p);
> >  		put_page(p);
> >  	}
> > 
> 
> 
> 
> -- 
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> 

-- 
Peter Xu

