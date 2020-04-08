Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFF5C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A0D206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoHSrUkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgDHPOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:14:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21652 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgDHPOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586358894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TJeMdbTy3cMpSAoamRCGFt+rciLmP7XVo2sGTxDbgbE=;
        b=GoHSrUkkSJXAMAue1GEMlkTgl3+r2gAC6/vLbwst9+aYv6S4+r6SEYzQTvi79quDFsTu4a
        SWjPnwZwQtDX/+H0N+v/3pWQQhrqY2Eil+VqZnwfWsMiMNUhQX9ervYLvj95hOo11vN7gr
        4tYTBxGSw2G1G0sAKdeiXZOUjp0anaM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-9CJmfoDaMOadHkNS2gMD_A-1; Wed, 08 Apr 2020 11:14:50 -0400
X-MC-Unique: 9CJmfoDaMOadHkNS2gMD_A-1
Received: by mail-wm1-f71.google.com with SMTP id 72so204944wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 08:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TJeMdbTy3cMpSAoamRCGFt+rciLmP7XVo2sGTxDbgbE=;
        b=DhRVqdRpbsLaTLZM8FEEpvGa9jm2M/kmDggMhbQLJwIrsmZxEeeJQeSSrzn1pKRl9y
         H4bpNT8X8T7NDWWoByWcN8d7yGcuPDJ4FFv4OJKiohIhHE10cqzKsueAXxHS1OiQikWs
         dIf4Kouk2+6mitHs7mr7L8LN8GVkndpxqNAtLQ9li3Y77oDfgMafWYDjbfaRFzFuW2TW
         Dkdc+Ic7ileeAI6FD+TOB34HkliatBiyYZCGRLyGTkZGWo90T11x8rcdtzikS/44z36c
         2mLMMuXPN9e0faqs3GuztGWQgyEGjDK6mSSu0mp8QHJIDvDSpKE5deYUGapYaSaYUB0p
         xMkQ==
X-Gm-Message-State: AGi0PuajL+s91Trx2Ff9+CF8id97GQyS0OhzcH9c/sBGhwGaZne1X99j
        5t+PU80wrqt7Xozg5jfiwfwlLd4ZSwHeRsGH2cnDS9edmKK5PnBQz1LprngsOR2ayTOW3d7F/wO
        vCSgsUXYUFX7e2Hkt0MJ2AOaN
X-Received: by 2002:adf:90ea:: with SMTP id i97mr8796619wri.123.1586358889055;
        Wed, 08 Apr 2020 08:14:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypI3uYYtxDBN3t1CujoBSI5yFF59WsvCO4fkf1V+yLa+AkNhg5OAiXAbwgTplABnky3zmdbgSQ==
X-Received: by 2002:adf:90ea:: with SMTP id i97mr8796599wri.123.1586358888818;
        Wed, 08 Apr 2020 08:14:48 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
        by smtp.gmail.com with ESMTPSA id c190sm7389476wme.10.2020.04.08.08.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 08:14:48 -0700 (PDT)
Date:   Wed, 8 Apr 2020 11:14:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+a95c7753605c9d219466@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, bgeffon@google.com,
        dvhart@infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Subject: Re: general protection fault in get_futex_key
Message-ID: <20200408151443.GF66033@xz-x1>
References: <0000000000008250f105a2c4ade1@google.com>
 <87mu7mayky.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mu7mayky.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 03:36:45PM +0200, Thomas Gleixner wrote:
> syzbot <syzbot+a95c7753605c9d219466@syzkaller.appspotmail.com> writes:
> > syzbot found the following crash on:
> >
> > HEAD commit:    763dede1 Merge tag 'for-linus-5.7-rc1' of git://git.kernel..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=136a055de00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=12205d036cec317f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a95c7753605c9d219466
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1578287de00000
> >
> > The bug was bisected to:
> >
> > commit 4426e945df588f2878affddf88a51259200f7e29
> > Author: Peter Xu <peterx@redhat.com>
> > Date:   Thu Apr 2 04:08:49 2020 +0000
> >
> >     mm/gup: allow VM_FAULT_RETRY for multiple times
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1707878fe00000
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=1487878fe00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1087878fe00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+a95c7753605c9d219466@syzkaller.appspotmail.com
> > Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
> >
> > general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> > CPU: 1 PID: 8869 Comm: syz-executor.1 Not tainted 5.6.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
> > RIP: 0010:compound_head include/linux/page-flags.h:174 [inline]
> > RIP: 0010:get_futex_key+0x2cd/0x1670 kernel/futex.c:574
> 
> This means that
> 
>      get_user_pages_fast(address, 1, FOLL_WRITE, &page)
> 
> returned 0, which is breaking the interface:
> 
>  * Returns number of pages pinned. This may be fewer than the number requested.
>  * If nr_pages is 0 or negative, returns 0. If no pages were pinned, returns
>  * -errno.
> 
> nr_pages is clearly 1. So if the call fails, the number of pinned pages
> is 0 and it should return a proper error number. It did before.
> 
> From a quick look at the commit in question I assume it's the
> 
> +               if (fatal_signal_pending(current))
> +                       break;
> 
> which can cause that to happen.

Right, sorry for the mess.

Hillf has posted a fix already in the other thread (with you CCed).
So I'm marking this one as a dup now.

#syz dup: WARNING in af_alg_make_sg

Thanks,

-- 
Peter Xu

