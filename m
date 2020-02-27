Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E258CC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA6524690
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgB0LkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:40:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54651 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbgB0LkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:40:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id z12so3134348wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 03:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=beEq6MZN/x5EMuGVI+R6VnGypgc13D/nnIpr/j6bKUA=;
        b=Eqj3a0D76RWAUZGh5K3DcNTI0F0/NGjvrr1CMBhd1txCaC2vjcMxhHnF65qis80tYH
         pS7koIvHz4KKSoSpG7S8STZJ0P3l/BgLOd1t177UiVyNHfMObBKJRao4v/yPG7j9m4J8
         yEV18CcfNBxGhJ0c4q1Tg2iA4TdlhTjhjuHTzXaCoCYMD0YcmMyGbC/UNcpZh+X+H7oe
         JrrvpAsAlqja6DQc6vzSWsKXg2eKfSMOcVYdwdYmuXCAq7Jj60MkgDJYKChZF7t2D+G5
         sldVJC7NmUNt9AQ/Q+4wm4jXc/c+W0NdTjFUERFCN52Gto3wKrfrMDounvRi5IwaJJ0Z
         oWAg==
X-Gm-Message-State: APjAAAXC4fNkHrcJ5iGSf6SPkmfgIH+SMxIf+u6KKUjnonZGVFOfoOBn
        WTSMWqo0GlvSaTXruqA9HF0=
X-Google-Smtp-Source: APXvYqw67FZer7NscQOzi55F+gb6m1IaeZlAkaYfJ9YxWSatjcXkR/MpZevN9PEn6sQXIqgN1GAohw==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr5010570wmi.51.1582803613256;
        Thu, 27 Feb 2020 03:40:13 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id i4sm7476534wmd.23.2020.02.27.03.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 03:40:12 -0800 (PST)
Subject: Re: possible deadlock in tty_unthrottle
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <20200227113622.4716-1-hdanton@sina.com>
From:   Jiri Slaby <jslaby@suse.com>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2dd19dd1-abd7-9a6d-356b-4806841c2671@suse.com>
Date:   Thu, 27 Feb 2020 12:40:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200227113622.4716-1-hdanton@sina.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 02. 20, 12:36, Hillf Danton wrote:
> 
> On Thu, 27 Feb 2020 00:39:12 -0800
>> syzbot found the following crash on:
>>
>> HEAD commit:    f8788d86 Linux 5.6-rc3
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1102d22de00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=26183d9746e62da329b8
>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 5.6.0-rc3-syzkaller #0 Not tainted
>> ------------------------------------------------------
>> syz-executor.4/20336 is trying to acquire lock:
>> ffff8880a2e952a0 (&tty->termios_rwsem){++++}, at: tty_unthrottle+0x22/0x100 drivers/tty/tty_ioctl.c:136
>>
>> but task is already holding lock:
>> ffffffff89462e70 (sel_lock){+.+.}, at: paste_selection+0x118/0x470 drivers/tty/vt/selection.c:374
>>
>> which lock already depends on the new lock.
>>
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #2 (sel_lock){+.+.}:
>>        lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
>>        __mutex_lock_common+0x16e/0x2f30 kernel/locking/mutex.c:956
>>        __mutex_lock kernel/locking/mutex.c:1103 [inline]
>>        mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:1118
>>        set_selection_kernel+0x3b8/0x18a0 drivers/tty/vt/selection.c:217
>>        set_selection_user+0x63/0x80 drivers/tty/vt/selection.c:181
>>        tioclinux+0x103/0x530 drivers/tty/vt/vt.c:3050
>>        vt_ioctl+0x3f1/0x3a30 drivers/tty/vt/vt_ioctl.c:364
>>        tty_ioctl+0xee6/0x15c0 drivers/tty/tty_io.c:2660
>>        vfs_ioctl fs/ioctl.c:47 [inline]
>>        ksys_ioctl fs/ioctl.c:763 [inline]
>>        __do_sys_ioctl fs/ioctl.c:772 [inline]
>>        __se_sys_ioctl+0x113/0x190 fs/ioctl.c:770
>>        __x64_sys_ioctl+0x7b/0x90 fs/ioctl.c:770
>>        do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
>>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> -> #1 (console_lock){+.+.}:
>>        lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
>>        console_lock+0x46/0x70 kernel/printk/printk.c:2289
>>        con_flush_chars+0x50/0x650 drivers/tty/vt/vt.c:3223
>>        n_tty_write+0xeae/0x1200 drivers/tty/n_tty.c:2350
>>        do_tty_write drivers/tty/tty_io.c:962 [inline]
>>        tty_write+0x5a1/0x950 drivers/tty/tty_io.c:1046
>>        __vfs_write+0xb8/0x740 fs/read_write.c:494
>>        vfs_write+0x270/0x580 fs/read_write.c:558
>>        ksys_write+0x117/0x220 fs/read_write.c:611
>>        __do_sys_write fs/read_write.c:623 [inline]
>>        __se_sys_write fs/read_write.c:620 [inline]
>>        __x64_sys_write+0x7b/0x90 fs/read_write.c:620
>>        do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
>>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> -> #0 (&tty->termios_rwsem){++++}:
>>        check_prev_add kernel/locking/lockdep.c:2475 [inline]
>>        check_prevs_add kernel/locking/lockdep.c:2580 [inline]
>>        validate_chain+0x1507/0x7be0 kernel/locking/lockdep.c:2970
>>        __lock_acquire+0xc5a/0x1bc0 kernel/locking/lockdep.c:3954
>>        lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
>>        down_write+0x57/0x140 kernel/locking/rwsem.c:1534
>>        tty_unthrottle+0x22/0x100 drivers/tty/tty_ioctl.c:136
>>        mkiss_receive_buf+0x12aa/0x1340 drivers/net/hamradio/mkiss.c:902
>>        tty_ldisc_receive_buf+0x12f/0x170 drivers/tty/tty_buffer.c:465
>>        paste_selection+0x346/0x470 drivers/tty/vt/selection.c:389
>>        tioclinux+0x121/0x530 drivers/tty/vt/vt.c:3055
>>        vt_ioctl+0x3f1/0x3a30 drivers/tty/vt/vt_ioctl.c:364
>>        tty_ioctl+0xee6/0x15c0 drivers/tty/tty_io.c:2660
>>        vfs_ioctl fs/ioctl.c:47 [inline]
>>        ksys_ioctl fs/ioctl.c:763 [inline]
>>        __do_sys_ioctl fs/ioctl.c:772 [inline]
>>        __se_sys_ioctl+0x113/0x190 fs/ioctl.c:770
>>        __x64_sys_ioctl+0x7b/0x90 fs/ioctl.c:770
>>        do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
>>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> other info that might help us debug this:
>>
>> Chain exists of:
>>   &tty->termios_rwsem --> console_lock --> sel_lock
>>
>>  Possible unsafe locking scenario:
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(sel_lock);
>>                                lock(console_lock);
>>                                lock(sel_lock);
>>   lock(&tty->termios_rwsem);
>>
>>  *** DEADLOCK ***
>>
>> 3 locks held by syz-executor.4/20336:
>>  #0: ffff8880a2e95090 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:267
>>  #1: ffff888097ac10a8 (&buf->lock){+.+.}, at: tty_buffer_lock_exclusive+0x33/0x40 drivers/tty/tty_buffer.c:61
>>  #2: ffffffff89462e70 (sel_lock){+.+.}, at: paste_selection+0x118/0x470 drivers/tty/vt/selection.c:374
>>
> The sel_lock was introduced in
> 	07e6124a1a46 ("vt: selection, close sel_buffer race")
> 
> and with it in position can we cut one lock for setting selection?

Ouch -- I will look into it. (But not until tomorrow.)

Thanks.

> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3015,8 +3015,6 @@ static struct console vt_console_driver
>   *
>   * There are some functions which can sleep for arbitrary periods
>   * (paste_selection) but we don't need the lock there anyway.
> - *
> - * set_selection_user has locking, and definitely needs it
>   */
>  
>  int tioclinux(struct tty_struct *tty, unsigned long arg)
> @@ -3035,10 +3033,8 @@ int tioclinux(struct tty_struct *tty, un
>  	switch (type)
>  	{
>  		case TIOCL_SETSEL:
> -			console_lock();
>  			ret = set_selection_user((struct tiocl_selection
>  						 __user *)(p+1), tty);
> -			console_unlock();
>  			break;
>  		case TIOCL_PASTESEL:
>  			ret = paste_selection(tty);
> 


-- 
js
suse labs
