Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F60C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5C320720
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rv6fGgsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGOP3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgGOP3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:29:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55A0C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:29:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so6230571wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EXJMV5iRCMLH2HXuXT+6t4HwlcQ7buWBqLF62l76Ssc=;
        b=rv6fGgsa/fqNZXnc+Vd4O2EB0xnyzoEhI4JYVRHs2BAm2pjXQpY3kr2ZdZflldiAZ2
         zgNLE+FasvAEwV22Oo3TUbKJGjmHJr4X85cLdRJVHbbtsK4koJNlpCZAe7ZBH+Mj8W9Y
         4i3eQzr5HCDSI1vA/T0zh1CEO/ILRYCqMjzORTF4WrLha0QpjfvG5WROqpiJnnChesDJ
         yYKdt4miDOQwJ9TN4VqEaSH1LB1uegyEjvwKuTyZhuO9pAFr/t2yd/yVwavLtHFlb/7/
         28XIUE0vKEEXBS4MYbse3gSqrYHgkR6S1jqvbBpYnDWPiZ/sadLcPg5Z8ELEYzAdside
         UNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EXJMV5iRCMLH2HXuXT+6t4HwlcQ7buWBqLF62l76Ssc=;
        b=N7mW2vy20Vh+kKOc8oG0/wHDW6Zn8dDn3nryZeucg1ogOXN/A2MtHBSUXUZpqWbYBM
         Jkvx5VQfE149lsz2YhDp4CxjIxUWLW3+eVHhus4wof12Wq0oTdTfa1uBYET3uK4+3IGW
         Po/edvpccabFrNLzlvEZaYoKN1SPHS8KIMRFsOrSieXCqA+uwkXLcSIX7Lkxpmq48dTv
         5uQXNyL5epGQj4n/4n1uZZmVE/JnQpuxlj+JJvoTmRTNFknlCWwp7eiVJOunL2DhrHkV
         5q6qiGClNxr+GfpUtGsETPzPe9kHw04PnDYAaxaaPrJV5SPYgUa11YACRdGxTkTL7cA4
         6S4Q==
X-Gm-Message-State: AOAM532QpwwaoMiM28hjq3PSdX6F2p9GdfaRmaCXe0SS84TeBw1fyhkQ
        xBKeOHRcSanIDGYYlDGAtaaCrQ==
X-Google-Smtp-Source: ABdhPJya3f8YbYeTG5ERqXVaoJCA04bI255e9uB53ecJyyuyJJIHvx6NS9eAMRbOYHiOmVROn6OOtw==
X-Received: by 2002:a05:600c:2144:: with SMTP id v4mr50586wml.128.1594826959232;
        Wed, 15 Jul 2020 08:29:19 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id n125sm4060060wme.30.2020.07.15.08.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:29:18 -0700 (PDT)
Date:   Wed, 15 Jul 2020 17:29:12 +0200
From:   Marco Elver <elver@google.com>
To:     syzbot <syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: KCSAN: data-race in generic_file_buffered_read /
 generic_file_buffered_read
Message-ID: <20200715152912.GA2209203@elver.google.com>
References: <0000000000004a4d6505aa7c688a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004a4d6505aa7c688a@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 08:16AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e9919e11 Merge branch 'for-linus' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1217a83b100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=570eb530a65cd98e
> dashboard link: https://syzkaller.appspot.com/bug?extid=0f1e470df6a4316e0a11
> compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in generic_file_buffered_read / generic_file_buffered_read

Our guess is that this is either misuse of an API from userspace, or a
bug. Can someone clarify?

Below are the snippets of code around these accesses.

> write to 0xffff8880968747b0 of 8 bytes by task 6336 on cpu 0:
>  generic_file_buffered_read+0x18be/0x19e0 mm/filemap.c:2246

	...
	would_block:
		error = -EAGAIN;
	out:
		ra->prev_pos = prev_index;
		ra->prev_pos <<= PAGE_SHIFT;
2246)		ra->prev_pos |= prev_offset;

		*ppos = ((loff_t)index << PAGE_SHIFT) + offset;
		file_accessed(filp);
		return written ? written : error;
	}
	EXPORT_SYMBOL_GPL(generic_file_buffered_read);
	...

>  generic_file_read_iter+0x7d/0x3e0 mm/filemap.c:2326
>  ext4_file_read_iter+0x2d6/0x420 fs/ext4/file.c:74
>  call_read_iter include/linux/fs.h:1902 [inline]
>  generic_file_splice_read+0x22a/0x310 fs/splice.c:312
>  do_splice_to fs/splice.c:870 [inline]
>  splice_direct_to_actor+0x2a8/0x660 fs/splice.c:950
>  do_splice_direct+0xf2/0x170 fs/splice.c:1059
>  do_sendfile+0x562/0xb10 fs/read_write.c:1540
>  __do_sys_sendfile64 fs/read_write.c:1601 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1587 [inline]
>  __x64_sys_sendfile64+0xf2/0x130 fs/read_write.c:1587
>  do_syscall_64+0x51/0xb0 arch/x86/entry/common.c:384
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> read to 0xffff8880968747b0 of 8 bytes by task 6334 on cpu 1:
>  generic_file_buffered_read+0x11e/0x19e0 mm/filemap.c:2011

	...
	index = *ppos >> PAGE_SHIFT;
	prev_index = ra->prev_pos >> PAGE_SHIFT;
2011)	prev_offset = ra->prev_pos & (PAGE_SIZE-1);
	last_index = (*ppos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
	offset = *ppos & ~PAGE_MASK;
	...

>  generic_file_read_iter+0x7d/0x3e0 mm/filemap.c:2326
>  ext4_file_read_iter+0x2d6/0x420 fs/ext4/file.c:74
>  call_read_iter include/linux/fs.h:1902 [inline]
>  generic_file_splice_read+0x22a/0x310 fs/splice.c:312
>  do_splice_to fs/splice.c:870 [inline]
>  splice_direct_to_actor+0x2a8/0x660 fs/splice.c:950
>  do_splice_direct+0xf2/0x170 fs/splice.c:1059
>  do_sendfile+0x562/0xb10 fs/read_write.c:1540
>  __do_sys_sendfile64 fs/read_write.c:1601 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1587 [inline]
>  __x64_sys_sendfile64+0xf2/0x130 fs/read_write.c:1587
>  do_syscall_64+0x51/0xb0 arch/x86/entry/common.c:384
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 6334 Comm: syz-executor.0 Not tainted 5.8.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> ==================================================================

Thanks,
-- Marco
