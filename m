Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D65DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6920221775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="HxkaKcaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgGTJI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgGTJI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:08:27 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2CDC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:08:27 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so19413087ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sh4MS3jUQIDrJLd4vHFPdZZzioXde4EYbE1HOPlh13U=;
        b=HxkaKcaN9yT2V7ZbAje7mzcMt/z6ba8T1u+k3mhy7wc0R6NzOoX+e2SOu89cEy0t9G
         nxR/Uf4XRe7rYBwENYitIi81YRTrMri/Ek7LRwQxg5chHBQsXwnTn269HZgi7dUptGje
         ARy/c/1/26H0oqgs5V1LTsU7ptGY2gzSrPrQQhK7ILynxD+PBzB8UlEyTJjfHKDHBQXN
         SmT89qTrR23UT9QaZ1JYGpS5Wxn6e0xyjZkzo8xDo2x/ehnyZHZ/bYNrd5THVvDjNjpE
         s6lyEEv8WcDjfaSh4RDNhFg1SOC2qyOi8BLgqG+/jNPV060oPMDOyJp+8sq2NYp2wPQx
         yWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sh4MS3jUQIDrJLd4vHFPdZZzioXde4EYbE1HOPlh13U=;
        b=rYbunJ+j5BRBllhVrkua5eiQLhS5t/mJn2h3wiGYPhY1XbJN8viord5P/ZANeXIp63
         YLa3gXCgQifZ7nhAOrUhF9Qnzzeih+yWhyDQn1UkDO+6g3l0cWPkLXI/pLlOxcOWhsoF
         Z1fBfKP2Dn3q09BUHgeZmn7buAOjua2x4mV9jgLXriARDHuZfnm/dbxBbPTycgP4vndB
         5qYecu0ZbGx8tx4lbGAVRL7OA4sE3Yk8CSIUxb+1RfvCOvDw09+anbqIwgF2yGdsPiX9
         bh7AruTg3tE0INVjO/9WC5zK+J/HFXA6WDHpqSxhMZXrYxyGxkWI60yVV+PxyJh8PFrL
         njrQ==
X-Gm-Message-State: AOAM530IpQAO0hlrSjcAe7DfNKGVz1Y5r1Wn8NKGKAVPIiCmQuLuvJhH
        TvLTJm+ICUI4pe2eLuXxQnLhYw==
X-Google-Smtp-Source: ABdhPJz8cpXNQtuNgua8Q/5kP+FMbyffG/YjFwU9hrEck7Rn4UUhQj4nSis1VJgGu6O/8JzycIR6SQ==
X-Received: by 2002:a2e:961a:: with SMTP id v26mr10549143ljh.467.1595236105719;
        Mon, 20 Jul 2020 02:08:25 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b11sm3661070lfa.50.2020.07.20.02.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:08:25 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 09F0F102393; Mon, 20 Jul 2020 12:08:25 +0300 (+03)
Date:   Mon, 20 Jul 2020 12:08:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+ed318e8b790ca72c5ad0@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Song Liu <songliubraving@fb.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        syzkaller-bugs@googlegroups.com,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: general protection fault in khugepaged
Message-ID: <20200720090824.gjg4bay2pnnurasm@box>
References: <000000000000358aec05a9fc8aa8@google.com>
 <20200718085409.1448-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718085409.1448-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 04:54:09PM +0800, Hillf Danton wrote:
> 
> Wed, 08 Jul 2020 23:43:19 -0700
> > syzbot found the following crash on:
> > 
> > HEAD commit:    e44f65fd xen-netfront: remove redundant assignment to vari..
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15de54a7100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=829871134ca5e230
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ed318e8b790ca72c5ad0
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113406a7100000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175597d3100000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+ed318e8b790ca72c5ad0@syzkaller.appspotmail.com
> > 
> > general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > CPU: 1 PID: 1155 Comm: khugepaged Not tainted 5.8.0-rc2-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:anon_vma_lock_write include/linux/rmap.h:120 [inline]
> > RIP: 0010:collapse_huge_page mm/khugepaged.c:1110 [inline]
> > RIP: 0010:khugepaged_scan_pmd mm/khugepaged.c:1349 [inline]
> > RIP: 0010:khugepaged_scan_mm_slot mm/khugepaged.c:2110 [inline]
> > RIP: 0010:khugepaged_do_scan mm/khugepaged.c:2193 [inline]
> > RIP: 0010:khugepaged+0x3bba/0x5a10 mm/khugepaged.c:2238
> > Code: 01 00 00 48 8d bb 88 00 00 00 48 89 f8 48 c1 e8 03 42 80 3c 30 00 0f 85 fa 0f 00 00 48 8b 9b 88 00 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 d4 0f 00 00 48 8b 3b 48 83 c7 08 e8 9f ff 30
> > RSP: 0018:ffffc90004be7c80 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81a72d8b
> > RDX: ffff8880a69d8100 RSI: ffffffff81b7606b RDI: ffff88809f0577c0
> > RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8881ff213a7f
> > R10: 0000000000000080 R11: 0000000000000000 R12: ffffffff8aae6110
> > R13: ffffc90004be7de0 R14: dffffc0000000000 R15: 0000000020000000
> > FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000000 CR3: 00000001fe0cf000 CR4: 00000000001406e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  kthread+0x3b5/0x4a0 kernel/kthread.c:291
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
> 
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")

It looks sane, but I think it's easier to check in
hugepage_vma_revalidate(). Something like this (untested):

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b043c40a21d4..700f5160f3e4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -958,6 +958,9 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 		return SCAN_ADDRESS_RANGE;
 	if (!hugepage_vma_check(vma, vma->vm_flags))
 		return SCAN_VMA_CHECK;
+	/* Anon VMA expected */
+	if (!vma->anon_vma || vma->vm_ops)
+		return SCAN_VMA_CHECK;
 	return 0;
 }
 
-- 
 Kirill A. Shutemov
