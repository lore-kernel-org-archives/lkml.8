Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A2C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CD820753
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586215284;
	bh=7Ms6k7vtj1LGpAsupPTDHj5cgP4OjIyU8/7ZqN55Tv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mhU8HhxMv+9Z/5hSjMFWjQs56KspOX3EhT9AmFA0n0HN1QQ1zxdz6zNhVOrkREfML
	 62PEFOS/oSpTuhpeu0QpI3X6pIcAh7oFqeucZ+nnyLGpZSSrK/4VpZttWSps0RPUlG
	 ra2yZZX4qZy3xSFjSEy/9Ib5IxRJO5Ef1+ANRGVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgDFXVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgDFXVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 19:21:19 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD3222078A;
        Mon,  6 Apr 2020 23:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586215279;
        bh=7Ms6k7vtj1LGpAsupPTDHj5cgP4OjIyU8/7ZqN55Tv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BtcbEpOg2S7UQrlZkniHtdpdYViLO04qm5l7mcnwA9YIYgNIs1O6CuYU9D13XWHeN
         YXuxhQt2K9UcLXVEGCbTfy4Gbq7Tyh/K/QKBaa5Ayte7V6LM1k0Tq0QuRUMLKVGO+z
         i4kJJOeSewsoOmEYuX85HsoEUR9LZFU6DUhBzjwE=
Date:   Mon, 6 Apr 2020 16:21:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+b4501d3e966ff59f6090@syzkaller.appspotmail.com>
Cc:     bgeffon@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, peterx@redhat.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Subject: Re: KASAN: user-memory-access Read in put_page
Message-Id: <20200406162118.4a91d61e8f506a9e728339f4@linux-foundation.org>
In-Reply-To: <00000000000021008f05a2a34336@google.com>
References: <00000000000021008f05a2a34336@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Apr 2020 11:16:13 -0700 syzbot <syzbot+b4501d3e966ff59f6090@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    bef7b2a7 Merge tag 'devicetree-for-5.7' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16940efbe00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f72ba8a207627d60
> dashboard link: https://syzkaller.appspot.com/bug?extid=b4501d3e966ff59f6090
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d79efbe00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1705901be00000
> 
> The bug was bisected to:
> 
> commit 4426e945df588f2878affddf88a51259200f7e29
> Author: Peter Xu <peterx@redhat.com>
> Date:   Thu Apr 2 04:08:49 2020 +0000
> 
>     mm/gup: allow VM_FAULT_RETRY for multiple times
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1441b1fbe00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1641b1fbe00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1241b1fbe00000

Thanks.  This looks like a duplicate of your report
syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com ("BUG: unable to
handle kernel paging request in kernel_get_mempolicy").

The bisection is believable but I can't spot why 4426e945df58 would
have messed up get_user_pages_locked() in this fashion - I've asked
Peter to take a look.

