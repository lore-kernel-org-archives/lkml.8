Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A26CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4863E20888
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Ao3RzKlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGXLGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXLGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:06:52 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031ADC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:06:52 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so9574021ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jXKeQslkasCGkmiEJGidKnpn3jO+QvFwQKxgsuZWyAc=;
        b=Ao3RzKlqG+lt/BTEdOxeRYjmWkjieqGJezqGQDakjEheTqlpUKoxAuhTjkN145Jp55
         fITq5JMnaJG5iNXFxc+xh9Ww/pWKzPmFBVm0Z0KtAXikP4xgkZSUzbhuffXo5YO0pke8
         1+P1GrE6v4r0LUjPmvpoG1b+EAOGaeaIy8GwlvGUM5GjDrYjNFhH0IE0YN5tEGhQldnh
         gH8g2gyDCFncUoZOMpXHuJNB/MKThF/T129YwncGEZPszLhkzE16Dv4UearzI1kSny3E
         0ExSPjJi9nU6OJ6VIfFLS/s4Py3VBgqmPMxPKhpvoNDYEqI61qbTO6rAb5W1X2ZK+hGN
         PRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jXKeQslkasCGkmiEJGidKnpn3jO+QvFwQKxgsuZWyAc=;
        b=gWqK5D8Kn4X4e+64upGCNNJ3wjqZtAO5WnlC9bqSS9gDhgtOPVr0TU2gsjSaUT3wBE
         QxqR58QlDCjczaPZ6z894AJwZwYF5KFTqCroR60wo1HXoN4tsF26YsQHCKbpWLAikTXK
         PL1cPLkL+cqiShQeKnfC6DILt6Od6KdHAaxdQPN32dsoHvpuelVCHXoCcvhA/QdPvmwW
         20atskeaUoBhblnD7NPdZsWH/ZUWch6agPyCZ5CXSGHdpxgrdxEKIGh40J4x+5LEOnqI
         X4+NjXwLA+u5UFO/98G5X43RGc+nQlcz8WM82KTuhTA/DId4uG/yAzAU0gfu76Hvtuyv
         bVSA==
X-Gm-Message-State: AOAM530DkU168OonelX24K9+Xfx8xg7usN45KI3IqLyCOMD0hCzFcsEq
        LeegY1EwdaEO8ztAewaMgnDNLg==
X-Google-Smtp-Source: ABdhPJwnoKc6x1hHROKOMLZMIFnWf7pq6WH7wkB0z51CZ6krgfsJCfbCu/8BZmPplohi/m4zN3PIeA==
X-Received: by 2002:a2e:8597:: with SMTP id b23mr3741829lji.338.1595588810431;
        Fri, 24 Jul 2020 04:06:50 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a1sm182479lfb.10.2020.07.24.04.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:06:49 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6930E101670; Fri, 24 Jul 2020 14:06:51 +0300 (+03)
Date:   Fri, 24 Jul 2020 14:06:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+ed318e8b790ca72c5ad0@syzkaller.appspotmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: general protection fault in khugepaged
Message-ID: <20200724110651.6yvcpse4emi2bdrm@box>
References: <000000000000358aec05a9fc8aa8@google.com>
 <20200718085409.1448-1-hdanton@sina.com>
 <20200720090824.gjg4bay2pnnurasm@box>
 <27C67962-55A0-4815-ABE3-7F71C5FDCE4D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27C67962-55A0-4815-ABE3-7F71C5FDCE4D@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:53:11PM +0000, Song Liu wrote:
> 
> 
> > On Jul 20, 2020, at 2:08 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > On Sat, Jul 18, 2020 at 04:54:09PM +0800, Hillf Danton wrote:
> >> 
> >> Wed, 08 Jul 2020 23:43:19 -0700
> >>> syzbot found the following crash on:
> >>> 
> >>> HEAD commit:    e44f65fd xen-netfront: remove redundant assignment to vari..
> >>> git tree:       net-next
> >>> console output: https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_x_log.txt-3Fx-3D15de54a7100000&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=dR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=MQfhDjE9yj2_juw34scN2XTASkKaxHCfKtrY5UlwTx4&s=6MfBZJE4yUynBic_FV4udh1WdM1wXz8vdcsOfuR23y0&e= 
> >>> kernel config:  https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_x_.config-3Fx-3D829871134ca5e230&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=dR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=MQfhDjE9yj2_juw34scN2XTASkKaxHCfKtrY5UlwTx4&s=KvhWD3PT9mC8iTIUtQGrMj2UJpBMlsmJOv_wx1kxkQQ&e= 
> >>> dashboard link: https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_bug-3Fextid-3Ded318e8b790ca72c5ad0&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=dR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=MQfhDjE9yj2_juw34scN2XTASkKaxHCfKtrY5UlwTx4&s=sLoGzpV5UcRyP33XaPaGp_NoxP6VSXh4jttnxne6n6I&e= 
> >>> compiler:       gcc (GCC) 10.1.0-syz 20200507
> >>> syz repro:      https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_x_repro.syz-3Fx-3D113406a7100000&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=dR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=MQfhDjE9yj2_juw34scN2XTASkKaxHCfKtrY5UlwTx4&s=HXYlOJ8r_Xv84UDkW6MSoEiG122ATfKJdhQlv3J7mao&e= 
> >>> C reproducer:   https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_x_repro.c-3Fx-3D175597d3100000&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=dR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=MQfhDjE9yj2_juw34scN2XTASkKaxHCfKtrY5UlwTx4&s=c5Vlm43NNztzFCNb0S6s8IKJuVUtEtm0yWwfV55CeAo&e= 
> >>> 
> >>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >>> Reported-by: syzbot+ed318e8b790ca72c5ad0@syzkaller.appspotmail.com
> >>> 
> >>> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> >>> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> >>> CPU: 1 PID: 1155 Comm: khugepaged Not tainted 5.8.0-rc2-syzkaller #0
> >>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >>> RIP: 0010:anon_vma_lock_write include/linux/rmap.h:120 [inline]
> >>> RIP: 0010:collapse_huge_page mm/khugepaged.c:1110 [inline]
> >>> RIP: 0010:khugepaged_scan_pmd mm/khugepaged.c:1349 [inline]
> >>> RIP: 0010:khugepaged_scan_mm_slot mm/khugepaged.c:2110 [inline]
> >>> RIP: 0010:khugepaged_do_scan mm/khugepaged.c:2193 [inline]
> >>> RIP: 0010:khugepaged+0x3bba/0x5a10 mm/khugepaged.c:2238
> >>> Code: 01 00 00 48 8d bb 88 00 00 00 48 89 f8 48 c1 e8 03 42 80 3c 30 00 0f 85 fa 0f 00 00 48 8b 9b 88 00 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 d4 0f 00 00 48 8b 3b 48 83 c7 08 e8 9f ff 30
> >>> RSP: 0018:ffffc90004be7c80 EFLAGS: 00010246
> >>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81a72d8b
> >>> RDX: ffff8880a69d8100 RSI: ffffffff81b7606b RDI: ffff88809f0577c0
> >>> RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8881ff213a7f
> >>> R10: 0000000000000080 R11: 0000000000000000 R12: ffffffff8aae6110
> >>> R13: ffffc90004be7de0 R14: dffffc0000000000 R15: 0000000020000000
> >>> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> >>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> CR2: 0000000000000000 CR3: 00000001fe0cf000 CR4: 00000000001406e0
> >>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>> Call Trace:
> >>> kthread+0x3b5/0x4a0 kernel/kthread.c:291
> >>> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
> >> 
> >> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> > 
> > It looks sane, but I think it's easier to check in
> > hugepage_vma_revalidate(). Something like this (untested):
> > 
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index b043c40a21d4..700f5160f3e4 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -958,6 +958,9 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> > 		return SCAN_ADDRESS_RANGE;
> > 	if (!hugepage_vma_check(vma, vma->vm_flags))
> > 		return SCAN_VMA_CHECK;
> > +	/* Anon VMA expected */
> > +	if (!vma->anon_vma || vma->vm_ops)
> > +		return SCAN_VMA_CHECK;
> > 	return 0;
> > }
> 
> Maybe move the new check to earlier in the function, say right after 
> we get the vma? 

Maybe. But we only protect against the race and it's not going to make a
difference for performance.

-- 
 Kirill A. Shutemov
